use sakila;
#Afficher les 10 locations les plus longues (nom/prenom client, film, video club, durée)
SELECT  datediff(return_date, rental_date) AS durée,c.first_name, c.last_name,f.title, s.store_id
FROM customer AS c
JOIN rental AS r ON r.customer_id = c.customer_id
JOIN inventory AS i ON i.inventory_id = r.inventory_id
JOIN film AS f ON i.film_id = f.film_id
JOIN store AS s ON s.store_id = i.store_id
ORDER BY durée DESC
LIMIT 10;

#Afficher les 10 meilleurs clients actifs par montant dépensé (nom/prénom client, montant dépensé)
SELECT sum(p.amount),c.last_name,c.first_name
FROM payment AS p 
JOIN customer AS c
ON c.customer_id = p.customer_id
JOIN store AS s
ON s.store_id = c.store_id
GROUP BY c.last_name, c.first_name
ORDER BY sum(p.amount) desc
LIMIT 10;

#Afficher la durée moyenne de location par film triée de manière descendante
SELECT AVG(datediff(return_date, rental_date)) AS durée, f.title
FROM rental AS r
JOIN inventory AS i
ON r.inventory_id = i.inventory_id
JOIN film AS f
ON f.film_id = i.film_id
GROUP BY f.title ORDER BY durée DESC;

#Afficher tous les films n'ayant jamais été empruntés
SELECT title
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
WHERE r.rental_id IS NULL;

#Afficher le nombre d'employés (staff) par video club
SELECT count(staff_id)
FROM staff
GROUP BY store_id;

#Afficher les 10 villes avec le plus de video clubs
SELECT c.city
FROM address AS a 
JOIN city AS c ON c.city_id = a.city_id
JOIN store AS s ON s.address_id = a.address_id
GROUP BY store_id
LIMIT 10;

# Afficher le film le plus long dans lequel joue Johnny Lollobrigida
SELECT a.last_name, a.first_name, f.title, f.length
FROM film AS f
JOIN film_actor AS fa ON fa.film_id = f.film_id
JOIN actor AS a ON a.actor_id = fa.actor_id
WHERE a.last_name = "LOLLOBRIGIDA" AND a.first_name = "JOHNNY"
ORDER BY f.length DESC LIMIT 1 ;

#Afficher le temps moyen de location du film 'Academy dinosaur'
SELECT f.title, AVG(datediff(return_date, rental_date)) AS durée
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON r.inventory_id = i.inventory_id
WHERE f.title = 'ACADEMY DINOSAUR'
GROUP BY f.title;

#Afficher les films avec plus de deux exemplaires en inventaire (store id, titre du film, nombre d'exemplaires)
SELECT f.title, count(i.inventory_id) AS nbr_exemplaire, s.store_id
FROM inventory AS i
JOIN film AS f ON f.film_id = i.film_id
JOIN store AS s ON s.store_id = i.store_id
GROUP BY f.title, s.store_id
HAVING count(i.inventory_id)>= 2;

#Lister les films contenant 'din' dans le titre
SELECT f.title 
FROM film AS f
WHERE f.title LIKE '%din%'; 

# Lister les 5 films les plus empruntés
SELECT f.title, COUNT(r.rental_id) AS emprunt
FROM rental AS r
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN film AS f ON i.film_id = f.film_id
GROUP BY f.title ORDER BY emprunt DESC  LIMIT 5;

#Lister les films sortis en 2003, 2005 et 2006
SELECT f.title, f.release_year
FROM film AS f
JOIN inventory AS i ON i.film_id = f.film_id
WHERE f.release_year = 2003 AND 2005 AND 2006;

#Afficher les films ayant été empruntés mais n'ayant pas encore été restitués, triés par date d'emprunt. 
#Afficher seulement les 10 premiers.
SELECT f.title , r.rental_date AS date_demprunt, r.return_date
FROM rental AS r
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN film AS f ON i.film_id = f.film_id
WHERE r.return_date IS NULL
ORDER BY date_demprunt
LIMIT 10;

# Afficher les films d'action durant plus de 2h
SELECT f.title, c.name, f.length
FROM category AS c
JOIN film_category AS fc ON fc.category_id = c.category_id
JOIN film AS f ON f.film_id = fc.film_id
WHERE f.length >120 AND c.name = 'action';

# Afficher tous les utilisateurs ayant emprunté des films avec la mention NC-17
SELECT DISTINCT c.first_name, c.last_name, f.title, f.rating, r.rental_date
FROM customer AS c 
JOIN rental AS r ON r.customer_id = c.customer_id 
JOIN inventory AS i ON i.inventory_id = r.inventory_id
JOIN film AS f ON f.film_id = i.film_id
WHERE rating = 'NC-17';

#Afficher les films d'animation dont la langue originale est l'anglais
SELECT f.title, l.language_id, c.name
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN film AS f ON f.film_id = fc.film_id
JOIN language AS l ON l.language_id = f.original_language_id
WHERE l.language_id = 'English' AND c.name ='animation';
#OU 
SELECT f.title, l.name, c.name
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN film AS f ON f.film_id = fc.film_id
JOIN language AS l ON l.language_id = f.original_language_id
WHERE l.name = 'English' AND c.name ='animation';
#OU
SELECT f.title, l.name, c.name
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN film AS f ON f.film_id = fc.film_id
JOIN language AS l ON l.language_id = f.language_id
WHERE l.name = 'English' AND c.name ='animation';

#Afficher les films dans lesquels une actrice nommée Jennifer a joué 
#(bonus: en même temps qu'un acteur nommé Johnny)
SELECT f.title, first_name
FROM actor AS a  
JOIN film_actor AS fa ON a.actor_id = fa.actor_id
JOIN film AS f ON f.film_id = fa.film_id
WHERE a.first_name = 'JENNIFER' AND 'JOHNNY';
# OU 
SELECT f.title, first_name
FROM actor AS a  
JOIN film_actor AS fa ON a.actor_id = fa.actor_id
JOIN film AS f ON f.film_id = fa.film_id
WHERE a.first_name = 'JENNIFER'
UNION
SELECT f.title, first_name
FROM actor AS a  
JOIN film_actor AS fa ON a.actor_id = fa.actor_id
JOIN film AS f ON f.film_id = fa.film_id
WHERE a.first_name = 'JOHNNY';
#OU
SELECT f.film_id
FROM film_actor AS f
WHERE exists
(SELECT a.first_name
FROM actor AS a
WHERE a.first_name = 'JENNIFER' AND 'JOHNNY' AND f.actor_id = a.actor_id);

#Quelles sont les 3 catégories les plus empruntées?
SELECT c.name, COUNT(r.rental_id) AS nbr_emprunt
FROM rental AS r
JOIN inventory AS i ON i.inventory_id = r.inventory_id
JOIN film AS f ON f.film_id = i.film_id
JOIN film_category AS fc ON fc.film_id = f.film_id
JOIN category AS c ON c.category_id = fc.category_id
GROUP BY c.name ORDER BY nbr_emprunt DESC LIMIT 3;

#Quelles sont les 10 villes où on a fait le plus de locations?
SELECT c.city, COUNT(r.rental_id) AS nbr_emprunt
FROM rental AS r 
JOIN customer AS cu ON r.customer_id = cu.customer_id
JOIN address AS a ON a.address_id = cu.address_id
JOIN city AS c ON c.city_id = a.city_id
GROUP BY c.city ORDER BY nbr_emprunt DESC LIMIT 10;

#Lister les acteurs ayant joué dans au moins 1 film
SELECT  a.first_name, a.last_name, COUNT(f.title) AS nbr_film
FROM actor AS a
JOIN film_actor AS fa ON fa.actor_id = a.actor_id
JOIN film AS f ON f.film_id = fa.film_id
GROUP BY a.first_name, a.last_name
HAVING COUNT(nbr_film) >=1;	
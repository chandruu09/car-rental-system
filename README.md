# Car Rental System

**Live demo:** https://car-rental-system-9meq.onrender.com
*(Hosted on a free plan, so the first load may take about a minute.)*

A full-stack web application where users can browse and book cars, and admins can manage cars and bookings.

## Features
**Users**
- Register and log in (passwords hashed with BCrypt)
- Browse cars, filter by type and price
- Book a car for a date range, with automatic availability check and price calculation
- View and cancel own bookings

**Admin**
- Add and delete cars
- View all bookings, approve or reject requests, mark cars as returned

## Tech stack
Java 17, Servlets, JSP, JSTL, JDBC, PostgreSQL, HTML, CSS, JavaScript, Bootstrap 5, Maven, Apache Tomcat 9, Docker, Render

## Database
Tables: `users`, `cars`, `bookings`. The schema is in `sql/schema.sql`.

## How to run locally
1. Install JDK 17+, Maven, Tomcat 9 and PostgreSQL.
2. Create a database named `car_rental` and run `sql/schema.sql`.
3. Set the environment variables `DB_URL`, `DB_USER` and `DB_PASSWORD`
   (defaults: `jdbc:postgresql://localhost:5432/car_rental`, `postgres`).
4. Build with `mvn package` and deploy `target/car-rental.war` to Tomcat.
5. Open `http://localhost:8080/car-rental/`.

## Author
Chandra Shekhar Malikhttps://car-rental-system-9meq.onrender.com
# MIS443-Final-Exam-2332300046
# Final Project - MIS443


# Customers Data
## Project Objectives



---

## Project Files

```
├── SQL/
│
└── README.md


## Business Questions

Contains 6 questions which is answered detailedly in the report.

# 📊 MIS443 — Database Design & SQL Project

<div align="center">

### 🗄️ Relational Database Management System

**Course:** MIS443
**Student:** Tang So Han
**Student ID:** 2332300046
**Project:** Database Design & ERD

![SQL](https://img.shields.io/badge/SQL-Database-blue?style=for-the-badge\&logo=postgresql)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-DBMS-336791?style=for-the-badge\&logo=postgresql)
![ERD](https://img.shields.io/badge/ERD-Database%20Design-purple?style=for-the-badge)
![Academic](https://img.shields.io/badge/Project-Academic-green?style=for-the-badge)

</div>

---

## 📌 Project Overview

This project focuses on designing and implementing a **relational database system** using SQL and PostgreSQL.

The database is structured to manage information related to:

* 👥 Customers
* 🛒 Orders
* 📦 Products
* 🧺 Shopping baskets
* 🌍 Countries
* 🎓 Students

The project demonstrates fundamental database concepts including **entity–relationship modeling, primary keys, foreign keys, data types, normalization, and relational integrity**.

---

## 🏗️ Database Structure

The database consists of **6 main tables**:

| Table       | Purpose                                                   |
| ----------- | --------------------------------------------------------- |
| `students`  | Stores student information                                |
| `customers` | Stores customer profiles and shopping-related information |
| `orders`    | Records customer orders                                   |
| `baskets`   | Connects orders with purchased products                   |
| `products`  | Stores product information and pricing                    |
| `country`   | Stores country and head-office information                |

---

## 🔗 Entity Relationship Diagram

The ERD represents the relationships between customers, orders, products, baskets, and countries.



### Relationship summary

* **Customers → Orders:** One customer can place many orders.
* **Country → Orders:** One country can be associated with many orders.
* **Orders → Baskets:** One order can contain multiple basket items.
* **Products → Baskets:** One product can appear in multiple basket items.
* **Baskets:** Acts as an associative entity between `orders` and `products`.

This structure helps resolve the **many-to-many relationship** between orders and products.

---

## 🗃️ Table Details

### 👥 `customers`

Stores information about customers.

| Column        | Data Type  | Key   |
| ------------- | ---------- | ----- |
| `customer_id` | INTEGER    | 🔑 PK |
| `first_shop`  | DATE       |       |
| `age`         | INTEGER    |       |
| `rewards`     | VARCHAR(3) |       |
| `can_email`   | VARCHAR(3) |       |

---

### 🛍️ `orders`

Stores information about customer purchases.

| Column          | Data Type   | Key   |
| --------------- | ----------- | ----- |
| `order_id`      | INTEGER     | 🔑 PK |
| `customer_id`   | INTEGER     | 🔗 FK |
| `date_shop`     | DATE        |       |
| `sales_channel` | VARCHAR(20) |       |
| `country_id`    | INTEGER     | 🔗 FK |

**Foreign keys:**

```sql
customer_id → customers(customer_id)
country_id  → country(country_id)
```

---

### 🧺 `baskets`

Represents individual products included in each order.

| Column       | Data Type | Key       |
| ------------ | --------- | --------- |
| `order_id`   | INTEGER   | 🔑 PK, FK |
| `product_id` | INTEGER   | 🔑 PK, FK |
| `quantity`   | INTEGER   |           |

The combination of:

```text
(order_id, product_id)
```

forms a **composite primary key**.

This prevents the same product from being duplicated within the same order record.

---

### 📦 `products`

Stores product information.

| Column       | Data Type     | Key   |
| ------------ | ------------- | ----- |
| `product_id` | INTEGER       | 🔑 PK |
| `category`   | VARCHAR(50)   |       |
| `price`      | NUMERIC(10,2) |       |

---

### 🌍 `country`

Stores country information.

| Column         | Data Type   | Key   |
| -------------- | ----------- | ----- |
| `country_id`   | INTEGER     | 🔑 PK |
| `country_name` | VARCHAR(50) |       |
| `head_office`  | VARCHAR(50) |       |

---

### 🎓 `students`

Stores student information for the academic database component.

| Column       | Data Type   | Key   |
| ------------ | ----------- | ----- |
| `student_id` | VARCHAR(10) | 🔑 PK |
| `full_name`  | VARCHAR(50) |       |
| `email`      | VARCHAR(50) |       |

---


## 🛠️ Technologies Used

| Technology     | Purpose                             |
| -------------- | ----------------------------------- |
| **PostgreSQL** | Relational database management      |
| **SQL**        | Database creation and querying      |
| **pgAdmin**    | Database administration             |
| **ERD**        | Database modeling and visualization |



## 🚀 How to Run the Project

### 1. Install PostgreSQL

Install PostgreSQL and pgAdmin on your computer.

### 2. Create a Database

```sql
CREATE DATABASE mis443_database;
```

### 3. Connect to the Database

Open the database using **pgAdmin** or your preferred PostgreSQL client.

### 4. Create Tables

Run the SQL script:

```text
SQL/create_tables.sql
```

### 5. Insert Data

Run:

```text
SQL/insert_data.sql
```

### 6. Execute Queries

Run the SQL queries in:

```text
SQL/queries.sql
```

---

## 📈 Example SQL Queries

### Find all customers

```sql
SELECT *
FROM customers;
```

### Display customer orders

```sql
SELECT
    c.customer_id,
    c.age,
    o.order_id,
    o.date_shop
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id;
```

### Display products in each order

```sql
SELECT
    b.order_id,
    p.product_id,
    p.category,
    p.price,
    b.quantity
FROM baskets b
JOIN products p
    ON b.product_id = p.product_id;
```

### Calculate order value

```sql
SELECT
    b.order_id,
    SUM(b.quantity * p.price) AS total_order_value
FROM baskets b
JOIN products p
    ON b.product_id = p.product_id
GROUP BY b.order_id;
```

---

## 🎯 Project Objectives

The main objectives of this project are to:

* Design a structured relational database.
* Identify appropriate entities and attributes.
* Define primary and foreign keys.
* Model one-to-many and many-to-many relationships.
* Apply relational database principles.
* Implement the database using PostgreSQL.
* Develop SQL queries for data retrieval and analysis.
* Maintain data integrity and consistency.



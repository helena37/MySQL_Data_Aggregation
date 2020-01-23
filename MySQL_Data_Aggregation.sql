#Lab-1
SELECT department_id, COUNT(id)
FROM restaurant.employees
GROUP BY department_id
ORDER BY department_id,
         COUNT(id);

#Lab-2
SELECT department_id, ROUND(AVG(salary), 2)
FROM restaurant.employees
GROUP BY department_id
ORDER BY department_id;

#Lab-3
SELECT department_id, ROUND(MIN(salary), 2) AS min_salary
FROM employees
GROUP BY department_id
HAVING min_salary > 800;

#Lab-4
SELECT COUNT(*)
FROM products
WHERE category_id = 2
  AND price > 8;

#lab-5
SELECT category_id,
       ROUND(AVG(price), 2) AS 'Average Price',
       MIN(price)           AS 'Cheapest Product',
       MAX(price)           AS 'Most Expensive Product'
FROM products
GROUP BY category_id;

/*
 Exercises: Data Aggregation
 */

#Exercise 1 - Records’ Count
SELECT COUNT(*) AS 'count'
FROM wizzard_deposits;

#Exercise 2 - Longest Magic Wand
SELECT MAX(magic_wand_size) AS 'longest_magic_wand'
FROM wizzard_deposits;

#Exercise 3 - Longest Magic Wand per Deposit Groups
SELECT deposit_group, MAX(magic_wand_size) AS 'longest_magic_wand'
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY longest_magic_wand ASC,
         deposit_group ASC;

#Exercise 4 - Smallest Deposit Group per Magic Wand Size*
SELECT deposit_group
FROM wizzard_deposits
HAVING MIN(magic_wand_size);

#Exercise 5 - Deposits Sum
SELECT deposit_group, SUM(deposit_amount) AS 'total_sum'
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY total_sum ASC;

#Exercise 6 - Deposits Sum for Ollivander family
SELECT deposit_group, SUM(deposit_amount) AS 'total_sum'
FROM wizzard_deposits
WHERE magic_wand_creator = 'Ollivander family'
GROUP BY deposit_group
ORDER BY deposit_group ASC;

#Exercise 7 - Deposits Filter
SELECT deposit_group, SUM(deposit_amount) AS 'total_sum'
FROM wizzard_deposits
WHERE magic_wand_creator = 'Ollivander family'
GROUP BY deposit_group
HAVING total_sum < 150000
ORDER BY total_sum DESC;

#Exercise 8 - Deposit charge
SELECT deposit_group, magic_wand_creator, MIN(deposit_charge) AS 'min_deposit_charge'
FROM wizzard_deposits
GROUP BY deposit_group, magic_wand_creator
ORDER BY magic_wand_creator ASC,
         deposit_group ASC;

#Exercise 9 - Age Groups
SELECT CASE
           WHEN age BETWEEN 0 AND 10 THEN '[0-10]'
           WHEN age BETWEEN 11 AND 20 THEN '[11-20]'
           WHEN age BETWEEN 21 AND 30 THEN '[21-30]'
           WHEN age BETWEEN 31 AND 40 THEN '[31-40]'
           WHEN age BETWEEN 41 AND 50 THEN '[41-50]'
           WHEN age BETWEEN 51 AND 60 THEN '[51-60]'
           ELSE '[61+]'
           END   AS 'age_group',
       COUNT(id) AS 'wizard_count'
FROM wizzard_deposits
GROUP BY age_group;

#Exercise 10 - First Letter
SELECT LEFT(first_name, 1) AS 'first_letter'
FROM wizzard_deposits
WHERE deposit_group = 'Troll Chest'
GROUP BY first_letter
ORDER BY first_letter ASC;

#Exercise 11 - Average Interest
SELECT deposit_group,
       is_deposit_expired,
       AVG(deposit_interest) AS 'average interest'
FROM wizzard_deposits
WHERE deposit_start_date > '1985/01/01'
GROUP BY deposit_group, is_deposit_expired
ORDER BY deposit_group DESC,
         is_deposit_expired ASC;

#Exercise 12 - Rich Wizard, Poor Wizard*
SELECT
    SUM(`fw`.`deposit_amount` - `sw`.`deposit_amount`) AS 'sum_difference'
FROM
    `wizzard_deposits` AS `fw`,
    `wizzard_deposits` AS `sw`
WHERE
    `sw`.`id` - `fw`.`id` = 1;

#Exercise 13 - Employees Minimum Salaries
SELECT department_id, MIN(salary) AS 'minimum_salary'
FROM employees
WHERE department_id = 2 OR department_id = 5 OR department_id = 7 AND hire_date > '2000-01-01'
GROUP BY department_id
ORDER BY department_id ASC;

#Exercise 14 - Employees Average Salaries
SELECT department_id,
CASE
WHEN department_id = 1 THEN AVG(salary + 5000)
ELSE AVG(salary)
END AS 'avg_salary'
FROM employees
WHERE manager_id <> 42 AND salary > 30000
GROUP BY department_id
ORDER BY department_id ASC;

#Exercise 15 - Employees Maximum Salaries
SELECT department_id, MAX(salary) AS 'max_salary'
FROM employees
GROUP BY department_id
HAVING NOT max_salary BETWEEN 30000 AND 70000
ORDER BY department_id ASC;

#Exercise 16 - Employees Count Salaries
SELECT COUNT(salary)
FROM employees
WHERE manager_id IS NULL;

#Exercise 17 - 3rd Highest Salary*
SELECT
    department_id,
    (SELECT DISTINCT
            e2.salary
        FROM
            employees AS e2
        WHERE
            e2.department_id = e1.department_id
        ORDER BY e2.salary DESC
        LIMIT 2 , 1) AS third_highest_salary
FROM
    employees AS e1
GROUP BY department_id
HAVING third_highest_salary IS NOT NULL;

#Exercise 18 - Salary Challenge**
SELECT
    e.first_name, e.last_name, e.department_id
FROM
    employees AS e
        JOIN
    (SELECT
        department_id, AVG(salary) AS dep_avg_salary
    FROM
        employees
    GROUP BY department_id) AS avrg ON e.department_id = avrg.department_id
WHERE
    salary > avrg.dep_avg_salary
ORDER BY department_id
LIMIT 10;

#Exercise 19 - Departments Total Salaries
SELECT department_id, SUM(salary) AS 'total_salary'
FROM employees
GROUP BY department_id;














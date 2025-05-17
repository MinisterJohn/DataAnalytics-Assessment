# Data Analyst Assessment Solution

This repository contains my solutions to the SQL Proficiency Assessment. The assessment demonstrates my ability to write SQL queries to solve real-world business problems involving data retrieval, aggregation, joins, subqueries, and data manipulation.

## Repository Structure

```
DataAnalytics-Assessment/
│
├── Assessment_Q1.sql
├── Assessment_Q2.sql
├── Assessment_Q3.sql
├── Assessment_Q4.sql
│
└── README.md
```

---

## Per-Question Explanations

### 1. High-Value Customers with Multiple Products

**Approach:**  
To identify customers with both a funded savings and a funded investment plan, I joined the `users_customuser`, `savings_savingsaccount`, and `plans_plan` tables. I filtered for customers with at least one savings plan (`is_regular_savings = 1`) and one investment plan (`is_a_fund = 1`). I then aggregated the number of each product per customer and summed their total deposits, ordering the results by total deposits.

**Challenges:**  
The main challenge was ensuring that customers were not double-counted if they had multiple plans. I resolved this by using `GROUP BY` on the customer and counting distinct plan types.

---

### 2. Transaction Frequency Analysis

**Approach:**  
I calculated the total number of transactions per customer per month using the `savings_savingsaccount` table. I then used a `CASE` statement to categorize customers as "High Frequency", "Medium Frequency", or "Low Frequency" based on their average monthly transactions. Finally, I counted the number of customers in each category and calculated the average transactions per month.

**Challenges:**  
Handling months with no transactions required careful use of date functions and ensuring that averages were calculated correctly, even for customers with intermittent activity.

---

### 3. Account Inactivity Alert

**Approach:**  
To flag inactive accounts, I identified the last transaction date for each account in both the `plans_plan` and `savings_savingsaccount` tables. I calculated the number of days since the last transaction and filtered for accounts with inactivity greater than 365 days.

**Challenges:**  
Some accounts had no transactions, so I had to handle `NULL` values for last transaction dates. I used `COALESCE` and date functions to ensure accurate inactivity calculations.

---

### 4. Customer Lifetime Value (CLV) Estimation

**Approach:**  
I calculated each customer's account tenure in months using their signup date from `users_customuser`. I summed their total transactions and calculated the average profit per transaction (0.1% of transaction value). The CLV was estimated using the provided formula, and results were ordered from highest to lowest CLV.

**Challenges:**  
I ensured that division by zero was avoided for customers with very short tenure and handled cases where transaction data was sparse.

---

## Challenges Encountered

- **Data Consistency:** Ensuring joins did not result in duplicate or missing records.
- **Date Calculations:** Handling date arithmetic and edge cases for inactivity and tenure.
- **Performance:** Writing efficient queries that scale with large datasets.

---

## How to Use

1. Review each `.sql` file for the solution to each question.
2. Each SQL file contains a single query, formatted and commented for clarity.
3. Run the queries against the provided database to verify results.

---

## Author

- John Nnoruka
- nnorukajohn755@gmail.com

---

## License

This project is licensed under the MIT License. 
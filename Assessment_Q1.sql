-- Question 1: High-Value Customers with Multiple Products
-- Find customers with both savings and investment plans, sorted by total deposits

/*
This query identifies customers who have both savings and investment plans, and calculates their total deposits.
The solution uses a Common Table Expression (CTE) to break down the complex logic into manageable parts.

Key points:
- Savings plans are identified by is_regular_savings = 1
- Investment plans are identified by is_a_fund = 1
- All monetary values are stored in kobo (1 naira = 100 kobo)
- Results are sorted by total deposits in descending order
*/

WITH customer_plans AS (
    -- First, we gather all customer plans and their transaction data
    SELECT 
        u.id as owner_id,                    -- Customer's unique identifier
        u.name,                              -- Customer's name
        -- Count savings plans for each customer
        COUNT(CASE WHEN p.is_regular_savings = 1 THEN 1 END) as savings_count,
        -- Count investment plans for each customer
        COUNT(CASE WHEN p.is_a_fund = 1 THEN 1 END) as investment_count,
        -- Sum all confirmed deposits, defaulting to 0 if no deposits
        COALESCE(SUM(s.confirmed_amount), 0) as total_deposits
    FROM users_customuser u                  -- Start with the users table
    LEFT JOIN plans_plan p ON u.id = p.owner_id  -- Join with plans table
    LEFT JOIN savings_savingsaccount s ON p.id = s.plan_id  -- Join with savings account table
    WHERE p.is_regular_savings = 1 OR p.is_a_fund = 1  -- Filter for relevant plan types
    GROUP BY u.id, u.name                    -- Group results by customer
    HAVING 
        -- Ensure customer has at least one savings plan
        COUNT(CASE WHEN p.is_regular_savings = 1 THEN 1 END) > 0
        -- AND at least one investment plan
        AND COUNT(CASE WHEN p.is_a_fund = 1 THEN 1 END) > 0
)
-- Final selection with formatted output
SELECT 
    owner_id,                                -- Customer ID
    name,                                    -- Customer name
    savings_count,                           -- Number of savings plans
    investment_count,                        -- Number of investment plans
    total_deposits / 100.0 as total_deposits -- Convert from kobo to naira
FROM customer_plans
ORDER BY total_deposits DESC;                -- Sort by total deposits (highest first) 
-- Question 3: Account Inactivity Alert
-- Find active accounts with no transactions in the last year

/*
This query identifies accounts that have been inactive for over a year.
It considers both savings and investment accounts, and calculates the number of days since their last transaction.

Key points:
- An account is considered inactive if it has no transactions in the last 365 days
- Both savings (is_regular_savings = 1) and investment (is_a_fund = 1) accounts are included
- Results are ordered by inactivity duration (longest first)
*/

WITH last_transactions AS (
    -- First CTE: Find the last transaction date for each account
    SELECT 
        p.id as plan_id,                     -- Account identifier
        p.owner_id,                          -- Customer identifier
        -- Determine account type
        CASE 
            WHEN p.is_regular_savings = 1 THEN 'Savings'
            WHEN p.is_a_fund = 1 THEN 'Investment'
        END as type,
        MAX(s.created_at) as last_transaction_date  -- Most recent transaction date
    FROM plans_plan p
    LEFT JOIN savings_savingsaccount s ON p.id = s.plan_id
    WHERE p.is_regular_savings = 1 OR p.is_a_fund = 1  -- Filter for relevant account types
    GROUP BY p.id, p.owner_id, p.is_regular_savings, p.is_a_fund
)
-- Final selection of inactive accounts
SELECT 
    plan_id,                                 -- Account ID
    owner_id,                                -- Customer ID
    type,                                    -- Account type (Savings/Investment)
    last_transaction_date,                   -- Date of last transaction
    EXTRACT(DAY FROM (CURRENT_DATE - last_transaction_date)) as inactivity_days  -- Days since last transaction
FROM last_transactions
WHERE 
    -- Filter for accounts inactive for over a year
    last_transaction_date < CURRENT_DATE - INTERVAL '1 year'
    -- OR accounts that have never had a transaction
    OR last_transaction_date IS NULL
ORDER BY inactivity_days DESC; 
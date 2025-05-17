-- Question 2: Transaction Frequency Analysis
-- Calculate average transactions per customer per month and categorize them

WITH monthly_transactions AS (
    SELECT 
        u.id as customer_id,
        DATE_TRUNC('month', s.created_at) as transaction_month,
        COUNT(*) as transaction_count
    FROM users_customuser u
    LEFT JOIN savings_savingsaccount s ON u.id = s.owner_id
    GROUP BY u.id, DATE_TRUNC('month', s.created_at)
),
customer_frequency AS (
    SELECT 
        customer_id,
        AVG(transaction_count) as avg_transactions_per_month
    FROM monthly_transactions
    GROUP BY customer_id
)
SELECT 
    CASE 
        WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
        WHEN avg_transactions_per_month >= 3 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END as frequency_category,
    COUNT(*) as customer_count,
    ROUND(AVG(avg_transactions_per_month), 1) as avg_transactions_per_month
FROM customer_frequency
GROUP BY 
    CASE 
        WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
        WHEN avg_transactions_per_month >= 3 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END
ORDER BY 
    CASE frequency_category
        WHEN 'High Frequency' THEN 1
        WHEN 'Medium Frequency' THEN 2
        ELSE 3
    END; 
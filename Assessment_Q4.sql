-- Question 4: Customer Lifetime Value (CLV) Estimation
-- Calculate CLV based on account tenure and transaction volume

WITH customer_metrics AS (
    SELECT 
        u.id as customer_id,
        u.name,
        EXTRACT(MONTH FROM AGE(CURRENT_DATE, u.date_joined)) as tenure_months,
        COUNT(s.id) as total_transactions,
        COALESCE(AVG(s.confirmed_amount), 0) as avg_transaction_value
    FROM users_customuser u
    LEFT JOIN savings_savingsaccount s ON u.id = s.owner_id
    GROUP BY u.id, u.name, u.date_joined
)
SELECT 
    customer_id,
    name,
    tenure_months,
    total_transactions,
    ROUND(
        (total_transactions / NULLIF(tenure_months, 0)) * 12 * (avg_transaction_value * 0.001),
        2
    ) as estimated_clv
FROM customer_metrics
WHERE tenure_months > 0
ORDER BY estimated_clv DESC; 
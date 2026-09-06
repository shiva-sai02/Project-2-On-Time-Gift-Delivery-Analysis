CREATE DATABASE gift_delivery_analysis;
CREATE TABLE gift_delivery_orders (
    order_id VARCHAR(20),
    order_date DATE,
    occasion_type VARCHAR(50),
    occasion_date DATE,
    customer_city VARCHAR(50),
    recipient_city VARCHAR(50),
    region VARCHAR(20),
    product_category VARCHAR(50),
    product_value DECIMAL(10,2),
    delivery_method VARCHAR(30),
    warehouse_city VARCHAR(50),
    distance_km INT,
    inventory_status VARCHAR(30),
    promised_delivery_date DATE,
    actual_delivery_date DATE,
    delivery_status VARCHAR(20),
    delivery_type VARCHAR(20),
    lead_time INT
);
USE gift_delivery_analysis;

SELECT COUNT(*) AS total_rows
FROM gift_delivery_orders;

USE gift_delivery_analysis;

TRUNCATE TABLE gift_delivery_orders;

ALTER TABLE gift_delivery_orders
MODIFY distance_km DECIMAL(10,2);
DESCRIBE gift_delivery_orders;
SELECT COUNT(*) AS total_rows
FROM gift_delivery_orders;
USE gift_delivery_analysis;

TRUNCATE TABLE gift_delivery_orders;
SELECT COUNT(*) AS total_rows
FROM gift_delivery_orders;
SELECT COUNT(*) AS total_rows
FROM gift_delivery_orders;
USE gift_delivery_analysis;

SELECT
    COUNT(*) AS total_orders,
    SUM(CASE
        WHEN delivery_status IN ('Early', 'Exact Date') THEN 1
        ELSE 0
    END) AS on_time_orders,
    SUM(CASE
        WHEN delivery_status = 'Late' THEN 1
        ELSE 0
    END) AS late_orders
FROM gift_delivery_orders;

SELECT
    COUNT(*) AS total_orders,
    SUM(CASE
        WHEN delivery_status IN ('Early', 'Exact Date') THEN 1
        ELSE 0
    END) AS on_time_orders,
    SUM(CASE
        WHEN delivery_status = 'Late' THEN 1
        ELSE 0
    END) AS late_orders,
    ROUND(
        100.0 * SUM(CASE
            WHEN delivery_status IN ('Early', 'Exact Date') THEN 1
            ELSE 0
        END) / COUNT(*), 2
    ) AS on_time_percentage
FROM gift_delivery_orders;

SELECT
    CASE
        WHEN lead_time <= 2 THEN '0-2 days'
        WHEN lead_time BETWEEN 3 AND 5 THEN '3-5 days'
        WHEN lead_time BETWEEN 6 AND 8 THEN '6-8 days'
        WHEN lead_time BETWEEN 9 AND 12 THEN '9-12 days'
        ELSE '13+ days'
    END AS lead_time_bucket,

    COUNT(*) AS orders,

    SUM(CASE
        WHEN delivery_status IN ('Early', 'Exact Date') THEN 1
        ELSE 0
    END) AS on_time_orders,

    ROUND(
        100.0 * SUM(CASE
            WHEN delivery_status IN ('Early', 'Exact Date') THEN 1
            ELSE 0
        END) / COUNT(*), 2
    ) AS on_time_percentage

FROM gift_delivery_orders

GROUP BY
    CASE
        WHEN lead_time <= 2 THEN '0-2 days'
        WHEN lead_time BETWEEN 3 AND 5 THEN '3-5 days'
        WHEN lead_time BETWEEN 6 AND 8 THEN '6-8 days'
        WHEN lead_time BETWEEN 9 AND 12 THEN '9-12 days'
        ELSE '13+ days'
    END

ORDER BY
    MIN(lead_time);
    
    SELECT
    CASE
        WHEN distance_km <= 200 THEN '0-200 km'
        WHEN distance_km BETWEEN 201 AND 500 THEN '201-500 km'
        WHEN distance_km BETWEEN 501 AND 800 THEN '501-800 km'
        ELSE '801+ km'
    END AS distance_bucket,

    COUNT(*) AS orders,

    SUM(CASE
        WHEN delivery_status IN ('Early', 'Exact Date') THEN 1
        ELSE 0
    END) AS on_time_orders,

    ROUND(
        100.0 * SUM(CASE
            WHEN delivery_status IN ('Early', 'Exact Date') THEN 1
            ELSE 0
        END) / COUNT(*), 2
    ) AS on_time_percentage

FROM gift_delivery_orders

GROUP BY
    CASE
        WHEN distance_km <= 200 THEN '0-200 km'
        WHEN distance_km BETWEEN 201 AND 500 THEN '201-500 km'
        WHEN distance_km BETWEEN 501 AND 800 THEN '501-800 km'
        ELSE '801+ km'
    END

ORDER BY MIN(distance_km);

SELECT
    inventory_status,
    COUNT(*) AS orders,

    SUM(CASE
        WHEN delivery_status IN ('Early', 'Exact Date') THEN 1
        ELSE 0
    END) AS on_time_orders,

    ROUND(
        100.0 * SUM(CASE
            WHEN delivery_status IN ('Early', 'Exact Date') THEN 1
            ELSE 0
        END) / COUNT(*), 2
    ) AS on_time_percentage

FROM gift_delivery_orders

GROUP BY inventory_status

ORDER BY on_time_percentage DESC;

SELECT
    warehouse_city,
    COUNT(*) AS orders,

    SUM(CASE
        WHEN delivery_status IN ('Early', 'Exact Date') THEN 1
        ELSE 0
    END) AS on_time_orders,

    ROUND(
        100.0 * SUM(CASE
            WHEN delivery_status IN ('Early', 'Exact Date') THEN 1
            ELSE 0
        END) / COUNT(*), 2
    ) AS on_time_percentage

FROM gift_delivery_orders

GROUP BY warehouse_city

ORDER BY on_time_percentage DESC;

SELECT
    delivery_method,
    COUNT(*) AS orders,

    SUM(CASE
        WHEN delivery_status IN ('Early', 'Exact Date') THEN 1
        ELSE 0
    END) AS on_time_orders,

    ROUND(
        100.0 * SUM(CASE
            WHEN delivery_status IN ('Early', 'Exact Date') THEN 1
            ELSE 0
        END) / COUNT(*), 2
    ) AS on_time_percentage

FROM gift_delivery_orders

GROUP BY delivery_method

ORDER BY on_time_percentage DESC;

SELECT *
FROM gift_delivery_orders
WHERE delivery_method = 'lead';

UPDATE gift_delivery_orders
SET
    product_value = 3872.69,
    delivery_method = 'Same-Day'
WHERE order_id = 'ORD00020';

SELECT
    order_id,
    product_value,
    delivery_method
FROM gift_delivery_orders
WHERE order_id = 'ORD00020';

UPDATE gift_delivery_orders
SET product_value = 3872.69,
    delivery_method = 'Same-Day'
WHERE order_id = 'ORD00020';
SELECT order_id, product_value, delivery_method
FROM gift_delivery_orders
WHERE order_id = 'ORD00020';

SELECT COUNT(*) AS total_rows
FROM gift_delivery_orders;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS unique_orders
FROM gift_delivery_orders;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS unique_orders,
    COUNT(*) - COUNT(DISTINCT order_id) AS duplicate_rows
FROM gift_delivery_orders;

CREATE TABLE gift_delivery_orders_backup AS
SELECT * FROM gift_delivery_orders;
SELECT COUNT(*) AS backup_rows
FROM gift_delivery_orders_backup;

CREATE TABLE gift_delivery_orders_clean AS
SELECT *
FROM gift_delivery_orders
GROUP BY order_id;
SHOW TABLES LIKE 'gift_delivery_orders_clean';
SELECT
    COUNT(*) AS clean_rows,
    COUNT(DISTINCT order_id) AS unique_orders
FROM gift_delivery_orders_clean;

DROP TABLE IF EXISTS gift_delivery_orders_clean;

CREATE TABLE gift_delivery_orders_clean AS
SELECT *
FROM gift_delivery_orders
WHERE id IN (
    SELECT MIN(id)
    FROM gift_delivery_orders
    GROUP BY order_id
);

DESCRIBE gift_delivery_orders;
DROP TABLE IF EXISTS gift_delivery_orders_clean;
CREATE TABLE gift_delivery_orders_clean AS
SELECT
    order_id,
    MAX(order_date) AS order_date,
    MAX(occasion_type) AS occasion_type,
    MAX(occasion_date) AS occasion_date,
    MAX(customer_city) AS customer_city,
    MAX(recipient_city) AS recipient_city,
    MAX(region) AS region,
    MAX(product_category) AS product_category,
    MAX(product_value) AS product_value,
    MAX(delivery_method) AS delivery_method,
    MAX(warehouse_city) AS warehouse_city,
    MAX(distance_km) AS distance_km,
    MAX(inventory_status) AS inventory_status,
    MAX(promised_delivery_date) AS promised_delivery_date,
    MAX(actual_delivery_date) AS actual_delivery_date,
    MAX(delivery_status) AS delivery_status,
    MAX(delivery_type) AS delivery_type,
    MAX(lead_time) AS lead_time
FROM gift_delivery_orders
GROUP BY order_id;
SELECT
    COUNT(*) AS clean_rows,
    COUNT(DISTINCT order_id) AS unique_orders
FROM gift_delivery_orders_clean;

SELECT
    COUNT(*) AS total_orders,
    COUNT(DISTINCT order_id) AS unique_orders,
    COUNT(*) - COUNT(DISTINCT order_id) AS duplicates
FROM gift_delivery_orders_clean;

SELECT delivery_method, COUNT(*) AS orders
FROM gift_delivery_orders_clean
GROUP BY delivery_method
ORDER BY orders DESC;

DROP TABLE gift_delivery_orders;
RENAME TABLE gift_delivery_orders_clean
TO gift_delivery_orders;
SELECT COUNT(*) AS total_orders,
       COUNT(DISTINCT order_id) AS unique_orders
FROM gift_delivery_orders;


SELECT
    region,
    COUNT(*) AS orders,
    SUM(
        CASE
            WHEN delivery_status IN ('Early', 'Exact Date')
            THEN 1
            ELSE 0
        END
    ) AS on_time_orders,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN delivery_status IN ('Early', 'Exact Date')
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS on_time_percentage
FROM gift_delivery_orders
GROUP BY region
ORDER BY on_time_percentage DESC;

SELECT
    occasion_type,
    COUNT(*) AS orders,
    SUM(
        CASE
            WHEN delivery_status IN ('Early', 'Exact Date')
            THEN 1
            ELSE 0
        END
    ) AS on_time_orders,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN delivery_status IN ('Early', 'Exact Date')
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS on_time_percentage
FROM gift_delivery_orders
GROUP BY occasion_type
ORDER BY on_time_percentage DESC;

SELECT
    product_category,
    COUNT(*) AS orders,
    SUM(
        CASE
            WHEN delivery_status IN ('Early', 'Exact Date')
            THEN 1
            ELSE 0
        END
    ) AS on_time_orders,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN delivery_status IN ('Early', 'Exact Date')
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS on_time_percentage
FROM gift_delivery_orders
GROUP BY product_category
ORDER BY on_time_percentage DESC;

SELECT
    delivery_type,
    COUNT(*) AS orders,
    SUM(
        CASE
            WHEN delivery_status IN ('Early', 'Exact Date')
            THEN 1
            ELSE 0
        END
    ) AS on_time_orders,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN delivery_status IN ('Early', 'Exact Date')
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS on_time_percentage
FROM gift_delivery_orders
GROUP BY delivery_type
ORDER BY on_time_percentage DESC;

SELECT
    CASE
        WHEN lead_time <= 2 THEN '0–2 days'
        WHEN lead_time BETWEEN 3 AND 5 THEN '3–5 days'
        WHEN lead_time BETWEEN 6 AND 8 THEN '6–8 days'
        WHEN lead_time BETWEEN 9 AND 12 THEN '9–12 days'
        ELSE '13+ days'
    END AS lead_time_group,
    COUNT(*) AS orders,
    SUM(
        CASE
            WHEN delivery_status IN ('Early', 'Exact Date')
            THEN 1
            ELSE 0
        END
    ) AS on_time_orders,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN delivery_status IN ('Early', 'Exact Date')
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS on_time_percentage
FROM gift_delivery_orders
GROUP BY lead_time_group
ORDER BY
    MIN(lead_time);
    
    SELECT
    CASE
        WHEN distance_km <= 200 THEN '0–200 km'
        WHEN distance_km BETWEEN 201 AND 500 THEN '201–500 km'
        WHEN distance_km BETWEEN 501 AND 800 THEN '501–800 km'
        ELSE '801+ km'
    END AS distance_group,
    COUNT(*) AS orders,
    SUM(
        CASE
            WHEN delivery_status IN ('Early', 'Exact Date')
            THEN 1
            ELSE 0
        END
    ) AS on_time_orders,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN delivery_status IN ('Early', 'Exact Date')
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS on_time_percentage
FROM gift_delivery_orders
GROUP BY distance_group
ORDER BY MIN(distance_km);

SELECT
    CASE
        WHEN lead_time <= 2 THEN '0–2 days'
        WHEN lead_time BETWEEN 3 AND 5 THEN '3–5 days'
        WHEN lead_time BETWEEN 6 AND 8 THEN '6–8 days'
        WHEN lead_time BETWEEN 9 AND 12 THEN '9–12 days'
        ELSE '13+ days'
    END AS lead_time_group,

    CASE
        WHEN distance_km <= 200 THEN '0–200 km'
        WHEN distance_km BETWEEN 201 AND 500 THEN '201–500 km'
        WHEN distance_km BETWEEN 501 AND 800 THEN '501–800 km'
        ELSE '801+ km'
    END AS distance_group,

    COUNT(*) AS orders,

    SUM(
        CASE
            WHEN delivery_status IN ('Early', 'Exact Date')
            THEN 1
            ELSE 0
        END
    ) AS on_time_orders,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN delivery_status IN ('Early', 'Exact Date')
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS on_time_percentage

FROM gift_delivery_orders
GROUP BY lead_time_group, distance_group
ORDER BY
    MIN(lead_time),
    MIN(distance_km);
    
    SELECT
    CASE
        WHEN lead_time <= 2 THEN '0–2 days'
        WHEN lead_time BETWEEN 3 AND 5 THEN '3–5 days'
        WHEN lead_time BETWEEN 6 AND 8 THEN '6–8 days'
        WHEN lead_time BETWEEN 9 AND 12 THEN '9–12 days'
        ELSE '13+ days'
    END AS lead_time_group,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN delivery_status IN ('Early', 'Exact Date')
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS overall_on_time_percentage,

    CASE
        WHEN
            100.0 * SUM(
                CASE
                    WHEN delivery_status IN ('Early', 'Exact Date')
                    THEN 1
                    ELSE 0
                END
            ) / COUNT(*) >= 90
        THEN 'Very High'

        WHEN
            100.0 * SUM(
                CASE
                    WHEN delivery_status IN ('Early', 'Exact Date')
                    THEN 1
                    ELSE 0
                END
            ) / COUNT(*) >= 70
        THEN 'High'

        WHEN
            100.0 * SUM(
                CASE
                    WHEN delivery_status IN ('Early', 'Exact Date')
                    THEN 1
                    ELSE 0
                END
            ) / COUNT(*) >= 50
        THEN 'Moderate'

        WHEN
            100.0 * SUM(
                CASE
                    WHEN delivery_status IN ('Early', 'Exact Date')
                    THEN 1
                    ELSE 0
                END
            ) / COUNT(*) >= 30
        THEN 'Low'

        ELSE 'Very Low'
    END AS reliability_level

FROM gift_delivery_orders
GROUP BY lead_time_group
ORDER BY MIN(lead_time);

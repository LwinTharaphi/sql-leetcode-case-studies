-- Problem: to find patients who have recovered from COVID - patients who tested positive but later tested negative.

-- A patient is considered recovered if they have at least one Positive test followed by at least one Negative test on a later date
-- Calculate the recovery time in days as the difference between the first positive test and the first negative test after that positive test
-- Only include patients who have both positive and negative test results

WITH first_positive AS (
    SELECT 
        patient_id,
        MIN(test_date) AS first_positive_date
    FROM covid_tests
    WHERE result = 'Positive'
    GROUP BY patient_id
),

recovery_dates AS (
    SELECT
        fp.patient_id,
        DATEDIFF(
            MIN(CASE 
                    WHEN ct.result = 'Negative'
                     AND ct.test_date > fp.first_positive_date
                    THEN ct.test_date
                END),
            fp.first_positive_date
        ) AS recovery_time
    FROM first_positive fp
    JOIN covid_tests ct
      ON ct.patient_id = fp.patient_id
    GROUP BY fp.patient_id, fp.first_positive_date
    HAVING recovery_time IS NOT NULL
)

SELECT
    p.patient_id,
    p.patient_name,
    p.age,
    r.recovery_time
FROM patients p
JOIN recovery_dates r
  ON p.patient_id = r.patient_id
ORDER BY r.recovery_time ASC, p.patient_name ASC;




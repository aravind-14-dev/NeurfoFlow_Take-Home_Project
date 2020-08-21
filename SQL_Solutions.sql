/* 1. How many users completed an exercise in their first month per monthly cohort? */
/*Typical month is assumed as 30 days*/

SELECT date_format(u.created_at, '%M-%Y') AS Cohort,
       count(CASE
                 WHEN (e.exercise_completion_date - u.created_at)<30 THEN u.user_id
             END)/count(u.user_id) * 100 AS Percentage_of_Users
FROM users u
INNER JOIN exercises e USING(user_id)
GROUP BY Cohort;



/* 2. How many users completed a given amount of exercises? */

SELECT count(user_id) AS Number_of_Users,
       Num_of_Act AS Number_of_Activities
FROM
  (SELECT user_id,
          count(exercise_id) AS Num_of_Act
   FROM exercises
   GROUP BY user_id) AS temp1
INNER JOIN users USING(user_id)
GROUP BY Num_of_Act;


/* 3. Which organizations have the most severe patient population? */ 

SELECT organisation_name AS Organisation,
       avg(score) AS Average
FROM Providers
INNER JOIN Phq9 USING(provider_id)
GROUP BY Organisation
ORDER BY Average DESC
LIMIT 5;
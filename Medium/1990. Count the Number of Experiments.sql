-- Table: Experiments

-- +-----------------+------+
-- | Column Name     | Type |
-- +-----------------+------+
-- | experiment_id   | int  |
-- | platform        | enum |
-- | experiment_name | enum |
-- +-----------------+------+
-- experiment_id is the primary key for this table.
-- platform is an enum with one of the values ('Android', 'IOS', 'Web').
-- experiment_name is an enum with one of the values ('Reading', 'Sports', 'Programming').
-- This table contains information about the ID of an experiment done with a random person, the platform used to do the experiment, and the name of the experiment.


-- Write an SQL query to report the number of experiments done on each of the three platforms for each of the three given experiments. Notice that all the pairs of (platform, experiment) should be included in the output including the pairs with zero experiments.

-- Return the result table in any order.

-- The query result format is in the following example.



-- Example 1:

-- Input:
-- Experiments table:
-- +---------------+----------+-----------------+
-- | experiment_id | platform | experiment_name |
-- +---------------+----------+-----------------+
-- | 4             | IOS      | Programming     |
-- | 13            | IOS      | Sports          |
-- | 14            | Android  | Reading         |
-- | 8             | Web      | Reading         |
-- | 12            | Web      | Reading         |
-- | 18            | Web      | Programming     |
-- +---------------+----------+-----------------+
-- Output:
-- +----------+-----------------+-----------------+
-- | platform | experiment_name | num_experiments |
-- +----------+-----------------+-----------------+
-- | Android  | Reading         | 1               |
-- | Android  | Sports          | 0               |
-- | Android  | Programming     | 0               |
-- | IOS      | Reading         | 0               |
-- | IOS      | Sports          | 1               |
-- | IOS      | Programming     | 1               |
-- | Web      | Reading         | 2               |
-- | Web      | Sports          | 0               |
-- | Web      | Programming     | 1               |
-- +----------+-----------------+-----------------+
-- Explanation:
-- On the platform "Android", we had only one "Reading" experiment.
-- On the platform "IOS", we had one "Sports" experiment and one "Programming" experiment.
-- On the platform "Web", we had two "Reading" experiments and one "Programming" experiment.


With t as (

SELECT platform, experiment_name
    FROM
    (
        SELECT 'Android' AS platform
        UNION
        SELECT 'IOS'
        UNION
        SELECT 'Web'
    ) t1
    CROSS JOIN
    (
        SELECT 'Reading' AS experiment_name
        UNION
        SELECT 'Sports'
        UNION
        SELECT 'Programming'
    ) t2
ORDER BY platform
    )

select t.platform, t.experiment_name, COUNT(experiment_id) AS num_experiments
from t
left join Experiments e
 on t.platform = e.platform
 and t.experiment_name = e.experiment_name
 GROUP BY t.platform, t.experiment_name
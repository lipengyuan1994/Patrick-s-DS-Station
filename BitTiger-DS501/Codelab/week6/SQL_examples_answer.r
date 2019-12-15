# please install sqldf package before class
library(sqldf) 
########## Q1 select 10th highest spend ###########
id = seq(1:100)
date = sort(rep(c('01/01/1990','01/02/1990','01/03/1990','01/04/1990','01/05/1990'), 20))
s = rnorm(100, 50, 10)
order_table = data.frame('id'=id, 'date'=date,'spend'=s)
# 1
sqldf("SELECT *
      FROM(
      SELECT Spend
      FROM order_table
      ORDER BY Spend DESC
      LIMIT 10)
      ORDER BY Spend LIMIT 1;")

# 2 note rank() over is not available in sqldf
sqldf("SELECT 
      FROM (SELECT *
      , RANK() OVER (ORDER BY Spend DESC)
      AS rk
      FROM order_table)
      WHERE rk = 10;
      ")

########## Q2 cancellation rate ###########
id = seq(1:10)
client_id = c(1,2,3,4,1,2,3,2,3,4)
driver_id = c(10,11,12,13,10,11,12,12,10,13)
city_id = c(1,1,6,6,1,6,6,12,12,12)
status = c('completed','cancelled_by_driver','completed','cancelled_by_client',
           'completed','completed','completed','completed','completed','cancelled_by_driver')
request_at = c('2013-10-01', rep('2013-10-01',3), rep('2013-10-02',3), rep('2013-10-03',3))

trips = data.frame('id'=id,'client_id'=client_id,'driver_id'=driver_id,
                   'city_id'=city_id,'status'=status,'request_at' = request_at)

users_id = c(1,2,3,4,10,11,12,13)
banned = rep('No',8)
banned[2] = 'Yes'
role = sort(rep(c('client','driver'), 4))

users = data.frame('users_id'=users_id, 'banned'=banned, 'role'=role)

sqldf("select request_at AS day,
           SUM(CASE WHEN status like 'cancel%' THEN 1 ELSE 0 END)/COUNT(1) AS cancellation_rate
       from trips t
       join users u
       on t.client_id = u.users_id
       and u.role = 'client'
       and u.banned = 'No'
       group by request_at
      ")
# check result, does it look right? why all 0?

# int/int gives int result, need to CAST to double
sqldf("select request_at AS day,
      CAST(SUM(status like 'com%') as double)/CAST(COUNT(1) as double) AS cancellation_rate
      from trips t
      join users u
      on t.client_id = u.users_id
      and u.role = 'client'
      and u.banned = 'No'
      group by request_at
      ")

########## Q3 spend trend ###########
campaigns = data.frame('aid' = c(1,1,1,2,2,2,3), 'cid' = c(123,130,140,235,236,237,300))
spend = data.frame('cid'=c(123,123,234,140,235,236,237,300),
                   'date'=c('08/01/17','08/02/17','09/01/17','09/15/17','07/01/17','08/01/17','09/01/17','08/20/17'),
                   'spend' = c(200,150,500,300,100,200,150,100))
# r cannot run rank(), no date_diff
sqldf("WITH cs AS
      (SELECT aid, date, sum(spend) AS daily_spend
      FROM campaigns c
      JOIN spend s
      ON c.cid =  s.cid
      GROUP BY 1, 2)

      SELECT AVG(DATEDIFF(first_date,maxspend_date)) AS time
      FROM (SELECT aid, 
                   MIN(date) AS first_date
            FROM cs
            GROUP BY aid
            ) first
      JOIN (SELECT aid,
                   date AS maxspend_date
            FROM cs
            WHERE rank() OVER (PARTITION BY aid ORDER BY
                  daily_spend DESC)  = 1
            )  max
      JOIN (SELECT aid,
                   max(date) AS last_date
            FROM cs
            GROUP BY aid
            ) last
      ON first.aid = max.aid
      AND first.aid = last.aid
      WHERE maxspend_date != last_date
      ")

########## Q4 mutual friend ###########
uid1 = c('A','A','B','B','B','C','D')
uid2 = c('B','C','A','C','D','A','C')
friend = data.frame('uid1' = uid1, 'uid2' = uid2)

# get mutual friends
sqldf("select f1.uid1 AS uid1, f1.uid2 AS mutual, f2.uid2 AS uid2
      FROM friend f1 
      JOIN friend f2 
      ON f1.uid2 = f2.uid1
      ")

# make it more efficient
sqldf("select f1.uid1 AS uid1, f2.uid2 AS uid2,
      COUNT(distinct f1.uid2) AS mutual_friends 
      FROM friend f1 
      JOIN friend f2 
      ON f1.uid2 = f2.uid1
      AND f1.uid1 < f2.uid2
      GROUP BY f1.uid1, f2.uid2")

# remove existing friends
sqldf("SELECT second.uid1,
      second.uid2,
      mutual_friends
      FROM (SELECT f1.uid1 AS uid1, 
      f2.uid2 AS uid2,
      COUNT(distinct f1.uid2) AS mutual_friends                  
      FROM friend f1             
      JOIN friend f2              
      ON f1.uid2 = f2.uid1             
      AND f1.uid1 < f2.uid2             
      GROUP BY f1.uid1, f2.uid2) second
      
      LEFT OUTER JOIN friend f
      ON second.uid1 = f.uid1
      AND second.uid2 = f.uid2
      WHERE f.uid2 IS NULL")

# Q2
job = data.frame('uid' = sort(rep(c('A','B'),4)),
                 'jobid' = c(11:14,11,12,13,15))
# find friends applied to >=3 job postings
common = sqldf("SELECT f.uid1,
                       f.uid2
              FROM job j1
              JOIN friend f
              ON j1.uid = f.uid1
              AND f.uid1<f.uid2
        
              JOIN job j2
              ON j2.uid = f.uid2
              
              GROUP BY 1,2
              HAVING count(1)>=3")
# find recommendated jobs with full outer join
sqldf("
      SELECT uid1, uid2, 
             j1.jobid AS recommend_u2, 
             j2.jobid AS recommend_u1
      FROM common c
      JOIN job j1
      ON c.uid1 = j1.uid
      FULL OUTER JOIN job j2
      ON c.uid2 = j2.uid
      AND j1.jobid = j2.jobid
      WHERE j1.jobid IS NULL OR j2.jobid IS NULL
      ")

# FULL outer join not suppoted in R, can use left outer join to test

########## Q5 pivot ###########
p = rep(c('A','B','C'),3)
u = c(1,1,1,2,2,2,3,3,3)
v = sample(0:20,9)
d = data.frame('user'=u,'product'=p,'volume'=v)

#pivot
pivot = sqldf("select user, 
              MAX(case when product = 'A' then volume end) ProductA, 
              MAX(case when product = 'B' then volume end) ProductB,
              MAX(case when product = 'C' then volume end) ProductC
      from d group by 1")

#unpivot
sqldf("select user, 'A' as product, productA as volume
       from pivot
       union all
       select user, 'B' as product, productB as volume
       from pivot
       union all
       select user, 'C' as product, productC as volume
       from pivot
      ")





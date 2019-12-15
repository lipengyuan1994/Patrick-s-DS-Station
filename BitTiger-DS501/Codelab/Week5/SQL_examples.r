# please install sqldf package before class
library(sqldf) 

########## Q1 select 10th highest spend ###########
id = seq(1:100)
date = sort(rep(c('01/01/1990','01/02/1990','01/03/1990','01/04/1990','01/05/1990'), 20))
s = rnorm(100, 50, 10)
order_table = data.frame('id'=id, 'date'=date,'spend'=s)

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

########## Q3 spend trend ###########
campaigns = data.frame('aid' = c(1,1,1,2,2,2,3), 'cid' = c(123,130,140,235,236,237,300))
spend = data.frame('cid'=c(123,123,234,140,235,236,237,300),
                   'date'=c('08/01/17','08/02/17','09/01/17','09/15/17','07/01/17','08/01/17','09/01/17','08/20/17'),
                   'spend' = c(200,150,500,300,100,200,150,100))


########## Q4 mutual friend ###########
uid1 = c('A','A','B','B','B','C','D')
uid2 = c('B','C','A','C','D','A','C')
friend = data.frame('uid1' = uid1, 'uid2' = uid2)


# Q2
job = data.frame('uid' = sort(rep(c('A','B'),4)),
                 'jobid' = c(11:14,11,12,13,15))

########## Q5 pivot ###########
p = rep(c('A','B','C'),3)
u = c(1,1,1,2,2,2,3,3,3)
v = sample(0:20,9)
d = data.frame('user'=u,'product'=p,'volume'=v)

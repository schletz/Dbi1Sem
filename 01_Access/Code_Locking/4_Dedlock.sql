/************/
/* DEADLOCK */
/************/
!!!!!!!!!!!!
!!! ALEX !!!
!!!!!!!!!!!!

/*0*/
   SET AUTOCOMMIT OFF;

   DELETE FROM customer;

   INSERT INTO customer VALUES (1, 'Fritz',   800);
   INSERT INTO customer VALUES (2, 'Susi',   1000);
   INSERT INTO customer VALUES (3, 'Werner', -200);
   INSERT INTO customer VALUES (4, 'Hans',      0);
   INSERT INTO customer VALUES (5, 'Alex',    400);
   INSERT INTO customer VALUES (6, 'Thomas',  100);

   COMMIT;
/*0*/

/*1*/
   UPDATE customer
   SET    balance = balance - 100
   WHERE  customer_id = 1;
/*1*/

/*3*/
   UPDATE customer
   SET    balance = balance + 100
   WHERE  customer_id = 6;
/*3*/

!!!!!!!!!!!!!!
!!! ANDREA !!!
!!!!!!!!!!!!!!
/*2*/
   SET AUTOCOMMIT OFF;

   UPDATE alex.customer
   SET    balance = balance + 500
   WHERE  customer_id = 6;
/*2*/

/*4*/
   UPDATE alex.customer
   SET    balance = balance - 500
   WHERE  customer_id = 1;
/*4*/
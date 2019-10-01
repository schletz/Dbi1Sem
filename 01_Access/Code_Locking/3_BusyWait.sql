/*************/
/* BUSY WAIT */
/*************/
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
   SELECT *
   FROM   customer
   WHERE  customer_id = 1;

   SELECT *
   FROM   customer
   WHERE  customer_id = 2;

   /* CHECK LOCK !!! */

   UPDATE customer
   SET    balance = balance - 100
   WHERE  customer_id = 1;

   UPDATE customer
   SET    balance = balance + 100
   WHERE  customer_id = 2;

   /* CHECK LOCK !!! */
/*1*/

/*3*/
   COMMIT;
/*3*/


!!!!!!!!!!!!!!
!!! ANDREA !!!
!!!!!!!!!!!!!!
/*2*/
   SET AUTOCOMMIT OFF;

   SELECT *
   FROM   alex.customer
   WHERE  customer_id = 1;

   /* CHECK LOCK !!! */

   UPDATE alex.customer
   SET    balance = balance + 100
   WHERE  customer_id = 1;
/*2*/
SELECT SID,
       DECODE ( block,
                    0, 'Not Blocking',
                    1, 'Blocking',
                    2, 'Global'
               ) status,
        DECODE (lmode,
                    0, 'None',
                    1, 'Null',
                    2, 'Row-S (SS)',
                    3, 'Row-X (SX)',
                    4, 'Share',
                    5, 'S/Row-X (SSX)',
                    6, 'Exclusive', TO_CHAR(lmode)
                ) mode_held,
        DECODE (REQUEST,
                    0, 'None',
                    1, 'Null',
                    2, 'Row-S (SS)',
                    3, 'Row-X (SX)',
                    4, 'Share',
                    5, 'S/Row-X (SSX)',
                    6, 'Exclusive', TO_CHAR(lmode)
                ) mode_request
FROM   v$lock
WHERE  TYPE = 'TM';

SELECT do.object_name,
       row_wait_obj#,
       row_wait_file#,
       row_wait_block#,
       row_wait_row#,
       dbms_rowid.rowid_create (1, ROW_WAIT_OBJ#, ROW_WAIT_FILE#,ROW_WAIT_BLOCK#, ROW_WAIT_ROW#)
FROM   v$session s,
       dba_objects do
WHERE  SID in (59, 60) and
       s.ROW_WAIT_OBJ# = do.OBJECT_ID;

SELECT *
FROM   alex.CUSTOMER
WHERE  ROWID = 'AAATTTAAEAAAADbAAA';
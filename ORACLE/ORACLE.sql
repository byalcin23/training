SELECT 
    ORDER_ID,
    LISTAGG(ID_, ', ') WITHIN GROUP (ORDER BY ID_) "IDLER"
FROM order_table2
GROUP BY ORDER_ID

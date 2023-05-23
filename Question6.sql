SELECT
  sp_p2.cat_id,
  sp_p2.cat_name,
  sp_p2.pro_name AS 'product name',
  sp_p2.supp_price AS 'product price'
FROM (
  SELECT
    c.*,
    sp_p.pro_id,
    sp_p.pro_name,
    sp_p.supp_price,
    RANK() OVER (
      PARTITION BY c.cat_id
      ORDER BY sp_p.supp_price
    ) AS price_rank
  FROM category c
  INNER JOIN (
    SELECT p.*, sp.supp_price
    FROM supplier_pricing sp
    INNER JOIN product p
    ON sp.pro_id = p.pro_id
  ) AS SP_P
  ON c.cat_id = sp_p.cat_id
) AS SP_P2
WHERE price_rank = 1;

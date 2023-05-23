select sp_p2.cat_id, sp_p2.cat_name, sp_p2.pro_name as 'product name', sp_p2.supp_price as 'product price' from (select c.*, sp_p.pro_id, sp_p.pro_name, sp_p.supp_price, rank() over(partition by c.cat_id order by sp_p.supp_price) as price_rank from category c inner join
(select p.*, sp.supp_price from supplier_pricing sp inner join
product p
on sp.pro_id = p.pro_id) as SP_P
on c.cat_id = sp_p.cat_id) as SP_P2
where price_rank = 1
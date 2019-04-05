

#report the total price of items which have discount in each shopping list
select `Shopping List`.ID, `Shopping List`.`List Name`, round(sum((1-Discount)*price*Quantity),2) as Total from Items, specials, `Items_has_Shopping List`, `Shopping List` 
where Items.ItemID = `Items_has_Shopping List`.Items_ItemID
and `Items_has_Shopping List`.`Shopping List_ID` = `Shopping List`.ID
and specials.ID = Items.Specials_ID 
group by `Shopping List`.ID ;


#report the total current price (after discount) for each shopping list 
select `Shopping List`.ID, `Shopping List`.`List Name`, round(sum((1-ifnull(discount,0))*price*Quantity),2) as Total from 
(items left join specials on Specials.ID = items.Specials_ID), `Items_has_Shopping List`, `Shopping List` 
where Items.ItemID = `Items_has_Shopping List`.Items_ItemID
and `Items_has_Shopping List`.`Shopping List_ID` = `Shopping List`.ID
group by `Shopping List`.ID;

# select customer(s) that has account with more than 1 card
select FName, Lname from customers, account
	where account.Customers_UserID = customers.UserID
    and account.AccountID in (select Account_AccountID from card_has_account
    group by account_accountID having count(*) >1);
    
    #report the account which has more card than the average number of card for each account
select AccountID, count(*) as Num, (select avg(Num) from
(select AccountID, count(*) as Num from Card, card_has_account, Account
where card.`Card Number`=card_has_account.`Card_Card Number`
and card_has_account.Account_AccountID=Account.AccountID
group by AccountID) as t1 )as average 
from Card, card_has_account, Account
where card.`Card Number`=card_has_account.`Card_Card Number`
and card_has_account.Account_AccountID=Account.AccountID
group by AccountID
having Num>average;



#find the items that have a special greater than the average special
select ItemName, Price, Manufacture from items where items.Specials_ID in 
(select ID from specials where discount > (select avg(discount) from specials)) order by price desc;


# find the shopping lists of customers with Yahoo email addresses
select * from `shopping list` where Customers_UserID in 
(select UserID from customers where email regexp 'yahoo');



# find the physical address of customers who joined this year
select *from address where AddressID in 
(select address_addressID from customers where userID in 
(select Customers_UserID from account where Year(`Join Date`)=2018)) ;

select Email, Phone from Customers 
where Lname = 'Newton'
and exists (select Password from Account where
Customers.UserID = Account.Customers_UserID);

select avg(`Shelf life (days)`) as averageShelfLife, ItemName, `category name`from Items, category
where items.Category_CategoryID= category.CategoryID
and `Shelf life (days)`<10000000
group by `category name`
order by averageShelfLife desc;

#select customers' address which beginning with "w"
select userid, fname, lname, City, Country, street from customers,Address 
where customers.address_addressid=address.AddressID
and Street regexp'^W';

# select customer(s) that has account with more than 1 card
select FName, Lname from customers, account
	where account.Customers_UserID = customers.UserID
    and account.AccountID in (select Account_AccountID from card_has_account
    group by account_accountID having count(*) >1);
    


select itemid, itemname
from items
where not exists (select * from store where not exists
(select * from items_has_store
where items.ItemID = items_has_store.Items_ItemID
and items_has_store.Store_Store_ID=store.Store_ID))

    
    
    
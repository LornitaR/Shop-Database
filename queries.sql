CREATE VIEW ProductReviews AS
(SELECT Products.ProductName, Artisans.ShopName, Reviews.ReviewText, Reviews.Rating FROM Products JOIN Reviews on Products.ProductID = Reviews.ProductID JOIN Artisans on Artisans.ArtisanID = Products.ArtisanID);

CREATE VIEW ArtisanAddresses AS
(SELECT ShopName, Guild, StreetName, County, Town, Bio
FROM Artisans JOIN Locations ON Artisans.LocationID = Locations.LocationID);


CREATE INDEX ProductIDX ON Reviews(CustomerID, ProductID, Date);
CREATE INDEX PurchaseIDX ON Purchases(CustomerID, ProductID);


SELECT * 
FROM Artisans 
HAVING ArtisanID IN
(SELECT ArtisanID
FROM Products JOIN Reviews ON Products.ProductID = Reviews.ProductID
WHERE Rating >= 3 );

SELECT Name 
FROM Customers JOIN Reviews 
ON Customers.CustomerID = Reviews.CustomerID 
HAVING COUNT(ReviewText) >= ALL
(SELECT ReviewText
FROM Customers JOIN Reviews 
WHERE Customers.CustomerID = Reviews.CustomerID);

SELECT Name
FROM customeraddresses
WHERE County =  'Limerick'
GROUP BY Town
HAVING COUNT(Name) > 2;

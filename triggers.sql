delimiter //
CREATE TRIGGER DeleteArtisan 
AFTER DELETE ON artisans
FOR EACH ROW BEGIN 

IF OLD.ArtisanID IN (SELECT ArtisanID FROM products) THEN
DELETE FROM Products WHERE ArtisanID = OLD.ArtisanID;
END IF;

IF OLD.ArtisanID IN (SELECT ArtisanID FROM products WHERE ProductID IN (SELECT ProductID FROM reviews)) THEN
DELETE FROM Reviews WHERE ProductID IN (
SELECT ProductID
FROM Products
WHERE ArtisanID = OLD.ArtisanID
);
END IF;
END;//

CREATE TRIGGER UpdateQuantity 
AFTER INSERT ON purchases
FOR EACH ROW BEGIN
UPDATE products SET Quantity = Quantity - NEW.Quantity WHERE ProductID = NEW.ProductID;

END ;//

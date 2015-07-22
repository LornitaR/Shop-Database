CREATE TABLE Locations (
    LocationID   INT          NOT NULL,
    StreetName   VARCHAR (50) NOT NULL,
    Town         VARCHAR (50) NOT NULL,
    County       VARCHAR (50) NOT NULL,
    PRIMARY KEY (LocationID)
);

INSERT INTO Locations (LocationID, StreetName, Town, County)
VALUES(1234, 'Street 1', 'Miltown', 'Clare');
INSERT INTO Locations (LocationID, StreetName, Town, County)
VALUES(1111,'Street 1', 'Newtown', 'Limerick');
INSERT INTO Locations (LocationID, StreetName, Town, County)
VALUES(2222, 'Street 1', 'Miltown', 'Kerry');
INSERT INTO Locations (LocationID, StreetName, Town, County)
VALUES(3333, 'Street 1', 'Milford', 'Limerick');
INSERT INTO Locations (LocationID, StreetName, Town, County)
VALUES(4444, 'Street 1', 'Dublin City', 'Dublin');


CREATE TABLE Customers (
    CustomerID   INT NOT NULL,
    Name         VARCHAR (50)  NOT NULL,
    LocationID   INT NOT NULL,
    DateOfBirth  DATETIME      NOT NULL,

    PRIMARY KEY (CustomerID ),
    FOREIGN KEY (LocationID) REFERENCES Locations(LocationID) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Customers(CustomerID, Name, LocationID, DateOfBirth) 
VALUES (4321, 'Jane Doe', 1234, '1973-02-05 00:00:00');
INSERT INTO Customers(CustomerID, Name, LocationID, DateOfBirth) 
VALUES (1234, 'John Smith', 1111, '1964-08-12 00:00:00');
INSERT INTO Customers(CustomerID, Name, LocationID, DateOfBirth) 
VALUES (1111, 'Max Power', 2222, '1993-06-06 00:00:00');
INSERT INTO Customers(CustomerID, Name, LocationID, DateOfBirth) 
VALUES (2222, 'Peter Parker', 3333, '1945-02-09 00:00:00');
INSERT INTO Customers(CustomerID, Name, LocationID, DateOfBirth) 
VALUES (3333, 'Mary McAleese', 4444, '1973-02-05 00:00:00');



CREATE TABLE Artisans (
    ArtisanID      INT           NOT NULL,
    Guild          VARCHAR (50)  NULL,
    ShopName       VARCHAR (50)  NULL,
    LocationID     INT           NOT NULL,
    Bio            VARCHAR (50) NULL,
   
    PRIMARY KEY (ArtisanID),
    FOREIGN KEY (LocationID) REFERENCES Locations (LocationID) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Artisans (ArtisanID, Guild, ShopName, LocationID, Bio)  
VALUES(4455, 'Woodwork', 'Woodies', 1234, 'Aa');
INSERT INTO Artisans (ArtisanID, Guild, ShopName, LocationID, Bio)  
VALUES(5566, 'Textiles', 'Seams', 1111, 'Bb');
INSERT INTO Artisans (ArtisanID, Guild, ShopName, LocationID, Bio)  
VALUES(6677, 'Masonry', 'Stonewall', 2222, 'Cc');
INSERT INTO Artisans (ArtisanID, Guild, ShopName, LocationID, Bio)  
VALUES(4567, 'Pottery', 'Harry Potter', 3333, 'Dd');
INSERT INTO Artisans (ArtisanID, Guild, ShopName, LocationID, Bio)  
VALUES(6789, 'Metalwork', 'Metallica', 4444, 'Ee');





CREATE TABLE Products (
    ProductID         INT           NOT NULL,
    ProductName       VARCHAR (50)  NOT NULL,
    ArtisanID         INT           NOT NULL,
    ProductCost       DECIMAL (18)  NULL,
    Description       VARCHAR (50)  NULL,
    DateAdded         DATETIME      NULL,
    Quantity          INT           NOT NULL,
    AverageRating     INT           NULL,
    NumberOfReviews   INT           NULL,

    PRIMARY KEY (ProductID),
    FOREIGN KEY (ArtisanID) REFERENCES Artisans (ArtisanID) ON DELETE NO ACTION ON UPDATE NO ACTION
);

INSERT INTO Products (ProductID, ProductName, ArtisanID, ProductCost, Description, DateAdded, Quantity)
VALUES(6644, 'Purse', 4455, 5.00, 'Leather purse for women', '2015-05-01 00:00:00', 115);
INSERT INTO Products (ProductID, ProductName, ArtisanID, ProductCost, Description, DateAdded,  Quantity)
VALUES(8877,  'Guitar', 5566, 75.00, 'Electric Guitar', '2015-05-01 00:00:00', 47);
INSERT INTO Products (ProductID, ProductName, ArtisanID, ProductCost, Description, DateAdded, Quantity)
VALUES(7766, 'Table', 6677, 114.99, 'Classic wooden table', '2015-05-01 00:00:00',  83);
INSERT INTO Products (ProductID, ProductName, ArtisanID, ProductCost, Description, DateAdded, Quantity)
VALUES(6655, 'Mask', 4567, 17.00, 'Spiderman mask', '2015-05-01 00:00:00', 50);
INSERT INTO Products (ProductID, ProductName, ArtisanID, ProductCost, Description, DateAdded, Quantity)
VALUES(9988, 'Frames', 6789, 18.00, 'Silver photo frame', '2015-05-01 00:00:00', 300);




CREATE TABLE Purchases (
    CustomerID         INT          NOT NULL,
    ProductID          INT          NOT NULL,
    PurchaseDate       DATE         NOT NULL,
    Quantity           INT          NOT NULL,
    PaymentMethod      CHAR (10)    NOT NULL,

        PRIMARY KEY (CustomerID, ProductID, PurchaseDate),
    FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID) ON UPDATE NO ACTION ON DELETE NO ACTION,
    FOREIGN KEY (ProductID) REFERENCES Products (ProductID) ON UPDATE NO ACTION ON DELETE NO ACTION
);

INSERT INTO Purchases (CustomerID,ProductID, PurchaseDate, Quantity, PaymentMethod) 
VALUES(4321, 9988, '2015-05-01 00:00:00', 3, 'visa');
INSERT INTO Purchases (CustomerID,ProductID, PurchaseDate, Quantity, PaymentMethod) 
VALUES(1234, 8877,'2015-05-01 00:00:00',2, 'mastercard' );
INSERT INTO Purchases (CustomerID,ProductID, PurchaseDate, Quantity, PaymentMethod) 
VALUES(1111,7766,'2015-05-01 00:00:00', 1, 'visa');
INSERT INTO Purchases (CustomerID,ProductID, PurchaseDate, Quantity, PaymentMethod) 
VALUES(2222, 6655,'2015-05-01 00:00:00', 5, 'visa');
INSERT INTO Purchases (CustomerID,ProductID, PurchaseDate, Quantity, PaymentMethod) 
VALUES(3333, 6644, '2015-05-01 00:00:00', 27, 'mastercard');



CREATE TABLE Reviews (
    CustomerID           INT          NOT NULL,
    ProductID            INT          NOT NULL,
    Date                 DATE    NOT NULL,
    ReviewText           VARCHAR (50) NOT NULL,
    Rating               INT          NOT NULL,

    PRIMARY KEY (CustomerID, ProductID, Date),

    FOREIGN KEY (ProductID) REFERENCES Products (ProductID) ON UPDATE NO ACTION ON DELETE NO ACTION,
FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID) ON UPDATE NO ACTION ON DELETE NO ACTION
);


INSERT INTO Reviews(CustomerID, ProductID, Date, ReviewText, Rating) 
VALUES(4321, 9988, '2015-05-01 00:00:00', 'Good', 4);
INSERT INTO Reviews (CustomerID, ProductID, Date, ReviewText, Rating) 
VALUES(1234, 8877, '2015-05-01 00:00:00', 'Bad', 3);
INSERT INTO Reviews (CustomerID, ProductID, Date, ReviewText, Rating) 
VALUES(1111,7766, '2015-05-01 00:00:00', 'Amazing', 5);
INSERT INTO Reviews (CustomerID, ProductID, Date, ReviewText, Rating) 
VALUES(2222, 6655,'2015-05-01 00:00:00', 'Terrible', 1);
INSERT INTO Reviews (CustomerID, ProductID, Date, ReviewText, Rating) 
VALUES(3333, 6644, '2015-05-01 00:00:00', 'Meh', 3);



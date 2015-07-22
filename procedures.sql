DELIMITER //
CREATE PROCEDURE SpecificReview
(IN pid INT(20))
BEGIN
  SELECT Date, ReviewText, ReviewText FROM Reviews
  WHERE ProductID= pid;
END//



CREATE PROCEDURE AddRatings(
            IN cid INTEGER,
            IN pid INTEGER,
            IN aDate DATETIME,
            IN aReviewText VARCHAR(50),
            IN aRating INTEGER
)

MODIFIES SQL DATA
BEGIN
     DECLARE prevRating INTEGER;

      SELECT Rating INTO prevRating 
      FROM Reviews
      WHERE CustomerID = cid AND ProductID = pid AND Date >= ALL 
                                      (SELECT Date 
                                       FROM Reviews
                                       WHERE CustomerID = cid AND ProductID = pid);
START TRANSACTION;
IF (prevRating  IS NULL)  THEN
UPDATE Products
SET AverageRating = aRating, NumberOfReviews = 1
WHERE ProductID = pid;

ELSE
UPDATE Products
SET AverageRating  = ((AverageRating * NumberOfReviews) + aRating) / (NumberOfReviews + 1), NumberOfReviews = NumberOfReviews + 1
WHERE ProductID = pid;



END IF;


INSERT INTO Reviews VALUES (cid, pid, NOW(), aReviewText, aRating);

COMMIT;
END;
//

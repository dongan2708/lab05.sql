USE AdventureWorks2012
GO

--Lấy ra dữ liệu của bảng Contact có ContactTypeID >=3 và ContactTypeID <=9
SELECT *
FROM Person.ContactType
WHERE ContactTypeID >= 3 AND ContactTypeId <=9

--lấy ra dữ liệu của bảng Contact có ContactTypeId trong đoạn [3,9]
SELECT * FROM Person.ContactType
WHERE ContactTypeID BETWEEN 3 AND 9

--LẤY ra dữ liệu của bảng Contact có ContactTypeID trong tập hợp(3,5,9)
SELECT * FROM Person.ContactType
WHERE ContactTypeID IN (1,3,5,9)

--lấy ra những Contact có LastName kết thúc bởi ký tự e
SELECT * FROM Person.Person
WHERE LastName LIKE '%e'
--lấy ra những Contact có LastName bẮt đầu bởi ký tự R hoặc A kết thúc bởi ký tự e
SELECT * FROM Person.Person
WHERE LastName LIKE '[RA]%e'
--lấy ra những Contact có LastName có 4 ký tự bắt đầu bởi ký tư R hoặc A kết thúc bởi ký tự e
SELECT * FROM Person.Person
WHERE LastName LIKE '[RA]__e'

--sử dụng DISTINCT các dữ liệu trùng lập bị loại bỏ
SELECT DISTINCT Title FROM Person.Person

--sử dụng GROUP BY các dữ liệu trúng lập dc gộp thành nhóm
SELECT Title
FROM Person.Person
GROUP BY Title
--do đó ta có thể sử dụng dc với các hàm tập hợp
SELECT Title, COUNT(*) [Title Number]
FROM Person.Person
GROUP BY Title

--ta có thể sử dụng mệnh đề WHER đẻ thỏa mãn điều kiện tìm kiếm
SELECT Title,COUNT(*) [Title Number]
FROM Person.Person
WHERE Title LIKE 'Mr%'

--GROUP BY với HAVING mệnh đề HAVING sẽ lọc kết quả trong lúc dc gộp nhóm
SELECT Title,COUNT(*) [Title Number]
FROM Person.Person
GROUP BY ALL Title
HAVING Title LIKE 'Mr%'

--GROUP BY với CUBE: sẽ có thêm 1 hàng siêu kếy hợp gộp tất cả các hàng trong tập trả về
SELECT Title,COUNT(*) [Title Nummber]
FROM Person.Person
GROUP BY Title WITH CUBE

--GROUP BY với CUBE: sẽ có thêm các hàng siêu kết hợp gộp tất cả các hàng trong tập trả về
SELECT Title,COUNT(*) [Title Number]
FROM Person.Person
GROUP BY Title WITH ROLLUP
-- ORDER BY dùng để sắp xếp kết quả trả về
SELECT * FROM Person.Person
ORDER BY FirstName,LastName DESC

--TRUY VẤN TỪ NHIỀU BẢNG 
--Lấy toàn bộ Contact của nhân viên(HumanResources.Employee)
SELECT * FROM Person.Person
SELECT * FROM HumanResources.Employee
--truy vấn con
SELECT * FROM Person.Person
WHERE BusinessEntityID in (
	SELECT BusinessEntityID
	FROM HumanResources.Employee)

	--Truy vấn quan hệ sử dụng EXIST 
SELECT * FROM Person.Person C
WHERE EXISTS  (
	SELECT BusinessEntityID
	FROM HumanResources.Employee
	WHERE  BusinessEntityID=C.BusinessEntityID)

	--kết hợp dữ liệu sử dụng UNION
SELECT ContactTypeID,Name
FROM Person.ContactType
WHERE ContactTypeID IN (1,2,3,4,5,6)
UNION
SELECT ContactTypeID,Name
FROM Person.ContactType
WHERE ContactTypeID IN (1,3,5,7)

--sử dụng INNER JOIN
SELECT *
FROM HumanResources.Employee AS e
	INNER JOIN Person.Person AS p
	ON e.BusinessEntityID = p.BusinessEntityID
ORDER BY p.LastName

--MULTIPLE OPERATOR
SELECT DISTINCT p1.ProductSubcategoryID,p1.ListPrice
FROM Production.Product p1 INNER JOIN Production.Product p2
	ON p1.ProductSubcategoryID = p2.ProductSubcategoryID AND p1.ListPrice <> p2.ListPrice
WHERE p1.ListPrice < $15 AND p2.ListPrice < $15
ORDER BY	ProductSubcategoryID;
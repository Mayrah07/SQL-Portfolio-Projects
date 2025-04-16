--ALL

SELECT *
FROM AdebisiPortfolio..NatashileHousing

--CONVERSION OF DATE

Select SaleDate
FROM AdebisiPortfolio..NatashileHousing


Select SaleDate, CONVERT (DATE,SaleDate)
FROM AdebisiPortfolio..NatashileHousing


Alter table AdebisiPortfolio..NatashileHousing
ADD SalesDateConverted Date;


UPDATE AdebisiPortfolio..NatashileHousing
SET SalesDateConverted = CONVERT(DATE,SaleDate)

 
 Select Salesdateconverted
 FROM AdebisiPortfolio..NatashileHousing

--PROPERTY ADDRESS

Select PropertyAddress
FROM AdebisiPortfolio..NatashileHousing

Select PropertyAddress
FROM AdebisiPortfolio..NatashileHousing
WHERE PropertyAddress is Null 

Select *
FROM AdebisiPortfolio..NatashileHousing
WHERE PropertyAddress is Null 
ORDER BY ParcelID

SELECT A.ParcelID, A.PropertyAddress, B.ParcelID, B.PropertyAddress
FROM AdebisiPortfolio..NatashileHousing A
JOIN AdebisiPortfolio.dbo.NatashileHousing B
ON A.ParcelID = B.ParcelID
AND A.[UniqueID ] <> B.[UniqueID ]
WHERE A.PropertyAddress IS NULL

SELECT A.ParcelID, A.PropertyAddress, B.ParcelID, B.PropertyAddress, ISNULL (a.PropertyAddress,B.PropertyAddress)
FROM AdebisiPortfolio..NatashileHousing A
JOIN AdebisiPortfolio.dbo.NatashileHousing B
ON A.ParcelID = B.ParcelID
AND A.[UniqueID ] <> B.[UniqueID ]
WHERE A.PropertyAddress IS NULL

UPDATE A
SET PROPERTYADDRESS = ISNULL (a.PropertyAddress,B.PropertyAddress)
FROM AdebisiPortfolio..NatashileHousing A
JOIN AdebisiPortfolio.dbo.NatashileHousing B
ON A.ParcelID = B.ParcelID
AND A.[UniqueID ] <> B.[UniqueID ]
WHERE A.PropertyAddress is null


--Address into Columns

SELECT *
FROM AdebisiPortfolio..NatashileHousing

SELECT PropertyAddress
FROM AdebisiPortfolio..NatashileHousing

SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1) as ADDRESS
, SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1,LEN(PropertyAddress)) 
FROM AdebisiPortfolio..NatashileHousing


Alter table AdebisiPortfolio..NatashileHousing
ADD PropertyAddressStreet nvarchar(255);


UPDATE AdebisiPortfolio..NatashileHousing
SET  PropertyAddressStreet = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1)
   

Alter table AdebisiPortfolio..NatashileHousing
ADD PropertyAddressCity nvarchar (255);


UPDATE AdebisiPortfolio..NatashileHousing
SET PropertyAddressCity = SUBSTRING(PropertyAddress, CHARINDEX (',',PropertyAddress) +1, LEN(PropertyAddress))

SELECT *
FROM AdebisiPortfolio..NatashileHousing

--OWNER ADDRESS
SELECT OwnerAddress
FROM AdebisiPortfolio..NatashileHousing

SELECT 
PARSENAME(REPLACE (OwnerAddress, ',', '.') ,3)
,PARSENAME(REPLACE (OwnerAddress, ',', '.') ,2)
,PARSENAME(REPLACE (OwnerAddress, ',', '.') ,1)
FROM AdebisiPortfolio..NatashileHousing


Alter table AdebisiPortfolio..NatashileHousing
ADD OwnerAddressStreet nvarchar(255);


UPDATE AdebisiPortfolio..NatashileHousing
SET  OwnerAddressStreet = PARSENAME(REPLACE (OwnerAddress, ',', '.') ,3)
   

Alter table AdebisiPortfolio..NatashileHousing
ADD OwnerAddressCity nvarchar (255);


UPDATE AdebisiPortfolio..NatashileHousing
SET OwnerAddressCity = PARSENAME(REPLACE (OwnerAddress, ',', '.') ,2)


Alter table AdebisiPortfolio..NatashileHousing
ADD OwnerAddressState nvarchar(255);


UPDATE AdebisiPortfolio..NatashileHousing
SET  OwnerAddressState = PARSENAME(REPLACE (OwnerAddress, ',', '.') ,1)



SELECT *
FROM AdebisiPortfolio..NatashileHousing


--SOLD AS VACANT
SELECT SoldAsVacant
FROM AdebisiPortfolio..NatashileHousing

SELECT SoldAsVacant, COUNT (Soldasvacant)
FROM AdebisiPortfolio..NatashileHousing
Group by soldasvacant
order by 1,2

SELECT SoldAsVacant
,CASE WHEN SoldAsVacant = 'N' THEN 'No'
WHEN SoldAsVacant = 'Y' THEN 'Yes'
ELSE SOLDASVACANT
END
FROM AdebisiPortfolio..NatashileHousing
Group by soldasvacant
order by 1,2

UPDATE AdebisiPortfolio..NatashileHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'N' THEN 'No'
WHEN SoldAsVacant = 'Y' THEN 'Yes'
ELSE SOLDASVACANT
END

SELECT *
FROM AdebisiPortfolio..NatashileHousing


--REMOVE DUPLICATES
SELECT *,
ROW_NUMBER () OVER (
PARTITION BY PROPERTYADDRESS, PARCELID, LANDUSE
ORDER BY UNIQUEID
) ROW_NUM
FROM AdebisiPortfolio..NatashileHousing

WITH ROWNUMBERCTE AS(
SELECT *,
ROW_NUMBER () OVER (
PARTITION BY PROPERTYADDRESS, PARCELID, LANDUSE
ORDER BY UNIQUEID
) ROW_NUM
FROM AdebisiPortfolio..NatashileHousing
)
DELETE
FROM ROWNUMBERCTE
WHERE ROW_NUM > 1

SELECT *
FROM AdebisiPortfolio..NatashileHousing


--REMOVE UNUSED COLUMNS
ALTER TABLE AdebisiPortfolio..NatashileHousing
drop column owneraddress
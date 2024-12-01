CREATE DATABASE StellarStayHotels;
USE StellarStayHotels;


CREATE TABLE Guest (
  GuestID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100) NOT NULL,
  Phone VARCHAR(15),
  Email VARCHAR(100) NOT NULL,
  Address VARCHAR(255),
  EmergencyContact VARCHAR(100)
);

CREATE TABLE GuestPreference (
  PreferenceID INT PRIMARY KEY AUTO_INCREMENT,
  GuestID INT,
  Preference VARCHAR(255),
  FOREIGN KEY (GuestID) REFERENCES Guest(GuestID)
);


CREATE TABLE SpecialRequest (
  RequestID INT PRIMARY KEY AUTO_INCREMENT,
  GuestID INT,
  SpecialRequest VARCHAR(255),
  FOREIGN KEY (GuestID) REFERENCES Guest(GuestID)
);


CREATE TABLE Reservation (
  ReservationNumber INT PRIMARY KEY AUTO_INCREMENT,
  GuestID INT,
  CheckInDate DATE,
  CheckOutDate DATE,
  RoomType ENUM('Standard', 'Deluxe', 'Suite'),
  NumberOfGuests INT,
  PaymentMethod ENUM('Cash', 'Card', 'Online'),
  TotalAmountDue DECIMAL(10,2),
  ConfirmedByStaff BOOLEAN,
  EmailConfirmation BOOLEAN,
  FOREIGN KEY (GuestID) REFERENCES Guest(GuestID)
);


CREATE TABLE Room (
  RoomID INT PRIMARY KEY AUTO_INCREMENT,
  RoomType ENUM('Standard', 'Deluxe', 'Suite'),
  Price DECIMAL(10,2),
  Status ENUM('Available', 'Under Maintenance', 'Not Bookable')
);


CREATE TABLE Staff (
  StaffID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100) NOT NULL,
  Role VARCHAR(50)
);


CREATE TABLE PerformanceRecord (
  RecordID INT PRIMARY KEY AUTO_INCREMENT,
  StaffID INT,
  PerformanceRecords TEXT,
  FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);


CREATE TABLE TrainingRecord (
  TrainingID INT PRIMARY KEY AUTO_INCREMENT,
  StaffID INT,
  TrainingRecords TEXT,
  FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);


CREATE TABLE Inventory (
  ItemID INT PRIMARY KEY AUTO_INCREMENT,
  ItemName VARCHAR(100),
  Category ENUM('Linens', 'Consumables', 'Beverages', 'Other'),
  Quantity INT
);


CREATE TABLE Room_Inventory (
  RoomID INT,
  ItemID INT,
  PRIMARY KEY (RoomID, ItemID),
  FOREIGN KEY (RoomID) REFERENCES Room(RoomID),
  FOREIGN KEY (ItemID) REFERENCES Inventory(ItemID)
);


CREATE TABLE Maintenance (
  MaintenanceID INT PRIMARY KEY AUTO_INCREMENT,
  RoomID INT,
  ScheduledDate DATE,
  Status ENUM('Scheduled', 'Completed', 'In Progress', 'Cancelled'),
  FOREIGN KEY (RoomID) REFERENCES Room(RoomID)
);


CREATE INDEX idx_guest_email ON Guest(Email);
CREATE INDEX idx_room_status ON Room(Status);
CREATE INDEX idx_reservation_dates ON Reservation(CheckInDate, CheckOutDate);



Create database Muabangame_com;
Use Muabangame_com
CREATE TABLE tblGames (
    game_id      INT PRIMARY KEY IDENTITY(1,1),
    title        NVARCHAR(255) NOT NULL,
    price        DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    release_date DATE,
    genre        NVARCHAR(100),
    platform     NVARCHAR(100),
    stock        INT DEFAULT 0 CHECK (stock >= 0),
    image_url    NVARCHAR(255),
    created_at   DATETIME DEFAULT GETDATE(),
    updated_at   DATETIME DEFAULT GETDATE()
);

Create table tblUsers(
	User_id int primary key identity(1,1),
	Username NVARCHAR(255) not null unique,
	Password varchar(255) not null,
	Email NVARCHAR(255) not null unique,
	Phone NVARCHAR(20),
	Address NVARCHAR(255),
	Role NVARCHAR(20) DEFAULT 'Customer' CHECK(Role IN('Customer', 'Admin')),
	Created_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE tblOrders(
	Order_id int primary key identity(1,1),
	User_id int not null,
	Total_price decimal(10,2) not null CHECK(total_price >= 0),
	Status NVARCHAR(50) DEFAULT 'pending' CHECK(Status IN('pending','processing','completed','canceled')),
	Created_at datetime DEFAULT GETDATE(),
	Update_at datetime DEFAULT GETDATE(),
	FOREIGN KEY(User_id) REFERENCES tblUsers(User_id)
);

Create table tblOrderDetails(
	Order_detail_id int primary key identity(1,1),
	Order_id int not null,
	Game_id int not null,
	Quantity int not null,
	Price decimal(10,2) not null CHECK(price >= 0),
	Total_price decimal(10,2) not null CHECK(Total_price >= 0),
	Foreign key(Order_id) References tblOrders(Order_id),
	Foreign key(Game_id) References tblGames(Game_id),
);

CREATE TABLE tblPayments (
    Payment_id  INT PRIMARY KEY IDENTITY(1,1),
    Order_id    INT NOT NULL,
    User_id     INT NOT NULL,
    Amount      DECIMAL(10,2) NOT NULL CHECK (amount >= 0),
    Method      NVARCHAR(50) NOT NULL CHECK (method IN ('credit_card', 'paypal', 'bank_transfer')),
    Status      NVARCHAR(50) DEFAULT 'pending' CHECK (status IN ('pending', 'completed', 'failed')),
    Created_at  DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (Order_id) REFERENCES tblOrders(Order_id),
    FOREIGN KEY (User_id) REFERENCES tblUsers(User_id)
);

CREATE TABLE tblReviews (
    Review_id  INT PRIMARY KEY IDENTITY(1,1),
    Game_id    INT NOT NULL,
    User_id    INT NOT NULL,
    Rating     INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    Comment    NVARCHAR(1000),
    Created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (Game_id) REFERENCES tblGames(Game_id),
    FOREIGN KEY (User_id) REFERENCES tblUsers(User_id)
);

CREATE TABLE tblCart (
    Cart_id   INT PRIMARY KEY IDENTITY(1,1),
    User_id   INT NOT NULL,
    Game_id   INT NOT NULL,
    Quantity  INT NOT NULL CHECK (quantity > 0),
    Added_at  DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (User_id) REFERENCES tblUsers(User_id),
    FOREIGN KEY (Game_id) REFERENCES tblGames(Game_id)
);


CREATE TABLE tblDiscounts (
    Discount_id INT PRIMARY KEY IDENTITY(1,1),
    Game_id     INT NOT NULL,
Discount_percent DECIMAL(5,2) NOT NULL CHECK (discount_percent BETWEEN 0 AND 100),
    Start_date  DATE NOT NULL,
    End_date    DATE NOT NULL,
    FOREIGN KEY (Game_id) REFERENCES tblGames(Game_id)
);


CREATE TABLE tblWishlists (
    Wishlist_id INT PRIMARY KEY IDENTITY(1,1),
    User_id     INT NOT NULL,
    Game_id     INT NOT NULL,
    Added_at    DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (User_id) REFERENCES tblUsers(User_id),
    FOREIGN KEY (Game_id) REFERENCES tblGames(Game_id)
);

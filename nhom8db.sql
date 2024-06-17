USE master
GO

IF DB_ID('nhom8db') IS NOT NULL
    DROP DATABASE nhom8db
GO

CREATE DATABASE nhom8db
GO

USE [nhom8db]
GO

/****** Object:  Table [dbo].[customer]  ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[customer] (
    customer_id INT NOT NULL IDENTITY(1,1),
    first_name NVARCHAR(100) NOT NULL,
    last_name NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) NOT NULL,
    [password] NVARCHAR(100) NOT NULL,
    address NVARCHAR(100) NOT NULL,
    phone_number NVARCHAR(10) NOT NULL,
    PRIMARY KEY (customer_id)
)
GO

CREATE TABLE [dbo].[category] (
    category_id INT NOT NULL IDENTITY(1,1),
    category_name NVARCHAR(100) NOT NULL,
    PRIMARY KEY (category_id)
)
GO

CREATE TABLE [dbo].[product] (
    product_id INT NOT NULL IDENTITY(1,1),
    sku NVARCHAR(100),
    name NVARCHAR(500) NOT null,
    price DECIMAL(10, 2) NOT NULL,
    stock INT,
    [image] NVARCHAR(1000) not NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (product_id),
    FOREIGN KEY (category_id) REFERENCES [dbo].[category](category_id)
)
GO

CREATE TABLE [dbo].[payment] (
    payment_id INT NOT NULL IDENTITY(1,1),
    payment_date DATETIME NOT NULL,
    payment_method NVARCHAR(100) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    customer_id INT NOT NULL,
    PRIMARY KEY (payment_id),
    FOREIGN KEY (customer_id) REFERENCES [dbo].[customer](customer_id)
)
GO

CREATE TABLE [dbo].[cart] (
    cart_id INT NOT NULL IDENTITY(1,1),
    quantity INT NOT NULL,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    PRIMARY KEY (cart_id),
    FOREIGN KEY (customer_id) REFERENCES [dbo].[customer](customer_id),
    FOREIGN KEY (product_id) REFERENCES [dbo].[product](product_id)
)
GO

CREATE TABLE [dbo].[order] (
    order_id INT NOT NULL IDENTITY(1,1),
    order_date DATETIME NOT NULL,
    total_price DECIMAL(10, 1) NOT NULL,
    customer_id INT NOT NULL,
    payment_id INT NOT NULL,
    status INT NOT NULL DEFAULT 0,
    PRIMARY KEY (order_id),
    FOREIGN KEY (customer_id) REFERENCES [dbo].[customer](customer_id),
    FOREIGN KEY (payment_id) REFERENCES [dbo].[payment](payment_id)
)
GO

CREATE TABLE [dbo].[order_item] (
    order_item_id INT NOT NULL IDENTITY(1,1),
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    product_id INT NOT NULL,
    order_id INT NOT NULL,
    PRIMARY KEY (order_item_id, order_id),
    FOREIGN KEY (order_id) REFERENCES [dbo].[order](order_id),
    FOREIGN KEY (product_id) REFERENCES [dbo].[product](product_id)
)
GO

CREATE TABLE [dbo].[shipment] (
    shipment_id INT NOT NULL IDENTITY(1,1),
    shipment_date DATETIME NOT NULL,
    address NVARCHAR(100) NOT NULL,
    city NVARCHAR(100) NOT NULL,
    state NVARCHAR(20) NOT NULL,
    country NVARCHAR(50) NOT NULL,
    zip_code NVARCHAR(10) NOT NULL,
    customer_id INT NOT NULL,
    PRIMARY KEY (shipment_id),
    FOREIGN KEY (customer_id) REFERENCES [dbo].[customer](customer_id)
)
GO

CREATE TABLE [dbo].[wishlist] (
    wishlist_id INT NOT NULL IDENTITY(1,1),
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    PRIMARY KEY (wishlist_id),
    FOREIGN KEY (customer_id) REFERENCES [dbo].[customer](customer_id),
    FOREIGN KEY (product_id) REFERENCES [dbo].[product](product_id),
)
GO

CREATE TABLE [dbo].[admin] (
    admin_id INT NOT NULL IDENTITY(1,1),
    username NVARCHAR(100) NOT NULL,
    password NVARCHAR(100) NOT NULL,
    name NVARCHAR(100) NOT NULL,
)



-- Insert data into category table
INSERT INTO [dbo].[category] (category_name) VALUES
(N'?i?n tho?i'),
(N'Máy tính'),
(N'Ph? ki?n');
GO

-- Insert sample data into customer table
INSERT INTO [dbo].[customer] (first_name, last_name, email, [password], address, phone_number) VALUES
(N'Nguy?n', N'V?n A', N'vana@gmail.com', N'password123', N'123 ???ng 1', N'0123456789'),
(N'Tr?n', N'Th? B', N'thib@gmail.com', N'password123', N'456 ???ng 2', N'0987654321'),
(N'Lê', N'V?n C', N'vanc@gmail.com', N'password123', N'789 ???ng 3', N'0234567891'),
(N'Ph?m', N'Th? D', N'thid@gmail.com', N'password123', N'101 ???ng 4', N'0345678912'),
(N'Hoàng', N'V?n E', N'vane@gmail.com', N'password123', N'202 ???ng 5', N'0456789123'),
(N'Phan', N'Th? F', N'thif@gmail.com', N'password123', N'303 ???ng 6', N'0567891234'),
(N'V?', N'V?n G', N'vang@gmail.com', N'password123', N'404 ???ng 7', N'0678912345'),
(N'Bùi', N'Th? H', N'thih@gmail.com', N'password123', N'505 ???ng 8', N'0789123456'),
(N'??', N'V?n I', N'vani@gmail.com', N'password123', N'606 ???ng 9', N'0891234567'),
(N'Ngô', N'Th? K', N'thik@gmail.com', N'password123', N'707 ???ng 10', N'0912345678');
GO

-- Insert sample data into product table with category_id = 1
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('9255921646436', N'Apple iPhone 11', 8550000, 2991, 'https://salt.tikicdn.com/cache/280x280/ts/product/aa/24/e0/57914989351786ef9dfe027046ba4626.jpg', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('5447919661404', N'Apple iPhone 13', 13490000, 1872, 'https://salt.tikicdn.com/cache/280x280/ts/product/b7/ba/88/66059a54a3a139d45841d412379b1fe4.jpg', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('6846969040800', N'?i?n tho?i Xiaomi Redmi 9A (2GB/32GB)', 1690000, 857, 'https://salt.tikicdn.com/cache/280x280/ts/product/22/34/6c/f2f6ca4edc76d9ba9fbb03ac976c06ae.png', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('7996455150829', N'?i?n Tho?i Nokia C30 (2GB/32GB) - Hàng Chính Hãng', 1490000, 228, 'https://salt.tikicdn.com/cache/280x280/ts/product/5c/57/85/312c7a38df0312e7525a18f61c5a0fbc.jpg', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('7223409541765', N'?i?n Tho?i Xiaomi Redmi 10 4GB/128GB - Hàng Chính Hãng', 2849000, 50, 'https://salt.tikicdn.com/cache/280x280/ts/product/3c/36/67/4bf3d8bd461e965f7a8d49e8c8fe9b08.jpg', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('6889720147216', N'?i?n tho?i Xiaomi Redmi 10A (2GB/32GB) - Hàng chính hãng', 1949000, 1, 'https://salt.tikicdn.com/cache/280x280/ts/product/67/09/80/e96911f68a37664e0dac06e6de4801a7.jpg', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('3589589912166', N'?i?n tho?i Nokia C30 2GB/32GB - Hàng chính hãng', 1550000, 44, 'https://salt.tikicdn.com/cache/280x280/ts/product/ae/77/39/dc4d08a8b156a0c2f797f95a1860bc8c.jpg', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('6125495845630', N'?i?n tho?i Nokia C20 (2GB/16GB) - Hàng Chính Hãng', 1289000, 17, 'https://salt.tikicdn.com/cache/280x280/ts/product/7e/b6/67/0fac1f808c2a8f43b896b955702c8d2c.jpg', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('5158981678404', N'?i?n tho?i Xiaomi Redmi 9A (2GB/32GB) - Hàng chính hãng', 1790000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/bd/2e/b8/6006994eca7ae21a0d38de2c315f77b1.jpg', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('7762173325757', N'Ulefone Armor X 5 ( ch?ng n??c,ch?ng va ??p,pin 5.000mAh ) hàng chính hãng', 3590000, 38, 'https://salt.tikicdn.com/cache/280x280/ts/product/db/dc/95/b3035c9a5987661b9579a247bdb9d76a.jpg', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('3052547408227', N'?i?n tho?i Ulefone Armor 14 pro (ch?ng n??c,ch?ng va ??p,pin kh?ng,pin 10.000mAh,Ram 8Gb,Rom 128Gb)- hàng chính hãng', 5990000, 4, 'https://salt.tikicdn.com/cache/280x280/ts/product/cc/02/3a/1d54b42c01e58cfcc866585cb61f7ee6.jpg', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('4004266821432', N'?i?n Tho?i Vsmart Bee Lite 2GB/16GB - Hàng Chính Hãng', 999000, 26, 'https://salt.tikicdn.com/cache/280x280/ts/product/3d/fa/0d/a1d998ecb3d2b880f2ed045ef719e088.jpg', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('8754421213076', N'?i?n tho?i Oukitel WP19(ch?ng s?c ,ch?ng n??c ,Pin 21000mAh ,Ram 8G ,Rom 256G ,T?m nhìn ban ?êm 64MP ,  Máy ?nh 90Hz ,?i?n tho?i Helio G95 )-hàng chính hãng', 9790000, 2, 'https://salt.tikicdn.com/cache/280x280/ts/product/17/5b/7b/ac1d0110b90e4a4f475051c186783acc.png', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('1513933203502', N'?i?n tho?i OUKITEL WP16 (pin 10.600mAh,  Ram 8Gb,Rom 128Gb, màn hình 6,39 in , Android 11, Máy ?nh nhìn ban ?êm 20MP, ch?ng n??c IP68,ch?ng va ??p, hai SIM 4G, NFC..) – hàng chính hãng', 5990000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/2f/2c/21/513325a975bee29b4b1dbbb0ef769747.jpg', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('8697899661797', N'?i?n Tho?i Samsung A04s 4GB/64GB - Hàng Chính Hãng', 2629000, 21, 'https://salt.tikicdn.com/cache/280x280/ts/product/ea/8f/3e/1ca9f736cdda1cdd317f23489cc475a0.jpg', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('4594947743515', N'?i?n Tho?i Masstel Hapi 30 3GB/32GB - Hàng Chính Hãng', 1879000, 2, 'https://salt.tikicdn.com/cache/280x280/ts/product/34/b7/7b/23b42cf71be2dadb2c3da04332a0fe07.jpg', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('6415838576314', N'?i?n Tho?i Tecno Spark 6 Go 4GB/64GB - Hàng Chính Hãng', 2079000, 13, 'https://salt.tikicdn.com/cache/280x280/ts/product/f1/0f/74/534eaff816c2126a7c49608e3b5a41fe.jpg', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('4552609527105', N'?i?n tho?i Vivo Y33s (8GB/128GB) - Hàng chính hãng', 6069000, 1, 'https://salt.tikicdn.com/cache/280x280/ts/product/44/5d/98/552402fb183ed24fc6053d1799d4c618.jpg', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('3232779349125', N'?i?n tho?i Realme C25Y (4GB/128GB) - Hàng chính hãng', 4990000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/8c/18/91/d8e35540bbad051b6182573802e60a5a.jpg', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('3205184125127', N'?i?n tho?i thông minh itel A26 - giá r? | 2 Sim 2 Sóng 4G LTE | Màn hình IPS 5.7" HD+ | RAM 2GB + ROM 32 GB (H? tr? th? nh? 32 GB) | M? khoá b?ng G??ng M?t | Chính Hãng b?o hành 12 tháng| 1 ??i 1 trong 30 ngày', 2390000, 1, 'https://salt.tikicdn.com/cache/280x280/ts/product/a4/14/05/a288f7276d63c8b23ecfc73c8375914b.jpg', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('6754259917289', N'?i?n Tho?i Vivo T1x 4GB/64GB - Hàng Chính Hãng', 3279000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/92/f7/ac/5c3a16204d91d37cc2b572cdbc96f8b2.jpg', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('2293673936215', N'?i?n tho?i ZTE Blade V40 Vita (ZTE 8045) - MH gi?t n??c HD+ 6.75" - Pin 6000 mAh s?c nhanh 22.5W -  B? nh? m? r?ng (4+2)GB - Hàng chính hãng', 4290000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/14/cc/b3/1224785fc8f2604497defb76fcf7d5f0.png', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('4965138104415', N'?i?n tho?i Realme C11 2021 (4GB/64GB) - Hàng chính hãng', 3790000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/40/93/b9/6a053b3d067bc57c941775944543aad0.jpg', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('1210066581201', N'?i?n tho?i Oppo A57 (4GB/64GB) - Hàng chính hãng', 4284000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/fd/85/18/ca377d0bc0fe919755c2b751b48b6b99.jpg', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('1457046669346', N'?i?n tho?i Samsung Galaxy A04 (3GB / 32GB) - Hàng chính hãng - M?i 100% Nguyên Seal - Pin Kh?ng 5000 mAh - B?o Hành 12 Tháng', 2400000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/6a/d2/4b/fdcd9917242118e899d02b07cf7ddd48.png', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('4139738487557', N'?i?n tho?i ch?c ch?n Ulefone Power Armor 18T Ultra (ch?p ?nh nhi?t Camera FLIR5G 512GB ROM +24GB RAM)- hàng chính hãng', 15990000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/c8/9d/d8/792d7d6173e2af937d35d2b225f8b2ce.png', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('1158412704100', N'?i?n tho?i Ulefone armor 22(ch?ng n??c,ch?ng va ??p, Màn hình gi?t n??c 6,58 inch, RAM:8GB,Rom 128GB/256GB,Th? nh? microSD Lên ??n 512GB, Camera kép 64MP + 64MP)- hàng chính hãng', 5990000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/5e/e6/8c/9e6bacfdb1dd5058ea80d1f8c65e519c.png', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('2945797983904', N'?i?n Tho?i Samsung A14 4GB/128GB - Hàng Chính Hãng', 3349000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/1d/8f/98/9ef6537d77a38ec6e1f8599d06e58638.jpg', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('1785870447338', N'?i?n tho?i Samsung Galaxy A04e (3GB/32GB) - Hàng chính hãng', 2325000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/57/38/08/1a245da2ad6361608a7895349c60ee0b.jpg', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('4836562576812', N'?i?n Tho?i Xiaomi POCO C65 6GB/128GB - Hàng Chính Hãng', 2899000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/6a/68/6c/538eb8bb5f823a66ad2cdb5b67cc40af.png', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('9579985042849', N'?i?n Tho?i Xiaomi POCO C65 8GB/256GB - Hàng Chính Hãng', 3389000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/33/7c/59/dbfecb46a7301b0f828045761d14228d.png', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('7842047666323', N'?i?n Tho?i Xiaomi Redmi Note 12 Pro 5G 8GB/256GB - Hàng Chính Hãng', 9000000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/f3/4d/65/07e40a0e40b246a3dfdc571ee31cacdf.png', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('7181816205059', N'?i?n Tho?i Xiaomi Redmi Note 12S (8GB/256GB) - Hàng Chính Hãng', 6132000, 1, 'https://salt.tikicdn.com/cache/280x280/ts/product/47/ce/a1/12297e0c98ec3e3404c9e5c432454767.png', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('4675748657316', N'?i?n Tho?i Samsung Galaxy M14 5G (4GB/128GB) - Hàng Chính Hãng', 3937000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/74/b8/4d/57ecb234f2469212cea4ef535e761cf0.png', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('2635631426614', N'?i?n Tho?i Samsung Galaxy A05 (6GB/128GB) - Hàng Chính Hãng', 3450000, 1, 'https://salt.tikicdn.com/cache/280x280/ts/product/5b/4d/02/593083642017d296811c5c9cd006c00c.jpg', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('9224589284305', N'?i?n tho?i Ulefone Note 17 Pro(Ram 12Gb,Rom 256Gb,Android 13,camera 108MP, MediaTek Helio G99,s?c nhanh 33W,Màn hình AMOLED 6.78 inch,pin 5.050mAh)- hàng chính hãng', 7490000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/65/58/b3/5b0903110b00f5de352c064cd514ecfb.jpg', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('5346349890140', N'?i?n tho?i Vivo Y36 (8GB/128GB) - Hàng Chính Hãng - Camera 50MP - S?c Nhanh 44W', 5190000, 2, 'https://salt.tikicdn.com/cache/280x280/ts/product/f1/c2/81/55a8cae03f215bd75dab198181ef799a.png', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('2723437356533', N'?i?n tho?i Oppo A17k (3GB/64GB) - Hàng chính hãng', 2579000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/3b/63/7e/4a2b685397627cea65312c6114c85192.jpg', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('2397579918164', N'?i?n Tho?i Xiaomi Redmi A2 2GB/32GB - Hàng Chính Hãng', 1739000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/ee/8f/27/b5fa527131132038a14949daa5acbcdf.jpg', 1);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('9469541340066', N'?i?n Tho?i Xiaomi Redmi A2+ 3GB/64GB - Hàng Chính Hãng', 1949000, 1, 'https://salt.tikicdn.com/cache/280x280/ts/product/6c/87/fe/ba445a218509da2a65dccbb03c6ce0c5.jpg', 1);

-- With category_id = 2
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('4004267735539', N'Máy vi tính Laptop Asus ExpertBook B1400 (Chip Intel Core i5-1235U | RAM 16GB | SSD 512GB NVMe | 14'' Full HD | B?o m?t vân tay | B?o m?t TPM 2.0 | ?? b?n chu?n quân ??i US) - Hàng Chính Hãng', 17190000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/02/61/07/31ed28cfaca4174838bf1eac0744dd8b.png', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('9024656957761', N'Lenovo ThinkPad L460 (Intel Core i5 6300 , RAM 8.0GB, 1x180GB SSD SATA III, Intel HD 520, MÀN HÌNH 14 INCH T?ng c?p + chu?t không dây + bàn di chu?t - HÀNG CHÍNH HÃNG', 7550000, 8, 'https://salt.tikicdn.com/cache/280x280/ts/product/14/8c/81/4187664413d60e99ef831fb3b1bfbba7.png', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('5192218543377', N'Máy tính xách tay Laptop Dell Latitude 3420 (Intel Core i5-1135G7 | 14 Inch | RAM 8GB | 256GB SSD NVMe | Intel Iris Xe Graphics | Fedora Os) - Hàng chính hãng', 14999000, 1, 'https://salt.tikicdn.com/cache/280x280/ts/product/e0/be/a2/2007a3fdbdc48892339afd62352c9782.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('9454375054810', N'Laptop Asus ExpertBook B1400 (Chip Intel Core i5-1235U | RAM 8GB | SSD 512GB NVMe | 14'' Full HD | B?o m?t vân tay | B?o m?t TPM 2.0 | ?? b?n chu?n quân ??i US) - Hàng Chính Hãng', 15890000, 1, 'https://salt.tikicdn.com/cache/280x280/ts/product/cb/a0/81/bb35665a854fae2122f16b1acac7283e.png', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('2032558437950', N'Laptop Asus Expertbook B1502 - B1502CV (Intel Core i5-1335U | RAM 8GB | 512GB SSD | Intel UHD Graphics | 15.6 inch Full HD | Win 11 b?n quy?n) - Hàng Chính Hãng', 16490000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/c3/38/e0/78676b0c573733c58a097aaa70a97d37.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('7126773233377', N' Apple Macbook Air 2020 13 inch (Apple M1 - 8GB/ 256GB) - MGND3SA/A', 17990000, 854, 'https://salt.tikicdn.com/cache/280x280/ts/product/2b/76/1c/6c89edecac5e58f346422c3a911934ea.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('4118458865925', N'Laptop Dell Latitude 3520 70251603 (Core i3-1115G4/ 4 GB/ 256GB SSD/ 15.6HD/ Fedora) - Hàng Chính Hãng', 10150000, 3, 'https://salt.tikicdn.com/cache/280x280/ts/product/43/a8/e0/0fabf09e71ac203abefa2d19dc473ca7.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('4036911495018', N'Lenovo ThinkPad L460 (Intel Core i5 6300 , RAM 8.0GB, 1x180GB SSD SATA III, Intel HD 520, MÀN HÌNH 14 INCH T?ng c?p + chu?t không dây + bàn di chu?t - HÀNG CHÍNH HÃNG', 5790000, 8, 'https://salt.tikicdn.com/cache/280x280/ts/product/14/8c/81/fb9e28fb39287ef103ee0e9765f98564.png', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('4430421908667', N'LapTop Lenovo V14 IIL (82C400W0VN) | Intel Core i3 _ 1005G1 | 4GB | 256GB SSD PCIe | Win 10 | 14 inch HD | Hàng Chính Hãng', 7650000, 2, 'https://salt.tikicdn.com/cache/280x280/ts/product/26/71/ed/8cc11995a60d8f554c523e3b9add95a7.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('2347380992805', N'Laptop Acer Aspire 3 A314 35 P3G9 N6000/4GB/256GB/Win11 - Hàng Chính Hãng', 10188000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/4c/f7/d9/455cd70b893a01f4fa432dc2db2ec80c.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('9831707285324', N'Laptop Asus Expertbook B1502CBA B1502 (Intel Core i5-1235U | RAM 8GB | 512GB SSD | Intel UHD Graphics | 15.6 inch Full HD | Win 11 b?n quy?n) - Hàng Chính Hãng', 14490000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/8b/45/b8/217c5775bd403c6badf2cb99805f5e27.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('6855271983717', N'Laptop Asus Zenbook 14 OLED UX3402VA (Intel Core I5-1340P | Ram 16GB | SSD 512GB | 14 inch OLED WQXGA+ | Win 11 B?n quy?n - Asus-UX3402VA-KM085W ) - Hàng Chính Hãng', 25890000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/6f/49/b0/a4a37355469a5663ef6b5b5d492c05f0.png', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('5760754320256', N'Laptop Asus ExpertBook B1400 - B1400CEAE-EK3724 (Chip Intel Core i5-1135G7 | RAM 8GB | SSD 256GB NVMe | 14'' Full HD | B?o m?t vân tay | B?o m?t TPM 2.0 | ?? b?n chu?n quân ??i US) - Hàng Chính Hãng', 13490000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/fe/49/f7/35576f8f9483d943643c43cb894f8bc4.png', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('1612011036866', N'Laptop Asus Expertbook B1502 - B1502CV (Intel Core i3-1315U | RAM 8GB | 512GB SSD | 15.6 inch Full HD | Win 11 b?n quy?n) - Hàng Chính Hãng', 10490000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/e7/4c/a1/40c2c073a31cfd82e15a2b075ee9f331.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('5279357249623', N'Laptop ASUS ExpertBook B1 B1402 - B1402CV (Intel Core i7-1355U | RAM 16GB | 512GB SSD | 14 inch Full HD | Win 11 b?n quy?n) - Hàng Chính Hãng', 17999000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/43/e0/51/4734fddbc7d29a03db9acde2a8abf079.png', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('6986363207264', N'Laptop Acer Aspire 7 A715-42G-R05G (AMD R5-5500U/ 8GB DDR4/ 512GB SSD/ GTX 1650 4GB/ 15.6 FHD IPS, 144Hz/ Win11) - Hàng Chính Hãng', 17520000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/ba/d5/8f/08cc3dda0f2c25028f222a809a22c9f4.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('2289621695933', N'Laptop Lenovo ThinkBook 14s Yoga ITL i7 1165G7/8GB/512GB/14"F/Touch/Pen/Win11/(20WE007PVN)/Xám - Hàng chính hãng', 29775600, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/0f/92/4a/012771e43b9c82a175d711952e6d7f28.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('6582497857610', N'Laptop Acer Aspire A315-56-58EG (NX.HS5SV.00J) Black/ Intel i5 1035G1 (up to 3.6GHz, 6MB)/ RAM 4GB/ 256GB SSD/ 15.6inch FHD/ Win 11- Hàng chính hãng', 13788000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/bf/d5/18/0435f21c463669ffd04b1c134654e911.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('1566104039143', N'Laptop Dell Vostro 15 3510 7T2YC2 (Core i5-1135G7/ 8GB DDR4/ 512GB SSD/ 15.6 FHD/ Win11 + Office) - Hàng Chính Hãng', 20990000, 1, 'https://salt.tikicdn.com/cache/280x280/ts/product/9f/10/3a/68fa9a5b90e0941d19e4364a29ffc9ba.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('5778817652358', N'Laptop Dell Vostro 3405 V4R53500U003W (AMD R5-3500U/ 8GB (1x8GB) DDR4 2400Mhz/ 512SSD M2 PCIe NVMe/ 14 FHD/ Win10) - Hàng Chính Hãng', 11550000, 2, 'https://salt.tikicdn.com/cache/280x280/ts/product/17/c1/6c/b577d1b1acb16650e44a37bd3e798ec8.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('7980558650937', N'Laptop Lenovo Ideapad Slim 5 15ITL05 (82FG001PVN). Intel Core I5 1135G7 - Hàng Chính hãng', 15290000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/4d/9c/47/bbfafef4382f9f0910230636f4712988.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('8758576305916', N'Laptop Acer Nitro 5 Tiger AN515-58-52SP (Core i5-12500H/ 8GB/ 512GB SSD/ RTX 3050/ 15.6 FHD IPS, 144Hz/ Win11) - Hàng Chính Hãng', 24000000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/a4/5c/c3/8510e556b4ed77ded2d10f67460d8341.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('6266873980220', N'Laptop Gaming Acer Nitro 5 Tiger AN515-58-52SP  i5-12500H/RAM 8GB/512GB SSD/3050 4GB Hàng Chính Hãng', 24000000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/7c/4e/f1/78f078320fb49ab07441497c4af20d98.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('5778538923356', N'Laptop CHUWI HeroBook Pro Intel Gemini Lake N4020 Intel UHD Graphics 600  8GB 256GB SSD 128GB TF Card - Hàng Chính Hãng', 10390000, 3, 'https://salt.tikicdn.com/cache/280x280/ts/product/43/07/56/4253fb1ea27d5f9ccfe08bb07f887adb.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('1802833632442', N'Laptop Lenovo ThinkPad E14 Gen 2 20TA00JJVN (Core i5-1135G7/ 8 GB, DDR4, 3200 MHz/ 512GB SSD/ 14 FHD IPS/ Win11) - Hàng Chính Hãng', 19990000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/ec/e8/68/36dd128586db6d27c5f20808a42ec3f5.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('2854122603582', N'Laptop LarkBook Intel Gemini-Lake N4120 Intel UHD Graphics 600 13.3 inch  8GB 256GB SSD 1*extra SS Up to 1T SSD - Hàng Chính Hãng', 10590000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/8e/50/9f/01a60d3fdf45fffaa06e5b73ccd220d1.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('9961746272988', N'Laptop GemiBook Pro Intel Celeron Processor N5100  Intel UHD Graphics 600 14.0 inch 8GB 256GB SSD Max 1TB SSD  - Hàng chính hãng', 10990000, 2, 'https://salt.tikicdn.com/cache/280x280/ts/product/2c/d8/2a/24ee1a155ac1f5b0bef87605abbe85ae.png', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('5740790979088', N'Laptop Lenovo ThinkBook 14s Yoga ITL i5 1135G7/16GB/512GB/14"F/Touch/Pen/Win11/(20WE007NVN)/Xám - Hàng chính hãng', 25188000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/e6/d3/c9/6916b15afedb0281bd2100af2159753b.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('9000571039677', N'LapTop Lenovo V14 IIL - 82C400W3VN | Intel Core i5 _ 1035G1 | 4GB | 256GB SSD PCIe | VGA INTEL  | 14 inch HD | FreeDos | Hàng Chính Hãng', 9850000, 3, 'https://salt.tikicdn.com/cache/280x280/ts/product/db/b5/11/9b49a332d68f5f3e77ba0cd203e4da60.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('3935930941947', N'Laptop Dell Vostro 3400 70253900 (Core i5-1135G7/ 8GB/ 256GB SSD/ 14 FHD/ Win 11 + Office) - Hàng Chính Hãng', 13750000, 2, 'https://salt.tikicdn.com/cache/280x280/ts/product/36/4f/94/65f9eac96247f79af20c3bf541f151e8.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('6172423459936', N'Laptop Acer Aspire 3 A315-56-38B1 i3 1005G1/4GB/256GB/15.6"FHD/Win11 - Hàng Chính Hãng', 8990000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/f5/64/47/b1cba1acefbac2349f0ad34978e7f4ee.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('5695441472620', N'Laptop HP ProBook 450 G8 51X30PA (i7-1165G7/ 8GB/ 512GB SSD/ 15.6FHD/ VGA ON/ Win10/ Silver/ LEB_KB/ V? nhôm) - Hàng chính hãng', 36396000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/1c/69/50/f4e584b86cd56cad8d1843b1859e75bd.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('2713952385750', N'Laptop Laptop Dell Inspiron 16 5620 i7 1260P/16GB/512GB/2GB MX570/OfficeHS/Win11 (N6I7000W1) - Hàng chính hãng', 36528000, 1, 'https://salt.tikicdn.com/cache/280x280/ts/product/42/6b/a5/2b3a68be18210796026daff2581c0f9f.png', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('5192218543377', N'Máy tính xách tay Laptop Dell Latitude 3420 (Intel Core i5-1135G7 | 14 Inch | RAM 8GB | 256GB SSD NVMe | Intel Iris Xe Graphics | Fedora Os) - Hàng chính hãng', 14999000, 1, 'https://salt.tikicdn.com/cache/280x280/ts/product/e0/be/a2/2007a3fdbdc48892339afd62352c9782.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('9963468601920', N'Laptop Dell Inspiron T7420 N4I5021W - Silver ( Intel Core i5 - 1235U (Up to 4.4 Ghz, 12Mb Cache ), 8G DDR4 3200Mhz, 512Gb SSD NVMe, 14" FHD 1920 x 1200 Truelife Touch, FingerPrint, 4 cell - 54Whr Battery, W11, Silver, Office H&S 2021 ) - Hàng Chính Hãng', 27072000, 1, 'https://salt.tikicdn.com/cache/280x280/ts/product/c8/19/5b/16034c5c306c132e29a8ac7a21dcb1f1.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('8935237344159', N'Máy tính Laptop Dell Vostro 5320 V3I7007W (I7 1260P/ 16Gb/ 512Gb SSD/ 13.3Inch QHD 2560 x 1600/ VGA On/ Win11 home + Office ST21/ Titan Gray/ 1Y) - Hàng chính hãng', 32967600, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/67/67/7e/dcb6a2856cfc167a173143c4a196f9cc.png', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('8806222242671', N'Laptop Lenovo V14 G2 ITL 82KA00WGVN | Core i5 1135G7 | 8GB | 256GB | 14" FHD | Dos | Hàng Chính hãng', 11050000, 1, 'https://salt.tikicdn.com/cache/280x280/ts/product/2b/5f/9e/9af64241a953d596cb3ae7d71f9ebb0e.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('6930527144705', N'Laptop Dell Vostro 3405 P132G002ABL (AMD R3-3250U/ 8GB DDR4/ HDD 1Tb/ 14 FHD/ Win11 + Office2021) - Hàng Chính Hãng', 8650000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/c1/26/a1/7c79bc4164e157897beab72adc9f0919.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('1451190432128', N'Laptop Acer Nitro Gaming AN515-58-773Y i7 12700H/8GB/512GB/15.6"FHD/3050Ti 4GB/Win11 Hàng Chính Hãng', 30000000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/5b/42/6f/28948e831728a7aaffe022511d510a59.png', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('9810654042743', N'Acer Nitro AN515 57 720A i7 11800H/8GB/512GB/4GB RTX3050Ti/15.6"F/144Hz/Win11/(NH.QEQSV.004)/?en - Hàng chính hãng', 36922800, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/cd/98/bd/ebc67ed07832305a1741463ef83f803c.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('7634548491971', N'Laptop Asus Vivobook F415E i3-1115G4/8GB/128SSD/UHD Graphics/14"FHD/Win10/Xám M?i 100%- Hàng Nh?p Kh?u', 10750000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/bf/0e/a9/62280749cd095d6dd351c8e01d2b7365.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('4312590305647', N'Laptop Lenovo IdeaPad 3 15ITL05 81X80055US (Core i3-1115G4/ 4GB/ 128GB SSD/ 15.6 FHD/ Win10) - Nh?p Kh?u Chính Hãng', 10290000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/23/a7/fc/610caf976a47c7f86a8513f9ac4434bd.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('8725450554583', N'Máy tính xách tay Laptop HP (Core i5-1135G7/ 8GB/ 256GB/ 14HD/ Win11/màu B?c ) - Hàng Chính Hãng', 16290000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/e2/bb/fa/162e340fb6a2e151e7eb079b7ec1927c.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('4781015241971', N'Laptop Lenovo Ideapad Gaming 3 15IMH05 i7 10750H/8GB/512GB/4GB GTX1650Ti/120Hz/Win10 (81Y4013UVN) - Hàng chính hãng', 20490000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/30/7c/43/f94cce5dd82f3452b65740c53b7c57f3.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('7974291751719', N'Laptop Dell Inspiron 16 5620 i5 1240P/16GB/512GB/2GB MX570/OfficeHS/Win11 (N6I5003W1) - Hàng chính hãng', 21550000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/bc/9b/5a/c802bed34a9904f75efd19e3401890a0.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('2403357126324', N'Laptop Asus VivoBook X515JA Core i3-1005G1/8GB/256GB/15.6"HD/Win 10/Màu Xám M?i 100%-Hàng Nh?p Kh?u', 10350000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/29/d3/ff/c375a5143579ff61d25375e3e55f5a2a.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('6205998686045', N'Laptop Acer Aspire A315 58 35AG i3 1115G4/4GB/256GB/15.6"F/Win11/(NX.ADDSV.00B)/B?c - Hàng chính hãng', 10700000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/42/a0/7f/144ba2cc58259b73e5fb8260d7cf9d11.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('1292317178337', N'Laptop Acer Aspire 7 A715-42G-R4XX (AMD R5-5500U/ 8GB DDR4/ 256GB SSD/ GTX 1650 4GB/ 15.6 FHD IPS/ Win11) - Hàng Chính Hãng', 15480000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/01/4b/20/b9e575ce75ec1ae50e627429920dd818.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('5716872200993', N'Laptop HP Pavilion 14-dv0534TU 4P5G3PA(Core i7-1165G7/8GB/512GB/Intel Iris Xe/14 Inch FHD/Win 10/Warm Gold) - Hàng chính hãng', 18290000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/1b/c1/21/245d7a6a02cee54207dec29798947eef.jpg', 2);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('9513282461916', N'Laptop HP 14s-dq2545TU 46M23PA (Core i5-1135G7/ 8GB/ 256GB/ 14HD/ Win10) - Hàng Chính Hãng', 15990000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/fd/b0/8a/dfdee1d6003cefd788e01cc1ed57756a.jpg', 2);

INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('4004267735539', N'Máy vi tính Laptop Asus ExpertBook B1400 (Chip Intel Core i5-1235U | RAM 16GB | SSD 512GB NVMe | 14'' Full HD | B?o m?t vân tay | B?o m?t TPM 2.0 | ?? b?n chu?n quân ??i US) - Hàng Chính Hãng', 17190000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/02/61/07/31ed28cfaca4174838bf1eac0744dd8b.png', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('9024656957761', N'Lenovo ThinkPad L460 (Intel Core i5 6300 , RAM 8.0GB, 1x180GB SSD SATA III, Intel HD 520, MÀN HÌNH 14 INCH T?ng c?p + chu?t không dây + bàn di chu?t - HÀNG CHÍNH HÃNG', 7550000, 8, 'https://salt.tikicdn.com/cache/280x280/ts/product/14/8c/81/4187664413d60e99ef831fb3b1bfbba7.png', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('5192218543377', N'Máy tính xách tay Laptop Dell Latitude 3420 (Intel Core i5-1135G7 | 14 Inch | RAM 8GB | 256GB SSD NVMe | Intel Iris Xe Graphics | Fedora Os) - Hàng chính hãng', 14999000, 1, 'https://salt.tikicdn.com/cache/280x280/ts/product/e0/be/a2/2007a3fdbdc48892339afd62352c9782.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('9454375054810', N'Laptop Asus ExpertBook B1400 (Chip Intel Core i5-1235U | RAM 8GB | SSD 512GB NVMe | 14'' Full HD | B?o m?t vân tay | B?o m?t TPM 2.0 | ?? b?n chu?n quân ??i US) - Hàng Chính Hãng', 15890000, 1, 'https://salt.tikicdn.com/cache/280x280/ts/product/cb/a0/81/bb35665a854fae2122f16b1acac7283e.png', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('2032558437950', N'Laptop Asus Expertbook B1502 - B1502CV (Intel Core i5-1335U | RAM 8GB | 512GB SSD | Intel UHD Graphics | 15.6 inch Full HD | Win 11 b?n quy?n) - Hàng Chính Hãng', 16490000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/c3/38/e0/78676b0c573733c58a097aaa70a97d37.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('7126773233377', N' Apple Macbook Air 2020 13 inch (Apple M1 - 8GB/ 256GB) - MGND3SA/A', 17990000, 854, 'https://salt.tikicdn.com/cache/280x280/ts/product/2b/76/1c/6c89edecac5e58f346422c3a911934ea.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('4118458865925', N'Laptop Dell Latitude 3520 70251603 (Core i3-1115G4/ 4 GB/ 256GB SSD/ 15.6HD/ Fedora) - Hàng Chính Hãng', 10150000, 3, 'https://salt.tikicdn.com/cache/280x280/ts/product/43/a8/e0/0fabf09e71ac203abefa2d19dc473ca7.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('4036911495018', N'Lenovo ThinkPad L460 (Intel Core i5 6300 , RAM 8.0GB, 1x180GB SSD SATA III, Intel HD 520, MÀN HÌNH 14 INCH T?ng c?p + chu?t không dây + bàn di chu?t - HÀNG CHÍNH HÃNG', 5790000, 8, 'https://salt.tikicdn.com/cache/280x280/ts/product/14/8c/81/fb9e28fb39287ef103ee0e9765f98564.png', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('4430421908667', N'LapTop Lenovo V14 IIL (82C400W0VN) | Intel Core i3 _ 1005G1 | 4GB | 256GB SSD PCIe | Win 10 | 14 inch HD | Hàng Chính Hãng', 7650000, 2, 'https://salt.tikicdn.com/cache/280x280/ts/product/26/71/ed/8cc11995a60d8f554c523e3b9add95a7.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('2347380992805', N'Laptop Acer Aspire 3 A314 35 P3G9 N6000/4GB/256GB/Win11 - Hàng Chính Hãng', 10188000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/4c/f7/d9/455cd70b893a01f4fa432dc2db2ec80c.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('9831707285324', N'Laptop Asus Expertbook B1502CBA B1502 (Intel Core i5-1235U | RAM 8GB | 512GB SSD | Intel UHD Graphics | 15.6 inch Full HD | Win 11 b?n quy?n) - Hàng Chính Hãng', 14490000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/8b/45/b8/217c5775bd403c6badf2cb99805f5e27.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('6855271983717', N'Laptop Asus Zenbook 14 OLED UX3402VA (Intel Core I5-1340P | Ram 16GB | SSD 512GB | 14 inch OLED WQXGA+ | Win 11 B?n quy?n - Asus-UX3402VA-KM085W ) - Hàng Chính Hãng', 25890000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/6f/49/b0/a4a37355469a5663ef6b5b5d492c05f0.png', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('5760754320256', N'Laptop Asus ExpertBook B1400 - B1400CEAE-EK3724 (Chip Intel Core i5-1135G7 | RAM 8GB | SSD 256GB NVMe | 14'' Full HD | B?o m?t vân tay | B?o m?t TPM 2.0 | ?? b?n chu?n quân ??i US) - Hàng Chính Hãng', 13490000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/fe/49/f7/35576f8f9483d943643c43cb894f8bc4.png', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('1612011036866', N'Laptop Asus Expertbook B1502 - B1502CV (Intel Core i3-1315U | RAM 8GB | 512GB SSD | 15.6 inch Full HD | Win 11 b?n quy?n) - Hàng Chính Hãng', 10490000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/e7/4c/a1/40c2c073a31cfd82e15a2b075ee9f331.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('5279357249623', N'Laptop ASUS ExpertBook B1 B1402 - B1402CV (Intel Core i7-1355U | RAM 16GB | 512GB SSD | 14 inch Full HD | Win 11 b?n quy?n) - Hàng Chính Hãng', 17999000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/43/e0/51/4734fddbc7d29a03db9acde2a8abf079.png', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('6986363207264', N'Laptop Acer Aspire 7 A715-42G-R05G (AMD R5-5500U/ 8GB DDR4/ 512GB SSD/ GTX 1650 4GB/ 15.6 FHD IPS, 144Hz/ Win11) - Hàng Chính Hãng', 17520000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/ba/d5/8f/08cc3dda0f2c25028f222a809a22c9f4.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('2289621695933', N'Laptop Lenovo ThinkBook 14s Yoga ITL i7 1165G7/8GB/512GB/14"F/Touch/Pen/Win11/(20WE007PVN)/Xám - Hàng chính hãng', 29775600, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/0f/92/4a/012771e43b9c82a175d711952e6d7f28.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('6582497857610', N'Laptop Acer Aspire A315-56-58EG (NX.HS5SV.00J) Black/ Intel i5 1035G1 (up to 3.6GHz, 6MB)/ RAM 4GB/ 256GB SSD/ 15.6inch FHD/ Win 11- Hàng chính hãng', 13788000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/bf/d5/18/0435f21c463669ffd04b1c134654e911.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('1566104039143', N'Laptop Dell Vostro 15 3510 7T2YC2 (Core i5-1135G7/ 8GB DDR4/ 512GB SSD/ 15.6 FHD/ Win11 + Office) - Hàng Chính Hãng', 20990000, 1, 'https://salt.tikicdn.com/cache/280x280/ts/product/9f/10/3a/68fa9a5b90e0941d19e4364a29ffc9ba.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('5778817652358', N'Laptop Dell Vostro 3405 V4R53500U003W (AMD R5-3500U/ 8GB (1x8GB) DDR4 2400Mhz/ 512SSD M2 PCIe NVMe/ 14 FHD/ Win10) - Hàng Chính Hãng', 11550000, 2, 'https://salt.tikicdn.com/cache/280x280/ts/product/17/c1/6c/b577d1b1acb16650e44a37bd3e798ec8.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('7980558650937', N'Laptop Lenovo Ideapad Slim 5 15ITL05 (82FG001PVN). Intel Core I5 1135G7 - Hàng Chính hãng', 15290000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/4d/9c/47/bbfafef4382f9f0910230636f4712988.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('8758576305916', N'Laptop Acer Nitro 5 Tiger AN515-58-52SP (Core i5-12500H/ 8GB/ 512GB SSD/ RTX 3050/ 15.6 FHD IPS, 144Hz/ Win11) - Hàng Chính Hãng', 24000000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/a4/5c/c3/8510e556b4ed77ded2d10f67460d8341.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('6266873980220', N'Laptop Gaming Acer Nitro 5 Tiger AN515-58-52SP  i5-12500H/RAM 8GB/512GB SSD/3050 4GB Hàng Chính Hãng', 24000000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/7c/4e/f1/78f078320fb49ab07441497c4af20d98.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('5778538923356', N'Laptop CHUWI HeroBook Pro Intel Gemini Lake N4020 Intel UHD Graphics 600  8GB 256GB SSD 128GB TF Card - Hàng Chính Hãng', 10390000, 3, 'https://salt.tikicdn.com/cache/280x280/ts/product/43/07/56/4253fb1ea27d5f9ccfe08bb07f887adb.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('1802833632442', N'Laptop Lenovo ThinkPad E14 Gen 2 20TA00JJVN (Core i5-1135G7/ 8 GB, DDR4, 3200 MHz/ 512GB SSD/ 14 FHD IPS/ Win11) - Hàng Chính Hãng', 19990000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/ec/e8/68/36dd128586db6d27c5f20808a42ec3f5.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('2854122603582', N'Laptop LarkBook Intel Gemini-Lake N4120 Intel UHD Graphics 600 13.3 inch  8GB 256GB SSD 1*extra SS Up to 1T SSD - Hàng Chính Hãng', 10590000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/8e/50/9f/01a60d3fdf45fffaa06e5b73ccd220d1.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('9961746272988', N'Laptop GemiBook Pro Intel Celeron Processor N5100  Intel UHD Graphics 600 14.0 inch 8GB 256GB SSD Max 1TB SSD  - Hàng chính hãng', 10990000, 2, 'https://salt.tikicdn.com/cache/280x280/ts/product/2c/d8/2a/24ee1a155ac1f5b0bef87605abbe85ae.png', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('5740790979088', N'Laptop Lenovo ThinkBook 14s Yoga ITL i5 1135G7/16GB/512GB/14"F/Touch/Pen/Win11/(20WE007NVN)/Xám - Hàng chính hãng', 25188000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/e6/d3/c9/6916b15afedb0281bd2100af2159753b.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('9000571039677', N'LapTop Lenovo V14 IIL - 82C400W3VN | Intel Core i5 _ 1035G1 | 4GB | 256GB SSD PCIe | VGA INTEL  | 14 inch HD | FreeDos | Hàng Chính Hãng', 9850000, 3, 'https://salt.tikicdn.com/cache/280x280/ts/product/db/b5/11/9b49a332d68f5f3e77ba0cd203e4da60.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('3935930941947', N'Laptop Dell Vostro 3400 70253900 (Core i5-1135G7/ 8GB/ 256GB SSD/ 14 FHD/ Win 11 + Office) - Hàng Chính Hãng', 13750000, 2, 'https://salt.tikicdn.com/cache/280x280/ts/product/36/4f/94/65f9eac96247f79af20c3bf541f151e8.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('6172423459936', N'Laptop Acer Aspire 3 A315-56-38B1 i3 1005G1/4GB/256GB/15.6"FHD/Win11 - Hàng Chính Hãng', 8990000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/f5/64/47/b1cba1acefbac2349f0ad34978e7f4ee.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('5695441472620', N'Laptop HP ProBook 450 G8 51X30PA (i7-1165G7/ 8GB/ 512GB SSD/ 15.6FHD/ VGA ON/ Win10/ Silver/ LEB_KB/ V? nhôm) - Hàng chính hãng', 36396000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/1c/69/50/f4e584b86cd56cad8d1843b1859e75bd.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('2713952385750', N'Laptop Laptop Dell Inspiron 16 5620 i7 1260P/16GB/512GB/2GB MX570/OfficeHS/Win11 (N6I7000W1) - Hàng chính hãng', 36528000, 1, 'https://salt.tikicdn.com/cache/280x280/ts/product/42/6b/a5/2b3a68be18210796026daff2581c0f9f.png', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('5192218543377', N'Máy tính xách tay Laptop Dell Latitude 3420 (Intel Core i5-1135G7 | 14 Inch | RAM 8GB | 256GB SSD NVMe | Intel Iris Xe Graphics | Fedora Os) - Hàng chính hãng', 14999000, 1, 'https://salt.tikicdn.com/cache/280x280/ts/product/e0/be/a2/2007a3fdbdc48892339afd62352c9782.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('9963468601920', N'Laptop Dell Inspiron T7420 N4I5021W - Silver ( Intel Core i5 - 1235U (Up to 4.4 Ghz, 12Mb Cache ), 8G DDR4 3200Mhz, 512Gb SSD NVMe, 14" FHD 1920 x 1200 Truelife Touch, FingerPrint, 4 cell - 54Whr Battery, W11, Silver, Office H&S 2021 ) - Hàng Chính Hãng', 27072000, 1, 'https://salt.tikicdn.com/cache/280x280/ts/product/c8/19/5b/16034c5c306c132e29a8ac7a21dcb1f1.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('8935237344159', N'Máy tính Laptop Dell Vostro 5320 V3I7007W (I7 1260P/ 16Gb/ 512Gb SSD/ 13.3Inch QHD 2560 x 1600/ VGA On/ Win11 home + Office ST21/ Titan Gray/ 1Y) - Hàng chính hãng', 32967600, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/67/67/7e/dcb6a2856cfc167a173143c4a196f9cc.png', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('8806222242671', N'Laptop Lenovo V14 G2 ITL 82KA00WGVN | Core i5 1135G7 | 8GB | 256GB | 14" FHD | Dos | Hàng Chính hãng', 11050000, 1, 'https://salt.tikicdn.com/cache/280x280/ts/product/2b/5f/9e/9af64241a953d596cb3ae7d71f9ebb0e.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('6930527144705', N'Laptop Dell Vostro 3405 P132G002ABL (AMD R3-3250U/ 8GB DDR4/ HDD 1Tb/ 14 FHD/ Win11 + Office2021) - Hàng Chính Hãng', 8650000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/c1/26/a1/7c79bc4164e157897beab72adc9f0919.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('1451190432128', N'Laptop Acer Nitro Gaming AN515-58-773Y i7 12700H/8GB/512GB/15.6"FHD/3050Ti 4GB/Win11 Hàng Chính Hãng', 30000000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/5b/42/6f/28948e831728a7aaffe022511d510a59.png', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('9810654042743', N'Acer Nitro AN515 57 720A i7 11800H/8GB/512GB/4GB RTX3050Ti/15.6"F/144Hz/Win11/(NH.QEQSV.004)/?en - Hàng chính hãng', 36922800, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/cd/98/bd/ebc67ed07832305a1741463ef83f803c.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('7634548491971', N'Laptop Asus Vivobook F415E i3-1115G4/8GB/128SSD/UHD Graphics/14"FHD/Win10/Xám M?i 100%- Hàng Nh?p Kh?u', 10750000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/bf/0e/a9/62280749cd095d6dd351c8e01d2b7365.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('4312590305647', N'Laptop Lenovo IdeaPad 3 15ITL05 81X80055US (Core i3-1115G4/ 4GB/ 128GB SSD/ 15.6 FHD/ Win10) - Nh?p Kh?u Chính Hãng', 10290000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/23/a7/fc/610caf976a47c7f86a8513f9ac4434bd.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('8725450554583', N'Máy tính xách tay Laptop HP (Core i5-1135G7/ 8GB/ 256GB/ 14HD/ Win11/màu B?c ) - Hàng Chính Hãng', 16290000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/e2/bb/fa/162e340fb6a2e151e7eb079b7ec1927c.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('4781015241971', N'Laptop Lenovo Ideapad Gaming 3 15IMH05 i7 10750H/8GB/512GB/4GB GTX1650Ti/120Hz/Win10 (81Y4013UVN) - Hàng chính hãng', 20490000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/30/7c/43/f94cce5dd82f3452b65740c53b7c57f3.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('7974291751719', N'Laptop Dell Inspiron 16 5620 i5 1240P/16GB/512GB/2GB MX570/OfficeHS/Win11 (N6I5003W1) - Hàng chính hãng', 21550000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/bc/9b/5a/c802bed34a9904f75efd19e3401890a0.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('2403357126324', N'Laptop Asus VivoBook X515JA Core i3-1005G1/8GB/256GB/15.6"HD/Win 10/Màu Xám M?i 100%-Hàng Nh?p Kh?u', 10350000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/29/d3/ff/c375a5143579ff61d25375e3e55f5a2a.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('6205998686045', N'Laptop Acer Aspire A315 58 35AG i3 1115G4/4GB/256GB/15.6"F/Win11/(NX.ADDSV.00B)/B?c - Hàng chính hãng', 10700000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/42/a0/7f/144ba2cc58259b73e5fb8260d7cf9d11.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('1292317178337', N'Laptop Acer Aspire 7 A715-42G-R4XX (AMD R5-5500U/ 8GB DDR4/ 256GB SSD/ GTX 1650 4GB/ 15.6 FHD IPS/ Win11) - Hàng Chính Hãng', 15480000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/01/4b/20/b9e575ce75ec1ae50e627429920dd818.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('5716872200993', N'Laptop HP Pavilion 14-dv0534TU 4P5G3PA(Core i7-1165G7/8GB/512GB/Intel Iris Xe/14 Inch FHD/Win 10/Warm Gold) - Hàng chính hãng', 18290000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/1b/c1/21/245d7a6a02cee54207dec29798947eef.jpg', 3);
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES ('9513282461916', N'Laptop HP 14s-dq2545TU 46M23PA (Core i5-1135G7/ 8GB/ 256GB/ 14HD/ Win10) - Hàng Chính Hãng', 15990000, 0, 'https://salt.tikicdn.com/cache/280x280/ts/product/fd/b0/8a/dfdee1d6003cefd788e01cc1ed57756a.jpg', 3);


-- Insert sample data into payment table
INSERT INTO [dbo].[payment] (payment_date, payment_method, amount, customer_id) VALUES
('2023-01-01', N'Ti?n m?t', 10000000, 1),
('2023-01-02', N'Ti?n m?t', 15000000, 2),
('2023-01-03', N'Chuy?n kho?n', 20000000, 3),
('2023-01-04', N'Chuy?n kho?n', 25000000, 4),
('2023-01-05', N'Th? tín d?ng', 500000, 5),
('2023-01-06', N'Th? tín d?ng', 300000, 6),
('2023-01-07', N'Th? tín d?ng', 200000, 7),
('2023-01-08', N'Chuy?n kho?n', 150000, 8),
('2023-01-09', N'Ti?n m?t', 100000, 9),
('2023-01-10', N'Chuy?n kho?n', 90000, 10);
GO

-- Insert sample data into cart table
INSERT INTO [dbo].[cart] (quantity, customer_id, product_id) VALUES
(2, 1, 1),
(1, 2, 2),
(3, 3, 3),
(1, 4, 4),
(2, 5, 5),
(1, 6, 6),
(4, 7, 7),
(2, 8, 8),
(3, 9, 9),
(1, 10, 10);
GO

-- Insert sample data into order table
INSERT INTO [dbo].[order] (order_date, total_price, customer_id, payment_id) VALUES
('2023-01-01', 10000000, 1, 1),
('2023-01-02', 15000000, 2, 2),
('2023-01-03', 20000000, 3, 3),
('2023-01-04', 25000000, 4, 4),
('2023-01-05', 500000, 5, 5),
('2023-01-06', 300000, 6, 6),
('2023-01-07', 200000, 7, 7),
('2023-01-08', 150000, 8, 8),
('2023-01-09', 100000, 9, 9),
('2023-01-10', 90000, 10, 10);
GO

-- Insert sample data into order_item table
INSERT INTO [dbo].[order_item] (quantity, price, product_id, order_id) VALUES
(2, 10000000, 1, 1),
(1, 15000000, 2, 2),
(3, 20000000, 3, 3),
(1, 25000000, 4, 4),
(2, 500000, 5, 5),
(1, 300000, 6, 6),
(4, 200000, 7, 7),
(2, 150000, 8, 8),
(3, 100000, 9, 9),
(1, 90000, 10, 10);
GO

-- Insert sample data into shipment table
INSERT INTO [dbo].[shipment] (shipment_date, address, city, state, country, zip_code, customer_id) VALUES
('2023-01-01', N'123 ???ng 1', N'Hà N?i', N'HN', N'Vi?t Nam', N'100000', 1),
('2023-01-02', N'456 ???ng 2', N'H? Chí Minh', N'HCM', N'Vi?t Nam', N'700000', 2),
('2023-01-03', N'789 ???ng 3', N'?à N?ng', N'DN', N'Vi?t Nam', N'550000', 3),
('2023-01-04', N'101 ???ng 4', N'H?i Phòng', N'HP', N'Vi?t Nam', N'180000', 4),
('2023-01-05', N'202 ???ng 5', N'C?n Th?', N'CT', N'Vi?t Nam', N'900000', 5),
('2023-01-06', N'303 ???ng 6', N'Nha Trang', N'NT', N'Vi?t Nam', N'650000', 6),
('2023-01-07', N'404 ???ng 7', N'V?ng Tàu', N'VT', N'Vi?t Nam', N'780000', 7),
('2023-01-08', N'505 ???ng 8', N'Hu?', N'HU', N'Vi?t Nam', N'530000', 8),
('2023-01-09', N'606 ???ng 9', N'Quy Nh?n', N'QN', N'Vi?t Nam', N'820000', 9),
('2023-01-10', N'707 ???ng 10', N'Buôn Ma Thu?t', N'BMT', N'Vi?t Nam', N'630000', 10);
GO

-- Insert sample data into wishlist table
INSERT INTO [dbo].[wishlist] (customer_id, product_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);
GO

INSERT INTO [dbo].[admin] (username, password, name) VALUES('admin', 'admin', 'admin');

-- Insert sample data into product table with category_id = 3 (Phụ kiện)
INSERT INTO [dbo].[product] (sku, name, price, stock, image, category_id) VALUES 
('9255921646437', N'Apple EarPods', 450000, 200, 'https://example.com/earpods.jpg', 3),
('9255921646438', N'Samsung Charger', 300000, 150, 'https://example.com/samsung_charger.jpg', 3),
('9255921646439', N'Anker PowerBank', 1200000, 100, 'https://example.com/anker_powerbank.jpg', 3),
('9255921646440', N'Logitech Mouse', 650000, 80, 'https://example.com/logitech_mouse.jpg', 3),
('9255921646441', N'Sony Headphones', 1500000, 50, 'https://example.com/sony_headphones.jpg', 3),
('9255921646442', N'Xiaomi Mi Band', 900000, 300, 'https://example.com/mi_band.jpg', 3),
('9255921646443', N'Baseus Car Charger', 400000, 120, 'https://example.com/baseus_car_charger.jpg', 3),
('9255921646444', N'Hoco Phone Stand', 250000, 200, 'https://example.com/hoco_phone_stand.jpg', 3),
('9255921646445', N'JBL Bluetooth Speaker', 1800000, 60, 'https://example.com/jbl_speaker.jpg', 3),
('9255921646446', N'Sandisk 64GB Memory Card', 300000, 500, 'https://example.com/sandisk_memory_card.jpg', 3);
GO

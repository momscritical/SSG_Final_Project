DROP TABLE IF EXISTS user;
CREATE TABLE user (
    user_idx int NOT NULL AUTO_INCREMENT,
    user_id varchar(20) NOT NULL,
    user_pw varchar(256) NOT NULL,
    user_name varchar(20) NOT NULL,
    user_email varchar(50) NOT NULL,
    user_phone varchar(20) NOT NULL,
    user_address varchar(100) NOT NULL,
    user_point int DEFAULT 0,
    user_role varchar(20) DEFAULT 'role_user',
    PRIMARY KEY(user_idx)
);

INSERT INTO user(user_id, user_pw, user_name, user_email, user_phone, user_address, user_role) VALUES ('admin', '12345', '관리자', 'admin@gmail.com', '010-0000-0000', '명왕성', 'role_admin');
INSERT INTO user(user_id, user_pw, user_name, user_email, user_phone, user_address) VALUES ('user1', '12345', '장재영', 'test@gmail.com', '010-1234-1234', '강남구 도곡동');
INSERT INTO user(user_id, user_pw, user_name, user_email, user_phone, user_address) VALUES ('user2', '12345', '홍길동', 'user@gmail.com', '010-5678-1472', '서초구 잠실');

DROP TABLE IF EXISTS product;
CREATE TABLE product (
    product_code int NOT NULL AUTO_INCREMENT,
    product_name varchar(50) NOT NULL,
    product_stock int NOT NULL,
    product_price int NOT NULL,
    product_description varchar(200) NOT NULL,
    product_date datetime DEFAULT now(),
    product_image_aws varchar(200) NOT NULL,
    product_image_azure varchar(200) NOT NULL,
    PRIMARY KEY(product_code)
);

DROP TABLE if exists cart;
CREATE TABLE cart (
    cart_number int NOT NULL AUTO_INCREMENT,
    user_id varchar(20) NOT NULL,
    product_code int NOT NULL,
    product_count int NOT NULL DEFAULT 0,
    PRIMARY KEY(cart_number)
);

DROP TABLE if exists orders;
CREATE TABLE orders (
    order_number VARCHAR(50) NOT NULL,
    order_product_code INT NOT NULL,
    order_product_stock INT NOT NULL,
    order_product_price INT NOT NULL,
    order_product_status VARCHAR(100) DEFAULT '준비중',
    order_product_date datetime DEFAULT now() NOT NULL,
    order_user_id VARCHAR(20) NOT NULL,
    order_user_name VARCHAR(20) NOT NULL,
    order_user_address VARCHAR(100) NOT NULL,
    order_user_phone VARCHAR(20) NOT NULL,
    PRIMARY KEY(order_number, order_product_code)
);
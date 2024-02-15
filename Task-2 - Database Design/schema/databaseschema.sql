-- Define table for genres
CREATE TABLE "genre" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar(50),
  "description" text
);

-- Define table for authors
CREATE TABLE "author" (
  "id" SERIAL PRIMARY KEY,
  "first_name" varchar(50),
  "last_name" varchar(50),
  "biography" text,
  "sex" varchar(1),
  "other_work" text
);

-- Define table for publishers
CREATE TABLE "publisher" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar(50),
  "address" varchar(255),
  "contact_info" varchar(50)
);

-- Define table for coupons
CREATE TABLE "coupon" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar(50),
  "code" varchar(25),
  "start_date" timestamptz,
  "end_date" timestamptz,
  "min_order_value" decimal,
  "usage_limit" int,
  "user_limit" int,
  "is_active" boolean
);

-- Define table for book_inventory
CREATE TABLE "book_inventory" (
  "id" SERIAL PRIMARY KEY,
  "quantity_available" int,
  "is_available" boolean
);

-- Define table for customer_addresses
CREATE TABLE "customer_address" (
  "id" uuid PRIMARY KEY,
  "address_line1" varchar(255),
  "address_line2" varchar(255),
  "postal_code" int,
  "city" varchar(50),
  "country" varchar(50)
);

-- Define table for customers
CREATE TABLE "customer" (
  "id" uuid PRIMARY KEY,
  "first_name" varchar(50),
  "last_name" varchar(50),
  "email" varchar(255) UNIQUE,
  "contact_number" varchar(20),
  "address_id" uuid REFERENCES "customer_address" ("id")
);


-- Define table for payment_details
CREATE TABLE "payment_detail" (
  "id" uuid PRIMARY KEY,
  "method" text,
  "currency" varchar(3),
  "amount_paid" decimal,
  "transaction_id" varchar(255) UNIQUE,
  "time" timestamptz,
  "status" text,
  "is_successful" bool,
  "receipt_url" text
);

-- Define table for customer_reviews
CREATE TABLE "customer_review" (
  "id" SERIAL PRIMARY KEY,
  "rating" float,
  "description" text,
  "posted_at" timestamptz,
  "updated_at" timestamptz,
  "reported" boolean,
  "likes_count" int,
  "dislikes_count" int,
  "is_deleted" boolean,
  "customer_id" uuid REFERENCES "customer" ("id")
);

-- Define table for books
CREATE TABLE "book" ( 
  "isbn" varchar(13) UNIQUE PRIMARY KEY,
  "book_title" varchar(255),
  "selling_price" decimal,
  "edition" int,
  "description" text,
  "language" varchar(50),
  "print_format" text,
  "inventory_id" SERIAL REFERENCES "book_inventory" ("id"),
  "author_id" SERIAL REFERENCES "author" ("id"),
  "genre_id" SERIAL REFERENCES "genre" ("id"),
  "publisher_id" SERIAL REFERENCES "publisher" ("id"),
  "customer_review_id" SERIAL REFERENCES "customer_review" ("id")
);

-- Define table for orders
CREATE TABLE "order" (
  "id" uuid PRIMARY KEY,
  "order_date" timestamptz,
  "order_status" text,
  "total_amount" decimal,
  "customer_id" uuid REFERENCES "customer" ("id"),
  "address_id" uuid REFERENCES "customer_address" ("id"),
  "coupon_id" SERIAL REFERENCES "coupon" ("id"),
  "payment_id" uuid REFERENCES "payment_detail" ("id")
);

-- Define table for order_items
CREATE TABLE "order_item" (
  "id" uuid PRIMARY KEY,
  "quantity" int,
  "unit_price" decimal,
  "discount_amount" decimal,
  "order_id" uuid REFERENCES "order" ("id"),
  "book_id" varchar(13) REFERENCES "book" ("isbn"),
  "coupon_id" SERIAL REFERENCES "coupon" ("id")
);

-- Define table for book_customer_reviews
CREATE TABLE "book_customer_review" (
  "book_customer_review_id" varchar(13) REFERENCES "book" ("isbn"),
  "customer_review_id" SERIAL REFERENCES "customer_review" ("id"),
  PRIMARY KEY ("book_customer_review_id", "customer_review_id")
);

ALTER TABLE "book_inventory" ADD COLUMN "book_id" varchar(13) REFERENCES "book" ("isbn");
ALTER TABLE "book_inventory" ADD FOREIGN KEY ("book_id") REFERENCES "book" ("isbn");
ALTER TABLE "customer_review" ADD COLUMN "book_id" varchar(13) REFERENCES "book" ("isbn");
ALTER TABLE "customer_review" ADD FOREIGN KEY ("book_id") REFERENCES "book" ("isbn");




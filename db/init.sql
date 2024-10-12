/* Create DB */
CREATE DATABASE IF NOT EXISTS catalogdb;

/* Select DB */
USE catalogdb;

/* Define catalog */
-- カテゴリテーブルの定義
CREATE TABLE IF NOT EXISTS categories (
    id VARCHAR(255) PRIMARY KEY,                   -- 商品マスタからの一意のID
    name VARCHAR(255) NOT NULL,                    -- 商品マスタからの名前
    display_name VARCHAR(255),                     -- ページ側表示用の直接入力可能な名前
    left_bound INT NOT NULL,                       -- 左インデックス
    right_bound INT NOT NULL,                      -- 右インデックス
    parent_id VARCHAR(255) DEFAULT NULL,           -- 親カテゴリID
    created_at DATETIME NOT NULL,                  -- 登録日
    updated_at DATETIME NOT NULL,                  -- 最終更新日
    deleted_at DATETIME                            -- 削除日時
);

-- 商品テーブルの定義
CREATE TABLE IF NOT EXISTS products (
    id VARCHAR(255) PRIMARY KEY,                   -- 商品マスタからの一意のID
    name VARCHAR(255) NOT NULL,                    -- 商品マスタからの名前
    display_name VARCHAR(255),                     -- ページ側表示用の直接入力可能な名前
    description TEXT,                              -- 商品の説明
    category_id VARCHAR(255),                      -- カテゴリID
    created_at DATETIME NOT NULL,                  -- 登録日
    updated_at DATETIME NOT NULL,                  -- 最終更新日
    deleted_at DATETIME,                           -- 削除日時
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- SKUテーブルの定義
CREATE TABLE IF NOT EXISTS skus (
    id VARCHAR(255) PRIMARY KEY,                   -- 商品マスタからの一意のID
    name VARCHAR(255) NOT NULL,                    -- 商品マスタからのSKU名
    display_name VARCHAR(255),                     -- ページ側表示用の直接入力可能な名前
    product_id VARCHAR(255),                       -- 商品ID
    list_price DECIMAL(10, 2),                     -- 定価
    price DECIMAL(10, 2),                          -- 価格
    created_at DATETIME NOT NULL,                  -- 登録日
    updated_at DATETIME NOT NULL,                  -- 最終更新日
    deleted_at DATETIME,                           -- 削除日時
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- スペックテーブルの定義
CREATE TABLE IF NOT EXISTS specs (
    id VARCHAR(255) PRIMARY KEY,                   -- 商品マスタからの一意のID
    sku_id VARCHAR(255),                           -- SKU ID
    spec_name VARCHAR(255) NOT NULL,               -- スペック名
    spec_value VARCHAR(255) NOT NULL,              -- スペックの値
    sort_order INT NOT NULL,                       -- ソート順
    created_at DATETIME NOT NULL,                  -- 登録日
    updated_at DATETIME NOT NULL,                  -- 最終更新日
    deleted_at DATETIME,                           -- 削除日時
    FOREIGN KEY (sku_id) REFERENCES skus(id)
);

-- ロケーションテーブルの定義
CREATE TABLE IF NOT EXISTS locations (
    id VARCHAR(255) PRIMARY KEY,                   -- ロケーションID
    name VARCHAR(255) NOT NULL,                    -- ロケーション名
    address VARCHAR(255),                          -- 住所
    type ENUM('store', 'warehouse'),               -- ロケーションのタイプ
    created_at DATETIME NOT NULL,                  -- 登録日
    updated_at DATETIME NOT NULL,                  -- 最終更新日
    deleted_at DATETIME                            -- 削除日時 (論理削除)
);

-- 在庫テーブルの定義
CREATE TABLE IF NOT EXISTS stocks (
    id VARCHAR(255) PRIMARY KEY,                   -- 在庫ID
    sku_id VARCHAR(255),                           -- SKU ID
    location_id VARCHAR(255),                      -- ロケーションID
    quantity INT,                                  -- 在庫数
    pickup_available BOOLEAN,                      -- 店舗受取可否
    delivery_available BOOLEAN,                    -- 直送可否
    created_at DATETIME NOT NULL,                  -- 登録日
    updated_at DATETIME NOT NULL,                  -- 最終更新日
    deleted_at DATETIME,                           -- 削除日時 (論理削除)
    FOREIGN KEY (sku_id) REFERENCES skus(id),
    FOREIGN KEY (location_id) REFERENCES locations(id)
);

-- カテゴリデータの投入
INSERT INTO categories (id, name, display_name, left_bound, right_bound, parent_id, created_at, updated_at)
VALUES
('1', '自転車', NULL, 1, 12, NULL, NOW(), NOW()),
('2', '電動アシスト自転車', NULL, 2, 3, '1', NOW(), NOW()),
('3', 'シティサイクル', NULL, 4, 5, '1', NOW(), NOW()),
('4', 'スポーツサイクル', NULL, 6, 7, '1', NOW(), NOW()),
('5', 'キッズサイクル', NULL, 8, 9, '1', NOW(), NOW()),
('6', '折りたたみ・小径車', NULL, 10, 11, '1', NOW(), NOW()),
('7', 'パーツ', NULL, 13, 22, NULL, NOW(), NOW()),
('8', '自転車部品', NULL, 14, 19, '7', NOW(), NOW()),
('9', 'ギア', NULL, 15, 16, '8', NOW(), NOW()),
('10', 'タイヤチューブ', NULL, 17, 18, '8', NOW(), NOW()),
('11', 'アクセサリー', NULL, 20, 23, '7', NOW(), NOW()),
('12', 'ヘルメット', NULL, 21, 22, '11', NOW(), NOW()),
('13', 'ライト', NULL, 23, 24, '11', NOW(), NOW()),
('14', 'ウェア', NULL, 25, 26, '7', NOW(), NOW());

-- 商品データの投入
INSERT INTO products (id, name, display_name, description, category_id, created_at, updated_at)
VALUES
('10001', 'MODEL101', '電動アシストモデルA', '最新の電動アシスト自転車', '2', NOW(), NOW()),
('10002', 'MODEL102', 'シティサイクルB', '街乗りに最適なシティサイクル', '3', NOW(), NOW()),
('10003', 'MODEL103', 'スポーツサイクルC', '高速走行可能なスポーツサイクル', '4', NOW(), NOW()),
('10004', 'MODEL104', 'キッズサイクルD', '子供向け自転車', '5', NOW(), NOW()),
('10005', 'MODEL105', '折りたたみサイクルE', '便利な折りたたみ自転車', '6', NOW(), NOW()),
('10006', 'MODEL106', 'ギアセットF', '高性能なギアセット', '9', NOW(), NOW()),
('10007', 'MODEL107', 'タイヤチューブG', '耐久性の高いタイヤチューブ', '10', NOW(), NOW()),
('10008', 'MODEL108', 'ヘルメットH', '軽量ヘルメット', '12', NOW(), NOW()),
('10009', 'MODEL109', 'ライトI', '明るいLEDライト', '13', NOW(), NOW());

-- SKUデータの投入
INSERT INTO skus (id, name, display_name, product_id, list_price, price, created_at, updated_at)
VALUES
('10001001', 'MODEL101001', 'Red', '10001', 160000, 150000, NOW(), NOW()),
('10001002', 'MODEL101002', 'Blue', '10001', 160000, 150000, NOW(), NOW()),
('10002001', 'MODEL102001', 'Silver', '10002', 60000, 55000, NOW(), NOW()),
('10002002', 'MODEL102002', 'Black', '10002', 60000, 55000, NOW(), NOW()),
('10003001', 'MODEL103001', 'Green', '10003', 180000, 170000, NOW(), NOW()),
('10004001', 'MODEL104001', 'Yellow', '10004', 40000, 35000, NOW(), NOW()),
('10005001', 'MODEL105001', 'White', '10005', 90000, 85000, NOW(), NOW()),
('10006001', 'MODEL106001', 'Steel', '10006', 20000, 18000, NOW(), NOW()),
('10007001', 'MODEL107001', 'Rubber', '10007', 3000, 2500, NOW(), NOW()),
('10008001', 'MODEL108001', 'Blue', '10008', 8000, 7500, NOW(), NOW()),
('10009001', 'MODEL109001', 'White', '10009', 5000, 4500, NOW(), NOW());

-- specs テーブルのサンプルデータ投入
INSERT INTO specs (id, sku_id, spec_name, spec_value, sort_order, created_at, updated_at)
VALUES
-- MODEL101 (Red)
(CONCAT('10001001', '01'), '10001001', '色', '赤', '01', NOW(), NOW()),
(CONCAT('10001001', '02'), '10001001', 'バッテリー容量', '500Wh', '02', NOW(), NOW()),
(CONCAT('10001001', '03'), '10001001', '重量', '25kg', '03', NOW(), NOW()),
(CONCAT('10001001', '04'), '10001001', 'モーター出力', '250W', '04', NOW(), NOW()),
(CONCAT('10001001', '05'), '10001001', '最大速度', '25km/h', '05', NOW(), NOW()),

-- MODEL101 (Blue)
(CONCAT('10001002', '01'), '10001002', '色', '青', '01', NOW(), NOW()),
(CONCAT('10001002', '02'), '10001002', 'バッテリー容量', '450Wh', '02', NOW(), NOW()),
(CONCAT('10001002', '03'), '10001002', '重量', '24kg', '03', NOW(), NOW()),
(CONCAT('10001002', '04'), '10001002', 'モーター出力', '250W', '04', NOW(), NOW()),
(CONCAT('10001002', '05'), '10001002', '最大速度', '24km/h', '05', NOW(), NOW()),

-- MODEL102 (Silver)
(CONCAT('10002001', '01'), '10002001', '色', 'シルバー', '01', NOW(), NOW()),
(CONCAT('10002001', '02'), '10002001', 'ホイールサイズ', '26インチ', '02', NOW(), NOW()),
(CONCAT('10002001', '03'), '10002001', 'フレーム材質', 'アルミニウム', '03', NOW(), NOW()),
(CONCAT('10002001', '04'), '10002001', '変速数', '7段変速', '04', NOW(), NOW()),
(CONCAT('10002001', '05'), '10002001', 'ブレーキタイプ', 'ディスクブレーキ', '05', NOW(), NOW()),

-- MODEL102 (Black)
(CONCAT('10002002', '01'), '10002002', '色', '黒', '01', NOW(), NOW()),
(CONCAT('10002002', '02'), '10002002', 'ホイールサイズ', '27インチ', '02', NOW(), NOW()),
(CONCAT('10002002', '03'), '10002002', 'フレーム材質', 'スチール', '03', NOW(), NOW()),
(CONCAT('10002002', '04'), '10002002', '変速数', '6段変速', '04', NOW(), NOW()),
(CONCAT('10002002', '05'), '10002002', 'ブレーキタイプ', 'ディスクブレーキ', '05', NOW(), NOW()),

-- MODEL103 (Green)
(CONCAT('10003001', '01'), '10003001', '色', '緑', '01', NOW(), NOW()),
(CONCAT('10003001', '02'), '10003001', 'ギア数', '21', '02', NOW(), NOW()),
(CONCAT('10003001', '03'), '10003001', 'フレーム材質', 'カーボンファイバー', '03', NOW(), NOW()),
(CONCAT('10003001', '04'), '10003001', 'ブレーキタイプ', 'ディスクブレーキ', '04', NOW(), NOW()),
(CONCAT('10003001', '05'), '10003001', 'サスペンション', 'フルサスペンション', '05', NOW(), NOW()),

-- MODEL104 (Yellow)
(CONCAT('10004001', '01'), '10004001', '色', '黄', '01', NOW(), NOW()),
(CONCAT('10004001', '02'), '10004001', 'ホイールサイズ', '18インチ', '02', NOW(), NOW()),
(CONCAT('10004001', '03'), '10004001', '重量', '12kg', '03', NOW(), NOW()),
(CONCAT('10004001', '04'), '10004001', 'フレーム材質', 'アルミニウム', '04', NOW(), NOW()),
(CONCAT('10004001', '05'), '10004001', 'ブレーキタイプ', 'Vブレーキ', '05', NOW(), NOW()),

-- MODEL105 (White)
(CONCAT('10005001', '01'), '10005001', '色', '白', '01', NOW(), NOW()),
(CONCAT('10005001', '02'), '10005001', '折りたたみ', 'はい', '02', NOW(), NOW()),
(CONCAT('10005001', '03'), '10005001', 'ホイールサイズ', '20インチ', '03', NOW(), NOW()),
(CONCAT('10005001', '04'), '10005001', '重量', '13kg', '04', NOW(), NOW()),
(CONCAT('10005001', '05'), '10005001', 'フレーム材質', 'スチール', '05', NOW(), NOW()),

-- MODEL106 (Steel)
(CONCAT('10006001', '01'), '10006001', '材質', 'スチール', '01', NOW(), NOW()),
(CONCAT('10006001', '02'), '10006001', 'ギア数', '7', '02', NOW(), NOW()),
(CONCAT('10006001', '03'), '10006001', '重量', '2kg', '03', NOW(), NOW()),
(CONCAT('10006001', '04'), '10006001', 'タイプ', 'シングルスピード', '04', NOW(), NOW()),
(CONCAT('10006001', '05'), '10006001', '表面処理', '防錆加工', '05', NOW(), NOW()),

-- MODEL107 (Rubber)
(CONCAT('10007001', '01'), '10007001', '材質', 'ラバー', '01', NOW(), NOW()),
(CONCAT('10007001', '02'), '10007001', '耐久性', '高い', '02', NOW(), NOW()),
(CONCAT('10007001', '03'), '10007001', 'サイズ', '26インチ', '03', NOW(), NOW()),
(CONCAT('10007001', '04'), '10007001', 'タイプ', 'チューブレス', '04', NOW(), NOW()),
(CONCAT('10007001', '05'), '10007001', '厚さ', '2.5mm', '05', NOW(), NOW()),

-- MODEL108 (Blue)
(CONCAT('10008001', '01'), '10008001', '色', '青', '01', NOW(), NOW()),
(CONCAT('10008001', '02'), '10008001', 'ヘルメットタイプ', 'ロード', '02', NOW(), NOW()),
(CONCAT('10008001', '03'), '10008001', '重量', '250g', '03', NOW(), NOW()),
(CONCAT('10008001', '04'), '10008001', '通気性', '高い', '04', NOW(), NOW()),
(CONCAT('10008001', '05'), '10008001', '耐久性', '中程度', '05', NOW(), NOW()),

-- MODEL109 (White)
(CONCAT('10009001', '01'), '10009001', '色', '白', '01', NOW(), NOW()),
(CONCAT('10009001', '02'), '10009001', 'ライトタイプ', 'LED', '02', NOW(), NOW()),
(CONCAT('10009001', '03'), '10009001', 'バッテリー寿命', '10時間', '03', NOW(), NOW()),
(CONCAT('10009001', '04'), '10009001', '防水性', 'IPX5', '04', NOW(), NOW()),
(CONCAT('10009001', '05'), '10009001', '輝度', '1000ルーメン', '05', NOW(), NOW());
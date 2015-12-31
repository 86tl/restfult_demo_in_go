/*
Navicat PGSQL Data Transfer

Source Server         : restful_api
Source Server Version : 90405
Source Host           : 10.20.0.188:5432
Source Database       : restful_demo
Source Schema         : public

Target Server Type    : PGSQL
Target Server Version : 90405
File Encoding         : 65001

Date: 2015-12-31 17:58:28
*/


-- ----------------------------
-- Table structure for "public"."relations"
-- ----------------------------
DROP TABLE "public"."relations";
CREATE TABLE "public"."relations" (
"id" int8 NOT NULL,
"user_id" int8,
"target_id" int8,
"state" varchar,
"type" varchar
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of relations
-- ----------------------------
INSERT INTO "public"."relations" VALUES ('1', '1', '2', 'liked', 'relationship');
INSERT INTO "public"."relations" VALUES ('2', '1', '3', 'matched', 'relationship');
INSERT INTO "public"."relations" VALUES ('3', '1', '4', 'disliked', 'relationship');
INSERT INTO "public"."relations" VALUES ('4', '3', '1', 'unliked', 'relationship');
INSERT INTO "public"."relations" VALUES ('5', '2', '3', 'disliked', 'relationship');
INSERT INTO "public"."relations" VALUES ('6', '3', '2', 'liked', 'relationship');
INSERT INTO "public"."relations" VALUES ('7', '1', '9', 'matched', 'relationship');
INSERT INTO "public"."relations" VALUES ('7', '9', '1', 'liked', 'relationship');

-- ----------------------------
-- Table structure for "public"."user"
-- ----------------------------
DROP TABLE "public"."user";
CREATE TABLE "public"."user" (
"id" int8 NOT NULL,
"name" varchar,
"type" varchar
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO "public"."user" VALUES ('1', 'Jack', 'user');
INSERT INTO "public"."user" VALUES ('2', 'Rose', 'user');
INSERT INTO "public"."user" VALUES ('3', 'Alice', 'user');
INSERT INTO "public"."user" VALUES ('4', 'Henry', 'user');

-- ----------------------------
-- Alter Sequences Owned By 
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table "public"."user"
-- ----------------------------
ALTER TABLE "public"."user" ADD PRIMARY KEY ("id");

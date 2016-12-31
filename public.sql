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

Date: 2016-01-03 12:48:10
*/


-- ----------------------------
-- Sequence structure for "public"."relations_id_seq"
-- ----------------------------
DROP SEQUENCE "public"."relations_id_seq";
CREATE SEQUENCE "public"."relations_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 17
 CACHE 1;

-- ----------------------------
-- Table structure for "public"."relations"
-- ----------------------------
DROP TABLE "public"."relations";
CREATE TABLE "public"."relations" (
"id" int4 DEFAULT nextval('relations_id_seq'::regclass) NOT NULL,
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
INSERT INTO "public"."relations" VALUES ('13', '9', '1', 'liked', 'relationship');
INSERT INTO "public"."relations" VALUES ('14', '1', '9', 'matched', 'relationship');
INSERT INTO "public"."relations" VALUES ('15', '3', '1', 'liked', 'relationship');
INSERT INTO "public"."relations" VALUES ('16', '1', '3', 'disliked', 'relationship');
INSERT INTO "public"."relations" VALUES ('17', '2', '3', 'disliked', 'relationship');

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
ALTER SEQUENCE "public"."relations_id_seq" OWNED BY "relations"."id";

-- ----------------------------
-- Primary Key structure for table "public"."relations"
-- ----------------------------
ALTER TABLE "public"."relations" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table "public"."user"
-- ----------------------------
ALTER TABLE "public"."user" ADD PRIMARY KEY ("id");

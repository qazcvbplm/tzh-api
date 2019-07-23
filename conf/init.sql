# Host: sh-cdb-0e99ru5c.sql.tencentcdb.com:62580  (Version 5.6.28-cdb2016-log)
# Date: 2019-07-23 14:26:03
# Generator: MySQL-Front 6.1  (Build 1.26)


#
# Structure for table "address"
#

DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '收货人姓名',
  `floor_id` int(11) NOT NULL DEFAULT '0' COMMENT '楼栋id',
  `phone` varchar(11) NOT NULL DEFAULT '' COMMENT '手机号码',
  `detail` varchar(255) NOT NULL DEFAULT '' COMMENT '详细',
  `school_id` int(11) NOT NULL DEFAULT '0' COMMENT '学校id',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `open_id` varchar(50) NOT NULL DEFAULT '' COMMENT '用户id',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=9594 DEFAULT CHARSET=utf8 COMMENT='收货地址';

#
# Structure for table "application"
#

DROP TABLE IF EXISTS `application`;
CREATE TABLE `application` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `vip_takeout_discount` decimal(5,4) NOT NULL DEFAULT '1.0000' COMMENT '会员折扣',
  `vip_run_discount` decimal(5,2) NOT NULL DEFAULT '1.00' COMMENT '跑腿会员折扣',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '平台总余额',
  `useable_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '可用余额',
  `login_name` varchar(40) NOT NULL DEFAULT '' COMMENT '登录名',
  `login_pass` varchar(255) NOT NULL DEFAULT '' COMMENT '登录密码',
  `vip_takeout_discount_flag` int(11) NOT NULL DEFAULT '0' COMMENT '外卖折扣标志',
  `vip_run_discount_flag` int(11) NOT NULL DEFAULT '0' COMMENT '跑腿折扣标志',
  `max_school_count` int(11) NOT NULL DEFAULT '0' COMMENT '最大拥有学校数量',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `phone` varchar(11) NOT NULL DEFAULT '' COMMENT '手机',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='全局信息';

#
# Structure for table "charge"
#

DROP TABLE IF EXISTS `charge`;
CREATE TABLE `charge` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `full` int(11) NOT NULL DEFAULT '0' COMMENT '充值金额',
  `send` int(11) NOT NULL DEFAULT '0' COMMENT '赠送金额',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='充值项';

#
# Structure for table "charge_log"
#

DROP TABLE IF EXISTS `charge_log`;
CREATE TABLE `charge_log` (
  `Id` varchar(50) NOT NULL DEFAULT '',
  `pay` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '充值金额',
  `send` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '赠送金额',
  `open_id` varchar(50) NOT NULL DEFAULT '' COMMENT '用户id',
  `create_time` varchar(30) NOT NULL DEFAULT '' COMMENT '时间',
  `app_id` int(11) NOT NULL DEFAULT '0' COMMENT 'appid',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='充值记录';

#
# Structure for table "coupon"
#

DROP TABLE IF EXISTS `coupon`;
CREATE TABLE `coupon` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `school_id` bigint(20) NOT NULL COMMENT '学校id',
  `coupon_name` varchar(255) NOT NULL DEFAULT '' COMMENT '优惠券名称',
  `coupon_desc` varchar(255) NOT NULL DEFAULT '' COMMENT '优惠券描述',
  `full_amount` int(11) NOT NULL COMMENT '优惠券面额（满额使用）',
  `cut_amount` int(11) NOT NULL COMMENT '优惠金额（减额）',
  `coupon_type` int(11) NOT NULL COMMENT '优惠券类型（0.店铺优惠券  1.首页优惠券 2-平台优惠券所有店铺使用）',
  `yes_show_index` int(4) NOT NULL DEFAULT '0' COMMENT '优惠券是否在首页展示（0不展示，1展示）',
  `send_begin_time` datetime NOT NULL COMMENT '优惠券发放开始时间',
  `send_end_time` datetime NOT NULL COMMENT '优惠券发放结束时间',
  `effective_days` int(11) NOT NULL COMMENT '优惠券有效天数',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_id` bigint(20) NOT NULL COMMENT '创建人id',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `update_id` bigint(20) DEFAULT NULL COMMENT '修改人id',
  `is_invalid` int(4) NOT NULL DEFAULT '0' COMMENT '是否失效（0.未使用/生效中 1.已使用/已失效 2.已过期/已失效）',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除（1.删除 0.未删除）',
  PRIMARY KEY (`id`),
  KEY `normal_index_yes_show_index` (`yes_show_index`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

#
# Structure for table "day_log_takeout"
#

DROP TABLE IF EXISTS `day_log_takeout`;
CREATE TABLE `day_log_takeout` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `self_name` varchar(40) NOT NULL DEFAULT '' COMMENT '店铺名字',
  `self_id` int(11) NOT NULL DEFAULT '0' COMMENT '本级id',
  `day` varchar(20) NOT NULL DEFAULT '' COMMENT '时间',
  `total_count` int(11) NOT NULL DEFAULT '0' COMMENT '总单数',
  `total_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '总交易金额',
  `self_get` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商铺总收入',
  `parent_get` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '学校收入',
  `takeout_total_count` int(11) NOT NULL DEFAULT '0' COMMENT '外卖单数',
  `selfget_total_count` int(11) NOT NULL DEFAULT '0' COMMENT '自取单数',
  `type` varchar(10) NOT NULL DEFAULT '' COMMENT '类型',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '上级id',
  `box_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '餐盒费',
  `send_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '配送费',
  `product_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商品费用',
  `wx_pay_get` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '微信支付所得',
  `bell_pay_get` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '钱包支付',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=24261 DEFAULT CHARSET=utf8 COMMENT='日记录';

#
# Structure for table "evaluate"
#

DROP TABLE IF EXISTS `evaluate`;
CREATE TABLE `evaluate` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `orderId` varchar(50) NOT NULL DEFAULT '' COMMENT '订单id',
  `content` varchar(1000) NOT NULL DEFAULT '' COMMENT '具体描述',
  `core` int(11) NOT NULL DEFAULT '0' COMMENT '评分',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `school_id` int(11) NOT NULL DEFAULT '0' COMMENT '学校id',
  `shop_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺id',
  `is_delete` bit(1) NOT NULL DEFAULT b'0' COMMENT '删除',
  `reply_content` varchar(255) NOT NULL DEFAULT '' COMMENT '回复',
  `reply_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '回复时间',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3024 DEFAULT CHARSET=utf8 COMMENT='评论';

#
# Structure for table "floor"
#

DROP TABLE IF EXISTS `floor`;
CREATE TABLE `floor` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL DEFAULT '' COMMENT '楼栋名字',
  `school_id` int(11) NOT NULL DEFAULT '0' COMMENT '学校id',
  `sort` bigint(20) NOT NULL DEFAULT '0' COMMENT '排序字段',
  `lat` varchar(20) NOT NULL DEFAULT '' COMMENT '纬度',
  `lng` varchar(20) NOT NULL DEFAULT '' COMMENT '经度',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `able_top` int(11) NOT NULL DEFAULT '0' COMMENT '是否支持上楼',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8 COMMENT='楼栋';

#
# Structure for table "full_cut"
#

DROP TABLE IF EXISTS `full_cut`;
CREATE TABLE `full_cut` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺id',
  `full` int(11) NOT NULL DEFAULT '0' COMMENT '满',
  `cut` int(11) NOT NULL DEFAULT '0' COMMENT '减',
  PRIMARY KEY (`Id`),
  KEY `index` (`shop_id`)
) ENGINE=InnoDB AUTO_INCREMENT=373 DEFAULT CHARSET=utf8 COMMENT='满减列表';

#
# Structure for table "home_coupon"
#

DROP TABLE IF EXISTS `home_coupon`;
CREATE TABLE `home_coupon` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `school_id` bigint(20) NOT NULL COMMENT '学校id',
  `coupon_id` bigint(20) NOT NULL COMMENT '优惠券id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_id` bigint(20) NOT NULL COMMENT '创建人id',
  `begin_time` datetime NOT NULL COMMENT '优惠券开始使用时间',
  `end_time` datetime NOT NULL COMMENT '优惠券发放结束时间',
  `is_delete` int(4) NOT NULL DEFAULT '0' COMMENT '是否删除（1.已删除 0.未删除）',
  PRIMARY KEY (`id`),
  KEY `normal_index_school_id` (`school_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='首页优惠券关联表';

#
# Structure for table "icon"
#

DROP TABLE IF EXISTS `icon`;
CREATE TABLE `icon` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(255) NOT NULL DEFAULT '' COMMENT '图片url',
  `path` varchar(100) NOT NULL DEFAULT '' COMMENT '跳转路径',
  `is_delete` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `school_id` int(11) NOT NULL DEFAULT '0' COMMENT '学校id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '图标名称',
  `sort` bigint(20) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='图标';

#
# Structure for table "logs"
#

DROP TABLE IF EXISTS `logs`;
CREATE TABLE `logs` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `msg` varchar(500) NOT NULL DEFAULT '' COMMENT '信息',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7830 DEFAULT CHARSET=utf8 COMMENT='日志记录';

#
# Structure for table "mqtt"
#

DROP TABLE IF EXISTS `mqtt`;
CREATE TABLE `mqtt` (
  `id` int(11) NOT NULL,
  `enable` bit(1) DEFAULT NULL COMMENT '是否开启',
  `total` decimal(10,4) DEFAULT NULL COMMENT '异常值',
  `per` decimal(4,2) DEFAULT NULL COMMENT '异常数',
  `open` varchar(50) NOT NULL DEFAULT '' COMMENT '异常信息',
  `tx` bit(1) NOT NULL DEFAULT b'0' COMMENT '异常标识',
  `school_id` int(11) NOT NULL DEFAULT '0' COMMENT '异常id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='重点人员';

#
# Structure for table "notice"
#

DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `school_id` int(11) NOT NULL DEFAULT '0' COMMENT '学校id',
  `title` varchar(150) NOT NULL DEFAULT '' COMMENT '标题',
  `content` varchar(1000) NOT NULL DEFAULT '' COMMENT '内容',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8 COMMENT='公告';

#
# Structure for table "order_product"
#

DROP TABLE IF EXISTS `order_product`;
CREATE TABLE `order_product` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(40) NOT NULL DEFAULT '' COMMENT '商品名字',
  `product_image` varchar(100) NOT NULL DEFAULT '' COMMENT '商品图片',
  `product_count` int(11) NOT NULL DEFAULT '0' COMMENT '商品数量',
  `product_discount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '折扣',
  `order_id` varchar(50) NOT NULL DEFAULT '' COMMENT '订单号',
  `total_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '总价',
  `attribute_name` varchar(40) NOT NULL DEFAULT '' COMMENT '规格名',
  `attribute_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '规格价格',
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT '商品id',
  PRIMARY KEY (`Id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=359413 DEFAULT CHARSET=utf8 COMMENT='订单商品';

#
# Structure for table "orders"
#

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `Id` varchar(50) NOT NULL DEFAULT '' COMMENT '订单',
  `app_id` int(11) NOT NULL DEFAULT '0' COMMENT '主体id',
  `school_id` int(11) NOT NULL DEFAULT '0' COMMENT '学校id',
  `school_top_down_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '楼上楼下差价',
  `shop_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺id',
  `shop_name` varchar(50) NOT NULL DEFAULT '' COMMENT '店铺名字',
  `shop_image` varchar(200) NOT NULL DEFAULT '' COMMENT '店铺图片',
  `shop_address` varchar(100) NOT NULL DEFAULT '' COMMENT '店铺地址',
  `shop_phone` varchar(11) NOT NULL DEFAULT '' COMMENT '店铺电话',
  `open_id` varchar(40) NOT NULL DEFAULT '' COMMENT '用户id',
  `address_name` varchar(50) NOT NULL DEFAULT '0' COMMENT '收货人姓名',
  `address_phone` varchar(11) NOT NULL DEFAULT '' COMMENT '收货人手机',
  `address_detail` varchar(150) NOT NULL DEFAULT '' COMMENT '收货人详细地址',
  `floor_id` int(11) NOT NULL DEFAULT '0' COMMENT '楼栋id',
  `typ` varchar(10) NOT NULL DEFAULT '' COMMENT '订单类型',
  `status` varchar(20) NOT NULL DEFAULT '待付款' COMMENT '订单状态',
  `box_price` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT '餐盒费',
  `send_price` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT '配送费',
  `send_base_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '基础配送费',
  `send_add_distance_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '额外距离配送费',
  `send_add_count_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '额外件数配送费',
  `product_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商品费用',
  `discount_type` varchar(20) DEFAULT '无优惠' COMMENT '优惠类型',
  `discount_price` decimal(10,2) DEFAULT '0.00' COMMENT '优惠价格',
  `coupon_id` bigint(20) DEFAULT '0' COMMENT '用户优惠券主键id',
  `coupon_full_amount` decimal(10,2) DEFAULT '0.00' COMMENT '优惠券满足条件金额',
  `coupon_used_amount` decimal(10,2) DEFAULT '0.00' COMMENT '优惠券减去金额',
  `full_cut_id` bigint(20) DEFAULT '0' COMMENT '店铺满减表id',
  `full_amount` decimal(10,2) DEFAULT '0.00' COMMENT '店铺满减满足条件金额',
  `full_used_amount` decimal(10,2) DEFAULT '0.00' COMMENT '店铺满减减去金额',
  `original_price` decimal(10,2) DEFAULT '0.00' COMMENT '订单原价,菜价+配送费+餐盒费',
  `pay_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '实际付款',
  `sender_name` varchar(30) DEFAULT NULL COMMENT '配送员名字',
  `sender_phone` varchar(11) DEFAULT NULL COMMENT '配送员手机',
  `sender_id` int(11) DEFAULT '0' COMMENT '配送员id',
  `destination` int(11) DEFAULT '0' COMMENT '是否送达',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `water_number` int(11) DEFAULT '0' COMMENT '订单相对于店铺的流水号',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `payment` varchar(10) DEFAULT '' COMMENT '支付方式',
  `pay_time` varchar(40) DEFAULT '' COMMENT '支付时间',
  `pay_time_long` bigint(20) DEFAULT NULL COMMENT '支付时间戳',
  `send_get_flag` int(11) NOT NULL DEFAULT '0' COMMENT '配送取得物品标志',
  `end_time` varchar(30) DEFAULT '' COMMENT '送达时间',
  `evaluate_flag` int(11) NOT NULL DEFAULT '0' COMMENT '是否评论',
  `resever_time` varchar(20) DEFAULT NULL COMMENT '预定送达时间',
  `shop_accept_time` varchar(20) NOT NULL DEFAULT '' COMMENT '商家接手时间',
  `pay_food_coupon` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT '粮票金额',
  PRIMARY KEY (`Id`),
  KEY `index` (`school_id`,`shop_id`,`floor_id`,`typ`,`status`,`pay_time`,`create_time`,`open_id`,`end_time`),
  KEY `normal_index_coupon_id` (`coupon_id`) USING BTREE,
  KEY `normal_index_full_cut_id` (`full_cut_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单';

#
# Structure for table "orders_complete"
#

DROP TABLE IF EXISTS `orders_complete`;
CREATE TABLE `orders_complete` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` varchar(50) NOT NULL DEFAULT '' COMMENT '订单id',
  `app_get_school_rate` decimal(4,3) NOT NULL DEFAULT '0.000' COMMENT '平台抽学校百分比',
  `school_get_shop_rate` decimal(4,3) NOT NULL DEFAULT '0.000' COMMENT '学校抽成店铺百分比',
  `school_get_sender_rate` decimal(4,3) NOT NULL DEFAULT '0.000' COMMENT '学校抽成配送员百分比',
  `app_get_total` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '平台所得',
  `school_get_shop` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '学校抽成店铺所得',
  `school_get_sender` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '学校抽成配送员所得',
  `school_get_total` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '学校所得',
  `sender_get_total` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '配送员所得',
  `shop_get_total` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '店铺所得',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=137874 DEFAULT CHARSET=utf8 COMMENT='订单结算';

#
# Structure for table "product"
#

DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(50) NOT NULL DEFAULT '' COMMENT '商品名字',
  `product_image` varchar(100) NOT NULL DEFAULT '' COMMENT '商品图片',
  `discount` decimal(3,2) NOT NULL DEFAULT '0.00' COMMENT '折扣',
  `box_price_flag` int(11) NOT NULL DEFAULT '0' COMMENT '是否计算餐盒费',
  `product_category_id` int(11) NOT NULL DEFAULT '0' COMMENT '商品分类id',
  `shop_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺id',
  `school_id` int(11) NOT NULL DEFAULT '0' COMMENT '学校id',
  `sale` int(11) NOT NULL DEFAULT '0' COMMENT '销量',
  `is_show` bit(1) NOT NULL DEFAULT b'0' COMMENT '上下架',
  `is_delete` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `stock` int(11) NOT NULL DEFAULT '0' COMMENT '库存',
  `stock_flag` int(11) NOT NULL DEFAULT '0' COMMENT '是否启动库存标志',
  PRIMARY KEY (`Id`),
  KEY `index` (`shop_id`,`product_category_id`,`is_show`,`is_delete`)
) ENGINE=InnoDB AUTO_INCREMENT=9100 DEFAULT CHARSET=utf8 COMMENT='商品';

#
# Structure for table "product_attribute"
#

DROP TABLE IF EXISTS `product_attribute`;
CREATE TABLE `product_attribute` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT '商品id',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '规格名字',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '规格价格',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`Id`),
  KEY `index` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18768 DEFAULT CHARSET=utf8 COMMENT='商品属性表';

#
# Structure for table "product_category"
#

DROP TABLE IF EXISTS `product_category`;
CREATE TABLE `product_category` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '分类名字',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `shop_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺id',
  `sort` bigint(20) NOT NULL DEFAULT '0' COMMENT '排序字段',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=1005 DEFAULT CHARSET=utf8 COMMENT='商品分类';

#
# Structure for table "run_orders"
#

DROP TABLE IF EXISTS `run_orders`;
CREATE TABLE `run_orders` (
  `Id` varchar(50) NOT NULL DEFAULT '' COMMENT '订单号',
  `app_id` int(11) NOT NULL DEFAULT '0' COMMENT '主体id',
  `address_name` varchar(50) NOT NULL DEFAULT '0' COMMENT '收货人姓名',
  `address_phone` varchar(11) NOT NULL DEFAULT '' COMMENT '收货人手机',
  `address_detail` varchar(150) NOT NULL DEFAULT '' COMMENT '收货人详细地址',
  `school_id` int(11) NOT NULL DEFAULT '0' COMMENT '学校id',
  `open_id` varchar(40) NOT NULL DEFAULT '' COMMENT '用户id',
  `total_price` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT '总金额',
  `create_time` varchar(30) NOT NULL DEFAULT '' COMMENT '创建时间',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '内容',
  `reserve_time` varchar(30) NOT NULL DEFAULT '' COMMENT '预定时间',
  `floor_id` int(11) NOT NULL DEFAULT '0' COMMENT '楼栋id',
  `sender_name` varchar(30) DEFAULT NULL COMMENT '配送员名字',
  `sender_phone` varchar(11) DEFAULT NULL COMMENT '配送员手机',
  `sender_id` int(11) DEFAULT '0' COMMENT '配送员id',
  `typ` varchar(10) NOT NULL DEFAULT '跑腿订单' COMMENT '订单类型',
  `status` varchar(20) NOT NULL DEFAULT '待付款' COMMENT '订单状态',
  `payment` varchar(10) DEFAULT '' COMMENT '支付方式',
  `evaluate_flag` int(11) NOT NULL DEFAULT '0' COMMENT '是否评论',
  `pay_time` varchar(40) DEFAULT '' COMMENT '支付时间',
  `pay_time_long` bigint(20) DEFAULT NULL COMMENT '支付时间戳',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='跑腿订单';

#
# Structure for table "school"
#

DROP TABLE IF EXISTS `school`;
CREATE TABLE `school` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` int(11) NOT NULL DEFAULT '0' COMMENT '主体id',
  `name` varchar(50) NOT NULL DEFAULT '火星大学' COMMENT '学校名字',
  `login_name` varchar(30) NOT NULL DEFAULT '' COMMENT '后台登录账号',
  `login_pass_word` varchar(255) NOT NULL DEFAULT '' COMMENT '后台登录密码',
  `rate` decimal(5,4) NOT NULL DEFAULT '0.0060' COMMENT '抽成',
  `money` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '学校可提现余额',
  `sort` bigint(20) DEFAULT '0' COMMENT '排序字段',
  `sender_money` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '配送员可提现余额',
  `send_max_distance` int(11) NOT NULL DEFAULT '0' COMMENT '免费配送距离',
  `send_per_out` int(11) NOT NULL DEFAULT '0' COMMENT '每超出多少米',
  `send_per_money` decimal(4,2) NOT NULL DEFAULT '0.00' COMMENT '每超出单位距离增加配送费',
  `wx_app_id` varchar(18) NOT NULL DEFAULT '' COMMENT '对应appid',
  `wx_secret` varchar(32) NOT NULL DEFAULT '' COMMENT '微信密钥',
  `mch_id` varchar(20) NOT NULL DEFAULT '' COMMENT '商户号',
  `wx_pay_id` varchar(32) NOT NULL DEFAULT '' COMMENT '微信支付密钥',
  `cert_path` varchar(255) NOT NULL DEFAULT '' COMMENT '微信证书存储路径',
  `top_down` decimal(4,2) NOT NULL DEFAULT '0.00' COMMENT '楼上楼下差价',
  `is_delete` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `enable_takeout` int(11) NOT NULL DEFAULT '0' COMMENT '是否开启外卖模式',
  `enable_coupon` int(4) NOT NULL DEFAULT '0' COMMENT '首页是否开启发放优惠券功能（0关闭，1开启）',
  `phone` varchar(11) NOT NULL DEFAULT '' COMMENT '手机号码',
  `sender_all_tx` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '配送员累计提现',
  `user_charge` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '用户累计充值',
  `user_bell_all` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '钱包剩余',
  `user_charge_send` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '该校剩余粮票额度',
  `page_layout` tinyint(3) NOT NULL DEFAULT '1' COMMENT '布局方式',
  `small_min_amount` decimal(5,2) NOT NULL DEFAULT '2.00' COMMENT '小件最低金额',
  `middle_min_amount` decimal(5,2) NOT NULL DEFAULT '3.00' COMMENT '中件最低金额',
  `large_min_amount` decimal(5,2) NOT NULL DEFAULT '5.00' COMMENT '大件最低金额',
  `extra_large_min_amount` decimal(5,2) NOT NULL DEFAULT '7.00' COMMENT '超大件最低金额',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='学校';

#
# Structure for table "second_hand"
#

DROP TABLE IF EXISTS `second_hand`;
CREATE TABLE `second_hand` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(150) NOT NULL DEFAULT '' COMMENT '标题',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '微信昵称',
  `avatar_url` varchar(255) NOT NULL DEFAULT '' COMMENT '微信头像',
  `open_id` varchar(40) NOT NULL DEFAULT '' COMMENT '用户id',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '内容',
  `is_show` int(11) NOT NULL DEFAULT '0' COMMENT '上下架',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '规格价格',
  `text` text NOT NULL COMMENT '图文详情',
  `wx_number` varchar(30) NOT NULL DEFAULT '' COMMENT '微信号',
  `phone` varchar(11) NOT NULL DEFAULT '' COMMENT '联系方式',
  `category` varchar(20) NOT NULL DEFAULT '' COMMENT '分类名字',
  `school_id` int(11) NOT NULL DEFAULT '0' COMMENT '学校id',
  `image` varchar(1000) NOT NULL DEFAULT '' COMMENT '轮播图',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`Id`),
  KEY `uindex` (`is_show`,`is_delete`,`school_id`)
) ENGINE=InnoDB AUTO_INCREMENT=222 DEFAULT CHARSET=utf8 COMMENT='二手';

#
# Structure for table "sender"
#

DROP TABLE IF EXISTS `sender`;
CREATE TABLE `sender` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `open_id` varchar(50) NOT NULL DEFAULT '' COMMENT '用户id',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '真实姓名',
  `phone` varchar(11) NOT NULL DEFAULT '' COMMENT '联系电话',
  `class_no` varchar(30) NOT NULL DEFAULT '' COMMENT '学号',
  `exam` varchar(20) NOT NULL DEFAULT '待审核' COMMENT '审核状态',
  `rate` decimal(5,4) NOT NULL DEFAULT '0.0000' COMMENT '抽成',
  `takeout_flag` int(11) NOT NULL DEFAULT '0' COMMENT '外卖标志',
  `run_flag` int(11) NOT NULL DEFAULT '0' COMMENT '跑腿标志',
  `shop_ids` varchar(300) NOT NULL DEFAULT '' COMMENT '负责的店铺',
  `floor_ids` varchar(300) NOT NULL DEFAULT '' COMMENT '负责的楼栋',
  `school_id` int(11) NOT NULL DEFAULT '0' COMMENT '学校id',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=848 DEFAULT CHARSET=utf8 COMMENT='配送员';

#
# Structure for table "shop"
#

DROP TABLE IF EXISTS `shop`;
CREATE TABLE `shop` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `school_id` int(11) NOT NULL DEFAULT '0' COMMENT '学校id',
  `shop_name` varchar(40) NOT NULL DEFAULT '' COMMENT '店铺名字',
  `shop_phone` varchar(11) NOT NULL DEFAULT '0' COMMENT '店铺手机',
  `shop_image` varchar(100) NOT NULL DEFAULT '' COMMENT '店铺图片',
  `shop_category_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺分类id',
  `open_flag` int(3) NOT NULL DEFAULT '0' COMMENT '店铺营业状态',
  `send_model_flag` int(11) NOT NULL DEFAULT '0' COMMENT '配送模式',
  `get_model_flag` int(11) NOT NULL DEFAULT '0' COMMENT '自取模式',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '评分',
  `start_price` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT '起送价格',
  `box_price` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT '餐盒费',
  `send_price` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT '配送费',
  `send_time` varchar(20) NOT NULL DEFAULT '40分钟' COMMENT '平均配送时间',
  `top_title` varchar(200) NOT NULL DEFAULT '' COMMENT '店铺公告',
  `shop_login_name` varchar(40) NOT NULL DEFAULT '' COMMENT '店铺登录账号',
  `shop_login_pass_word` varchar(40) NOT NULL DEFAULT '' COMMENT '登录密码',
  `shop_address` varchar(200) NOT NULL DEFAULT '' COMMENT '店铺地址',
  `rate` decimal(5,4) NOT NULL DEFAULT '0.0000' COMMENT '对店铺的抽成',
  `lat` varchar(20) NOT NULL DEFAULT '' COMMENT '纬度',
  `lng` varchar(20) NOT NULL DEFAULT '' COMMENT '经度',
  `vip_discount_flag` int(11) NOT NULL DEFAULT '0' COMMENT '是否开启会员折扣',
  `send_price_add_by_count_flag` int(11) NOT NULL DEFAULT '0' COMMENT '是否按物品件数增加配送费',
  `send_price_add` decimal(4,2) NOT NULL DEFAULT '0.00' COMMENT '每增加一件物品增加配送费',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `sort` bigint(20) NOT NULL DEFAULT '0' COMMENT '排序字段',
  `ts_model_flag` bit(1) NOT NULL DEFAULT b'0' COMMENT '堂食模式标志',
  `full_minus_rate` decimal(3,2) NOT NULL DEFAULT '0.00' COMMENT '满减承担比例',
  `coupon_rate` decimal(3,2) NOT NULL DEFAULT '0.00' COMMENT '优惠券承担比例',
  `discount_rate` decimal(3,2) NOT NULL DEFAULT '0.00' COMMENT '折扣承担比例',
  `coupon_id` int(11) NOT NULL DEFAULT '0' COMMENT '下单获得的优惠券id',
  `shop_tx_flag` bit(1) DEFAULT b'0' COMMENT '店铺提现标志',
  `tx_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '余额',
  `all_tx_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '累计提现',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=213 DEFAULT CHARSET=utf8 COMMENT='店铺';

#
# Structure for table "shop_category"
#

DROP TABLE IF EXISTS `shop_category`;
CREATE TABLE `shop_category` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '分类名字',
  `sort` bigint(20) NOT NULL DEFAULT '0' COMMENT '排序字段',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `school_id` int(11) NOT NULL DEFAULT '0' COMMENT '学校id',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COMMENT='店铺分类';

#
# Structure for table "shop_coupon"
#

DROP TABLE IF EXISTS `shop_coupon`;
CREATE TABLE `shop_coupon` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `shop_id` bigint(20) NOT NULL COMMENT '店铺id',
  `coupon_id` bigint(20) NOT NULL COMMENT '优惠券id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_id` bigint(20) NOT NULL COMMENT '创建人id',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除（1.删除 0.未删除）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='店铺优惠券关联表';

#
# Structure for table "shop_full_cut"
#

DROP TABLE IF EXISTS `shop_full_cut`;
CREATE TABLE `shop_full_cut` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `shop_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '店铺id',
  `full_amount` int(11) DEFAULT '0' COMMENT '满',
  `cut_amount` int(11) DEFAULT '0' COMMENT '减',
  `is_delete` tinyint(4) DEFAULT '0' COMMENT '是否删除 0：否 1：是',
  `create_id` bigint(20) NOT NULL COMMENT '创建人ID',
  `update_id` bigint(20) NOT NULL COMMENT '更新人ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `index` (`shop_id`)
) ENGINE=InnoDB AUTO_INCREMENT=373 DEFAULT CHARSET=utf8 COMMENT='满减列表';

#
# Structure for table "shop_open_time"
#

DROP TABLE IF EXISTS `shop_open_time`;
CREATE TABLE `shop_open_time` (
  `start_time` varchar(5) NOT NULL COMMENT '开始时间',
  `end_time_long` bigint(20) NOT NULL DEFAULT '0' COMMENT '结束时间相对时间戳',
  `start_time_long` bigint(20) NOT NULL DEFAULT '0' COMMENT '开始时间相对时间戳',
  `end_time` varchar(5) NOT NULL COMMENT '结束时间',
  `shop_id` int(11) NOT NULL COMMENT '店铺id',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1035 DEFAULT CHARSET=utf8;

#
# Structure for table "sign"
#

DROP TABLE IF EXISTS `sign`;
CREATE TABLE `sign` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `open_id` varchar(50) NOT NULL DEFAULT '' COMMENT '微信用户唯一标识',
  `day` int(11) NOT NULL DEFAULT '0' COMMENT '签到日期',
  `source` int(11) NOT NULL DEFAULT '0' COMMENT '增加的积分',
  `indexs` int(11) NOT NULL DEFAULT '1' COMMENT '连续次数',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=22737 DEFAULT CHARSET=utf8 COMMENT='签到表';

#
# Structure for table "slide"
#

DROP TABLE IF EXISTS `slide`;
CREATE TABLE `slide` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(100) NOT NULL DEFAULT '' COMMENT '图片地址',
  `path` varchar(100) NOT NULL DEFAULT '' COMMENT '跳转路径',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `school_id` int(11) NOT NULL DEFAULT '0' COMMENT '学校id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `sort` bigint(20) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8 COMMENT='轮播图表';

#
# Structure for table "source_order"
#

DROP TABLE IF EXISTS `source_order`;
CREATE TABLE `source_order` (
  `Id` varchar(50) NOT NULL DEFAULT '' COMMENT '订单号',
  `app_id` int(11) NOT NULL DEFAULT '0' COMMENT '主体id',
  `school_id` int(11) NOT NULL DEFAULT '0' COMMENT '学校id',
  `open_id` varchar(40) NOT NULL DEFAULT '' COMMENT '用户id',
  `address_name` varchar(50) NOT NULL DEFAULT '0' COMMENT '收货人姓名',
  `address_phone` varchar(11) NOT NULL DEFAULT '' COMMENT '收货人手机',
  `address_detail` varchar(150) NOT NULL DEFAULT '' COMMENT '收货人详细地址',
  `status` varchar(20) NOT NULL DEFAULT '待发货' COMMENT '订单状态',
  `pay_price` int(10) NOT NULL DEFAULT '0' COMMENT '实际付款',
  `floor_id` int(11) NOT NULL DEFAULT '0' COMMENT '楼栋id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `product_name` varchar(40) NOT NULL DEFAULT '' COMMENT '商品名字',
  `product_image` varchar(100) NOT NULL DEFAULT '' COMMENT '商品图片',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='积分订单表';

#
# Structure for table "source_product"
#

DROP TABLE IF EXISTS `source_product`;
CREATE TABLE `source_product` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(50) NOT NULL DEFAULT '' COMMENT '商品名字',
  `product_image` varchar(100) NOT NULL DEFAULT '' COMMENT '商品图片',
  `school_id` int(11) NOT NULL DEFAULT '0' COMMENT '学校id',
  `sale` int(11) NOT NULL DEFAULT '0' COMMENT '销量',
  `is_show` int(11) NOT NULL DEFAULT '0' COMMENT '上下架',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `price` int(11) NOT NULL DEFAULT '0' COMMENT '价格',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COMMENT='积分商品';

#
# Structure for table "test"
#

DROP TABLE IF EXISTS `test`;
CREATE TABLE `test` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

#
# Structure for table "tx_log"
#

DROP TABLE IF EXISTS `tx_log`;
CREATE TABLE `tx_log` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `txer_id` int(11) NOT NULL DEFAULT '0' COMMENT '提现者id',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT '提现类别',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '时间',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '金额',
  `result` varchar(255) NOT NULL DEFAULT '' COMMENT '结果',
  `school_id` int(11) NOT NULL DEFAULT '0' COMMENT '学校id',
  `app_id` int(11) NOT NULL DEFAULT '0' COMMENT '主体id',
  `ishow` bit(1) NOT NULL DEFAULT b'0',
  `is_tx` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否提现(0.申请提现 1.审核通过 2.审核失败)',
  `dz_openid` varchar(255) NOT NULL DEFAULT '' COMMENT '到账用户openid',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4553 DEFAULT CHARSET=utf8 COMMENT='提现日志';

#
# Structure for table "wx_user"
#

DROP TABLE IF EXISTS `wx_user`;
CREATE TABLE `wx_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `open_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '微信用户唯一标识',
  `nick_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '微信昵称',
  `avatar_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '微信头像',
  `gender` varchar(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '未知' COMMENT '性别',
  `province` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '未知' COMMENT '省',
  `city` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '未知' COMMENT '城市',
  `phone` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '手机号码',
  `client` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '来源',
  `school_id` int(11) NOT NULL DEFAULT '0' COMMENT '学校id',
  `app_id` int(11) NOT NULL DEFAULT '0' COMMENT '主体id',
  `gzh_open_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '公众号openid',
  PRIMARY KEY (`open_id`),
  UNIQUE KEY `index_key_id` (`id`) USING BTREE,
  KEY `index` (`app_id`,`school_id`,`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=16324 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='微信用户';

#
# Structure for table "wx_user_bell"
#

DROP TABLE IF EXISTS `wx_user_bell`;
CREATE TABLE `wx_user_bell` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `wx_user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT 'wxuser表主键id',
  `phone` varchar(61) NOT NULL DEFAULT '' COMMENT '手机号',
  `source` int(11) NOT NULL DEFAULT '0' COMMENT '积分',
  `money` decimal(7,2) NOT NULL DEFAULT '0.00' COMMENT '余额',
  `is_vip` int(11) NOT NULL DEFAULT '0' COMMENT '会员标志',
  `vip_out_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '会员过期时间',
  `food_coupon` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT '粮票余额',
  PRIMARY KEY (`phone`),
  UNIQUE KEY `index_key_id` (`id`) USING BTREE,
  KEY `un_index_wxuser_id` (`wx_user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10769 DEFAULT CHARSET=utf8 COMMENT='用户信息表';

#
# Structure for table "wx_user_coupon"
#

DROP TABLE IF EXISTS `wx_user_coupon`;
CREATE TABLE `wx_user_coupon` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `wx_user_id` bigint(20) NOT NULL COMMENT '用户id',
  `coupon_id` bigint(20) NOT NULL COMMENT '优惠券id',
  `shop_id` bigint(20) DEFAULT NULL COMMENT '店铺id',
  `coupon_type` int(4) NOT NULL COMMENT '优惠券类型（0.店铺优惠券  1.首页优惠券 2-平台优惠券所有店铺使用）',
  `get_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '优惠券领取时间',
  `use_time` datetime DEFAULT NULL COMMENT '优惠券使用时间',
  `failure_time` datetime NOT NULL COMMENT '失效时间',
  `is_invalid` int(4) NOT NULL DEFAULT '0' COMMENT '是否失效（0.未使用/生效中 1.已使用/已失效 2.已过期/已失效）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='用户优惠券关联表';

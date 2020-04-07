DROP DATABASE IF EXISTS `taxi`;
CREATE DATABASE taxi;
USE taxi;

DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`
(
    `username` varchar(20) NOT NULL COMMENT '用户名',
    `password` varchar(50) NOT NULL COMMENT '密码',
    PRIMARY KEY (`username`)
);

DROP TABLE IF EXISTS `taxi`;
CREATE TABLE `taxi`
(
    `id`                         int(5)          NOT NULL AUTO_INCREMENT COMMENT '车辆编号',
    `plate_num`                  char(8)         NOT NULL COMMENT '车牌号码',
    `model`                      varchar(20)     NOT NULL COMMENT '车型',
    `engine_num`                 char(8) UNIQUE  NOT NULL COMMENT '发动机号',
    `vehicle_identification_num` char(17) UNIQUE NOT NULL COMMENT '车架号',
    `launch_date`                timestamp       NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发行日期',
    PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `driver`;
CREATE TABLE `driver`
(
    `id`                    char(6)         NOT NULL COMMENT '司机编号',
    `name`                  varchar(20)     NOT NULL COMMENT '姓名',
    `gender`                char(1)         NOT NULL COMMENT '性别',
    `password`              varchar(50)     NOT NULL COMMENT '密码',
    `phone`                 char(11)        NOT NULL COMMENT '手机',
    `license_num`           char(6) UNIQUE  NOT NULL COMMENT '证件号码',
    `driving_license_num`   char(18) UNIQUE NOT NULL COMMENT '驾驶证号',
    `driving_license_class` char(2)         NOT NULL COMMENT '准驾车型',
    PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `contract`;
CREATE TABLE `contract`
(
    `id`          char(14)      NOT NULL COMMENT '编号',
    `taxi_id`     int(5)        NOT NULL COMMENT '车辆编号',
    `driver_id`   char(6)       NOT NULL COMMENT '司机编号',
    `create_time` timestamp     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '签约时间',
    `end_time`    timestamp     NOT NULL COMMENT '合同中止时间',
    `deposit`     double(10, 2) NOT NULL COMMENT '押金',
    PRIMARY KEY (`id`),
    CONSTRAINT `contract_driver_fk` FOREIGN KEY (`driver_id`) REFERENCES `driver` (`id`),
    CONSTRAINT `contract_taxi_fk` FOREIGN KEY (`taxi_id`) REFERENCES `taxi` (`id`)
);

DROP TABLE IF EXISTS `reward`;
CREATE TABLE `reward`
(
    `id`        char(12)     NOT NULL COMMENT '编号',
    `admin`     varchar(20)  NOT NULL COMMENT '管理员',
    `driver_id` char(6)      NOT NULL COMMENT '司机编号',
    `reason`    varchar(255) NOT NULL COMMENT '奖励原因',
    `cost`      int(5)       NOT NULL COMMENT '奖励金额',
    `from`      varchar(20)  NOT NULL COMMENT '来源',
    `time`      timestamp    NOT NULL COMMENT '记录时间',
    PRIMARY KEY (`id`),
    CONSTRAINT `reward_admin_fk` FOREIGN KEY (`admin`) REFERENCES `admin` (`username`),
    CONSTRAINT `reward_driver_fk` FOREIGN KEY (`driver_id`) REFERENCES `driver` (`id`)
);

DROP TABLE IF EXISTS `punish`;
CREATE TABLE `punish`
(
    `id`        char(12)     NOT NULL COMMENT '编号',
    `admin`     varchar(20)  NOT NULL COMMENT '管理员',
    `driver_id` char(6)      NOT NULL COMMENT '司机编号',
    `taxi_id`   int(5)       NOT NULL COMMENT '车辆编号',
    `reason`    varchar(255) NOT NULL COMMENT '处罚原因',
    `cost`      int(5)       NOT NULL COMMENT '处罚金额',
    `from`      varchar(20)  NOT NULL COMMENT '来源',
    `type`      int(1)       NOT NULL COMMENT '类型',
    `time`      timestamp    NOT NULL COMMENT '记录时间',
    `location`  varchar(255) NOT NULL COMMENT '发生地点',
    PRIMARY KEY (`id`),
    CONSTRAINT `punish_admin_fk` FOREIGN KEY (`admin`) REFERENCES `admin` (`username`),
    CONSTRAINT `punish_driver_fk` FOREIGN KEY (`driver_id`) REFERENCES `driver` (`id`),
    CONSTRAINT `punish_taxi_fk` FOREIGN KEY (`taxi_id`) REFERENCES `taxi` (`id`)
);

CREATE TABLE `complain`
(
    `id`          char(12)     NOT NULL COMMENT '编号',
    `driver_id`   char(6)      NOT NULL COMMENT '被投诉司机编号',
    `plate_num`   varchar(10) COMMENT '被投诉车牌号码',
    `phone`       char(11)     NOT NULL COMMENT '投诉人手机号',
    `reason`      varchar(255) NOT NULL COMMENT '投诉原因',
    `state`       int(1)       NOT NULL DEFAULT '0' COMMENT '投诉状态',
    `result`      varchar(255) COMMENT '处理结果',
    `time`        timestamp    NOT NULL COMMENT '发生时间',
    `location`    varchar(255) NOT NULL COMMENT '发生地点',
    `create_time` timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '投诉时间',
    PRIMARY KEY (`id`)
)


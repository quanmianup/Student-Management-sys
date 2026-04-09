-- ============================================================
-- 学生信息管理系统 — 数据库初始化脚本
-- 数据库：studentinfomanagement
-- 字符集：utf8
-- 说明：按顺序执行本脚本即可完成建库、建表和示例数据导入
-- ============================================================

-- ------------------------------------------------------------
-- 1. 创建并选择数据库
-- ------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS `studentinfomanagement`
  CHARACTER SET utf8
  COLLATE utf8_general_ci;

USE `studentinfomanagement`;

-- ------------------------------------------------------------
-- 2. 建表
--    依赖顺序：department → class → student
--                        course → sc
--                        user（独立）
-- ------------------------------------------------------------

-- 2.1 用户表
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `username` VARCHAR(50)  NOT NULL COMMENT '用户名',
  `password` VARCHAR(100) NOT NULL COMMENT '密码',
  `level`    VARCHAR(20)  NOT NULL COMMENT '权限级别（管理员 / 用户）',
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统用户表';

-- 2.2 院系表
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `Dno`   VARCHAR(20)  NOT NULL COMMENT '院系编号',
  `Dname` VARCHAR(100) NOT NULL COMMENT '院系名称',
  PRIMARY KEY (`Dno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='院系表';

-- 2.3 班级表
DROP TABLE IF EXISTS `class`;
CREATE TABLE `class` (
  `Clno`   VARCHAR(20)  NOT NULL COMMENT '班级编号',
  `Clname` VARCHAR(100) NOT NULL COMMENT '班级名称',
  `Dno`    VARCHAR(20)  NOT NULL COMMENT '所属院系编号',
  PRIMARY KEY (`Clno`),
  CONSTRAINT `fk_class_dept` FOREIGN KEY (`Dno`)
    REFERENCES `department` (`Dno`)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='班级表';

-- 2.4 学生表
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `Sno`   VARCHAR(20)  NOT NULL COMMENT '学号',
  `Sname` VARCHAR(50)  NOT NULL COMMENT '姓名',
  `Ssex`  VARCHAR(4)   NOT NULL COMMENT '性别',
  `Sage`  INT          NOT NULL COMMENT '年龄',
  `Clno`  VARCHAR(20)  NOT NULL COMMENT '所在班级编号',
  PRIMARY KEY (`Sno`),
  CONSTRAINT `fk_student_class` FOREIGN KEY (`Clno`)
    REFERENCES `class` (`Clno`)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='学生表';

-- 2.5 课程表
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `Cno`      VARCHAR(20)  NOT NULL COMMENT '课程号',
  `Cname`    VARCHAR(100) NOT NULL COMMENT '课程名称',
  `Cteacher` VARCHAR(50)  NOT NULL COMMENT '执教老师',
  `Ccredit`  DOUBLE       NOT NULL COMMENT '学分',
  PRIMARY KEY (`Cno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='课程表';

-- 2.6 选课成绩表（SC）
DROP TABLE IF EXISTS `sc`;
CREATE TABLE `sc` (
  `Sno`   VARCHAR(20) NOT NULL COMMENT '学号',
  `Cno`   VARCHAR(20) NOT NULL COMMENT '课程号',
  `Grade` DOUBLE      NOT NULL COMMENT '成绩',
  PRIMARY KEY (`Sno`, `Cno`),
  CONSTRAINT `fk_sc_student` FOREIGN KEY (`Sno`)
    REFERENCES `student` (`Sno`)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT `fk_sc_course` FOREIGN KEY (`Cno`)
    REFERENCES `course` (`Cno`)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='选课成绩表';

-- ------------------------------------------------------------
-- 3. 示例数据
-- ------------------------------------------------------------

-- 3.1 用户（密码明文存储，与项目保持一致）
INSERT INTO `user` (`username`, `password`, `level`) VALUES
('admin',   'admin123', '管理员'),
('zhangsan', '123456',  '用户'),
('lisi',     '123456',  '用户');

-- 3.2 院系
INSERT INTO `department` (`Dno`, `Dname`) VALUES
('D01', '计算机科学与技术学院'),
('D02', '数学与统计学院'),
('D03', '外国语学院');

-- 3.3 班级
INSERT INTO `class` (`Clno`, `Clname`, `Dno`) VALUES
('C0101', '计科2101班', 'D01'),
('C0102', '计科2102班', 'D01'),
('C0201', '数学2101班', 'D02'),
('C0301', '英语2101班', 'D03');

-- 3.4 学生
INSERT INTO `student` (`Sno`, `Sname`, `Ssex`, `Sage`, `Clno`) VALUES
('2021010101', '张三',   '男', 20, 'C0101'),
('2021010102', '李四',   '女', 19, 'C0101'),
('2021010201', '王五',   '男', 21, 'C0102'),
('2021020101', '赵六',   '女', 20, 'C0201'),
('2021030101', '钱七',   '男', 22, 'C0301');

-- 3.5 课程
INSERT INTO `course` (`Cno`, `Cname`, `Cteacher`, `Ccredit`) VALUES
('CS001', '数据库原理',     '陈老师', 3.0),
('CS002', 'Java程序设计',   '李老师', 4.0),
('CS003', '数据结构',       '王老师', 3.0),
('MA001', '高等数学',       '张老师', 4.0),
('EN001', '大学英语',       '刘老师', 2.0);

-- 3.6 选课成绩
INSERT INTO `sc` (`Sno`, `Cno`, `Grade`) VALUES
('2021010101', 'CS001', 88.0),
('2021010101', 'CS002', 92.0),
('2021010101', 'MA001', 75.0),
('2021010102', 'CS001', 55.0),
('2021010102', 'CS002', 78.0),
('2021010102', 'EN001', 85.0),
('2021010201', 'CS001', 90.0),
('2021010201', 'CS003', 82.0),
('2021020101', 'MA001', 95.0),
('2021020101', 'CS003', 68.0),
('2021030101', 'EN001', 91.0),
('2021030101', 'MA001', 58.0);

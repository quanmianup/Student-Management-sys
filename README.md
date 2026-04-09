# 🎓 学生信息管理系统

> 基于 Java Web（JSP + Servlet）+ MySQL 开发的学生信息管理系统，支持管理员与普通用户两种角色，实现对学生、课程、成绩等核心数据的增删改查与统计分析。

---

## 📋 目录

- [功能简介](#功能简介)
- [技术栈](#技术栈)
- [项目结构](#项目结构)
- [数据库设计](#数据库设计)
- [快速开始](#快速开始)
- [页面预览](#页面预览)

---

## 功能简介

### 👤 用户角色

| 角色 | 说明 |
|------|------|
| 管理员 | 可对所有数据进行增删改查，并查看统计报表 |
| 普通用户 | 登录后可查看与自身相关的信息 |

### 🛠️ 管理员功能

- **用户管理**：查询、新增、删除、修改系统用户
- **院系管理**：查询、新增、删除、修改院系信息
- **班级管理**：查询、新增、删除、修改班级信息
- **学生管理**：查询、新增、删除、修改学生信息
- **课程管理**：查询、新增、删除、修改课程信息
- **成绩管理**：查询、新增、删除、修改学生选课成绩
- **统计分析**：
  - 各课程平均分统计
  - 各课程不及格率统计
  - 各课程成绩排名

### 🔐 账号功能

- 用户注册 / 登录 / 退出
- 登录成功后根据权限级别自动跳转至对应页面

---

## 技术栈

| 类别 | 技术 |
|------|------|
| 前端 | HTML5、CSS3、JavaScript、JSP |
| 后端 | Java Servlet（Java EE 2.5） |
| 数据库 | MySQL 5.x |
| 数据库驱动 | mysql-connector-java 5.1.38 |
| 应用服务器 | Apache Tomcat |
| 开发工具 | Eclipse / IntelliJ IDEA |

---

## 项目结构

```
code/
├── src/
│   ├── dao/                  # 数据访问层（DAO）
│   │   ├── ClassDao.java
│   │   ├── CourseDao.java
│   │   ├── DepartmentDao.java
│   │   ├── SCDao.java
│   │   ├── StudentDao.java
│   │   └── UserDao.java
│   ├── model/                # 实体模型（JavaBean）
│   │   ├── Class.java
│   │   ├── Course.java
│   │   ├── Course_avg.java
│   │   ├── Course_fail_rate.java
│   │   ├── Course_ranking.java
│   │   ├── Department.java
│   │   ├── SC.java
│   │   ├── Student.java
│   │   └── User.java
│   ├── service/              # 业务逻辑层（Servlet）
│   │   ├── AdminDao.java     # 管理员所有操作的核心 Servlet
│   │   ├── LoginServlet.java
│   │   ├── RegisterServlet.java
│   │   └── UserExitServlet.java
│   └── utils/
│       └── DBUtils.java      # 数据库连接工具类
└── WebContent/
    ├── login.html            # 登录页
    ├── register.html         # 注册页
    ├── admin.jsp             # 管理员主页
    ├── user.jsp              # 普通用户主页
    ├── message.jsp           # 提示信息页
    ├── css/                  # 样式文件
    ├── js/                   # 脚本文件
    ├── images/               # 图片资源
    └── WEB-INF/
        ├── web.xml           # Servlet 配置
        └── lib/              # 依赖 JAR 包
```

---

## 数据库设计

数据库名：`studentinfomanagement`

主要数据表：

| 表名 | 说明 | 主要字段 |
|------|------|----------|
| `user` | 系统用户 | username、password、level（用户/管理员） |
| `department` | 院系 | 院系编号、院系名称 |
| `class` | 班级 | 班级编号、班级名称、所属院系 |
| `student` | 学生 | Sno（学号）、Sname、Ssex、Sage、Clno（班级） |
| `course` | 课程 | Cno（课程号）、Cname、Cteacher、Ccredit（学分） |
| `sc` | 选课成绩 | Sno、Cno、Grade（成绩） |

---

## 快速开始

### 环境要求

- JDK 1.8+
- MySQL 5.x
- Apache Tomcat 8.x+

### 部署步骤

**1. 克隆项目**

```bash
git clone https://github.com/quanmianup/Student-Management-sys.git
```

**2. 创建数据库**

```sql
CREATE DATABASE studentinfomanagement CHARACTER SET utf8 COLLATE utf8_general_ci;
```

根据 `model` 包中各实体类的字段，在数据库中创建对应的数据表。

**3. 配置数据库连接**

修改 `src/utils/DBUtils.java` 中的连接信息：

```java
String dbUserName = "sa";          // 数据库用户名
String dbUserPasswd = "hellojava"; // 数据库密码
String dbURL = "jdbc:mysql://localhost:3306/studentinfomanagement?...";
```

**4. 部署到 Tomcat**

将 `code/` 目录导入 Eclipse 或 IntelliJ IDEA，配置 Tomcat 服务器后启动项目。

**5. 访问系统**

打开浏览器，访问：

```
http://localhost:8080/StudentManagement/login.html
```

---

## 页面预览

| 页面 | 路径 |
|------|------|
| 登录页 | `login.html` |
| 注册页 | `register.html` |
| 管理员主页 | `admin.jsp`（登录后跳转） |
| 用户主页 | `user.jsp`（登录后跳转） |
| 提示页 | `message.jsp`（操作结果提示） |

---

## 📄 License

本项目基于 [MIT License](LICENSE) 开源，仅供学习参考，欢迎 Fork 与二次开发。

# Báo cáo bài tập kết nối Database dùng thư viện JDBC

- Project: [download here)](https://raw.githubusercontent.com/quockhanhtn/KShare/master/jdbcConnect18110304.zip)
- Video demo : [Youtube](https://youtu.be/cPW7Sm7l2V4)

### Tạo database mẫu và insert dữ liệu để test

```sql
DROP SCHEMA IF EXISTS book_manager;
create schema book_manager;
use book_manager;

DROP TABLE IF EXISTS `book`;
CREATE TABLE IF NOT EXISTS `book` (
	`book_id` BIGINT AUTO_INCREMENT,
	`book_name` NVARCHAR(50) NOT NULL,
	`book_quantity` INT NOT NULL,
	`book_image_path` LONGTEXT NOT NULL,
    
    PRIMARY KEY(`book_id`)
) ENGINE = InnoDB;

insert into `book`(`book_name`, `book_quantity`, `book_image_path`)
values 
	(N'The clean Coder', 5, N'.\\images\\1.jpg'),
	(N'Head first javascript', 10, N'.\\images\\2.jpg'),
    (N'Head first C', 7, N'.\\images\\3.jpg'),
    (N'Head first Java', 4, N'.\\images\\4.jpg');
```

Project có 3 package:

- com.quockhanh.controller (Chứa các Servlet)
- com.quockhanh.model (Chứa model)
- com.quockhanh.utils
	
#### Package ```com.quockhanh.utils``` gồm 2 lớp:
- Lớp **```DatabaseConnection```** lưu các giá trị như url, username, password để tạo ```Connection``` tới database

```java
package com.quockhanh.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Config JDBC Connection and get JDBC Connection
 */
public class DatabaseConnection {
   final static String url = "jdbc:mysql://localhost:3306/book_manager";
   final static String username = "root";
   final static String password = "0000";

   /**
    * Get MySql JDBC Connection
    *
    * @return Connection to MySql database or null
    */
   public static Connection getConnection() {
      try {
         Class.forName("com.mysql.jdbc.Driver");
         return DriverManager.getConnection(url, username, password);
      } catch (SQLException | ClassNotFoundException e) {
         e.printStackTrace();
      }
      return null;
   }
}
```

- Lớp **```DatabaseUtils```**, có các hàm sau:

```java
package com.quockhanh.utils;

import java.math.BigDecimal;
import java.sql.*;
import java.util.List;

public class DatabaseUtils {
   /**
    * Set parameter cho PreparedStatement
    *
    * @param prepStmt   PreparedStatement cần set parameter
    * @param parameters List parameter để set, do có kiểu là Object nên có thể truyền vào nhiều kiểu dữ liệu
    */
   private static void setParameters(PreparedStatement prepStmt, List<Object> parameters) {
      if (parameters == null) {
         return;
      }
      try {
         for (int i = 0; i < parameters.size(); i++) {
            Object para = parameters.get(i);
			
			// Kiểm tra object truyền vào thuộc kiểu nào để set tham số

            if (para instanceof Boolean) prepStmt.setBoolean(i + 1, (Boolean) para);
            else if (para instanceof Byte) prepStmt.setByte(i + 1, (Byte) para);
            else if (para instanceof Integer) prepStmt.setInt(i + 1, (Integer) para);
            else if (para instanceof Float) prepStmt.setFloat(i + 1, (Float) para);
            else if (para instanceof Long) prepStmt.setLong(i + 1, (Long) para);
            else if (para instanceof Double) prepStmt.setDouble(i + 1, (Double) para);
            else if (para instanceof BigDecimal) prepStmt.setBigDecimal(i + 1, (BigDecimal) para);
            else if (para instanceof String) prepStmt.setString(i + 1, (String) para);
         }
      } catch (SQLException exception) {
         exception.printStackTrace();
      }
   }

   /**
    * Executes truy vấn SQL
    *
    * @param sqlQuery   câu lệnh SQL để lấy dữ liệu
    * @param parameters list tham số
    * @return một ResultSet nếu execute query thành công, ngược lại trả về null
    */
   public static ResultSet executeQuery(String sqlQuery, List<Object> parameters) {
      Connection conn = DatabaseConnection.getConnection();
      PreparedStatement prepStmt;
      ResultSet rs = null;

      if (conn == null) {
         return null;
      }
      try {
         prepStmt = conn.prepareStatement(sqlQuery);
         if (parameters != null) {
            setParameters(prepStmt, parameters);
         }
         rs = prepStmt.executeQuery(sqlQuery);
      } catch (SQLException e) {
         e.printStackTrace();
      }
      return rs;
   }

   /**
    * Thực thi câu lệnh INSERT, UPDATE, DELETE
    *
    * @param sqlQuery   câu lệnh SQL INSERT, UPDATE, DELETE
    * @param parameters list tham số
    * @return số lượng dòng thay đổi sau khi thực hiện câu lệnh hoặc 0 nếu thất bại
    */
   public static int executeUpdate(String sqlQuery, List<Object> parameters) {
      Connection conn = DatabaseConnection.getConnection();
      PreparedStatement prepStmt = null;
      int executeResult = 0;

      if (conn == null) {
         return executeResult;   // 0
      }

      try {
         prepStmt = conn.prepareStatement(sqlQuery);
         if (parameters != null) {
            setParameters(prepStmt, parameters);
         }
         executeResult = prepStmt.executeUpdate();
      } catch (SQLException e) {
         e.printStackTrace();
      } finally {
         if (prepStmt != null) {
            try {
               prepStmt.close();
            } catch (SQLException ex) {
               // ignore
            }
         }
      }

      return executeResult;
   }

   /**
    * Thực thi câu lệnh INSERT cho bảng có field nhận giá tự tăng (auto_increament)
    *
    * @param sqlQuery   câu lệnh SQL INSERT
    * @param parameters list tham số
    * @return Giá trị của field tự tăng vừa insert
    */
   public static Object executeUpdateAutoIncrement(String sqlQuery, List<Object> parameters) {
      Connection conn = DatabaseConnection.getConnection();
      PreparedStatement prepStmt = null;
      ResultSet rs = null;
      Object autoIncKeyFromApi = null;

      if (conn == null) {
         return null;   // 0
      }

      try {
         prepStmt = conn.prepareStatement(sqlQuery, Statement.RETURN_GENERATED_KEYS);
         if (parameters != null) {
            setParameters(prepStmt, parameters);
         }
         if (prepStmt.executeUpdate() != 0) {
            rs = prepStmt.getGeneratedKeys();
            if (rs.next()) {
               autoIncKeyFromApi = rs.getObject(1);
            }
         }
      } catch (SQLException exception) {
         exception.printStackTrace();
      } finally {
         if (rs != null) {
            try {
               rs.close();
            } catch (SQLException ex) {
               ex.printStackTrace();
            }
         }

         if (prepStmt != null) {
            try {
               prepStmt.close();
            } catch (SQLException ex) {
               ex.printStackTrace();
            }
         }
      }
      return autoIncKeyFromApi;
   }
}
```

#### Package ```com.quockhanh.model``` gồm 2 lớp: 

- Lớp **```BookDTO```** dùng để lưu dữ liệu mỗi record lấy về được từ Database thông qua ResultSet

- Lớp **```BookDAO```** được viết theo design partern Singleton, gồm các hàm gets(), getById(), insert(), update(), delete() để tương tác với database và trả về các object có kiểu BookDTO

#### Package ```com.quockhanh.controller``` gồm 4 Servlet: 
- BookController : Gọi hàm ```gets()``` từ **```BookDAO```** để lấy list book rồi setAttribute và forward đến trang book.jsp để hiển thị danh sách
- BookAddController : Gọi hàm ```insert()``` từ **```BookDAO```** để thêm sách mới
- BookDeleteController : Gọi hàm ```delete()``` từ **```BookDAO```** để xóa một cuốn sách
- BookEditController: Gọi hàm ```getById()``` từ **```BookDAO```** để lấy thông tin sách cần cập nhật rồi setAttribute và forward đến trang book-edit.jsp
- BookUpdateController: Gọi hàm ```update()``` từ **```BookDAO```** để cập nhật thông tin sách

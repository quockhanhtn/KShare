# Tutorial #1 - Example Java EE MVC Web application in IntelliJ IDEA



## 1. Tạo Java Java Enterprise project trong IntelliJ

- Chọn `New Project` khi mở IntelliJ
<br>![new-project](img/tut-1/00_welcome-popup.png) 

- `New Project` dialog hiện ra, chọn `Java Enterprise`. Trong bài viết này, chúng ta sẽ để mặc định **Build Tool** là `Maven` và **Test Runner** là `JUnit`. Click `Next` để tiếp tục.
<br>![project_type](img/tut-1/01_project_type.png)

- Add `Servlet` library trong mục `Specifications`, tiếp tục click `Next`.
<br>![title](img/tut-1/02_add_library.png)

- Đặt tên projcet, nơi lưu, và chọn `Finish`
<br>![title](img/tut-1/03_set_project_name.png)

## 2. Viết code theo mô hình MVC

- Cấu trúc project như sau:

<pre>
project
├── src
│   ├── main
│   │   ├── java
│   │   │   ├── com.example.controller
│   │   │   │   └── <a href="./resource/tut-1/src/main/java/com.example.controller/OrderSevlet.java" target="_blank">OrderSevlet.java</a>
│   │   │   ├── com.example.model
│   │   │   │   └── <a href="./resource/tut-1/src/main/java/com.example.model/Order.java" target="_blank">Order.java</a>
│   │   ├── webapp
│   │   │   ├── WEB-INF
│   │   │   │   └─── <a href="./resource/tut-1/src/main/webapp/WEB-INF/web.xml" target="_blank">web.xml</a>
│   │   │   ├── <a href="./resource/tut-1/src/main/webapp/order.jsp" target="_blank">order.jsp</a>
│   │   │   ├── <a href="./resource/tut-1/src/main/webapp/order-error.jsp" target="_blank">order-error.jsp</a>
│   │   │   └── <a href="./resource/tut-1/src/main/webapp/order-success.jsp" target="_blank">order-success.jsp</a>
└── <a href="./resource/tut-1/pom.xml" target="_blank">pom.xml</a>
</pre>

- Project được chia ra ba phần:
  - Phần `Model`gồm các class đặt trong package `com.example.model`
  - Phần `View` gồm các file được lưu ở `src\main\webapp`
  - Phần `Controller` gồm các class đặt trong package `com.example.controller`


## 3. Cấu hình GlassFish Sever để run project trên localhost

- Trên thanh menu chọn **`File`** -> **`Setting...`** (hoặc nhấn tổ hợp `Ctrl + Alt + S`), chọn tab **`Build, Execution, Deployment`** -> **`Application Servers`**
<br>![ctrl-alt-s](img/tut-1/05_go_to_setting.png)

- Nhấn vào biểu tượng dấu **`+`**, chọn **`Glassfish Server`**
<br>![ctrl-alt-s](img/tut-1/06_add_glassfish.png)

- Chọn đường dẫn đến nơi chứa GlassFish, có thể tải GlassFish 4.1.1 [tại đây][glass-fish-oracle] hoặc [tại đây][glass-fish-reup]
<br>![glassfish_dir](img/tut-1/07-glassfish_dir.png)

- Cuối cùng chọn **`OK`**
<br>![glassfish_ok](img/tut-1/08-glassfish_ok.png)

- Edit file `asenv.conf` trong thư mục `glassfish/config`
  - Trên thanh menu chọn **`File`** -> **`Project Structure...`** (hoặc nhấn tổ hợp `Ctrl + Alt + Shift + S`)
  <br>![project_structure](img/tut-1/09_project_structure.png)
  
  - **Project Structure** dialog hiện ra, chọn tab **`Platform Settings`** -> **`SDKs`**
  <br>![project_structure](img/tut-1/10_project_structure_sdks.png)

  - Copy `JDK home path` và thêm `AS_JAVA=<JDK home path>` vào cuối file `asenv.conf` như hình dưới đây
  <br>![edit_assenv.conf](img/tut-1/11_edit_assenv.conf.png)

## 4. Tạo GlassFish run configuration


- Vào menu **`Run`** -> **`Edit Configurations...`** 
<br>![edit_assenv.conf](img/tut-1/12.png)

- Nhấn vào biểu tượng dấu **`+`**, chọn **`Glassfish Server Local`**
<br>![edit_assenv.conf](img/tut-1/13.png)

- Tại phần **Glassfish Server Setting** trong tab **`Server`**, đặt giái trị cho **`Server domain`** là `domain1`
<br>![edit_assenv.conf](img/tut-1/14.png)

- Trong tab **`Deployment`**, add the `artifact` mà bạn muốn deploy
<br>![edit_assenv.conf](img/tut-1/15.png)
<br>![edit_assenv.conf](img/tut-1/16.png)

- Mở lại tab **`Server`**, ta thấy `URL` đã được set giá trị là `http://localhost:8080/<project-name>-<version>/`
<br>![edit_assenv.conf](img/tut-1/17.png)

- Click **OK**. Để run configuration, nhấn tổ hợp phím `Alt + Shift + F10` hoặc click vào nút play màu xanh lá góc trên bên trái màn hình
<br>![edit_assenv.conf](img/tut-1/18.png)


### Khi build project thành công, IDE sẽ mờ trình duyệt, truy cập vào trang web của chúng ta ở localhost
<br>![edit_assenv.conf](img/tut-1/19.png)

## Thank you for reading <3



[glass-fish-oracle]: https://github.com/quockhanhtn/quockhanhtn/blob/master/img/vietnam_flag.png
[glass-fish-reup]: https://drive.google.com/file/d/1Hj21_zSOEDWbxMiRoZxaLSgqbzLlgipn/view?usp=sharing
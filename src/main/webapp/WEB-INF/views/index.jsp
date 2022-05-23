<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<body>
<h1 - darkorange;"> My Dynamic Page </h1>
</br>
<h3>Date and 'Hello Word' messages were generated dynamically</h3>
<h1>${msg}</h1>
<h2>Today is <fmt:formatDate type = "both" dateStyle = "long" timeStyle = "long" value = "${today}" /></h2>
</br>
<h1 style="color: rgb(17, 112, 255);">Running from ${env}</h1>
<h3> Meeting at 6.30 pm </h3>
<h1 style="color: crimson;">-------------------------------------------------------</h1>
</body>
</html>
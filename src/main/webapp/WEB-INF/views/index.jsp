<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<body>
<h1 style="color: darkorange;"> My Dynamic Page </h1>
</br>
<h3>Date and 'Hello Word' messages were generated dynamically</h3>
<h1>${msg}</h1>
<h2>Today is <fmt:formatDate type = "both" dateStyle = "long" timeStyle = "long" value = "${today}" /></h2>
</body>
</html>
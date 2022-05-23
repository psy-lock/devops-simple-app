<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
    <body>
        <h1>Welcome to my Simple App</h1>
        <h1 style="color: darkorange;"> My Dynamic Page </h1>
        </br>
        <h3>Date and '${msg}' messages were generated in java</h3>
        <h1>${msg}</h1>
        <h2>Today is <fmt:formatDate type = "both" dateStyle = "long" timeStyle = "long" value = "${today}" /></h2>
    </body>
</html>
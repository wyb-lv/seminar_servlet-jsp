<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setLocale value="en_US" scope="session" />

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Album Gallery - Curated vinyl records and music collection">
        <title>Album Gallery - Vinyl Records Store</title>

        <!-- Google Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
              rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
              crossorigin="anonymous">
        <link rel="stylesheet"
              href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

        <!-- Custom CSS -->
        <link rel="stylesheet" href="<c:url value="/css/site.css" />">
    </head>
    <body>
        <%-- ==================== Header ==================== --%>
        <header class="main-header">
            <div class="container-fluid px-4">
                <nav class="navbar navbar-light py-3">
                    <a class="navbar-brand" href="<c:url value="/" />">
                        <i class="bi bi-vinyl-fill me-2"></i>
                        <span class="brand-text">ALBUM GALLERY</span>
                    </a>

                    <div class="d-flex gap-3 align-items-center ms-auto">
                        <%-- Guest User (Not Logged In) --%>
                        <c:if test="${account == null}">
                            <a href="#" class="nav-link-custom" data-bs-toggle="modal" data-bs-target="#loginModal" title="Login">
                                <i class="bi bi-person"></i>
                            </a>
                            <a href="<c:url value="/account/register.do" />" class="nav-link-custom" title="Sign Up">
                                <i class="bi bi-person-plus"></i>
                            </a>
                        </c:if>

                        <%-- Logged In User --%>
                        <c:if test="${account != null}">
                            <a href="#" class="nav-link-custom" title="Welcome, ${account.name}">
                                <i class="bi bi-person-fill"></i>
                            </a>
                        </c:if>

                        <%-- Logout Icon (Only for logged in users) --%>
                        <c:if test="${account != null}">
                            <a href="<c:url value="/account/logout.do" />" class="nav-link-custom" title="Logout">
                                <i class="bi bi-box-arrow-right"></i>
                            </a>
                        </c:if>
                    </div>
                </nav>
            </div>
        </header>

        <%-- ==================== Main Content ==================== --%>
        <main class="main-content">
            <div class="container-fluid px-4 py-5">
                <jsp:include page="/WEB-INF/${controller}/${action}.jsp" />
            </div>
        </main>

        <%-- ==================== Footer ==================== --%>
        <footer class="main-footer">
            <div class="container-fluid px-4 py-4">
                <div class="footer-content text-center">
                    <h5 class="footer-title mb-2">
                        <i class="bi bi-vinyl-fill me-2"></i>ALBUM GALLERY
                    </h5>
                    <p class="footer-text mb-3">Curated vinyl records and music collection for true music lovers.</p>
                    <p class="footer-copyright mb-0">&copy; 2025 Album Gallery. All rights reserved.</p>
                </div>
            </div>
        </footer>

        <!-- Bootstrap JavaScript Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
                crossorigin="anonymous">
        </script>
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // Header scroll effect
                const header = document.querySelector('.main-header');
                window.addEventListener('scroll', function() {
                    if (window.scrollY > 50) {
                        header.classList.add('scrolled');
                    } else {
                        header.classList.remove('scrolled');
                    }
                });

                // Check URL parameters using JavaScript
                const urlParams = new URLSearchParams(window.location.search);
                const alertBox = document.getElementById('alertBox');
                const alertTitle = document.getElementById('alertTitle');
                const alertMessage = document.getElementById('alertMessage');

                // Show login modal if login=1
                if (urlParams.get('login') === '1') {
                    var loginModal = new bootstrap.Modal(document.getElementById('loginModal'));
                    loginModal.show();
                }

                // Show success messages
                if (urlParams.get('success') === 'checkout') {
                    alertBox.className = 'alert alert-success alert-dismissible';
                    alertTitle.textContent = 'Success!';
                    alertMessage.textContent = 'Your order has been placed successfully. Thank you for shopping with us!';
                    alertBox.style.display = 'block';
                }

                // Show error messages
                if (urlParams.get('error') === '1') {
                    alertBox.className = 'alert alert-danger alert-dismissible';
                    alertTitle.textContent = 'Error!';
                    alertMessage.textContent = 'Invalid email or password. Please try again.';
                    alertBox.style.display = 'block';
                }

                if (urlParams.get('error') === 'checkout') {
                    alertBox.className = 'alert alert-danger alert-dismissible';
                    alertTitle.textContent = 'Error!';
                    alertMessage.textContent = 'There was a problem processing your order. Please try again.';
                    alertBox.style.display = 'block';
                }
            });

            // Set upload date for create form
            const uploadDateInput = document.getElementById('uploadDate');
            if (uploadDateInput) {
                const now = new Date();
                const year = now.getFullYear();
                const month = String(now.getMonth() + 1).padStart(2, '0');
                const day = String(now.getDate()).padStart(2, '0');
                const hours = String(now.getHours()).padStart(2, '0');
                const minutes = String(now.getMinutes()).padStart(2, '0');

                const formattedDateTime = `${year}-${month}-${day}T${hours}:${minutes}`;
                uploadDateInput.value = formattedDateTime;
            }
        </script>

        <%-- Session-based Alert (for login success/failure) --%>
        <c:if test="${not empty sessionScope.alert}">
            <div class="alert alert-${sessionScope.alert.type} alert-dismissible fade show"
                 style="position: fixed; bottom: 20px; left: 5%; right: 5%; z-index: 1050;">
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                <strong>${sessionScope.alert.title}</strong> ${sessionScope.alert.message}
            </div>
            <c:remove var="alert" scope="session"/>
        </c:if>

        <%-- URL parameter-based Alert (for checkout success/error) --%>
        <div id="alertBox" class="alert alert-dismissible" style="display: none; position: fixed; bottom: 20px; left: 5%; right: 5%; z-index: 1050;">
            <button type="button" class="btn-close" onclick="document.getElementById('alertBox').style.display='none'"></button>
            <strong id="alertTitle"></strong> <span id="alertMessage"></span>
        </div>

        <!-- ==================== Login Modal ==================== -->
        <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">

                    <div class="modal-header">
                        <h4 class="modal-title" id="loginModalLabel">
                            <i class="bi bi-box-arrow-in-right me-2"></i>Login
                        </h4>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>

                    <!-- FORM LOGIN GIỮ NGUYÊN -->
                    <form action="<c:url value='/account/login.do' />" method="POST">

                        <div class="modal-body">

                            <!-- EMAIL -->
                            <div class="mb-3">
                                <label for="email" class="form-label">Email:</label>
                                <input type="email"
                                       class="form-control"
                                       id="loginEmail"
                                       name="email"
                                       placeholder="Enter email"
                                       value="${sessionScope.email}"
                                       required="">
                            </div>
                            <c:remove var="email" scope="session"/>

                            <!-- PASSWORD -->
                            <div class="mb-3">
                                <label for="password" class="form-label">Password:</label>
                                <input type="password"
                                       class="form-control"
                                       id="password"
                                       name="password"
                                       placeholder="Enter password"
                                       required="">
                            </div>

                            <!-- REMEMBER ME -->
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" name="remember" id="remember">
                                <label for="remember" class="form-check-label">Remember me</label>
                            </div>

                        </div>

                        <div class="modal-footer">
                            <button type="submit"
                                    class="btn btn-primary"
                                    name="op"
                                    value="login">
                                <i class="bi bi-box-arrow-in-right me-1"></i>Login
                            </button>
                            <button type="button"
                                    class="btn btn-secondary"
                                    data-bs-dismiss="modal">
                                <i class="bi bi-x-lg me-1"></i>Cancel
                            </button>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
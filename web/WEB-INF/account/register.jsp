<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
    /* Registration Page - Clean & Elegant */
    .signup-section {
        min-height: 65vh;
        padding: 2rem 0;
    }

    .signup-card {
        background: #ffffff;
        border: 1px solid #e8e3dc;
        padding: 2.5rem;
        max-width: 500px;
        margin: 0 auto;
    }

    .signup-header {
        margin-bottom: 2rem;
    }

    .signup-icon {
        font-size: 2.5rem;
        color: #8b7355;
        margin-bottom: 0.75rem;
    }

    .signup-title {
        font-size: 1.5rem;
        font-weight: 600;
        color: #2d2a26;
        margin-bottom: 0.25rem;
    }

    .signup-subtitle {
        color: #6b6560;
        font-size: 0.9rem;
    }

    .signup-form .form-label {
        font-weight: 500;
        color: #2d2a26;
        margin-bottom: 0.4rem;
        font-size: 0.9rem;
    }

    .signup-form .form-label i {
        color: #8b7355;
        margin-right: 0.3rem;
    }

    .signup-form .form-control {
        border: 1px solid #e8e3dc;
        padding: 0.7rem 0.9rem;
        font-size: 0.95rem;
        background: #faf8f5;
        transition: border-color 0.2s;
    }

    .signup-form .form-control:focus {
        border-color: #8b7355;
        background: #ffffff;
        box-shadow: 0 0 0 3px rgba(139, 115, 85, 0.1);
    }

    .signup-form .form-text {
        font-size: 0.8rem;
        color: #9d9690;
        margin-top: 0.25rem;
    }

    .btn-signup {
        padding: 0.75rem;
        font-size: 0.95rem;
        font-weight: 500;
        background: #2d2a26;
        border: none;
        color: #ffffff;
        transition: all 0.2s;
    }

    .btn-signup:hover {
        background: #3d3a36;
    }

    .signup-link {
        color: #8b7355;
        text-decoration: none;
        font-weight: 500;
    }

    .signup-link:hover {
        color: #2d2a26;
        text-decoration: underline;
    }

    @media (max-width: 576px) {
        .signup-card {
            padding: 2rem 1.5rem;
        }
    }
</style>

<%-- Sign Up Page --%>
<section class="signup-section">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="signup-card">
                <%-- Header --%>
                <div class="signup-header text-center mb-4">
                    <i class="bi bi-vinyl-fill signup-icon"></i>
                    <h2 class="signup-title">Create Account</h2>
                    <p class="signup-subtitle">Join our vinyl community</p>
                </div>

                <%-- Sign Up Form --%>
                <form action="<c:url value='/account/registerHandler.do' />" method="POST" class="signup-form">
                    
                    <%-- Username Field --%>
                    <div class="mb-3">
                        <label for="username" class="form-label">
                            <i class="bi bi-person me-1"></i>Username
                        </label>
                        <input type="text" 
                               class="form-control" 
                               id="username" 
                               name="username" 
                               placeholder="Enter your username"
                               required
                               minlength="3"
                               maxlength="50">
                        <div class="form-text">At least 3 characters</div>
                    </div>

                    <%-- Email Field --%>
                    <div class="mb-3">
                        <label for="email" class="form-label">
                            <i class="bi bi-envelope me-1"></i>Email Address
                        </label>
                        <input type="email" 
                               class="form-control" 
                               id="email" 
                               name="email" 
                               placeholder="Enter your email"
                               required>
                        <div class="form-text">We'll never share your email</div>
                    </div>

                    <%-- Password Field --%>
                    <div class="mb-3">
                        <label for="password" class="form-label">
                            <i class="bi bi-lock me-1"></i>Password
                        </label>
                        <input type="password" 
                               class="form-control" 
                               id="password" 
                               name="password" 
                               placeholder="Create a password"
                               required
                               minlength="6">
                        <div class="form-text">At least 6 characters</div>
                    </div>

                    <%-- Confirm Password Field --%>
                    <div class="mb-4">
                        <label for="confirmPassword" class="form-label">
                            <i class="bi bi-lock-fill me-1"></i>Confirm Password
                        </label>
                        <input type="password" 
                               class="form-control" 
                               id="confirmPassword" 
                               name="confirmPassword" 
                               placeholder="Re-enter your password"
                               required
                               minlength="6">
                    </div>

                    <%-- Submit Button --%>
                    <div class="d-grid mb-3">
                        <button type="submit" class="btn btn-primary btn-signup">
                            <i class="bi bi-person-plus me-2"></i>Create Account
                        </button>
                    </div>

                    <%-- Login Link --%>
                    <div class="text-center">
                        <p class="mb-0 text-muted">
                            Already have an account? 
                            <a href="<c:url value='/?login=1' />" class="signup-link">Login here</a>
                        </p>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

<script>
    // Password confirmation validation
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.querySelector('.signup-form');
        const password = document.getElementById('password');
        const confirmPassword = document.getElementById('confirmPassword');

        form.addEventListener('submit', function(e) {
            if (password.value !== confirmPassword.value) {
                e.preventDefault();
                confirmPassword.setCustomValidity('Passwords do not match');
                confirmPassword.reportValidity();
            } else {
                confirmPassword.setCustomValidity('');
            }
        });

        confirmPassword.addEventListener('input', function() {
            if (password.value === confirmPassword.value) {
                confirmPassword.setCustomValidity('');
            } else {
                confirmPassword.setCustomValidity('Passwords do not match');
            }
        });
    });
</script>


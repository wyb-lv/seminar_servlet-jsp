<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8"); %>

<style>
    .delete-container {
        max-width: 600px;
        margin: 3rem auto;
        background: #ffffff;
        border: 2px solid #dc3545;
        padding: 2.5rem;
        text-align: center;
    }
    
    .delete-icon {
        font-size: 4rem;
        color: #dc3545;
        margin-bottom: 1.5rem;
    }
    
    .delete-title {
        color: #2d2a26;
        font-weight: 600;
        font-size: 1.75rem;
        margin-bottom: 1rem;
    }
    
    .delete-message {
        color: #6b6560;
        font-size: 1.1rem;
        margin-bottom: 2rem;
    }
    
    .delete-warning {
        background: #fff3cd;
        border: 1px solid #ffc107;
        padding: 1rem;
        margin-bottom: 2rem;
        border-radius: 4px;
    }
    
    .delete-warning p {
        margin: 0;
        color: #856404;
        font-weight: 500;
    }
    
    .btn-group-custom {
        display: flex;
        gap: 1rem;
        justify-content: center;
    }
    
    .btn-group-custom button {
        min-width: 150px;
    }
</style>

<%-- Delete Confirmation --%>
<section class="delete-section py-3">
    <div class="delete-container">
        <i class="bi bi-exclamation-triangle delete-icon"></i>
        
        <h2 class="delete-title">Delete Album?</h2>
        
        <p class="delete-message">
            Are you sure you want to delete this album?
        </p>
        
        <div class="delete-warning">
            <p>
                <i class="bi bi-info-circle me-2"></i>
                This action cannot be undone!
            </p>
        </div>
        
        <c:if test="${not empty message}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle me-2"></i>${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <form action="<c:url value='/home/delete_handler.do' />" method="POST">
            <input type="hidden" name="id" value="${param.id}">
            
            <div class="btn-group-custom">
                <button type="submit" name="choice" value="yes" class="btn btn-danger">
                    <i class="bi bi-trash me-1"></i>Yes, Delete
                </button>
                <button type="submit" name="choice" value="cancel" class="btn btn-secondary">
                    <i class="bi bi-x-circle me-1"></i>Cancel
                </button>
            </div>
        </form>
    </div>
</section>


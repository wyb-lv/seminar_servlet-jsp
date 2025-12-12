<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% request.setCharacterEncoding("UTF-8"); %>

<style>
    .form-container {
        max-width: 800px;
        margin: 0 auto;
        background: #ffffff;
        border: 1px solid #e8e3dc;
        padding: 2.5rem;
    }
    
    .form-header {
        margin-bottom: 2rem;
        padding-bottom: 1rem;
        border-bottom: 2px solid #8b7355;
    }
    
    .form-header h2 {
        color: #2d2a26;
        font-weight: 600;
        margin: 0;
    }
    
    .form-label {
        font-weight: 500;
        color: #2d2a26;
        margin-bottom: 0.5rem;
    }
    
    .form-control {
        border: 1px solid #e8e3dc;
        padding: 0.7rem 0.9rem;
        background: #faf8f5;
    }
    
    .form-control:focus {
        border-color: #8b7355;
        background: #ffffff;
        box-shadow: 0 0 0 3px rgba(139, 115, 85, 0.1);
    }
    
    .btn-group-custom {
        display: flex;
        gap: 1rem;
        margin-top: 2rem;
    }
</style>

<%-- Edit Product Form --%>
<section class="edit-section py-3">
    <div class="form-container">
        <div class="form-header">
            <h2><i class="bi bi-pencil me-2"></i>Edit Album</h2>
        </div>
        
        <c:if test="${not empty message}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle me-2"></i>${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <form action="<c:url value='/home/edit_handler.do' />" method="POST">
            <input type="hidden" name="id" value="${product.id}">
            
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="id" class="form-label">Product ID</label>
                    <input type="number" class="form-control" id="id" value="${product.id}" disabled>
                </div>
                
                <div class="col-md-6 mb-3">
                    <label for="name" class="form-label">Album Name</label>
                    <input type="text" class="form-control" id="name" name="name" value="${product.name}" required>
                </div>
            </div>
            
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="artist" class="form-label">Artist</label>
                    <input type="text" class="form-control" id="artist" name="artist" value="${product.artist}" required>
                </div>
                
                <div class="col-md-6 mb-3">
                    <label for="category" class="form-label">Category</label>
                    <select class="form-control" id="category" name="category" required>
                        <option value="Rock" ${product.category == 'Rock' ? 'selected' : ''}>Rock</option>
                        <option value="Pop" ${product.category == 'Pop' ? 'selected' : ''}>Pop</option>
                        <option value="Jazz" ${product.category == 'Jazz' ? 'selected' : ''}>Jazz</option>
                        <option value="Classical" ${product.category == 'Classical' ? 'selected' : ''}>Classical</option>
                        <option value="Hip Hop" ${product.category == 'Hip Hop' ? 'selected' : ''}>Hip Hop</option>
                        <option value="Electronic" ${product.category == 'Electronic' ? 'selected' : ''}>Electronic</option>
                        <option value="R&B" ${product.category == 'R&B' ? 'selected' : ''}>R&B</option>
                        <option value="Country" ${product.category == 'Country' ? 'selected' : ''}>Country</option>
                    </select>
                </div>
            </div>
            
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="price" class="form-label">Price (₫)</label>
                    <input type="number" step="0.01" class="form-control" id="price" name="price" value="${product.price}" required>
                </div>
                
                <div class="col-md-6 mb-3">
                    <label for="stockStatus" class="form-label">Stock Status</label>
                    <select class="form-control" id="stockStatus" name="stockStatus" required>
                        <option value="Còn hàng" ${product.stockStatus == 'Còn hàng' ? 'selected' : ''}>Còn hàng</option>
                        <option value="Hết hàng" ${product.stockStatus == 'Hết hàng' ? 'selected' : ''}>Hết hàng</option>
                        <option value="Sắp về" ${product.stockStatus == 'Sắp về' ? 'selected' : ''}>Sắp về</option>
                    </select>
                </div>
            </div>
            
            <div class="mb-3">
                <label for="imageUrl" class="form-label">Image URL</label>
                <input type="text" class="form-control" id="imageUrl" name="imageUrl" value="${product.imageUrl}" required>
                <small class="text-muted">Enter the image filename (e.g., album1.jpg)</small>
            </div>
            
            <div class="mb-3">
                <label for="uploadDate" class="form-label">Update Date</label>
                <fmt:formatDate value="${product.uploadDate}" pattern="yyyy-MM-dd'T'HH:mm" var="formattedDate"/>
                <input type="datetime-local" class="form-control" id="uploadDate" name="uploadDate" value="${formattedDate}" required>
            </div>
            
            <div class="btn-group-custom">
                <button type="submit" name="choice" value="update" class="btn btn-warning flex-fill">
                    <i class="bi bi-check-circle me-1"></i>Update Album
                </button>
                <button type="submit" name="choice" value="cancel" class="btn btn-secondary flex-fill">
                    <i class="bi bi-x-circle me-1"></i>Cancel
                </button>
            </div>
        </form>
    </div>
</section>


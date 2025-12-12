<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% request.setCharacterEncoding("UTF-8"); %>

<style>
    .detail-container {
        max-width: 1000px;
        margin: 2rem auto;
    }

    .detail-card {
        background: #ffffff;
        border: 1px solid #e8e3dc;
        padding: 0;
        overflow: hidden;
    }

    .detail-image {
        width: 100%;
        height: 500px;
        object-fit: cover;
    }

    .detail-content {
        padding: 2.5rem;
    }

    .detail-header {
        margin-bottom: 2rem;
        padding-bottom: 1.5rem;
        border-bottom: 2px solid #8b7355;
    }

    .detail-title {
        font-size: 2rem;
        font-weight: 600;
        color: #2d2a26;
        margin-bottom: 0.5rem;
    }

    .detail-artist {
        font-size: 1.25rem;
        color: #8b7355;
        font-weight: 500;
    }

    .detail-info {
        margin-bottom: 2rem;
    }

    .info-row {
        display: flex;
        padding: 1rem 0;
        border-bottom: 1px solid #e8e3dc;
    }

    .info-label {
        font-weight: 600;
        color: #2d2a26;
        width: 150px;
        flex-shrink: 0;
    }

    .info-value {
        color: #6b6560;
        flex-grow: 1;
    }

    .detail-price {
        font-size: 2rem;
        font-weight: 700;
        color: #8b7355;
        margin-bottom: 1.5rem;
    }

    .stock-badge {
        display: inline-block;
        padding: 0.5rem 1rem;
        border-radius: 4px;
        font-weight: 500;
        font-size: 0.9rem;
    }

    .stock-available {
        background: #d4edda;
        color: #155724;
    }

    .stock-unavailable {
        background: #f8d7da;
        color: #721c24;
    }

    .stock-coming {
        background: #fff3cd;
        color: #856404;
    }

    .btn-group-detail {
        display: flex;
        gap: 1rem;
        margin-top: 2rem;
    }

    .btn-back {
        background: #6b6560;
        border: none;
        color: #ffffff;
    }

    .btn-back:hover {
        background: #5a5450;
        color: #ffffff;
    }
</style>

<%-- Product Detail Section --%>
<section class="detail-section py-3">
    <div class="detail-container">
        <c:if test="${not empty message}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle me-2"></i>${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${not empty product}">
            <div class="detail-card">
                <div class="row g-0">
                    <div class="col-md-6">
                        <c:choose>
                            <c:when test="${not empty product.imageUrl}">
                                <img src="<c:url value="/products/${product.imageUrl}" />"
                                     class="detail-image"
                                     alt="${product.name}">
                            </c:when>
                            <c:otherwise>
                                <img src="<c:url value="/products/default.jpg" />"
                                     class="detail-image"
                                     alt="${product.name}">
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="col-md-6">
                        <div class="detail-content">
                            <div class="detail-header">
                                <h1 class="detail-title">${product.name}</h1>
                                <p class="detail-artist">
                                    <i class="bi bi-person-fill me-2"></i>${product.artist}
                                </p>
                            </div>

                            <div class="detail-info">
                                <div class="info-row">
                                    <span class="info-label">Category:</span>
                                    <span class="info-value">
                                        <span class="badge bg-secondary">${product.category}</span>
                                    </span>
                                </div>

                                <div class="info-row">
                                    <span class="info-label">Product ID:</span>
                                    <span class="info-value">#${product.id}</span>
                                </div>

                                <div class="info-row">
                                    <span class="info-label">Upload Date:</span>
                                    <span class="info-value">
                                        <fmt:formatDate value="${product.uploadDate}" pattern="dd/MM/yyyy HH:mm"/>
                                    </span>
                                </div>

                                <div class="info-row">
                                    <span class="info-label">Stock Status:</span>
                                    <span class="info-value">
                                        <c:choose>
                                            <c:when test="${product.stockStatus == 'Còn hàng'}">
                                                <span class="stock-badge stock-available">
                                                    <i class="bi bi-check-circle me-1"></i>${product.stockStatus}
                                                </span>
                                            </c:when>
                                            <c:when test="${product.stockStatus == 'Hết hàng'}">
                                                <span class="stock-badge stock-unavailable">
                                                    <i class="bi bi-x-circle me-1"></i>${product.stockStatus}
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="stock-badge stock-coming">
                                                    <i class="bi bi-clock me-1"></i>${product.stockStatus}
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                            </div>

                            <div class="detail-price">
                                <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                            </div>

                            <div class="btn-group-detail">
                                <a href="<c:url value="/home/index.do" />" class="btn btn-back">
                                    <i class="bi bi-arrow-left me-1"></i>Back to Albums
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
</section>
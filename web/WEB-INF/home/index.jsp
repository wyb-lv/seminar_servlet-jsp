<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% request.setCharacterEncoding("UTF-8"); %>

<%-- Product Listing Section --%>
<section class="products-section py-3">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="mb-0">
            <i class="bi bi-vinyl me-2"></i>Our Albums
        </h2>
        <c:if test="${not empty sessionScope.account}">
            <a href="<c:url value="/home/create.do" />" class="btn btn-primary">
                <i class="bi bi-plus-circle me-1"></i>Add New Album
            </a>
        </c:if>
    </div>

    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
        <c:forEach var="product" items="${products}">
            <div class="col">
                <article class="card h-100 shadow-sm product-card hover-lift">
                    <%-- Product Image - Clickable --%>
                    <a href="<c:url value="/home/detail.do?id=${product.id}" />" class="text-decoration-none">
                        <div class="position-relative overflow-hidden product-image-wrapper">
                            <c:choose>
                                <c:when test="${not empty product.imageUrl}">
                                    <img src="<c:url value="/products/${product.imageUrl}" />"
                                         class="card-img-top product-image"
                                         alt="${product.name}"
                                         loading="lazy">
                                </c:when>
                                <c:otherwise>
                                    <img src="<c:url value="/products/${product.imageUrl}" />"
                                         class="card-img-top product-image"
                                         alt="${product.name}"
                                         loading="lazy">
                                </c:otherwise>
                            </c:choose>
                            <%-- Stock Status Badge --%>
                            <c:if test="${product.stockStatus != 'Còn hàng'}">
                                <span class="badge bg-warning text-dark position-absolute top-0 end-0 m-2 small">
                                    ${product.stockStatus}
                                </span>
                            </c:if>
                        </div>
                    </a>

                    <%-- Product Details --%>
                    <div class="card-body p-3 d-flex flex-column">
                        <a href="<c:url value="/home/detail.do?id=${product.id}" />" class="text-decoration-none">
                            <h6 class="card-title mb-1 text-dark" title="${product.name}">${product.name}</h6>
                        </a>
                        <p class="card-text text-muted small mb-2">
                            <c:if test="${not empty product.artist}">
                                <i class="bi bi-person-fill me-1"></i><span class="artist-name">${product.artist}</span>
                            </c:if>
                        </p>
                        <p class="card-text mb-2">
                            <span class="badge bg-secondary small">${product.category}</span>
                        </p>

                        <%-- Pricing --%>
                        <div class="pricing mb-2 mt-auto">
                            <span class="price-text fw-bold text-primary">
                                <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                            </span>
                        </div>

                        <%-- Action Buttons - Only show for logged-in users --%>
                        <c:choose>
                            <c:when test="${not empty sessionScope.account}">
                                <div class="d-flex gap-2">
                                    <a href="<c:url value="/home/edit.do?id=${product.id}" />"
                                       class="btn btn-sm btn-warning flex-fill">
                                        <i class="bi bi-pencil me-1"></i>Edit
                                    </a>
                                    <a href="<c:url value="/home/delete.do?id=${product.id}" />"
                                       class="btn btn-sm btn-danger flex-fill">
                                        <i class="bi bi-trash me-1"></i>Delete
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <a href="<c:url value="/home/detail.do?id=${product.id}" />"
                                   class="btn btn-sm btn-primary w-100">
                                    <i class="bi bi-eye me-1"></i>View Details
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </article>
            </div>
        </c:forEach>
    </div>
</section>


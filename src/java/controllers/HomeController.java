package controllers;

import db.Product;
import db.ProductFacade;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "HomeController", urlPatterns = {"/home"})
public class HomeController extends HttpServlet {

    /**
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String controller = (String) request.getAttribute("controller");
        String action = (String) request.getAttribute("action");
        switch (action) {
            case "index":
                //watch product
                index(request, response);
                break;
            case "detail":
                detail(request, response);
                break;
            case "create":
                //watch product
                create(request, response);
                break;
            case "create_handler": //Xử lý form create
                createHandler(request, response);
                break;
            case "edit":
                edit(request, response);
                break;
            case "edit_handler": //Xử lý form edit
                editHandler(request, response);
                break;
            case "delete":
                delete(request, response);
                break;
            case "delete_handler":
                deleteHandler(request, response);//Xử lý form delete
                break;
            default:
                index(request, response);
                break;
        }
    }

    protected void index(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ProductFacade productFacade = new ProductFacade();
            List<Product> products = productFacade.readAll();
            request.setAttribute("products", products); //truyền dữ liệu products cho view
        } catch (SQLException ex) {
            request.setAttribute("message", ex.getMessage()); //lưu exception vào request truyền cho view
            ex.printStackTrace();
        }
        //chuyển request và response cho view registerHandler.jsp
        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
    }

    protected void detail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            ProductFacade productFacade = new ProductFacade();
            Product product = productFacade.getProduct(id);
            if (product != null) {
                request.setAttribute("product", product);
            } else {
                request.setAttribute("message", "Product not found");
            }
        } catch (Exception ex) {
            request.setAttribute("message", "Can't view product details: " + ex.getMessage());
            ex.printStackTrace();
        }
        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
    }

    protected void create(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is logged in
        if (request.getSession().getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/account/login.do");
            return;
        }
        try {
            ProductFacade productFacade = new ProductFacade();
            List<Product> products = productFacade.readAll();
            request.setAttribute("products", products); //truyền dữ liệu products cho view
        } catch (SQLException ex) {
            request.setAttribute("message", ex.getMessage()); //lưu exception vào request truyền cho view
            ex.printStackTrace();
        }
        //chuyển request và response cho view registerHandler.jsp
        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
    }

    protected void createHandler(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Check if user is logged in
        if (request.getSession().getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/account/login.do");
            return;
        }
        String choice = request.getParameter("choice");
        switch (choice) {
            case "create":
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    String name = request.getParameter("name");
                    String category = request.getParameter("category");
                    String artist = request.getParameter("artist");
                    double price = Double.parseDouble(request.getParameter("price"));
                    String stockStatus = request.getParameter("stockStatus");
                    String imageUrl = request.getParameter("imageUrl");

                    // Parse timestamp using SimpleDateFormat
                    String uploadDateStr = request.getParameter("uploadDate");
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                    Date parsedDate = sdf.parse(uploadDateStr);
                    Timestamp uploadDate = new Timestamp(parsedDate.getTime());

                    ProductFacade productFacade = new ProductFacade();
                    //Tạo object product
                    Product product = new Product(id, name, category, artist, price, stockStatus, imageUrl, uploadDate);
                    productFacade.create(product);
                    //Chuyển về trang index.jsp
                    response.sendRedirect(request.getContextPath() + "/home/index.do");
                } catch (Exception ex) {
                    request.setAttribute("message","Can't insert new product: " + ex.getMessage()); //lưu exception vào request truyền cho view
                    ex.printStackTrace();
                    // Set action to "create" so the layout includes the correct JSP
                    request.setAttribute("action", "create");
                    create(request, response);
                }
                break;
            default: //cancel
                //Chuyển về trang index.jsp
                response.sendRedirect(request.getContextPath() + "/home/index.do");
        }
    }

    protected void delete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is logged in
        if (request.getSession().getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/account/login.do");
            return;
        }
        //chuyển request và response cho view delete.jsp
        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
    }

    protected void deleteHandler(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Check if user is logged in
        if (request.getSession().getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/account/login.do");
            return;
        }
        String choice = request.getParameter("choice");
        switch (choice) {
            case "yes":
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    ProductFacade productFacade = new ProductFacade();
                    productFacade.delete(id);
                    //Chuyển về trang index.jsp
                    response.sendRedirect(request.getContextPath() + "/home/index.do");
                } catch (Exception ex) {
                    request.setAttribute("message","Can't delete product: " + ex.getMessage()); //lưu exception vào request truyền cho view
                    ex.printStackTrace();
                    request.setAttribute("action", "delete");
                    delete(request, response);
                }
                break;
            default: //cancel
                //Chuyển về trang index.jsp
                response.sendRedirect(request.getContextPath() + "/home/index.do");
        }
    }

    protected void edit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is logged in
        if (request.getSession().getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/account/login.do");
            return;
        }
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            ProductFacade productFacade = new ProductFacade();
            Product product = productFacade.getProduct(id);
            request.setAttribute("product", product); //truyền dữ liệu toys cho view
        } catch (SQLException ex) {
            request.setAttribute("message", "Can not load data from database"); //lưu exception vào request truyền cho view
            ex.printStackTrace();
        }
        //chuyển request và response cho view create.jsp
        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
    }

    protected void editHandler(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Check if user is logged in
        if (request.getSession().getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/account/login.do");
            return;
        }
        String choice = request.getParameter("choice");
        switch (choice) {
            case "update":
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    String name = request.getParameter("name");
                    String category = request.getParameter("category");
                    String artist = request.getParameter("artist");
                    double price = Double.parseDouble(request.getParameter("price"));
                    String stockStatus = request.getParameter("stockStatus");
                    String imageUrl = request.getParameter("imageUrl");

                    // Parse timestamp using SimpleDateFormat
                    String uploadDateStr = request.getParameter("uploadDate");
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                    Date parsedDate = sdf.parse(uploadDateStr);
                    Timestamp uploadDate = new Timestamp(parsedDate.getTime());

                    ProductFacade productFacade = new ProductFacade();
                    //Tạo object product
                    Product product = new  Product(id, name, category, artist, price, stockStatus, imageUrl, uploadDate);
                    productFacade.update(product);
                    //Chuyển về trang index.jsp
                    response.sendRedirect(request.getContextPath() + "/home/index.do");
                } catch (Exception ex) {
                    request.setAttribute("message","Can't update product: " + ex.getMessage()); //lưu exception vào request truyền cho view
                    //Hiện lỗi cho dev
                    ex.printStackTrace();
                    //Hiện lại form edit
                    request.setAttribute("action", "edit");
                    edit(request, response);
                }
                break;
            default: //cancel
                //Chuyển về trang index.jsp
                response.sendRedirect(request.getContextPath() + "/home/index.do");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

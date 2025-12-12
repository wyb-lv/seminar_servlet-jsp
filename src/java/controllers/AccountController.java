package controllers;

import db.Account;
import db.AccountFacade;
import db.Product;
import db.ProductFacade;
import utils.Alert;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "AccountController", urlPatterns = {"/account"})
public class AccountController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String controller = (String) request.getAttribute("controller");
        String action = (String) request.getAttribute("action");
        switch (action) {
            case "login":
                //login method
                login(request, response);
                break;
            case "logout":
                //logout method
                logout(request, response);
                break;
            case "register":
                //registerHandler method
                register(request, response);
                break;
            case "registerHandler":
                //registerHandler method
                registerHandler(request, response);
                break;
        }
    }

    protected void login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Alert alert = null;
        String queryString = "?alert=1";
        try {
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            AccountFacade ac = new AccountFacade();
            Account account = ac.login(email, password);
            if (account == null) {
                //login thất bại
                session.setAttribute("email", email);
                alert = new Alert("danger", "Login Error", "Please check your email and password.");
                queryString += "&login=1";
            } else {
                //login thành công
                session.setAttribute("account", account);
                alert = new Alert("success", "Login successfully", "Welcome to our site.");
            }
        } catch (Exception ex) {
            //Lưu thông báo lỗi vào request để truyền thông báo lỗi cho view toy.jsp
            //request.setAttribute("message", ex.getMessage());
            alert = new Alert("danger", "Login Error", ex.getMessage());
            //In chi tiết lỗi
            ex.printStackTrace();
        }
        session.setAttribute("alert", alert);
        //chuyển request & response về home page
        response.sendRedirect(request.getContextPath() + queryString);
    }

    protected void logout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.invalidate();
        response.sendRedirect(request.getContextPath() + "/");
    }

    protected void register(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //chuyển request và response cho view registerHandler.jsp
        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
    }

    protected void registerHandler(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Alert alert = null;
        String queryString = "?alert=1";
        try {
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String username = request.getParameter("username");
            AccountFacade ac = new AccountFacade();
            ac.register(username, email, password);
            alert = new Alert("success", "Register successfully", "Welcome to our site.");
        } catch (Exception ex) {
            //Lưu thông báo lỗi vào request để truyền thông báo lỗi cho view toy.jsp
            alert = new Alert("danger", "Register Error", ex.getMessage());
            //In chi tiết lỗi
            ex.printStackTrace();
        }
        session.setAttribute("alert", alert);
        //chuyển request & response về home page
        response.sendRedirect(request.getContextPath() + queryString);
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

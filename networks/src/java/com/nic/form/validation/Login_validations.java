package com.nic.form.validation;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.xsshtmlfilter.HTMLFilter;

/**
 * @author Administrator
 */
public class Login_validations {

    public boolean validations(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String username = null;
        String password = null;
        String code = null;
        try {
            username = new HTMLFilter().filter(request.getParameter("username"));
            password = new HTMLFilter().filter(request.getParameter("password"));
            code = new HTMLFilter().filter(request.getParameter("code"));
        } catch (Exception _EX) {
            System.out.println(_EX);
            username = "";
            password = "";
            code = "";
            return false;
        }
        if (username == null || username.equals("")) {
            return false;
        }
        if (password == null || password.equals("")) {
            return false;
        }
        if (code == null || code.equals("")) {
            return false;
        }
        return true;

    }

}

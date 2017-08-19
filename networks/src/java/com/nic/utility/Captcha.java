package com.nic.utility;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Captcha extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int width = 193;
        int height = 40;
        char captchaV[] = new char[7];
        char captchaCode[] = 
        {   'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
            'J', 'K', 'M', 'N', 'P', 'Q', 'R', 'S', 
            'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '1', 
            '2', '3', '4', '5', '6', '7', '8', '9',
        };
        int x = 25;
        int y = 0;
        Random ran = new Random();
        for (int i = 0; i < 7; i++) {
            final int ij = ran.nextInt(100) % 32;
            captchaV[i] = captchaCode[ij];
        }
        BufferedImage bufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D g2d = bufferedImage.createGraphics();

        Font font = new Font("Georgia", Font.BOLD, 18);
        g2d.setFont(font);

        RenderingHints rh = new RenderingHints(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        rh.put(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
        g2d.setRenderingHints(rh);
        GradientPaint gp = new GradientPaint(0, 0,
                Color.LIGHT_GRAY, 0, height / 2, Color.BLUE, true);
        g2d.setPaint(gp);
        g2d.fillRect(0, 0, width, height);
        g2d.setColor(new Color(255, 153, 0));
        String captcha = String.copyValueOf(captchaV);
        request.getSession().setAttribute("captcha", captcha);
        for (int i = 0; i < 7; i++) {
            x += 13;
            y = 25;
            g2d.drawChars(captchaV, i, 1, x, y);
        }
        g2d.dispose();
        response.setContentType("image/png");
        OutputStream os = response.getOutputStream();
        ImageIO.write(bufferedImage, "png", os);
        os.close();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
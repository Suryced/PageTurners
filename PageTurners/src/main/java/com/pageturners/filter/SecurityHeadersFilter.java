package com.pageturners.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Security Headers Filter for Production
 * Adds essential security headers to all HTTP responses
 */
@WebFilter("/*")
public class SecurityHeadersFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // Content Security Policy - Optimized for JHU APL environment
        httpResponse.setHeader("Content-Security-Policy", 
            "default-src 'self' https://dev13.apl.jhu.edu; " +
            "script-src 'self' 'unsafe-inline' https://dev13.apl.jhu.edu; " +
            "style-src 'self' 'unsafe-inline' https://dev13.apl.jhu.edu; " +
            "img-src 'self' data: https: https://dev13.apl.jhu.edu; " +
            "font-src 'self' https://dev13.apl.jhu.edu; " +
            "connect-src 'self' https://dev13.apl.jhu.edu; " +
            "frame-ancestors 'none'");
        
        // X-Content-Type-Options - Prevents MIME sniffing
        httpResponse.setHeader("X-Content-Type-Options", "nosniff");
        
        // X-Frame-Options - Prevents clickjacking (backup for CSP)
        httpResponse.setHeader("X-Frame-Options", "DENY");
        
        // X-XSS-Protection - Legacy XSS protection
        httpResponse.setHeader("X-XSS-Protection", "1; mode=block");
        
        // Referrer Policy - Controls referrer information
        httpResponse.setHeader("Referrer-Policy", "strict-origin-when-cross-origin");
        
        // Permissions Policy - Controls browser features
        httpResponse.setHeader("Permissions-Policy", 
            "camera=(), microphone=(), geolocation=(), payment=()");
        
        // Strict-Transport-Security - Force HTTPS (JHU APL handles SSL)
        if (httpRequest.isSecure() || "https".equals(httpRequest.getHeader("X-Forwarded-Proto"))) {
            httpResponse.setHeader("Strict-Transport-Security", 
                "max-age=31536000; includeSubDomains; preload");
        }
        
        // Cache Control for sensitive pages
        String requestURI = httpRequest.getRequestURI();
        if (requestURI.contains("/login") || requestURI.contains("/checkout") || 
            requestURI.contains("/profile") || requestURI.contains("/order")) {
            httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            httpResponse.setHeader("Pragma", "no-cache");
            httpResponse.setHeader("Expires", "0");
        }
        
        // Add deployment environment header for debugging
        httpResponse.setHeader("X-Deployment-Environment", "JHU-APL-Production");
        
        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Filter initialization if needed
    }

    @Override
    public void destroy() {
        // Filter cleanup if needed
    }
}
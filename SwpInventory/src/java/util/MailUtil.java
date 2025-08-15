package util;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class MailUtil {
    public static void sendMail(String to, String subject, String messageText) throws Exception {
        final String from = "dongxubg2k4@gmail.com";
        final String password = "tlik itwm eesk hbqv"; // App Password

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(from, "Hệ thống Quản lý Kho", "UTF-8"));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject(MimeUtility.encodeText(subject, "UTF-8", "B"));

        // Sửa ở đây để xử lý tiếng Việt:
        message.setContent(messageText, "text/plain; charset=UTF-8");

        Transport.send(message);
    }
}

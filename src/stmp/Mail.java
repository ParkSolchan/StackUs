package stmp;

import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Mail {

    public int sendMail(String mail) {
        int re = -1;
    	
        Properties p = System.getProperties();
        p.put("mail.smtp.starttls.enable", "true");     // gmail�� true ����
        p.put("mail.smtp.host", "smtp.naver.com");      // smtp ���� �ּ�
        p.put("mail.smtp.auth","true");                 // gmail�� true ����
        p.put("mail.smtp.port", "587");                 // ���̹� ��Ʈ
        p.put("mail.smtp.port", "587");                 // ���̹� ��Ʈ
           
        Authenticator auth = new MyAuthentication();
        //session ���� ��  MimeMessage����
        Session session = Session.getDefaultInstance(p, auth);
        MimeMessage msg = new MimeMessage(session);
         
        try{
            //���������ð�
            msg.setSentDate(new Date());
            InternetAddress from = new InternetAddress() ;
            from = new InternetAddress("leekm96@naver.com"); //�߽��� ���̵�
            // �̸��� �߽���
            msg.setFrom(from);
            // �̸��� ������
            InternetAddress to = new InternetAddress(mail);
            msg.setRecipient(Message.RecipientType.TO, to);
            // �̸��� ����
            msg.setSubject("���� ���� �ȳ� ����.", "UTF-8");
            // �̸��� ����
            msg.setText("�����Ͻ� ������� 1�� ���ҽ��ϴ�.", "UTF-8");
            // �̸��� ���
            msg.setHeader("content-Type", "text/html");
            //���Ϻ�����
            javax.mail.Transport.send(msg, msg.getAllRecipients());
            System.out.println("���� ����");
            re = 1;
            
        }catch (AddressException addr_e) {
            addr_e.printStackTrace();
        }catch (MessagingException msg_e) {
            msg_e.printStackTrace();
        }catch (Exception msg_e) {
            msg_e.printStackTrace();
        }
        return re;
    }


	public int sendPw(String mail, String pw) {
		int re = -1;
		
		Properties p = System.getProperties();
		p.put("mail.smtp.starttls.enable", "true");     // gmail�� true ����
		p.put("mail.smtp.host", "smtp.naver.com");      // smtp ���� �ּ�
		p.put("mail.smtp.auth","true");                 // gmail�� true ����
		p.put("mail.smtp.port", "587");                 // ���̹� ��Ʈ
		p.put("mail.smtp.port", "587");                 // ���̹� ��Ʈ
		
		Authenticator auth = new MyAuthentication();
		//session ���� ��  MimeMessage����
		Session session = Session.getDefaultInstance(p, auth);
		MimeMessage msg = new MimeMessage(session);
		
		try{
			//���������ð�
			msg.setSentDate(new Date());
			InternetAddress from = new InternetAddress() ;
			from = new InternetAddress("leekm96@naver.com"); //�߽��� ���̵�
			// �̸��� �߽���
			msg.setFrom(from);
			// �̸��� ������
			InternetAddress to = new InternetAddress(mail);
			msg.setRecipient(Message.RecipientType.TO, to);
			// �̸��� ����
			msg.setSubject("��й�ȣ�Դϴ�", "UTF-8");
			// �̸��� ����
			msg.setText("ȸ������ ��й�ȣ�� "+pw+" �Դϴ�.", "UTF-8");
			// �̸��� ���
			msg.setHeader("content-Type", "text/html");
			//���Ϻ�����
			javax.mail.Transport.send(msg, msg.getAllRecipients());
			System.out.println("���� ����");
			re = 1;
			
		}catch (AddressException addr_e) {
			addr_e.printStackTrace();
		}catch (MessagingException msg_e) {
			msg_e.printStackTrace();
		}catch (Exception msg_e) {
			msg_e.printStackTrace();
		}
		return re;
	}
	}
 
class MyAuthentication extends Authenticator {
      
    PasswordAuthentication pa;
    public MyAuthentication(){
         
        String id = "leekm96@naver.com";  //���̹� �̸��� ���̵�
        String pw = "fpdls7246A^";        //���̹� ��й�ȣ
 
        // ID�� ��й�ȣ�� �Է��Ѵ�.
        pa = new PasswordAuthentication(id, pw);
        System.out.println("�Է¿Ϸ�");
    }
 
    // �ý��ۿ��� ����ϴ� ��������
    public PasswordAuthentication getPasswordAuthentication() {
        return pa;
    }
} 
  

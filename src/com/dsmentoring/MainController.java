package com.dsmentoring;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.SocketTimeoutException;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.apache.tomcat.util.codec.binary.Base64;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import org.json.simple.parser.JSONParser;

@Controller
public class MainController {
	
	private Properties props = null;
	private String base_path = this.getClass().getResource("/").getPath();
	private String prop_file = base_path + "conf/api.properties";
	
	@RequestMapping(value={"/insertuser.do", "/insertdevice.do"},produces="application/x-www-form-urlencoded; charset=utf8")
	public @ResponseBody String userInsert(HttpServletRequest request) throws Exception{
		props = new Properties();
		
		
		BufferedReader br = null;
		JSONObject jsonObj = new JSONObject();
		
		HttpURLConnection conn = null;
		String data = null;
		
		props.load(new FileInputStream(prop_file));
		String apiURL = props.getProperty("API.url");
		
		try {
			
			String strUrl = null;
			// insert user
			if(request.getServletPath().equals("/insertuser.do")) {
				String user_id = request.getParameter("user_id");
				String user_name = request.getParameter("user_name");
				String user_email = request.getParameter("user_email");
				String user_mobile = request.getParameter("user_mobile");
				String user_code = request.getParameter("user_code");
				
				JSONObject json = new JSONObject();
				data = "userId="+user_id+"&userName="+user_name+"&userEmail="+user_email+"&userMobile="+user_mobile+"&userCode="+user_code;
				strUrl = apiURL + "/user";
			// insert device
			} else {
				String user_id = request.getParameter("user_id");
				String device_id = request.getParameter("device_id");
				String device_name = request.getParameter("device_name");
				String device_code = request.getParameter("device_code");
				String device_mac = request.getParameter("device_mac");
				
				JSONObject json = new JSONObject();
				data = "userId="+user_id+"&deviceId="+device_id+"&deviceName="+device_name+"&deviceCode="+device_code+"&deviceMac="+device_mac;
				strUrl = apiURL + "/device";
			}
			
			URL url = new URL(strUrl);
			conn = (HttpURLConnection) url.openConnection();
			
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", createBasicAuth(request.getHeader("Authorization")));
			conn.setRequestProperty("Content-Type", request.getHeader("Content-Type"));
			conn.setDoOutput(true);
			
			OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
			wr.write(data);
			wr.flush();
			wr.close();
			
			int HttpResult = conn.getResponseCode();
			if(HttpResult == HttpURLConnection.HTTP_OK) {
				br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
				String line = null;
				StringBuffer sb = new StringBuffer();
				while ((line = br.readLine()) != null) {
					sb.append(line);
				}
				JSONParser parser = new JSONParser();
				JSONObject object = (JSONObject) parser.parse(sb.toString());
				
				return object.toString();
			}

		} catch (SocketTimeoutException ste) {
			ste.printStackTrace();
		} catch (UnsupportedEncodingException uee) {
			uee.printStackTrace();
		} catch (IOException ioe) {
			ioe.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (br != null) br.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			try {
				if (conn != null) conn.disconnect();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		JSONObject object = new JSONObject();
		object.put("message", "요청에 실패하였습니다.");
		object.put("rtnCode", "ERR");
		return object.toJSONString();
	}
	
	@RequestMapping(value={"/deleteuser.do", "/deletedevice.do"},produces="application/x-www-form-urlencoded; charset=utf8")
	public @ResponseBody String delete(HttpServletRequest request) throws Exception{
		props = new Properties();
		
		
		BufferedReader br = null;
		
		HttpURLConnection conn = null;
		String data = null;
		
		props.load(new FileInputStream(prop_file));
		String apiURL = props.getProperty("API.url");
		
		try {
			
			String strUrl = null;
			// delete user
			if(request.getServletPath().equals("/deleteuser.do")) {
				String user_id = request.getParameter("user_id");
				
				
				JSONObject json = new JSONObject();
				data = "userId="+user_id;
				strUrl = apiURL + "/user/"+user_id;
			// delete device
			} else {
				String device_id = request.getParameter("device_id");
				
				JSONObject json = new JSONObject();
				data = "deviceId="+device_id;
				strUrl = apiURL + "/device/"+device_id;
			}
			
			URL url = new URL(strUrl);
			conn = (HttpURLConnection) url.openConnection();
			
			conn.setRequestMethod("DELETE");
			conn.setRequestProperty("Authorization", createBasicAuth(request.getHeader("Authorization")));
			conn.setRequestProperty("Content-Type", request.getHeader("Content-Type"));
			conn.setDoOutput(true);
			
			OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
			wr.write(data);
			wr.flush();
			wr.close();
			
			int HttpResult = conn.getResponseCode();
			if(HttpResult == HttpURLConnection.HTTP_OK) {
				br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
				String line = null;
				StringBuffer sb = new StringBuffer();
				while ((line = br.readLine()) != null) {
					sb.append(line);
				}
				JSONParser parser = new JSONParser();
				JSONObject object = (JSONObject) parser.parse(sb.toString());
				
				return object.toString();
			}

		} catch (SocketTimeoutException ste) {
			ste.printStackTrace();
		} catch (UnsupportedEncodingException uee) {
			uee.printStackTrace();
		} catch (IOException ioe) {
			ioe.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (br != null) br.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			try {
				if (conn != null) conn.disconnect();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		JSONObject object = new JSONObject();
		object.put("message", "요청에 실패하였습니다.");
		object.put("rtnCode", "ERR");
		return object.toJSONString();
	}
	
	@RequestMapping(value="/updateuser.do",produces="application/x-www-form-urlencoded; charset=utf8")
	public @ResponseBody String updateUser(HttpServletRequest request) throws Exception{
		props = new Properties();
		
		
		BufferedReader br = null;
		JSONObject jsonObj = new JSONObject();
		
		HttpURLConnection conn = null;
		String data = null;
		
		props.load(new FileInputStream(prop_file));
		String apiURL = props.getProperty("API.url");
		
		try {
			
			String strUrl = null;
			
			String user_id = request.getParameter("user_id");
			String user_name = request.getParameter("user_name");
			String user_email = request.getParameter("user_email");
			String user_mobile = request.getParameter("user_mobile");
			String user_code = request.getParameter("user_code");
			
			JSONObject json = new JSONObject();
			data = "userId="+user_id+"&userName="+user_name+"&userEmail="+user_email+"&userMobile="+user_mobile+"&userCode="+user_code;
			strUrl = apiURL + "/user/"+user_id;
			
			
			URL url = new URL(strUrl);
			conn = (HttpURLConnection) url.openConnection();
			
			conn.setRequestMethod("PUT");
			conn.setRequestProperty("Authorization", createBasicAuth(request.getHeader("Authorization")));
			conn.setRequestProperty("Content-Type", request.getHeader("Content-Type"));
			conn.setDoOutput(true);
			
			OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
			wr.write(data);
			wr.flush();
			wr.close();
			
			int HttpResult = conn.getResponseCode();
			if(HttpResult == HttpURLConnection.HTTP_OK) {
				br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
				String line = null;
				StringBuffer sb = new StringBuffer();
				while ((line = br.readLine()) != null) {
					sb.append(line);
				}
				JSONParser parser = new JSONParser();
				JSONObject object = (JSONObject) parser.parse(sb.toString());
				
				return object.toString();
			}

		} catch (SocketTimeoutException ste) {
			ste.printStackTrace();
		} catch (UnsupportedEncodingException uee) {
			uee.printStackTrace();
		} catch (IOException ioe) {
			ioe.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (br != null) br.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			try {
				if (conn != null) conn.disconnect();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		JSONObject object = new JSONObject();
		object.put("message", "요청에 실패하였습니다.");
		object.put("rtnCode", "ERR");
		return object.toJSONString();
	}
	
	@RequestMapping(value="/auth.do", produces="application/x-www-form-urlencoded; charset=utf8")
	public @ResponseBody String auth(HttpServletRequest request) throws Exception{
		props = new Properties();
		
		
		BufferedReader br = null;
		
		HttpURLConnection conn = null;
		String data = null;
		
		props.load(new FileInputStream(prop_file));
		String apiURL = props.getProperty("API.url");
		
		try {
			
			String strUrl = null;
			
			String user_id = request.getParameter("user_id");
			String device_id = request.getParameter("device_id");
			/* String system_code = request.getParameter("system_code"); */
			String action_code = request.getParameter("action_code");
			String connection_type = request.getParameter("connection_type");
			
			
			JSONObject json = new JSONObject();
			//data = "userId="+user_id+"&deviceId="+device_id+"&systemCode="+system_code+"&actionCode="+action_code+"&connectionType="+connection_type;
			data = "userId="+user_id+"&deviceId="+device_id+"&actionCode="+action_code+"&connectionType="+connection_type;
			strUrl = apiURL + "/authenticate";
			
			
			URL url = new URL(strUrl);
			conn = (HttpURLConnection) url.openConnection();
			
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", createBasicAuth(request.getHeader("Authorization")));
			conn.setRequestProperty("Content-Type", request.getHeader("Content-Type"));
			conn.setDoOutput(true);
			
			OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
			wr.write(data);
			wr.flush();
			wr.close();
			
			int HttpResult = conn.getResponseCode();
			if(HttpResult == HttpURLConnection.HTTP_OK) {
				br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
				String line = null;
				StringBuffer sb = new StringBuffer();
				while ((line = br.readLine()) != null) {
					sb.append(line);
				}
				JSONParser parser = new JSONParser();
				JSONObject object = (JSONObject) parser.parse(sb.toString());
				
				return object.toString();
			}

		} catch (SocketTimeoutException ste) {
			ste.printStackTrace();
		} catch (UnsupportedEncodingException uee) {
			uee.printStackTrace();
		} catch (IOException ioe) {
			ioe.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (br != null) br.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			try {
				if (conn != null) conn.disconnect();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		JSONObject object = new JSONObject();
		object.put("message", "요청에 실패하였습니다.");
		object.put("rtnCode", "ERR");
		return object.toJSONString();
	}
	
	private String createBasicAuth(String auth) {
		String result = "";
		
		byte[] encodedAuth = Base64.encodeBase64(auth.getBytes(Charset.forName("UTF-8")));
		result = "Basic "+new String(encodedAuth);
		return result;
	}

}

package com.test.pdf1;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.StringReader;
import java.nio.charset.Charset;
import java.text.DecimalFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.itextpdf.text.Document;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfImportedPage;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.XMLWorker;
import com.itextpdf.tool.xml.XMLWorkerFontProvider;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import com.itextpdf.tool.xml.css.StyleAttrCSSResolver;
import com.itextpdf.tool.xml.html.CssAppliersImpl;
import com.itextpdf.tool.xml.html.Tags;
import com.itextpdf.tool.xml.parser.XMLParser;
import com.itextpdf.tool.xml.pipeline.css.CssResolverPipeline;
import com.itextpdf.tool.xml.pipeline.end.PdfWriterPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipelineContext;



public class PDF_Test extends HttpServlet{

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(req, resp);
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8"); 
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		if (request.getRequestURI().endsWith("test.p")){			
			
			String data = getBody(request); //받은 json > String
			JsonParser parser = new JsonParser(); 
			JsonElement xjson = parser.parse(data); //String > json		
			JsonObject reg = xjson.getAsJsonObject(); //json > jsonObject

			//숫자에 콤마 찍기
			DecimalFormat formatter = new DecimalFormat("###,###");
			
			// html 코드
			String date = reg.get("date").getAsString();
			String customer = reg.get("customer").getAsString();
			int term = Integer.parseInt(reg.get("term").getAsString());
			int amount = Integer.parseInt(reg.get("amount").getAsString());
			int price1 = Integer.parseInt(reg.get("price").getAsString());
			int price2 = price1*amount*term;
			int tax = price2/10;
			int sum = (price2+tax);
			
			String html = "<html>" +
					"<head></head>" +
					"<body>" +
					"<div class=\"date\">"+date+"</div>" +
					"<div class=\"customer\">"+customer+" 귀하</div>" +
					"<div class=\"sm sum\" style=\"font-weight:bold;\">\\ "+formatter.format(sum)+"</div>"+
					"<div class=\"sm term\">"+term+"</div>"+ //기간
					"<div class=\"sm amount\">"+amount+"</div>"+ //수량
					"<div class=\"sm price1\">"+formatter.format(price1)+"</div>"+ //단가
					"<div class=\"sm price2\">"+formatter.format(price2)+"</div>"+ //공급가
					"<div class=\"sm tax\">"+formatter.format(tax)+"</div>"+ //세액
					"<div class=\"sm price22\">"+formatter.format(price2)+"</div>"+
					"<div class=\"sm taxx\">"+formatter.format(tax)+"</div>"+
					"</body>" +
					"</html>";

			// pdf 이름
			String s = "갤러리360_거래명세서";
			try (FileOutputStream os = new FileOutputStream("d:\\Work\\"+s+".pdf")) {
				// Pdf형식의 document를 생성한다.
				Document document = new Document(PageSize.A4, 70, 50, 120, 50); //좌 우 상 하
				// PdfWriter를 취득한다.
				PdfWriter writer = PdfWriter.getInstance(document, os);
				// document Open한다.
				document.open();
				
				
				
				// 원본 pdf 파일(클래스패스에서 가져옴)
				PdfContentByte canvas = writer.getDirectContent();
				/*  class에서 class위치 찾기  */
		        PdfReader reader = new PdfReader(PDF_Test.class.getResourceAsStream("/com/test/pdf1/transaction_statement.pdf"));
				
		        PdfImportedPage page = writer.getImportedPage(reader,1);
		        document.newPage();
		        canvas.addTemplate(page, 0, 0);
		        
		        
		        //table

		        
		        
				// css를 설정할 resolver 인스턴스 생성
				StyleAttrCSSResolver cssResolver = new StyleAttrCSSResolver();
				/*  class에서 css,js위치 찾기  */
				String css = request.getSession().getServletContext().getRealPath("/resource/css/css1.css");
				
				try (FileInputStream cssStream = new FileInputStream(css)) {
					cssResolver.addCss(XMLWorkerHelper.getCSS(cssStream));
				}

				
				// 폰트 설정
				XMLWorkerFontProvider font = new XMLWorkerFontProvider(XMLWorkerFontProvider.DONTLOOKFORFONTS);
				// window 폰트 설정
				font.register("c:/windows/fonts/malgun.ttf", "MalgunGothic");
				// 폰트 인스턴스를 생성한다.
				CssAppliersImpl cssAppliers = new CssAppliersImpl(font);
				//htmlContext의 pipeline 생성. (폰트 인스턴스 생성)
				HtmlPipelineContext htmlContext = new HtmlPipelineContext(cssAppliers);
				htmlContext.setTagFactory(Tags.getHtmlTagProcessorFactory());
				// pdf의 pipeline 생성.
				PdfWriterPipeline pdfPipeline = new PdfWriterPipeline(document, writer);
				// Html의pipeline을 생성 (html 태그, pdf의 pipeline설정)
				HtmlPipeline htmlPipeline = new HtmlPipeline(htmlContext, pdfPipeline);
				// css의pipeline을 합친다.
				CssResolverPipeline cssResolverPipeline = new CssResolverPipeline(cssResolver, htmlPipeline);
				//Work 생성 pipeline 연결
				XMLWorker worker = new XMLWorker(cssResolverPipeline, true);
				//Xml 파서 생성(Html를 pdf로 변환)
				XMLParser xmlParser = new XMLParser(true, worker, Charset.forName("UTF-8"));
				
				
				// 출력한다.
				try (StringReader strReader = new StringReader(html)) {
					xmlParser.parse(strReader);
				}
				// document의 리소스 반환
				document.close();
				
			} catch (Throwable e) {
				e.printStackTrace();
			}
			
			//json 타입
			out.println(reg);
		}
		
	}
	
	
	
	public static String getBody(HttpServletRequest request) throws IOException {
		 
        String body = null;
        StringBuilder stringBuilder = new StringBuilder();
        BufferedReader bufferedReader = null;
 
        try {
            InputStream inputStream = request.getInputStream();
            if (inputStream != null) {
                bufferedReader = new BufferedReader(new InputStreamReader(inputStream, "UTF-8"));
                char[] charBuffer = new char[128];
                int bytesRead = -1;
                while ((bytesRead = bufferedReader.read(charBuffer)) > 0) {     	
                	
                	
                    stringBuilder.append(charBuffer, 0, bytesRead);
                  
                }
            }
        } catch (IOException ex) {
            throw ex;
        } finally {
            if (bufferedReader != null) {
                try {
                    bufferedReader.close();
                } catch (IOException ex) {
                    throw ex;
                }
            }
        }
 
        body = stringBuilder.toString();
       /* body =  cleanXSS(body);    */
        return body;
    }
	
	
/*	private static String cleanXSS(String value) {      

		  //You'll need to remove the spaces from the html entities below    
		  
		  value = value.replaceAll("<", "&lt;").replaceAll(">", "&gt;");         
		  
		  value = value.replaceAll("\\(", "&#40;").replaceAll("\\)", "&#41;");         
		  
		  value = value.replaceAll("'", "&#39;");        
		  
		  value = value.replaceAll("eval\\((.*)\\)", "");         
		  
		  value = value.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");         
		  
		  value = value.replaceAll("script", "");         
		  
		  return value;     
		  
	} 
	*/
}

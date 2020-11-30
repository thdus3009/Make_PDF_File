package com.test.pdf1;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.StringReader;
import java.nio.charset.Charset;

import com.itextpdf.text.Document;
import com.itextpdf.text.PageSize;
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

public class Test {

	public static void main(String[] args){
		System.out.println("////////////////////////////");
		
		//public static void main(String[] args)가 아니라 버튼을 누르면 db정보를 호출하는 방식의 클래스형식으로 ....
		//파일이 다른이름으로 저장하고 싶은데 바로 다운받아짐.
		
		
		// PDF를 작성하는 html
		String html = "<html>" +
		"<head></head>" +
		"<body>" +
		"<div>Test</div>" +
		"<div>김소연입니다.</div>" +
		"</body>" +
		"</html>";
		
		
		// 파일 IO 스트림을 취득한다.
		
		String s = "asd";
		try (FileOutputStream os = new FileOutputStream("d:\\Work\\"+s+".pdf")) {
		// Pdf형식의 document를 생성한다.
		Document document = new Document(PageSize.A4, 10, 10, 10, 10);
		// PdfWriter를 취득한다.
		PdfWriter writer = PdfWriter.getInstance(document, os);
		// document Open한다.
		document.open();
		// css를 설정할 resolver 인스턴스 생성
		StyleAttrCSSResolver cssResolver = new StyleAttrCSSResolver();
		// Css 파일 설정 (css1.css 파일 설정)
		try (FileInputStream cssStream = new FileInputStream("d:\\Work\\css1.css")) {
		cssResolver.addCss(XMLWorkerHelper.getCSS(cssStream));
		}
		// Css 파일 설정 (css2.css 파일 설정)
		try (FileInputStream cssStream = new FileInputStream("d:\\Work\\css2.css")) {
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

	}
}

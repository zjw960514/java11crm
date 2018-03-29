package com.situ.crm.test;

import java.io.FileOutputStream;
import java.io.IOException;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.junit.Test;


public class tes {
	@Test
	public void  nishi() throws IOException {
		HSSFWorkbook workbook = new HSSFWorkbook();
		HSSFSheet hssfSheet = workbook.createSheet("你是谁？"); 
		HSSFRow createRow = hssfSheet.createRow(3);
		HSSFCell createCell = createRow.createCell(2);
		createCell.setCellValue("dada");
		FileOutputStream fileOutputStream = new FileOutputStream("G:\\新建.xls");
		workbook.write(fileOutputStream);
		workbook.close();
		fileOutputStream.close();
	}
	@Test
	public void name() {
		String[] yi=new String[]{"T","h","p","r","n","w","l","v","e","s","t","i","l","y","o","u"," "};
		int[] er=new int[]{0,1,8,16,2,8,3,9,14,4,16,5,1,14,16 ,12,14,7,8,9,16, 11,9,16, 9,10,11,6,6,16,13,14,15};
		String xsdh="";
		for(int a : er){
		xsdh=xsdh+yi[a];
		}
		System. out.println(xsdh+"!");
	}
	
}

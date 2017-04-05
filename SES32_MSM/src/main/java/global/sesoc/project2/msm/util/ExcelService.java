package global.sesoc.project2.msm.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.xssf.extractor.XSSFExcelExtractor;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import jxl.Workbook;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;

public class ExcelService {
	static Logger log = LoggerFactory.getLogger(ExcelService.class);

	/**
	 * 엑셀 내용 읽기
	 * @param filePath 업로드된 파일의 경로
	 * @return
	 */
	public static List<List<String>> getExcelList(String filePath)  {
		log.debug("getExcelList :: filepath = {}", filePath);
		// xls / xlsx 에따라 처리방법이 다르므로 분기처리
		if (filePath.substring(filePath.lastIndexOf(".")).equals(".xls")) {
			return readExcelXLS(filePath);
		} else {
			return readExcelXLSX(filePath);
		}
	}

	/**
	 * xls파일에 대한 처리
	 * @param filePath
	 * @return
	 */
	private static List<List<String>> readExcelXLS(String filePath)  {
		FileInputStream fis = null;
		POIFSFileSystem fs = null;

		HSSFWorkbook workbook = null;
		HSSFSheet sheet = null;
		HSSFRow row = null;
		HSSFCell cell = null;
		List<List<String>> rowList = new ArrayList<List<String>>();
		List<String> colList = new ArrayList<String>();
		// int sheets = 0;
		try {
			// Excel 파일 읽어 오기
			fis = new FileInputStream(filePath);
			fs = new POIFSFileSystem(fis);
			workbook = new HSSFWorkbook(fs);

			sheet = workbook.getSheetAt(0);

			if (sheet != null) {
				int nRowStartIndex = 1; // 기록물철의 경우 실제 데이터가 시작되는 Row지정
				int nRowEndIndex = sheet.getLastRowNum(); // 기록물철의 경우 실제 데이터가 끝 Row지정
				int nColumnStartIndex = 0; // 기록물철의 경우 실제 데이터가 시작되는 Column지정
				int nColumnEndIndex = sheet.getRow(0).getLastCellNum(); // 기록물철의경우 실제데이터가 끝나는 Column지정

				String strValue = "";

				for (int i = nRowStartIndex; i <= nRowEndIndex; i++) {
					row = sheet.getRow(i);
					for (int nColumn = nColumnStartIndex; nColumn <= nColumnEndIndex; nColumn++) {
						cell = row.getCell((int) nColumn);
						if (cell == null) {
							continue;
						}
						switch (cell.getCellType()) {
						case Cell.CELL_TYPE_STRING:
							strValue = cell.getRichStringCellValue().getString();
							strValue = strValue != null ? strValue : "";
							break;

						case Cell.CELL_TYPE_NUMERIC:
							strValue = String.valueOf(Long.toString((long) cell.getNumericCellValue()));
							break;
						case Cell.CELL_TYPE_BOOLEAN:
							strValue = String.valueOf(cell.getBooleanCellValue());
							break;

						case Cell.CELL_TYPE_FORMULA:
							strValue = String.valueOf(cell.getCellFormula());
							break;

						default:
							strValue = cell.getRichStringCellValue().getString();
						}
						colList.add(nColumn, strValue);

					}
					rowList.add(colList);
					colList = new ArrayList<String>();
				}
			}

		} catch (FileNotFoundException e) {
			log.error("1: {}", e.getMessage());
		} catch (IOException e) {
			log.error("2: {}", e.getMessage());
		} finally {
			try {

				fis.close();
			} catch (IOException e) {
				log.error("3: {}", e.getMessage());
			}
		}
		return rowList;
	}

	/**
	 * xlsx 파일에 대한 처리
	 * @param filePath
	 * @return
	 */
	private static List<List<String>> readExcelXLSX(String filePath) {
		File file = new File(filePath);
		FileInputStream fis = null;
		XSSFWorkbook workbook = null;
		XSSFExcelExtractor extractor = null;
		// int sheets = 0;

		List<List<String>> rowList = new ArrayList<List<String>>();
		List<String> colList = new ArrayList<String>();
		try {

			// Excel 파일 읽어 오기
			fis = new FileInputStream(file);
			workbook = new XSSFWorkbook(filePath);

			extractor = new XSSFExcelExtractor(workbook);

			extractor.setFormulasNotResults(true);
			extractor.setIncludeSheetNames(false);
			String strValue = "";
			XSSFCell cell = null;
			XSSFRow row = null;
			XSSFSheet sheet = null;
			sheet = workbook.getSheetAt(0);

			int nRowStartIndex = 1; // 기록물철의 경우 실제 데이터가 시작되는 Row지정
			int nRowEndIndex = sheet.getLastRowNum(); // 기록물철의 경우 실제 데이터가 끝 Row지정
			int nColumnStartIndex = 0; // 기록물철의 경우 실제 데이터가 시작되는 Column지정
			int nColumnEndIndex = sheet.getRow(0).getLastCellNum(); // 기록물철의경우 실제데이터가 끝나는 Column지정

			for (int i = nRowStartIndex; i <= nRowEndIndex; i++) {

				row = sheet.getRow(i);
				for (int nColumn = nColumnStartIndex; nColumn < nColumnEndIndex; nColumn++) {
					cell = row.getCell((int) nColumn);
					switch (cell.getCellType()) {
					case Cell.CELL_TYPE_STRING:
						strValue = cell.getRichStringCellValue().getString();
						strValue = strValue != "" ? strValue : "";
						break;

					case Cell.CELL_TYPE_NUMERIC:
						strValue = String.valueOf(Long.toString((long) cell.getNumericCellValue()));
						break;
					case Cell.CELL_TYPE_BOOLEAN:
						strValue = String.valueOf(cell.getBooleanCellValue());
						break;

					case Cell.CELL_TYPE_FORMULA:
						strValue = String.valueOf(cell.getCellFormula());
						break;

					default:
						strValue = cell.getRichStringCellValue().getString();
					}

					colList.add(nColumn, strValue);
				}
				rowList.add(colList);
				colList = new ArrayList<String>();
			}
		} catch (FileNotFoundException e) {
			log.error("4: {}", e.getMessage());
		} catch (IOException e) {
			log.error("5: {}", e.getMessage());
		} catch (Exception e) {
			log.error("6: {}", e.getMessage());
		} finally {
			try {
				fis.close();
			} catch (IOException e) {
				log.error("7: {}", e.getMessage());
			}
		}
		return rowList;
	}
	
	/**
	 * 엑셀파일 write
	 * @param file 저장될 파일의 경로
	 * @param dto_list 저장될 vo 내용
	 * @param members vo에 정의된 변수명의 배열 (엑셀에 표기될 column을 모두 정의)
	 * @param cell_headers 엑셀에 표기될 members각각에 대한 헤더의 배열
	 * @param cell_widths 헤더에 대한 너비
	 * @throws Exception
	 */
	public final static void simpleExcelWrite(
			File file
			, List<DataVO> dto_list
			, String[] members
			, String[] cell_headers
			, int[] cell_widths) throws Exception {
		WritableWorkbook workbook = null;
		WritableSheet sheet = null;
		
		log.debug("simpleExcelWrite");
		log.debug("=============================");
		log.debug("vo 내용 : {}", dto_list);
		log.debug("표기 vo배열 : {}", members.toString());
		log.debug("헤더 : {}", cell_headers.toString());
		log.debug("헤더 너비 : {}", cell_widths);

		try {

			workbook = Workbook.createWorkbook(file); // 지정된 파일명 경로로 워크북 즉 엑셀파일을 만듭니다.
			workbook.createSheet("Sheet", 0); // 지정한 워크북에 싯트를 만듭니다. "Sheet" 가 싯트명이 됩니다.
			sheet = workbook.getSheet(0); // 시트를 가져옵니다.

			WritableCellFormat cellFormat = new WritableCellFormat(); // 셀의 스타일을 지정하기 위한 부분입니다.
			cellFormat.setBorder(Border.ALL, BorderLineStyle.THIN); // 셀의 스타일을 지정합니다. 테두리에 라인그리는거에요

			// 빙글빙글 돌리면서 엑셀에 데이터를 작성합니다.
//			for (int row = 0; row < data.length; row++) {
//				for (int col = 0; col < data[0].length; col++) {
//					Label label = new jxl.write.Label(col, row, (String) data[row][col], cellFormat);
//					sheet.addCell(label);
//				}
//			}
			
			int i = 0;

			// 헤더 생성부
			for (String header : cell_headers) {
				sheet.setColumnView(i, cell_widths[i]);
				Label label = new Label(i++, 0, header);
				sheet.addCell(label);
			}
			
			// 헤더 하위 데이터 생성부
			int j = 0;

			ArrayList<HashMap<String, Object>> contents = new ArrayList<>();
			for (DataVO dto : dto_list) {
				getMemberFields(contents, dto, true);
			}
			
			for (HashMap<String, Object> content : contents) {
				i = 0;
				j++;
				for (String member : members) {
					Label label = new Label(i++, j,
							content.get(member) != null ? content
									.get(member).toString() : "");
					sheet.addCell(label);
				}
			}

			workbook.write();

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			try {
				if (workbook != null)
					workbook.close();
			} catch (WriteException e) {
				// e.printStackTrace();
			} catch (IOException e) {
				// e.printStackTrace();
			}
		}
		log.debug("=============================");
		//[출처] 자바<JAVA> JXL 이용하여 엑셀에 쓰기 초간단 예제|작성자 달빛
	}
	
	/**
	 * vo값 가져오기
	 * @param contents 엑셀에 들어갈 내용
	 * @param vo vo객체
	 * @param isMemberLowerCase 비교대상 키값이 소문자인지 설정여부
	 * @throws Exception
	 */
	public static void getMemberFields(ArrayList<HashMap<String, Object>> contents, DataVO vo, boolean isMemberLowerCase) throws Exception {
		HashMap<String, Object> map = new HashMap<>();
		
		log.debug("getMemberFields");
		if (vo != null) {
			Class c = vo.getClass();
			Method[] methods = c.getMethods();

			log.debug("----------------------------------------------");
			for (int i = 0; i < methods.length; i++) {
				String methodName = methods[i].getName();

				if ((methodName.equals("getClass"))
						|| (!methodName.subSequence(0, 3).equals("get")))
					continue;
				String fieldName = methodName.substring(3);
				Object fieldValue = methods[i].invoke(vo, new Object[0]);
				
				log.debug(String.format("fieldName: %s / fieldValue: %s", fieldName, fieldValue));

				if (isMemberLowerCase) {
					fieldName = fieldName.toLowerCase();
				}

				map.put(fieldName, fieldValue);
			}
			contents.add(map);
			log.debug("----------------------------------------------");

		}
	}
}

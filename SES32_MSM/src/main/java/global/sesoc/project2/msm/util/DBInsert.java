package global.sesoc.project2.msm.util;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DBInsert {
	private String path;

	public DBInsert(String path) {
		this.path = path;

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
		}

		try (BufferedReader br = new BufferedReader(new FileReader(path));
				Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@127.0.0.1:1521:XE", "hr",
						"hr");) {

			String s = null;
			while ((s = br.readLine()) != null) {
				
				String sql = "insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval,?, ?, ?, ?, ?, ?, ?,?)";
				String[] output = s.split(",");
				try (PreparedStatement pstmt = connection.prepareCall(sql);) {
					pstmt.setString(1, output[0]);
					pstmt.setString(2, output[1]);
					pstmt.setString(3, output[2]);
					pstmt.setString(4, output[3]);
					pstmt.setString(5, output[4]);
					pstmt.setString(6, output[5]);
					pstmt.setInt(7, Integer.parseInt(output[6]));
					pstmt.setString(8, output[7]);
					pstmt.executeUpdate();
					pstmt.close();
				}
				
			}
			
		} catch (FileNotFoundException e) {
		} catch (IOException e) {
		} catch (SQLException e) {
		}

	}

	public static void main(String[] args) {
		new DBInsert("c:/상품리스트1.csv");
	}
}


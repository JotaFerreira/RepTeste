package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class DAO {

	public Connection getMyConnection() { // retorna a conexão com o banco

		try {

			String url = "jdbc:mysql://localhost:3306/bd_locadora_trabalho";
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, "usuariocomum",
					"");
			return con;

		} catch (Exception ex) {

			ex.printStackTrace();
			return null;

		}

	}

	public List getConsulta(String query) { // retorna uma list com os valores obtidos na query

		try {
			ResultSet res = null;
			Connection cn = this.getMyConnection();
			Statement stmt = cn.createStatement();
			res = stmt.executeQuery(query);
			List var = resultSetToArrayList(res);
			cn.close();
			return var;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}

	}

	public int executarQuery(String query) throws SQLException { // retorna a quantidade de linhas afetadas na execução da query

		try {

			Connection cn = this.getMyConnection();
			Statement stmt = cn.createStatement();
			int var = stmt.executeUpdate(query);

			stmt.close();
			cn.close();
			return var;

		}

		catch (Exception e) {

			e.printStackTrace();
			return 0;

		}
	}

	
	public List resultSetToArrayList(ResultSet rs) throws SQLException{ // converte um resultset em list para ser manipulado em todo o sistema
		  ResultSetMetaData md = rs.getMetaData();
		  int columns = md.getColumnCount();
		
		  ArrayList list = new ArrayList(50);
		  while (rs.next()){
		     HashMap row = new HashMap(columns);
		     for(int i=1; i<=columns; ++i){           
		      row.put(md.getColumnLabel(i),rs.getObject(i));
		     }
		      list.add(row);
		  }

		 return list;
		}
	

}

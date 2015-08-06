package model;

import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class Operador {

	model.DAO DAO = new model.DAO();

	public int cadastraCategoria(String categoria, String cor, String preco)
			throws SQLException { // cadastra uma categoria no banco

		int var = DAO
				.executarQuery("insert into categoria(nome,cor,preco) values('"
						+ categoria + "','" + cor + "','" + preco + "')");

		return var;

	}

	public int cadastraGenero(String nome) throws SQLException { // cadastra um genero no banco

		int var = DAO.executarQuery("insert into genero(nome) values('" + nome
				+ "')");

		return var;

	}

	public int cadastraFilme(String nome, String nacionalidade,
			int numero_copias, int categoria) throws SQLException { // cadastra um filme no banco

		int var = DAO
				.executarQuery("insert into filme(nome,nacionalidade,copias,categoria) values('"
						+ nome
						+ "','"
						+ nacionalidade
						+ "',"
						+ numero_copias
						+ "," + categoria + ")");

		return var;

	}

	public List pesquisaFilme(String nome, String categoria, String genero) { // pesquisa filme no banco com criterios de pesquisa

		String f_nome = nome != "" ? " and nome= '" + nome + "'" : "";
		String f_categoria = categoria != "" ? " and categoria= '" + categoria
				+ "'" : "";
		String f_genero = genero != "" ? " and genero= '" + genero + "'" : "";
		model.DAO DAO = new model.DAO();

		return DAO
				.getConsulta(String
						.format("select nome,nacionalidade,copias,categoria,genero from tb_filme where 1=1 {0} {1} {2}",
								f_nome, f_categoria, f_genero));

	}

	public void atualizaFilme(Object listaFilmes, Object filme,
			Object nacionalidade, Object copias, Object categoria, Object[] generos)
			throws SQLException { // altera propriedades do filme de acordo com os criterios solicitados

		model.DAO DAO = new model.DAO();
		model.Genero Genero = new model.Genero();
		model.Categoria Categoria = new model.Categoria();
		 
		String[] filmes = listaFilmes.toString().trim().split(",");
			
		// faz um loop nos filmes que foram solicitada alterações e verifica quais campos demandam atualização
		
		for (int i = 0; i <= filmes.length - 1; i++) {

			if (filme != null) {

				DAO.executarQuery("update filme set nome='" + filme
						+ "' where id=" + filmes[i].trim());
			}
			
			if (nacionalidade != null) {

				DAO.executarQuery("update filme set nacionalidade='" + nacionalidade
						+ "' where id=" + filmes[i].trim());
			}
			
			if (copias != null) {

				DAO.executarQuery("update filme set copias='" + copias
						+ "' where id=" + filmes[i].trim());
			}
			
			if (categoria != null) {

				Categoria.setNome(categoria.toString());
				DAO.executarQuery("update filme set categoria='" + Categoria.getId()
						+ "' where id=" + filmes[i].trim());
			}
			
			if(generos != null)
			{
				
				DAO.executarQuery("delete from filme_genero where filme = " + filmes[i].trim() + ";");
				
				for(int x =0;x<= generos.length-1;x++){ // loop no generos do filme porque eles podem ser mais de um
					
					Genero.setNome(generos[x].toString());
					int idGenero = Genero.getId();
					DAO.executarQuery("insert into filme_genero(filme,genero) values(" + filmes[i].trim() + "," + idGenero + ")");
					
				}
				
			}
			
		}

	}
	
}

package br.sigecon.daos;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;

import br.sigecon.beans.Pessoa;

public class PessoaDAO {
	private EntityManagerFactory emf;
	
	public PessoaDAO() {
		emf = PersistenceManager.getIstance().getEntityManagerFactory();
	}
	
	public Pessoa buscarPessoaPeloId(int id) {
		EntityManager entityManager = emf.createEntityManager();
		Pessoa pessoa = null;
			try {				
				Query query = entityManager.createQuery("select p from Pessoa p where p.codPessoa = :id");
				query.setParameter("id", id);
				
				pessoa = (Pessoa) query.getSingleResult();
			} finally {
				entityManager.close();
			}
		return pessoa;
	}
}

package br.sigecon.daos;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;

import br.sigecon.beans.Banco;

public class BancoDAO {
	private EntityManagerFactory emf;
	
	public BancoDAO() {
		emf = PersistenceManager.getIstance().getEntityManagerFactory();
	}
	
	public List<Banco> listAll() {
		EntityManager entityManager = emf.createEntityManager();
		try {
			return entityManager.createQuery("from Banco", Banco.class).getResultList();
		} finally {
			entityManager.close();
		}
	}
	
	public Banco buscarBancoPeloId(int id) {
		EntityManager entityManager = emf.createEntityManager();
		Banco banco = null;
			try {				
				Query query = entityManager.createQuery("select b from Banco b where b.codBanco = :id");
				query.setParameter("id", id);
				
				banco = (Banco) query.getSingleResult();
			} finally {
				entityManager.close();
			}
		return banco;
	}
}

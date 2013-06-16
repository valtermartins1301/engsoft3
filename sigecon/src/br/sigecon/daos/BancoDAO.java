package br.sigecon.daos;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

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
}

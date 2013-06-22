package br.sigecon.daos;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;

import br.sigecon.beans.TipoLancamento;

public class TipoLancamentoDAO {
private EntityManagerFactory emf;

	public TipoLancamentoDAO() {
		emf = PersistenceManager.getIstance().getEntityManagerFactory();
	}
	
	public TipoLancamento buscarTipoLancamentoPeloId(int id) {
		EntityManager entityManager = emf.createEntityManager();
		TipoLancamento tipoLancamento = null;
			try {				
				Query query = entityManager.createQuery("select tl from TipoLancamento tl where tl.codLancamento = :id");
				query.setParameter("id", id);
				
				tipoLancamento = (TipoLancamento) query.getSingleResult();
			} finally {
				entityManager.close();
			}
		return tipoLancamento;
	}
}
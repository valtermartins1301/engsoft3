package br.sigecon.daos;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;

import br.sigecon.beans.Conta;
import br.sigecon.beans.Transferencia;

public class TransferenciaDAO {
	private EntityManagerFactory emf;
	
	public TransferenciaDAO(){
		emf = PersistenceManager.getIstance().getEntityManagerFactory();
	}
	
	public List<Transferencia> listAll() {
		EntityManager entityManager = emf.createEntityManager();
		try {
			return entityManager.createQuery("from Transferencia", Transferencia.class).getResultList();
		} finally {
			entityManager.close();
		}
	}
	
	public void merge(Transferencia transferencia){
		EntityManager entityManager = emf.createEntityManager();
		try {
			EntityTransaction transaction = entityManager.getTransaction();
			try {
				transaction.begin();
				
				entityManager.find(Transferencia.class, transferencia.getCodLancamento());
				transferencia.setContaCorrente(transferencia.getContaCorrente());
				transferencia.setContaDestino(transferencia.getContaDestino());
				transferencia.setDataLancamento(transferencia.getDataLancamento());
				transferencia.setMotivoLancamento(transferencia.getMotivoLancamento());
				transferencia.setTipoLancamento(transferencia.getTipoLancamento());
				transferencia.setValorLancamento(transferencia.getValorLancamento());
				
				entityManager.merge(transferencia);
				transaction.commit();
			} finally {
				if (transaction.isActive()) {
					transaction.rollback();
				}
			}
		} finally {			
			entityManager.close();
		}
	}
	
	public void persist(Transferencia transferencia) {
		EntityManager entityManager = emf.createEntityManager();
		try {
			EntityTransaction transaction = entityManager.getTransaction();
			try {
				transaction.begin();
				entityManager.persist(transferencia);
				transaction.commit();
			} finally {
				if (transaction.isActive()) {
					transaction.rollback();
				}
			}	
		} finally {
			entityManager.close();
		}
	}
	
	public void remove(int id) {
		EntityManager entityManager = emf.createEntityManager();
		try {
			EntityTransaction transaction = entityManager.getTransaction();
			try {
				transaction.begin();
				Transferencia transferencia = entityManager.find(Transferencia.class, id);
//				transferencia.setCodLancamento(transferencia.getCodLancamento());
//				transferencia.setContaCorrente(transferencia.getContaCorrente());
//				transferencia.setContaDestino(transferencia.getContaDestino());
//				transferencia.setDataLancamento(transferencia.getDataLancamento());
//				transferencia.setMotivoLancamento(transferencia.getMotivoLancamento());
//				transferencia.setTipoLancamento(transferencia.getTipoLancamento());
//				transferencia.setValorLancamento(transferencia.getValorLancamento());
				
				entityManager.remove(transferencia);
				transaction.commit();
			} finally {
				if (transaction.isActive()) {
					transaction.rollback();
				}
			}
		} finally {
			entityManager.close();
		}
	}
	
	public Transferencia buscarTransferenciaPeloId(int id) {
		EntityManager entityManager = emf.createEntityManager();
		Transferencia transferencia = null;
		try {
			EntityTransaction transaction = entityManager.getTransaction();
			try {
				transaction.begin();
				
				transferencia = entityManager.find(Transferencia.class, id);
				transferencia.setCodLancamento(transferencia.getCodLancamento());
				transferencia.setContaCorrente(transferencia.getContaCorrente());
				transferencia.setContaDestino(transferencia.getContaDestino());
				transferencia.setDataLancamento(transferencia.getDataLancamento());
				transferencia.setMotivoLancamento(transferencia.getMotivoLancamento());
				transferencia.setTipoLancamento(transferencia.getTipoLancamento());
				transferencia.setValorLancamento(transferencia.getValorLancamento());
				
				transaction.commit();
			} finally {
				if (transaction.isActive()) {
					transaction.rollback();
				}
			}
		} finally {
			entityManager.close();
		}		
		return transferencia;
	}
}
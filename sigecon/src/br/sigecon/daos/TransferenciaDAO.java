package br.sigecon.daos;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;

import br.sigecon.beans.Transferencia;

public class TransferenciaDAO {
	private EntityManager entityManager;
	private EntityManagerFactory factory;
	
	public TransferenciaDAO(){
		factory = Persistence.createEntityManagerFactory("persist");
		entityManager = factory.createEntityManager();
	}
	
	public void merge(Transferencia transferencia){
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
			factory.close();			
		}
	}
	
	public void persist(Transferencia transferencia) {
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
			factory.close();			
		}
	}
	
	public void remove(int id) {
		try {
			EntityTransaction transaction = entityManager.getTransaction();
			try {
				transaction.begin();
				Transferencia transferencia = entityManager.find(Transferencia.class, id);
				transferencia.setCodLancamento(transferencia.getCodLancamento());
				transferencia.setContaCorrente(transferencia.getContaCorrente());
				transferencia.setContaDestino(transferencia.getContaDestino());
				transferencia.setDataLancamento(transferencia.getDataLancamento());
				transferencia.setMotivoLancamento(transferencia.getMotivoLancamento());
				transferencia.setTipoLancamento(transferencia.getTipoLancamento());
				transferencia.setValorLancamento(transferencia.getValorLancamento());
				
				entityManager.remove(transferencia);
				transaction.commit();
			} finally {
				if (transaction.isActive()) {
					transaction.rollback();
				}
			}
		} finally {
			entityManager.close();
			factory.close();	
		}
	}
	
	public Transferencia buscarContaPeloId(int id) {
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
			factory.close();	
		}		
		return transferencia;
	}

}

package br.sigecon.daos;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Query;

import org.postgresql.util.PSQLException;

import br.sigecon.beans.Conta;
import br.sigecon.beans.ContaCorrente;

public class ContasDAO {
	private EntityManagerFactory emf;
	
	public ContasDAO() {
		emf = PersistenceManager.getIstance().getEntityManagerFactory();
	}
	
	public List<Conta> listAll() {
		EntityManager entityManager = emf.createEntityManager();
		try {
			return entityManager.createQuery("from Conta c order by c.codConta", Conta.class).getResultList();
		} finally {
			entityManager.close();
		}
	}
	
	public void merge(Conta conta) {
		EntityManager entityManager = emf.createEntityManager();
		try {
			EntityTransaction transaction = entityManager.getTransaction();
			try {
				transaction.begin();
				
				ContaCorrente contaCorrente = entityManager.find(ContaCorrente.class, conta.getCodConta());		
				contaCorrente.setBanco(conta.getBanco());
				contaCorrente.setPessoa(conta.getPessoa());
				contaCorrente.setNumeroConta(conta.getNumeroConta());
				contaCorrente.setNumeroAgencia(conta.getNumeroAgencia());
				
				transaction.commit();
			}finally {
				if (transaction.isActive()) {
					transaction.rollback();
				}
			}
		} finally {			
			entityManager.close();
		}
	}
	
	public void persist(Conta conta) {
		EntityManager entityManager = emf.createEntityManager();
		try {
			EntityTransaction transaction = entityManager.getTransaction();
			try {
				transaction.begin();
				
				ContaCorrente contaCorrente = new ContaCorrente();		
				contaCorrente.setBanco(conta.getBanco());
				contaCorrente.setPessoa(conta.getPessoa());
				contaCorrente.setNumeroConta(conta.getNumeroConta());
				contaCorrente.setNumeroAgencia(conta.getNumeroAgencia());

				entityManager.persist(contaCorrente);
				
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
	
	/**
	 * Método resposável por fazer a exclusão de uma conta no banco.
	 * 
	 * @param id
	 * @throws PSQLException Caso exista o id da conta associado a um lançamento/transferência
	 */
	public void remove(int id) throws PSQLException {
		EntityManager entityManager = emf.createEntityManager();
		try {
			EntityTransaction transaction = entityManager.getTransaction();
			try {
				Conta conta = entityManager.find(Conta.class, id);
				
				if (conta != null) {
					transaction.begin();
					
					entityManager.remove(conta);					

					transaction.commit();
				}
			} finally {
				if (transaction.isActive()) {
					transaction.rollback();
				}
			}
		} finally {
			entityManager.close();
		}
	}
	
	public ContaCorrente buscarContaPeloId(int id) {
		EntityManager entityManager = emf.createEntityManager();
		ContaCorrente contaCorrente = null;
			try {				
				Query query = entityManager.createQuery("select c from ContaCorrente c where c.codConta = :id");
				query.setParameter("id", id);
				
				contaCorrente = (ContaCorrente) query.getSingleResult();
			} finally {
				entityManager.close();
			}
		return contaCorrente;
	}
}
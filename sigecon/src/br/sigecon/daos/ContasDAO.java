package br.sigecon.daos;

import java.util.ArrayList;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;

import br.sigecon.beans.Conta;
import br.sigecon.beans.ContaCorrente;
import br.sigecon.beans.Lancamento;

public class ContasDAO {
	private EntityManager entityManager;
	private EntityManagerFactory factory;
	
	public ContasDAO() {
		factory = Persistence.createEntityManagerFactory("persist");
		entityManager = factory.createEntityManager();
	}
	
	public ArrayList<Lancamento> consultarLancamento(Conta conta) {
		return null;	
	}
	
	public Conta[] consultarSaldo(Conta conta) {
		return null;
	}
	
	public ArrayList<Lancamento> faturaCartaoCredito(Conta conta) {
		return null;
	}
	
	public void merge(Conta conta) {
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
	
	public void persist(Conta conta) {
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
			factory.close();			
		}
	}
	
	public void remove(Conta conta) {
		try {
			EntityTransaction transaction = entityManager.getTransaction();
			try {
				transaction.begin();
				entityManager.remove(conta);
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
	
	public ContaCorrente buscarContaPeloId(int id) {
		ContaCorrente contaCorrente = null;
		try {
			EntityTransaction transaction = entityManager.getTransaction();
			try {
				transaction.begin();
				
				contaCorrente = entityManager.find(ContaCorrente.class, id);	
				contaCorrente.setCodConta(contaCorrente.getCodConta());
				contaCorrente.setBanco(contaCorrente.getBanco());
				contaCorrente.setPessoa(contaCorrente.getPessoa());
				contaCorrente.setNumeroConta(contaCorrente.getNumeroConta());
				contaCorrente.setNumeroAgencia(contaCorrente.getNumeroAgencia());

//				entityManager.remove(contaCorrente);
			
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
		return contaCorrente;
	}
}
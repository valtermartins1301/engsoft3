package br.sigecon.util;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;

import br.sigecon.beans.ContaCorrente;
import br.sigecon.beans.Lancamento;
import br.sigecon.beans.TipoLancamento;
import br.sigecon.beans.Transferencia;

public class Main {
	public static void main(String[] args) {
		EntityManagerFactory factory = Persistence.createEntityManagerFactory("persist");
		EntityManager entityManager = factory.createEntityManager();
		EntityTransaction transaction = entityManager.getTransaction();
		
		transaction.begin();

//		ContaCorrente contaCorrente = new ContaCorrente();		
//		contaCorrente.setBanco(entityManager.find(Banco.class, 1));
//		contaCorrente.setPessoa(entityManager.find(Pessoa.class, 1));
//		contaCorrente.setNumeroConta(1235);
//		contaCorrente.setNumeroAgencia(4454);
//		entityManager.persist(contaCorrente);

		Transferencia transferencia = new Transferencia();
		transferencia.setContaCorrente(entityManager.find(ContaCorrente.class, 8));
		transferencia.setContaDestino(entityManager.find(ContaCorrente.class, 8));
		transferencia.setDataLancamento(new Date());
		transferencia.setTipoLancamento(entityManager.find(TipoLancamento.class, 1));
		transferencia.setMotivoLancamento("teste");
		transferencia.setValorLancamento(100L);
		
		entityManager.persist(transferencia);
		
		ContaCorrente contaCorrente = entityManager.find(ContaCorrente.class, 8);
		Lancamento lancamento = entityManager.find(Lancamento.class, 4);

		if (contaCorrente.getLancamentoList() == null) {
			List<Lancamento> lancamentos = new ArrayList<Lancamento>();
			lancamentos.add(lancamento);
			contaCorrente.setLancamentoList(lancamentos);			
		} else {
			contaCorrente.getLancamentoList().add(lancamento);
		}
		
		entityManager.persist(contaCorrente);
		
		transaction.commit();
		
		entityManager.close();
		factory.close();
	}
}
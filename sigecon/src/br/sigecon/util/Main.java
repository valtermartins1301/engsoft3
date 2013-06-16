package br.sigecon.util;

import br.sigecon.beans.Banco;
import br.sigecon.beans.Conta;
import br.sigecon.beans.ContaCorrente;
import br.sigecon.beans.Pessoa;
import br.sigecon.daos.ContasDAO;

public class Main {
	public static void main(String[] args) {
//		EntityManagerFactory factory = Persistence.createEntityManagerFactory("persist");
//		EntityManager entityManager = factory.createEntityManager();
//		EntityTransaction transaction = entityManager.getTransaction();
		
//		transaction.begin();

		Banco banco = new Banco();
		banco.setCodBanco(1);
		
		Pessoa pesssoa = new Pessoa();
		pesssoa.setCodPessoa(1);		
		
		ContaCorrente contaCorrente = new ContaCorrente();
		contaCorrente.setCodConta(9);
		contaCorrente.setBanco(banco);
		contaCorrente.setPessoa(pesssoa);
		contaCorrente.setNumeroConta(567);
		contaCorrente.setNumeroAgencia(4451);
	
		ContasDAO dao = new ContasDAO();
		
//		Conta conta = dao.buscarContaPeloId(9);
//		dao.remove(conta);
		
		dao.persist(contaCorrente);
		
//		Transferencia transferencia = new Transferencia();
//		transferencia.setContaCorrente(entityManager.find(ContaCorrente.class, 8));
//		transferencia.setContaDestino(entityManager.find(ContaCorrente.class, 8));
//		transferencia.setDataLancamento(new Date());
//		transferencia.setTipoLancamento(entityManager.find(TipoLancamento.class, 1));
//		transferencia.setMotivoLancamento("teste");
//		transferencia.setValorLancamento(100L);
//		
//		entityManager.persist(transferencia);
		
//		ContaCorrente contaCorrente = entityManager.find(ContaCorrente.class, 8);
//		Lancamento lancamento = entityManager.find(Lancamento.class, 4);
//
//		if (contaCorrente.getLancamentoList() == null) {
//			List<Lancamento> lancamentos = new ArrayList<Lancamento>();
//			lancamentos.add(lancamento);
//			contaCorrente.setLancamentoList(lancamentos);			
//		} else {
//			contaCorrente.getLancamentoList().add(lancamento);
//		}
//		
//		entityManager.persist(contaCorrente);
//		
//		transaction.commit();
//		
//		entityManager.close();
//		factory.close();
	}
}
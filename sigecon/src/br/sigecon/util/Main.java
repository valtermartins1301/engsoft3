package br.sigecon.util;

import java.util.Date;

import br.sigecon.beans.Banco;
import br.sigecon.beans.Conta;
import br.sigecon.beans.ContaCorrente;
import br.sigecon.beans.Lancamento;
import br.sigecon.beans.Pessoa;
import br.sigecon.beans.TipoLancamento;
import br.sigecon.beans.Transferencia;
import br.sigecon.daos.ContasDAO;
import br.sigecon.daos.TransferenciaDAO;

public class Main {
	public static void main(String[] args) {

//----------Adiciona Conta-----------------------------
//		Banco banco = new Banco();
//		banco.setCodBanco(1);
//		
//		Pessoa pesssoa = new Pessoa();
//		pesssoa.setCodPessoa(1);		
//		
//		ContaCorrente contaCorrente = new ContaCorrente();
//		contaCorrente.setBanco(banco);
//		contaCorrente.setPessoa(pesssoa);
//		contaCorrente.setNumeroConta(51222);
//		contaCorrente.setNumeroAgencia(4451233);
//	
//		ContasDAO dao = new ContasDAO();
//		dao.persist(contaCorrente);
		
//----------Edita Conta-----------------------------
//		Banco banco = new Banco();
//		banco.setCodBanco(1);
//		
//		Pessoa pesssoa = new Pessoa();
//		pesssoa.setCodPessoa(1);		
//		
//		ContaCorrente contaCorrente = new ContaCorrente();
//		contaCorrente.setCodConta(5);
//		contaCorrente.setBanco(banco);
//		contaCorrente.setPessoa(pesssoa);
//		contaCorrente.setNumeroConta(51222);
//		contaCorrente.setNumeroAgencia(433);
//	
//		ContasDAO dao = new ContasDAO();
//		dao.merge(contaCorrente);
		
//----------Remove Conta-----------------------------
		
//		Banco banco = new Banco();
//		banco.setCodBanco(1);
//		
//		Pessoa pesssoa = new Pessoa();
//		pesssoa.setCodPessoa(1);		
//		
//		ContaCorrente contaCorrente = new ContaCorrente();
//		contaCorrente.setCodConta(5);
//		contaCorrente.setBanco(banco);
//		contaCorrente.setPessoa(pesssoa);
//		contaCorrente.setNumeroConta(51222);
//		contaCorrente.setNumeroAgencia(433);
	
		ContasDAO dao = new ContasDAO();
		ContaCorrente contaCorrente = dao.buscarContaPeloId(1);
		dao.remove(contaCorrente);
		
//----------Adiciona Transferencia-------------------
//		ContaCorrente conta = new ContaCorrente();
//		conta.setCodConta(1);
//		TipoLancamento tipo = new TipoLancamento();
//		tipo.setCodLancamento(2);
//					
//		Transferencia transferencia = new Transferencia();
//		transferencia.setContaCorrente(conta);
//		transferencia.setContaDestino(conta);
//		transferencia.setDataLancamento(new Date());
//		transferencia.setTipoLancamento(tipo);
//		transferencia.setMotivoLancamento("teste");
//		transferencia.setValorLancamento(1000000L);
//	
//		TransferenciaDAO dao = new TransferenciaDAO();
//		dao.persist(transferencia);
		
//----------Edita Transferencia-------------------
//		ContaCorrente conta = new ContaCorrente();
//		conta.setCodConta(1);
//		TipoLancamento tipo = new TipoLancamento();
//		tipo.setCodLancamento(2);
//					
//		Transferencia transferencia = new Transferencia();
//		transferencia.setCodLancamento(3);
//		transferencia.setContaCorrente(conta);
//		transferencia.setContaDestino(conta);
//		transferencia.setDataLancamento(new Date());
//		transferencia.setTipoLancamento(tipo);
//		transferencia.setMotivoLancamento("teste");
//		transferencia.setValorLancamento(123450L);
//		
//		TransferenciaDAO dao = new TransferenciaDAO();
//		dao.merge(transferencia);
		
//----------Remove Transferencia-------------------		
//		int id = 3;
//		TransferenciaDAO dao = new TransferenciaDAO();
//		dao.remove(id);
//
//		
		
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
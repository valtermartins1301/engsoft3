package br.sigecon.util;

import br.sigecon.daos.BancoDAO;
import br.sigecon.daos.ContasDAO;
import br.sigecon.daos.PessoaDAO;
import br.sigecon.daos.TipoLancamentoDAO;
import br.sigecon.daos.TransferenciaDAO;

public class FactoryDAO {
	public static ContasDAO criarContasDAO() {
		return new ContasDAO();
	}
	
	public static TransferenciaDAO criarTransferenciaDAO() {
		return new TransferenciaDAO();
	}
	
	public static BancoDAO criarBancoDAO() {
		return new BancoDAO();
	}
	
	public static PessoaDAO criarPessoaDAO() {
		return new PessoaDAO();
	}
	
	public static TipoLancamentoDAO criarTipoLancamentoDAO() {
		return new TipoLancamentoDAO();
	}
}
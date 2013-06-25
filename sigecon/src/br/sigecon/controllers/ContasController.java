package br.sigecon.controllers;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import br.sigecon.beans.Banco;
import br.sigecon.beans.Conta;
import br.sigecon.beans.Pessoa;
import br.sigecon.daos.BancoDAO;
import br.sigecon.daos.ContasDAO;
import br.sigecon.daos.PessoaDAO;
import br.sigecon.util.FactoryDAO;

@Controller
public class ContasController {
	@RequestMapping(value = "listagemContas")
	public String listar(Model model) {
		ContasDAO contasDAO = FactoryDAO.criarContasDAO();
		List<Conta> contas = contasDAO.listAll();
		
		BancoDAO bancoDAO = FactoryDAO.criarBancoDAO();
		List<Banco> bancos = bancoDAO.listAll();
		
		model.addAttribute("contas", contas);
		model.addAttribute("bancos", bancos);
		
		return "contas";
	}
	
	/**
	 * Método responsável por receber uma requisição do tipo post e salvar uma conta.
	 * 
	 * @param idBanco
	 * @param conta
	 * @param result Resultado da requisição
	 * @return Retorna uma resposta para a requisição
	 */
	@RequestMapping(value="salvaConta", method = RequestMethod.POST)
	public @ResponseBody String salvaConta(@RequestParam("idBanco") int idBanco, @ModelAttribute(value="conta") Conta conta, BindingResult result) {		
		if (!result.hasErrors()) {
			BancoDAO bancoDAO = FactoryDAO.criarBancoDAO();
			Banco banco = bancoDAO.buscarBancoPeloId(idBanco);
			
			PessoaDAO pessoaDAO = FactoryDAO.criarPessoaDAO();
			Pessoa pessoa = pessoaDAO.buscarPessoaPeloId(1);
						
			conta.setBanco(banco);
			conta.setPessoa(pessoa);
			
			ContasDAO contasDAO = FactoryDAO.criarContasDAO();
			contasDAO.persist(conta);
		}
		return "sucesso";
	}
	
	/**
	 * Método responsável por receber uma requisição do tipo post e editar uma conta.
	 * 
	 * @param idBanco
	 * @param conta
	 * @param result Resultado da requisição
	 * @return Retorna uma resposta para a requisição
	 */
	@RequestMapping(value="editaConta", method = RequestMethod.POST)
	public @ResponseBody String editaConta(@RequestParam("idBanco") int idBanco, @ModelAttribute(value="conta") Conta conta, BindingResult result) {		
		if (!result.hasErrors()) {
			BancoDAO bancoDAO = FactoryDAO.criarBancoDAO();
			Banco banco = bancoDAO.buscarBancoPeloId(idBanco);
			
			PessoaDAO pessoaDAO = FactoryDAO.criarPessoaDAO();
			Pessoa pessoa = pessoaDAO.buscarPessoaPeloId(1);
						
			conta.setBanco(banco);
			conta.setPessoa(pessoa);
			
			ContasDAO contasDAO = FactoryDAO.criarContasDAO();
			contasDAO.merge(conta);
		}
		return "sucesso";
	}
	
	/**
	 * Método responsável por receber uma requisição do tipo post e excluir uma conta. 
	 * A mesma só pode ser excluída quando não existe nenhum lançamento/transferência associado a ela.
	 * 
	 * @param idConta
	 * @return Retorna uma resposta para a requisição
	 */
	@RequestMapping(value = "excluiConta", method = RequestMethod.POST)
	public @ResponseBody String excluiConta(@RequestParam("idConta") int idConta) {
		ContasDAO contasDAO = FactoryDAO.criarContasDAO();
		try {
			contasDAO.remove(idConta);
		} catch (Exception e) {
			e.printStackTrace();
			return "erroAssociacao";
		}
		return "sucesso";
	}
}
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

@Controller
public class ContasController {
	@RequestMapping(value = "listagemContas")
	public String listar(Model model) {
		ContasDAO contasDAO = new ContasDAO();
		List<Conta> contas = contasDAO.listAll();
		
		BancoDAO bancoDAO = new BancoDAO();
		List<Banco> bancos = bancoDAO.listAll();
		
		model.addAttribute("contas", contas);
		model.addAttribute("bancos", bancos);
		
		return "contas";
	}
	
	@RequestMapping(value="salvaConta", method = RequestMethod.POST)
	public @ResponseBody String cadastrar(@RequestParam("idBanco") int idBanco, @ModelAttribute(value="conta") Conta conta, BindingResult result) {		
		if (!result.hasErrors()) {
			BancoDAO bancoDAO = new BancoDAO();
			Banco banco = bancoDAO.buscarBancoPeloId(idBanco);
			
			PessoaDAO pessoaDAO = new PessoaDAO();
			Pessoa pessoa = pessoaDAO.buscarPessoaPeloId(1);
						
			conta.setBanco(banco);
			conta.setPessoa(pessoa);
			
			ContasDAO contasDAO = new ContasDAO();
			conta.setCodConta(contasDAO.persist(conta));
		}
		
		return conta.getCodConta() + "";
	}
	
	@RequestMapping(value="editaConta", method = RequestMethod.POST)
	public @ResponseBody String editar(@RequestParam("idBanco") int idBanco, @ModelAttribute(value="conta") Conta conta, BindingResult result) {		
		if (!result.hasErrors()) {
			BancoDAO bancoDAO = new BancoDAO();
			Banco banco = bancoDAO.buscarBancoPeloId(idBanco);
			
			PessoaDAO pessoaDAO = new PessoaDAO();
			Pessoa pessoa = pessoaDAO.buscarPessoaPeloId(1);
						
			conta.setBanco(banco);
			conta.setPessoa(pessoa);
			
			ContasDAO contasDAO = new ContasDAO();
			contasDAO.merge(conta);
		}
		
		return "";
	}
	
	@RequestMapping(value = "excluiConta", method = RequestMethod.POST)
	public @ResponseBody String excluir(@RequestParam("idConta") int idConta) {
			ContasDAO contasDAO = new ContasDAO();
			contasDAO.remove(idConta);
		return "sucesso";
	}
}
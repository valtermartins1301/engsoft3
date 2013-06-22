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

import br.sigecon.beans.Conta;
import br.sigecon.beans.ContaCorrente;
import br.sigecon.beans.Transferencia;
import br.sigecon.daos.ContasDAO;
import br.sigecon.daos.TransferenciaDAO;
@Controller
public class TransferenciaController {
	@RequestMapping(value = "listagemTransferencias")
	public String listar(Model model) {
		TransferenciaDAO transferenciaDAO = new TransferenciaDAO();
		List<Transferencia> transferencias = transferenciaDAO.listAll();
				
		model.addAttribute("transferencias", transferencias);
				
		return "transferencias";
	}
	
	@RequestMapping(value="cadastraTransferencia", method = RequestMethod.POST)
	public @ResponseBody String cadastrar(@RequestParam("contaOrigem") int idContaOrigem, @RequestParam("contaDestino") int idContaDestino,
			@ModelAttribute(value="transferencia") Transferencia transferencia, BindingResult result) {		
		if (!result.hasErrors()) {
			ContasDAO contaDAO = new ContasDAO();
			ContaCorrente contaOrigem = contaDAO.buscarContaPeloId(idContaOrigem);
			ContaCorrente contaDestino = contaDAO.buscarContaPeloId(idContaDestino);
			
			transferencia.setContaCorrente(contaOrigem);
			transferencia.setContaDestino(contaDestino);
			
			TransferenciaDAO transferenciaDAO = new TransferenciaDAO();
			transferenciaDAO.persist(transferencia);
		}
		
		return transferencia.getCodLancamento() + "";
	}
	
	@RequestMapping(value="editaTransferencia", method = RequestMethod.POST)
	public @ResponseBody String editar(@ModelAttribute(value="transferencia") Transferencia transferencia, BindingResult result) {		
		if (!result.hasErrors()) {
			TransferenciaDAO transferenciaDAO = new TransferenciaDAO();
			transferenciaDAO.merge(transferencia);
		}
		
		return "";
	}
	
	@RequestMapping(value = "excluiTransferencia", method = RequestMethod.POST)
	public @ResponseBody String excluir(@RequestParam("idTransferecia") int idTransferencia) {
			TransferenciaDAO transferenciaDAO = new TransferenciaDAO();
			transferenciaDAO.remove(idTransferencia);
		return "";
	}
}

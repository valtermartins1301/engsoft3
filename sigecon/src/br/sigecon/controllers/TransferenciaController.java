package br.sigecon.controllers;

import java.util.Date;
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
import br.sigecon.beans.TipoLancamento;
import br.sigecon.beans.Transferencia;
import br.sigecon.daos.ContasDAO;
import br.sigecon.daos.TipoLancamentoDAO;
import br.sigecon.daos.TransferenciaDAO;
import br.sigecon.util.DateUtil;
import br.sigecon.util.FactoryDAO;
@Controller
public class TransferenciaController {
	@RequestMapping(value = "listagemTransferencias")
	public String listar(Model model) {
		TransferenciaDAO transferenciaDAO = FactoryDAO.criarTransferenciaDAO();
		List<Transferencia> transferencias = transferenciaDAO.listAll();
		
		ContasDAO contasDAO = FactoryDAO.criarContasDAO();
		List<Conta> contas =  contasDAO.listAll();		
		
		model.addAttribute("transferencias", transferencias);
		model.addAttribute("contas", contas);		
		
		return "transferencias";
	}
	
	@RequestMapping(value="salvaTransferencia", method = RequestMethod.POST)
	public @ResponseBody String salvaTransferencia(@RequestParam("idContaOrigem") int idContaOrigem, @RequestParam("idContaDestino") int idContaDestino,
			@RequestParam("data") String data, @ModelAttribute(value="transferencia") Transferencia transferencia, BindingResult result) {		
		if (!result.hasErrors()) {
			ContasDAO contaDAO = FactoryDAO.criarContasDAO();
			ContaCorrente contaOrigem = contaDAO.buscarContaPeloId(idContaOrigem);
			ContaCorrente contaDestino = contaDAO.buscarContaPeloId(idContaDestino);
			
			TipoLancamentoDAO tipoLancamentoDAO = FactoryDAO.criarTipoLancamentoDAO();
			TipoLancamento tipoLancamento = tipoLancamentoDAO.buscarTipoLancamentoPeloId(2);
			
			Date dataLancamento = DateUtil.parseStringToDate(data);
			transferencia.setDataLancamento(dataLancamento);
			transferencia.setContaCorrente(contaOrigem);
			transferencia.setContaDestino(contaDestino);
			transferencia.setTipoLancamento(tipoLancamento);
	
			TransferenciaDAO transferenciaDAO = FactoryDAO.criarTransferenciaDAO();
			transferenciaDAO.persist(transferencia);
		}
		return "";
	}
	
	@RequestMapping(value="editaTransferencia", method = RequestMethod.POST)
	public @ResponseBody String editar(@RequestParam("idContaOrigem") int idContaOrigem, @RequestParam("idContaDestino") int idContaDestino,
			@RequestParam("data") String data, @ModelAttribute(value="transferencia") Transferencia transferencia, BindingResult result) {		
		if (!result.hasErrors()) {
			ContasDAO contaDAO = FactoryDAO.criarContasDAO();
			ContaCorrente contaOrigem = contaDAO.buscarContaPeloId(idContaOrigem);
			ContaCorrente contaDestino = contaDAO.buscarContaPeloId(idContaDestino);
			
			TipoLancamentoDAO tipoLancamentoDAO = FactoryDAO.criarTipoLancamentoDAO();
			TipoLancamento tipoLancamento = tipoLancamentoDAO.buscarTipoLancamentoPeloId(2);
			
			Date dataLancamento = DateUtil.parseStringToDate(data);
			transferencia.setDataLancamento(dataLancamento);
			transferencia.setContaCorrente(contaOrigem);
			transferencia.setContaDestino(contaDestino);
			transferencia.setTipoLancamento(tipoLancamento);
			
			TransferenciaDAO transferenciaDAO = FactoryDAO.criarTransferenciaDAO();
			transferenciaDAO.merge(transferencia);
		}
		return "";
	}
	
	@RequestMapping(value = "excluiTransferencia", method = RequestMethod.POST)
	public @ResponseBody String excluir(@RequestParam("idTransferencia") int idTransferencia) {
			TransferenciaDAO transferenciaDAO = FactoryDAO.criarTransferenciaDAO();
			transferenciaDAO.remove(idTransferencia);
		return "";
	}
}
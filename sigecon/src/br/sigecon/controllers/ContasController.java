package br.sigecon.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import br.sigecon.beans.Conta;

@Controller
public class ContasController {
	@RequestMapping(value="cadastrar", method = RequestMethod.POST)
	public @ResponseBody String cadastrar(@ModelAttribute(value="conta") Conta conta, BindingResult result) {
		if (!result.hasErrors()) {
			return conta.getNumeroAgencia() + " - " + conta.getNumeroConta();			
		} else {	
			return null;
		}
	}
}
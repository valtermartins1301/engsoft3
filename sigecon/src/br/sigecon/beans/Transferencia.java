package br.sigecon.beans;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "transferencias")
public class Transferencia extends Lancamento {
	@ManyToOne
	@JoinColumn(name = "id_conta_destino")
	private ContaCorrente contaDestino;

	public ContaCorrente getContaDestino() {
		return contaDestino;
	}

	public void setContaDestino(ContaCorrente contaDestino) {
		this.contaDestino = contaDestino;
	}
}
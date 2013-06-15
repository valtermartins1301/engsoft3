package br.sigecon.beans;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.OneToMany;
import javax.persistence.Table;


@Entity
@Table(name = "contas_correntes")
public class ContaCorrente extends Conta {
	@OneToMany
	@JoinTable(name = "contas_lancamentos",
			joinColumns = @JoinColumn(name = "id_conta_corrente"),
			inverseJoinColumns = @JoinColumn(name = "id_lancamento"))
	private List<Lancamento> lancamentoList;

	public List<Lancamento> getLancamentoList() {
		return lancamentoList;
	}

	public void setLancamentoList(List<Lancamento> lancamentoList) {
		this.lancamentoList = lancamentoList;
	}	
}
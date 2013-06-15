package br.sigecon.beans;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "tipos_lancamentos")
public class TipoLancamento {
	@Id
	@GeneratedValue(generator = "increment")
	@GenericGenerator(name = "increment", strategy = "increment")
	@Column(name = "id")
	private int codLancamento;
	@Column(name = "tipo_lancamento")
	private String tipoLancamento;

	public int getCodLancamento() {
		return codLancamento;
	}

	public void setCodLancamento(int codLancamento) {
		this.codLancamento = codLancamento;
	}

	public String getTipoLancamento() {
		return tipoLancamento;
	}

	public void setTipoLancamento(String tipoLancamento) {
		this.tipoLancamento = tipoLancamento;
	}
}
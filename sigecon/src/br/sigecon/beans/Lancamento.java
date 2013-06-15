package br.sigecon.beans;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "lancamentos")
@Inheritance(strategy = InheritanceType.JOINED)
public class Lancamento {
	@Id
	@GeneratedValue(generator = "increment")
	@GenericGenerator(name = "increment", strategy = "increment")
	@Column(name = "id")
	private int codLancamento;
	
	@ManyToOne
	@JoinColumn(name = "id_conta_corrente")
	private ContaCorrente contaCorrente;
	
	@Temporal(TemporalType.DATE)
	@Column(name = "data")
	private Date dataLancamento;
	
	@ManyToOne
	@JoinColumn(name = "id_tipo_lancamento")
	private TipoLancamento tipoLancamento;
	
	@Column(name = "motivo")
	private String motivoLancamento;
	
	@Column(name = "valor")
	private long valorLancamento;

	public int getCodLancamento() {
		return codLancamento;
	}

	public void setCodLancamento(int codLancamento) {
		this.codLancamento = codLancamento;
	}

	public ContaCorrente getContaCorrente() {
		return contaCorrente;
	}

	public void setContaCorrente(ContaCorrente contaCorrente) {
		this.contaCorrente = contaCorrente;
	}

	public Date getDataLancamento() {
		return dataLancamento;
	}

	public void setDataLancamento(Date dataLancamento) {
		this.dataLancamento = dataLancamento;
	}

	public TipoLancamento getTipoLancamento() {
		return tipoLancamento;
	}

	public void setTipoLancamento(TipoLancamento tipoLancamento) {
		this.tipoLancamento = tipoLancamento;
	}

	public String getMotivoLancamento() {
		return motivoLancamento;
	}

	public void setMotivoLancamento(String motivoLancamento) {
		this.motivoLancamento = motivoLancamento;
	}

	public long getValorLancamento() {
		return valorLancamento;
	}

	public void setValorLancamento(long valorLancamento) {
		this.valorLancamento = valorLancamento;
	}
}
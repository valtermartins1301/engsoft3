package br.sigecon.beans;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "contas")
@Inheritance(strategy = InheritanceType.JOINED)
public class Conta {
	@Id
	@GeneratedValue(generator = "increment")
	@GenericGenerator(name = "increment", strategy = "increment")
	@Column(name = "id")
	private int codConta;
	
	@ManyToOne
	@JoinColumn(name = "id_banco")
	private Banco banco;
	
	@Column(name = "numero_conta")
	private int numeroConta;
	
	@Column(name = "numero_agencia")
	private int numeroAgencia;
	
	@ManyToOne
	@JoinColumn(name = "id_pessoa")
	private Pessoa pessoa;

	public int getCodConta() {
		return codConta;
	}

	public void setCodConta(int codConta) {
		this.codConta = codConta;
	}

	public Banco getBanco() {
		return banco;
	}

	public void setBanco(Banco banco) {
		this.banco = banco;
	}

	public int getNumeroConta() {
		return numeroConta;
	}

	public void setNumeroConta(int numeroConta) {
		this.numeroConta = numeroConta;
	}

	public int getNumeroAgencia() {
		return numeroAgencia;
	}

	public void setNumeroAgencia(int numeroAgencia) {
		this.numeroAgencia = numeroAgencia;
	}

	public Pessoa getPessoa() {
		return pessoa;
	}

	public void setPessoa(Pessoa pessoa) {
		this.pessoa = pessoa;
	}
}
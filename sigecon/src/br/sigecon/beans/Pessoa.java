package br.sigecon.beans;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "pessoas")
public class Pessoa {
	@Id
	@GeneratedValue(generator = "increment")
	@GenericGenerator(name = "increment", strategy = "increment")
	@Column(name = "id")
	private int codPessoa;
	@Column(name = "nome_pessoa")
	private String nomePessoa;
	@Column(name = "cpf")
	private int cpfPessoa;
	@Column
	private String senha;

	public int getCodPessoa() {
		return codPessoa;
	}

	public void setCodPessoa(int codPessoa) {
		this.codPessoa = codPessoa;
	}

	public String getNomePessoa() {
		return nomePessoa;
	}

	public void setNomePessoa(String nomePessoa) {
		this.nomePessoa = nomePessoa;
	}

	public int getCpfPessoa() {
		return cpfPessoa;
	}

	public void setCpfPessoa(int cpfPessoa) {
		this.cpfPessoa = cpfPessoa;
	}

	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) {
		this.senha = senha;
	}
}
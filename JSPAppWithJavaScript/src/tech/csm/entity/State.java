package tech.csm.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@Entity
@ToString
@Table(name="tbl_state")
public class State implements Serializable {
	@Id
	@Column(name="state_id")
	private Integer stateId;
	@Column(name="state_name")
	private String stateName;
	
	@ManyToOne
	@JoinColumn(name="country_id")
	private Country country;
	
}

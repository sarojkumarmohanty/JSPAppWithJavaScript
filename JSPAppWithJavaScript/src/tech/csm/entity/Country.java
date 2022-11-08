package tech.csm.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@Entity
@ToString
@Table(name="tbl_country")
public class Country implements Serializable {

	@Id
	@Column(name="country_id")
	private Integer countryId;
	@Column(name="country_name")
	private String countryName;
	
	
}

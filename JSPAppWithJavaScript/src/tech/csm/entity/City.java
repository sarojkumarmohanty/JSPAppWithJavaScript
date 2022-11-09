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
@ToString
@Entity
@Table(name="tbl_city")
public class City implements Serializable {
	@Id
	@Column(name="city_id")
	private Integer cityId;
	@Column(name="city_name")
	private String cityName;
	@ManyToOne
	@JoinColumn(name="state_id")
	private State state;
}

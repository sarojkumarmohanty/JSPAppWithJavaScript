package tech.csm.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
@Entity
@Table(name="branch_info")
public class BranchInfo implements Serializable {
	
	@Id
	@Column(name="branch_id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer branchId;
	@Column(name="branch_name")
	private String branchName;
	
	private Double fees;

}

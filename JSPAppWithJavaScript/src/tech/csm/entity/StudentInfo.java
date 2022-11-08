package tech.csm.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
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
@Table(name="student_info")
public class StudentInfo implements Serializable {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="roll_no")
	private Integer rollNo;
	
	@Column(name="sname")
	private String name;
	
	private String email;
	
	@Column(name="phone_no")
	private String phoneNo;
	
	@Column(name="college_name")
	private String collegeName;
	
	
	@ManyToOne
	@JoinColumn(name="branch", referencedColumnName = "branch_id")
	private BranchInfo branch;
	
	private Double cgpa;
	
	private Date dob;
	
	@Column(name="student_type")
	private String studentType;
	
	@Column(name="interest_area")
	private String interestArea;
	
	@ManyToOne (cascade = CascadeType.ALL)
	@JoinColumn(name="address_id")
	private Address address;
	
	@Column(name="is_deleted")
	private String isDeleted;
	
}

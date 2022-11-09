package tech.csm.util;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import tech.csm.entity.Address;
import tech.csm.entity.BranchInfo;
import tech.csm.entity.City;
import tech.csm.entity.Country;
import tech.csm.entity.State;
import tech.csm.entity.StudentInfo;



public class HibernateUtil {
	private static Session session=null;
	static {
		Configuration cfg=new Configuration().configure();
		cfg.addAnnotatedClass(StudentInfo.class);
		cfg.addAnnotatedClass(BranchInfo.class);
		cfg.addAnnotatedClass(Country.class);
		cfg.addAnnotatedClass(State.class);
		cfg.addAnnotatedClass(Address.class);
		cfg.addAnnotatedClass(City.class);
		SessionFactory sessionFactory=cfg.buildSessionFactory();
		session=sessionFactory.openSession();
	}
	public static Session getSession() {
		return session;
	}

}

package tech.csm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import tech.csm.entity.Address;
import tech.csm.entity.BranchInfo;
import tech.csm.entity.Country;
import tech.csm.entity.State;
import tech.csm.entity.StudentInfo;
import tech.csm.util.HibernateUtil;
//this is the front controller
@WebServlet("/")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Session session;

	@Override
	public void init() throws ServletException {
		session = HibernateUtil.getSession();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");
		PrintWriter pw = resp.getWriter();
		String endPoint = req.getServletPath();

		if (endPoint.equals("/getRegdForm")) {

			Query<BranchInfo> seQueryBranch = session.createQuery("from BranchInfo");
			req.setAttribute("branchList", seQueryBranch.list());
			Query<Country> seQueryCountry = session.createQuery("from Country");
			req.setAttribute("countryList", seQueryCountry.list());
			Query<StudentInfo> seQueryStudent = session.createQuery("from StudentInfo where isDeleted='NO'");
			req.setAttribute("studentList", seQueryStudent.list());

			RequestDispatcher rd = req.getRequestDispatcher("student_form.jsp");
			rd.forward(req, resp);

		} else if (endPoint.equals("/savestudent")) {

			Address address = new Address();

			address.setCountry(session.get(Country.class, Integer.parseInt(req.getParameter("country"))));
			address.setState(session.get(State.class, Integer.parseInt(req.getParameter("state"))));
			address.setAddress(req.getParameter("addressl"));
			StudentInfo st = new StudentInfo();
			if (!req.getParameter("rollNo").equals(""))
				st.setRollNo(Integer.parseInt(req.getParameter("rollNo")));
			st.setName(req.getParameter("name"));
			st.setPhoneNo(req.getParameter("phone"));
			st.setEmail(req.getParameter("email"));
			st.setCollegeName(req.getParameter("collegeName"));
			st.setBranch(session.get(BranchInfo.class, Integer.parseInt(req.getParameter("branch"))));
			st.setCgpa(Double.parseDouble(req.getParameter("cgpa")));
			try {
				st.setDob(new SimpleDateFormat("yyyy-MM-dd").parse(req.getParameter("dob")));
			} catch (ParseException e) {
				e.printStackTrace();
			}
			st.setStudentType(req.getParameter("studType"));
			String temp = Arrays.toString(req.getParameterValues("interestArea"));
			st.setInterestArea(temp.substring(1, temp.length() - 1));
			st.setAddress(address);
			st.setIsDeleted("NO");

			System.out.println(st);

			Transaction tx = session.beginTransaction();

			if (st.getRollNo() == null) {
				Integer sId = (int) session.save(st);
				req.getSession().setAttribute("msg", "Record Saved With Id : " + sId);
			} else {
				session.clear();
				session.update(st);
				req.getSession().setAttribute("msg", "Record Updated Successfully !!");
			}
			tx.commit();

			resp.sendRedirect("./getRegdForm");

		} else if (endPoint.equals("/getStates")) {

			Integer cId = Integer.parseInt(req.getParameter("countryId"));
			Query<State> seQueryState = session.createQuery("from State where country.countryId=?1");
			seQueryState.setParameter(1, cId);
			List<State> stateList = seQueryState.list();
			String sop = "<option value='0'>-select-</option>";
			for (State s : stateList)
				sop += "<option value='" + s.getStateId() + "'>" + s.getStateName() + "</option>";
			pw.println(sop);

		} else if (endPoint.equals("/getFeeByBranchId")) {
			BranchInfo bInfo = session.get(BranchInfo.class, Integer.parseInt(req.getParameter("branchId")));
			pw.println(bInfo.getFees());

		} else if (endPoint.equals("/deletestudent")) {
			StudentInfo stud = session.get(StudentInfo.class, Integer.parseInt(req.getParameter("rollNo")));
			stud.setIsDeleted("YES");
			Transaction tx = session.beginTransaction();
			session.update(stud);
			tx.commit();
			req.getSession().setAttribute("msg", "Roll No : " + stud.getRollNo() + " deleted Successfully !!  ");
			resp.sendRedirect("./getRegdForm");

		} else if (endPoint.equals("/updatestudent")) {
			StudentInfo stud = session.get(StudentInfo.class, Integer.parseInt(req.getParameter("rollNo")));
			req.setAttribute("ustud", stud);
			Query<State> seQueryState = session.createQuery("from State where country.countryId=?1");
			seQueryState.setParameter(1, stud.getAddress().getCountry().getCountryId());
			req.setAttribute("uStateList", seQueryState.list());
			List<State> stateList = seQueryState.list();

			req.getRequestDispatcher("/getRegdForm").forward(req, resp);

		}

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

}

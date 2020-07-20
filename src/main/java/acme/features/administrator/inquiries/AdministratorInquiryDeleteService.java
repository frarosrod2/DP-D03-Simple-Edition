package acme.features.administrator.inquiries;

import org.springframework.beans.factory.annotation.Autowired;

import acme.entities.inquiries.Inquiry;
import acme.framework.components.Errors;
import acme.framework.components.Model;
import acme.framework.components.Request;
import acme.framework.entities.Administrator;
import acme.framework.services.AbstractDeleteService;

public class AdministratorInquiryDeleteService implements AbstractDeleteService<Administrator, Inquiry>{
	
	@Autowired
	AdministratorInquiryRepository repository;

	@Override
	public boolean authorise(Request<Inquiry> request) {
		assert request != null;
		return true;
	}

	@Override
	public void bind(Request<Inquiry> request, Inquiry entity, Errors errors) {
		assert request != null;
		assert entity != null;
		assert errors != null;
		
		request.bind(entity, errors);
		
	}

	@Override
	public void unbind(Request<Inquiry> request, Inquiry entity, Model model) {
		assert request != null;
		assert entity != null;
		assert model != null;
		
		request.unbind(entity, model, "title", "creation", "deadline", "description", "email", "range");
	}

	@Override
	public Inquiry findOne(Request<Inquiry> request) {
		assert request != null;
		
		Inquiry result;
		int id;
		
		id = request.getModel().getInteger("id");
		result = this.repository.findInquiryById(id);
		
		return result;
	}

	@Override
	public void validate(Request<Inquiry> request, Inquiry entity, Errors errors) {
		assert request != null;
		assert entity != null;
		assert errors != null;
		
	}

	@Override
	public void delete(Request<Inquiry> request, Inquiry entity) {
		assert request != null;
		assert entity != null;
		
		this.repository.delete(entity);
		
	}

}

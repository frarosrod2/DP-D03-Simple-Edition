package acme.features.administrator.inquiries;

import java.sql.Date;

import org.springframework.beans.factory.annotation.Autowired;

import acme.entities.inquiries.Inquiry;
import acme.framework.components.Errors;
import acme.framework.components.Model;
import acme.framework.components.Request;
import acme.framework.entities.Administrator;
import acme.framework.services.AbstractUpdateService;

public class AdministratorInquiryUpdateService implements AbstractUpdateService<Administrator, Inquiry>{
	
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
		
		if (!errors.hasErrors("deadline")) {
			Date now = new Date(System.currentTimeMillis() -1);
			errors.state(request, entity.getDeadline().after(now), "deadline", "administrator.inquiry.form.error.notValid");
		}
		
		if (!errors.hasErrors("minMoney")) {
			errors.state(request, entity.getMinMoney().getCurrency().equals("EUR") || 
					entity.getMinMoney().getCurrency().equals("€"), "minMoney", "administrator.inquiry.form.error.onlyEuro");
		}
		
		if (!errors.hasErrors("maxMoney")) {
			errors.state(request, entity.getMaxMoney().getCurrency().equals("EUR") || 
					entity.getMaxMoney().getCurrency().equals("€"), "maxMoney", "administrator.inquiry.form.error.onlyEuro");
		}
		
		if (!errors.hasErrors("maxMoney")) {
			errors.state(request, entity.getMaxMoney().getAmount() > 
			entity.getMinMoney().getAmount(), "maxMoney", "administrator.inquiry.form.error.maxAndMinError");
		}
		
	}

	@Override
	public void update(Request<Inquiry> request, Inquiry entity) {
		assert request != null;
		assert entity != null;
		
		this.repository.save(entity);
		
	}
	
	

}
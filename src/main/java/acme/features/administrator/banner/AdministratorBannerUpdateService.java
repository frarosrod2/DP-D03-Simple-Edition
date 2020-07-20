
package acme.features.administrator.banner;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import acme.entities.banners.Banner;
import acme.framework.components.Errors;
import acme.framework.components.Model;
import acme.framework.components.Request;
import acme.framework.entities.Administrator;
import acme.framework.services.AbstractUpdateService;

@Service
public class AdministratorBannerUpdateService implements AbstractUpdateService<Administrator, Banner> {

	@Autowired
	AdministratorBannerRepository repository;


	@Override
	public boolean authorise(final Request<Banner> request) {
		assert request != null;

		return true;
	}

	@Override
	public void bind(final Request<Banner> request, final Banner entity, final Errors errors) {
		assert request != null;
		assert entity != null;
		assert errors != null;

		request.bind(entity, errors);
	}

	@Override
	public void unbind(final Request<Banner> request, final Banner entity, final Model model) {
		assert request != null;
		assert entity != null;
		assert model != null;

		request.unbind(entity, model, "picture", "slogan", "targetURL", "creditCard.holderName", "creditCard.brand", "creditCard.number", "creditCard.cvv", "creditCard.expMonth", "creditCard.expYear");
	}

	@Override
	public Banner findOne(final Request<Banner> request) {
		assert request != null;

		Banner result;
		int id;

		id = request.getModel().getInteger("id");
		result = this.repository.findOneById(id);

		return result;
	}

	@Override
	public void validate(final Request<Banner> request, final Banner entity, final Errors errors) {
		assert request != null;
		assert entity != null;
		assert errors != null;

		// Check if credit card is in past
		Calendar calendar;
		Date present;
		Calendar test;
		Date check;

		// Check if year is in past
		if (!errors.hasErrors("creditCard.expYear")) {
			calendar = new GregorianCalendar();
			test = new GregorianCalendar();
			present = calendar.getTime();
			test.set(2000 + entity.getCreditCard().getExpYear(), entity.getCreditCard().getExpMonth(), 1);
			check = test.getTime();
			boolean isExpiredYear = check.after(present);
			// Check if year is current year
			if (!isExpiredYear) {
				calendar.set(Calendar.MONTH, entity.getCreditCard().getExpMonth());
				calendar.set(Calendar.DATE, 1);
				Date testing = calendar.getTime();
				if (testing.equals(check)) {
					// Check if month is in past
					if (!errors.hasErrors("creditCard.expMonth")) {
						calendar = new GregorianCalendar();
						test = new GregorianCalendar();
						present = calendar.getTime();
						test.set(2000 + entity.getCreditCard().getExpYear(), entity.getCreditCard().getExpMonth(), 1);
						check = test.getTime();
						boolean isExpiredMonth = check.after(present);
						errors.state(request, isExpiredMonth, "creditCard.expMonth", "administrator.commercialBanner.error.past-month");
					}
				} else {
					errors.state(request, isExpiredYear, "creditCard.expYear", "administrator.commercialBanner.error.past-year");
				}
			}
		}

	}

	@Override
	public void update(final Request<Banner> request, final Banner entity) {
		assert request != null;
		assert entity != null;

		this.repository.save(entity);

	}

}

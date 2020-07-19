
package acme.datatypes;

import javax.persistence.Embeddable;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.CreditCardNumber;
import org.hibernate.validator.constraints.Range;

import acme.framework.datatypes.DomainDatatype;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Embeddable
@Getter
@Setter
@ToString
public class CreditCard extends DomainDatatype {

	//Serialisation identifier ----------------

	private static final long	serialVersionUID	= 1L;

	//Serialisation identifier ----------------

	@NotBlank
	private String				holderName;

	@NotBlank
	@CreditCardNumber
	private String				number;

	@NotBlank
	private String				brand;

	@NotNull
	@Range(min = 100, max = 999)
	private Integer				cvv;

	@NotNull
	@Range(min = 1, max = 12)
	private Integer				expMonth;

	@NotNull
	@Range(min = 10, max = 99)
	private Integer				expYear;

	//Relationships

}

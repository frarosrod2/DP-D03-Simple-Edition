
package acme.features.administrator.dashboard;

import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import acme.framework.repositories.AbstractRepository;

@Repository
public interface AdministratorDashboardRepository extends AbstractRepository {

	@Query("select count(n) from Notice n")
	Integer getNumberOfNotices();

	@Query("select count(tr) from TechnologyRecord tr")
	Integer getNumberOfTechnologyRecords();

	@Query("select count(tr) from ToolRecord tr")
	Integer getNumberOfToolRecords();

	@Query("select COALESCE(min(i.minMoney.amount), 0) from Inquiry i where i.deadline > current_date()")
	Object[] getMinimumMoneyActiveInquiries();

	@Query("select COALESCE(max(i.maxMoney.amount), 0) from Inquiry i where i.deadline > current_date()")
	Object[] getMaxMoneyActiveInquiries();

	@Query("select COALESCE(avg((i.minMoney.amount + i.maxMoney.amount)/2), 0) from Inquiry i where i.deadline > current_date()")
	Object[] getAverageMoneyActiveInquiries();

	@Query("select COALESCE(stddev((i.minMoney.amount + i.maxMoney.amount)/2), 0) from Inquiry i where i.deadline > current_date()")
	Object[] getStandardDeviationMoneyActiveInquiries();

	@Query("select COALESCE(min(o.minMoney.amount), 0) from Overture o where o.deadline > current_date()")
	Object[] getMinimumMoneyActiveOvertures();

	@Query("select COALESCE(max(o.maxMoney.amount), 0) from Overture o where o.deadline > current_date()")
	Object[] getMaxMoneyActiveOvertures();

	@Query("select COALESCE(avg((o.minMoney.amount + o.maxMoney.amount)/2), 0) from Overture o where o.deadline > current_date()")
	Object[] getAverageMoneyActiveOvertures();

	@Query("select COALESCE(stddev((o.minMoney.amount + o.maxMoney.amount)/2), 0) from Overture o where o.deadline > current_date()")
	Object[] getStandardDeviationMoneyActiveOvertures();

	// Grouping by sector ---------------------------------------------------------------------

	@Query("select count(tr) from TechnologyRecord tr group by tr.activitySector")
	Object[] getNumberOfTechnologyRecordsBySector();

	@Query("select tr.activitySector from TechnologyRecord tr group by tr.activitySector")
	Object[] getTechnologyRecordsSectors();

	@Query("select count(tr) from ToolRecord tr group by tr.activitySector")
	Object[] getNumberOfToolRecordsBySector();

	@Query("select tr.activitySector from ToolRecord tr group by tr.activitySector")
	Object[] getToolRecordsSectors();

	// Ratio -----------------------------------------------------------------------------------

	@Query("select 1.0 * count(a) / (select count(b) from TechnologyRecord b) from TechnologyRecord a where a.openSource=TRUE")
	Double getRatioOpenTechnologies();

	@Query("select 1.0 * count(a) / (select count(b) from TechnologyRecord b) from TechnologyRecord a where a.openSource=FALSE")
	Double getRatioClosedTechnologies();

	@Query("select 1.0 * count(a) / (select count(b) from ToolRecord b) from ToolRecord a where a.openSource=TRUE")
	Double getRatioOpenTools();

	@Query("select 1.0 * count(a) / (select count(b) from ToolRecord b) from ToolRecord a where a.openSource=FALSE")
	Double getRatioClosedTools();

}

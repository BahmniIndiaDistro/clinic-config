select  ifnull(sum(if(visit_type_name='OPD New',1,0)),0) as OPD,
        ifnull(sum(if(visit_type_name='OPD Review',1,0)),0) as Review
        from
        (select v.visit_id, vt.name as visit_type_name, p.person_id, date(v.date_started) as date_started, date(p.date_created) as date_created from visit v
            inner join person p on p.person_id=v.patient_id
            inner join visit_type vt on vt.visit_type_id=v.visit_type_id
            where cast(CONVERT_TZ(v.date_started,'+00:00','+5:30') as date) between '#startDate#' and '#endDate#') as raw_result;
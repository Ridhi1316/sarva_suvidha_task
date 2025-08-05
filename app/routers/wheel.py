from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from datetime import date
from typing import List, Optional
from fastapi import Query
from ..db import get_db
from ..models.wheel import WheelSpecification
from ..schemas.wheel import WheelCreate, WheelResponseSingle, WheelResponseList

router = APIRouter()

@router.post("/wheel-specifications", response_model=WheelResponseSingle, status_code=201)
def create_wheel_spec(form: WheelCreate, db: Session = Depends(get_db)):
    try:
        # Create new DB record
        record = WheelSpecification(
            form_number=form.form_number,
            submitted_by=form.submitted_by,
            submitted_date=form.submitted_date,
            tread_diameter_new=form.fields.tread_diameter_new,
            last_shop_issue_size=form.fields.last_shop_issue_size,
            condemning_dia=form.fields.condemning_dia,
            wheel_gauge=form.fields.wheel_gauge,
            variation_same_axle=form.fields.variation_same_axle,
            variation_same_bogie=form.fields.variation_same_bogie,
            variation_same_coach=form.fields.variation_same_coach,
            wheel_profile=form.fields.wheel_profile,
            intermediate_wwp=form.fields.intermediate_wwp,
            bearing_seat_diameter=form.fields.bearing_seat_diameter,
            roller_bearing_outer_dia=form.fields.roller_bearing_outer_dia,
            roller_bearing_bore_dia=form.fields.roller_bearing_bore_dia,
            roller_bearing_width=form.fields.roller_bearing_width,
            axle_box_housing_bore_dia=form.fields.axle_box_housing_bore_dia,
            wheel_disc_width=form.fields.wheel_disc_width
        )

        db.add(record)
        db.commit()

        return {
            "success": True,
            "message": "Wheel specification submitted successfully.",
            "data": {
                "formNumber": form.form_number,
                "submittedBy": form.submitted_by,
                "submittedDate": str(form.submitted_date),
                "status": "Saved"
            }
        }

    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=f"Something went wrong: {e}")

@router.get("/wheel-specifications", response_model=WheelResponseList)
def get_wheel_specifications(
        formNumber: Optional[str] = Query(None),
        submittedBy: Optional[str] = Query(None),
        submittedDate: Optional[str] = Query(None),
        db: Session = Depends(get_db)
    ):
    query = db.query(WheelSpecification)

    if formNumber:
        query = query.filter(WheelSpecification.form_number == formNumber)
    if submittedBy:
        query = query.filter(WheelSpecification.submitted_by == submittedBy)
    if submittedDate:
        query = query.filter(WheelSpecification.submitted_date == submittedDate)

    results = query.all()

    formatted_data = [
    {
        "form_number": row.form_number,
        "submitted_by": row.submitted_by,
        "submitted_date": str(row.submitted_date),
        "fields": {
            "tread_diameter_new": row.tread_diameter_new,
            "last_shop_issue_size": row.last_shop_issue_size,
            "condemning_dia": row.condemning_dia,
            "wheel_gauge": row.wheel_gauge,
            "variation_same_axle": row.variation_same_axle,
            "variation_same_bogie": row.variation_same_bogie,
            "variation_same_coach": row.variation_same_coach,
            "wheel_profile": row.wheel_profile,
            "intermediate_wwp": row.intermediate_wwp,
            "bearing_seat_diameter": row.bearing_seat_diameter,
            "roller_bearing_outer_dia": row.roller_bearing_outer_dia,
            "roller_bearing_bore_dia": row.roller_bearing_bore_dia,
            "roller_bearing_width": row.roller_bearing_width,
            "axle_box_housing_bore_dia": row.axle_box_housing_bore_dia,
            "wheel_disc_width": row.wheel_disc_width
        }
    }
    for row in results
    ]

    return {
        "success": True,
        "message": "Filtered wheel specification forms fetched successfully.",
        "data": formatted_data
    }
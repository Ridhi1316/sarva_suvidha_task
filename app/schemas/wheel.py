from pydantic import BaseModel
from datetime import date
from typing import List, Union, Dict

class WheelFields(BaseModel):
    tread_diameter_new: str
    last_shop_issue_size: str
    condemning_dia: str
    wheel_gauge: str
    variation_same_axle: str
    variation_same_bogie: str
    variation_same_coach: str
    wheel_profile: str
    intermediate_wwp: str
    bearing_seat_diameter: str
    roller_bearing_outer_dia: str
    roller_bearing_bore_dia: str
    roller_bearing_width: str
    axle_box_housing_bore_dia: str
    wheel_disc_width: str

class WheelCreate(BaseModel):
    form_number: str
    submitted_by: str
    submitted_date: date
    fields: WheelFields


class WheelResponseSingle(BaseModel):
    success: bool
    message: str
    data: Dict

class WheelResponseList(BaseModel):
    success: bool
    message: str
    data: List[Dict]

    class Config:
        orm_mode = True

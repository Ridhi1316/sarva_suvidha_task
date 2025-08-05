from sqlalchemy import Column, Integer, String, Date
from ..db import Base

class WheelSpecification(Base):
    __tablename__ = 'wheel_specifications'
    id = Column(Integer, primary_key=True, index=True)
    form_number = Column(String, index=True)
    submitted_by = Column(String)
    submitted_date = Column(Date)

    tread_diameter_new = Column(String)
    last_shop_issue_size = Column(String)
    condemning_dia = Column(String)
    wheel_gauge = Column(String)
    variation_same_axle = Column(String)
    variation_same_bogie = Column(String)
    variation_same_coach = Column(String)
    wheel_profile = Column(String)
    intermediate_wwp = Column(String)
    bearing_seat_diameter = Column(String)
    roller_bearing_outer_dia = Column(String)
    roller_bearing_bore_dia = Column(String)
    roller_bearing_width = Column(String)
    axle_box_housing_bore_dia = Column(String)
    wheel_disc_width = Column(String)

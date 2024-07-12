class AllAttendanceHistoryModel {
  int? status;
  Null? count;
  List<Data>? data;
  String? message;

  AllAttendanceHistoryModel({this.status, this.count, this.data, this.message});

  AllAttendanceHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    count = json['count'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? date;
  String? checkInTime;
  String? checkOutTime;
  String? status;
  String? totalHours;
  String? leaveCategory;
  String? leaveType;
  String? holidayName;
  String? holidayImage;
  Null? restrictedDayImage;

  Data(
      {this.date,
        this.checkInTime,
        this.checkOutTime,
        this.status,
        this.totalHours,
        this.leaveCategory,
        this.leaveType,
        this.holidayName,
        this.holidayImage,
        this.restrictedDayImage});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    checkInTime = json['check_in_time'];
    checkOutTime = json['check_out_time'];
    status = json['status'];
    totalHours = json['total_hours'];
    leaveCategory = json['leave_category'];
    leaveType = json['leave_type'];
    holidayName = json['holiday_name'];
    holidayImage = json['holiday_image'];
    restrictedDayImage = json['restricted_day_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['check_in_time'] = this.checkInTime;
    data['check_out_time'] = this.checkOutTime;
    data['status'] = this.status;
    data['total_hours'] = this.totalHours;
    data['leave_category'] = this.leaveCategory;
    data['leave_type'] = this.leaveType;
    data['holiday_name'] = this.holidayName;
    data['holiday_image'] = this.holidayImage;
    data['restricted_day_image'] = this.restrictedDayImage;
    return data;
  }
}

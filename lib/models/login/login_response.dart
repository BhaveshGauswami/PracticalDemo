class LoginResponse {
  int? status;
  String? count;
  List<Data>? data;
  String? message;

  LoginResponse({this.status, this.count, this.data, this.message});

  LoginResponse.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  String? employeeId;
  int? organizationSiteId;
  int? organizationId;
  int? userroleid;
  int? employmentTypeId;
  String? userfirstname;
  String? usermiddlename;
  String? userlastname;
  String? userdob;
  String? userContactCountryCode;
  String? usercontactno;
  String? userAlternateContactCountryCode;
  String? userAlternateContactNo;
  String? userEmergencyContactCountryCode;
  String? userEmergencyContactNo;
  String? userEmergencyContactPersonName;
  String? userEmergencyContactPersonRelation;
  int? isMobileWhatsapp;
  int? isAlternateMobileWhatsapp;
  String? useremail;
  String? userofficialemail;
  String? userpassword;
  String? userpermanentaddress1;
  String? userpermanentaddress2;
  String? usercommunicationaddressline1;
  String? usercommunicationaddressline2;
  String? userreligion;
  String? usergender;
  String? userprofilephoto;
  String? userdateofjoining;
  String? userPFcode;
  String? userESIcode;
  String? userheight;
  String? userweight;
  int? userBloodTypeId;
  String? userallergies;
  String? useridentificationmarks;
  String? userphysicaldisability;
  String? maritalstatus;
  String? dateofanniversary;
  int? userpermanentpincodeId;
  int? usercommunicationpicodeId;
  int? longLeaveOne;
  int? longLeaveTwo;
  int? satOff;
  int? isHrpolicyaccept;
  int? isNdaAccept;
  int? isResigned;
  int? isProbation;
  int? noticePeriod;
  String? noticePeriodEndDate;
  int? isExit;
  String? nationality;
  int? checkinallowanywhere;
  int? reportCompulsory;
  int? isReportChecker;
  int? status;
  String? browserName;
  String? browserPlatform;
  String? browserVersion;
  String? ipAddress;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  String? token;
  String? deviceId;
  String? deviceModel;
  String? osVersion;
  String? mobilePlateform;
  String? permanentpincode;
  String? permanentcountry;
  String? permanentdistrict;
  String? permanentstate;
  String? communicationpincode;
  String? communicationcountry;
  String? communicationdistrict;
  String? communicationstate;
  String? orgnizationSiteLat;
  String? orgnizationSiteLong;
  String? orgnizationSite;
  String? hrName;
  String? hrContact;
  String? organizationHrPolicy;
  String? organizationNda;
  String? dateOfJoining;
  String? officialDateOfJoing;
  String? userrole;
  int? isWorkMenuEnable;
  int? distance;

  Data(
      {this.userId,
      this.employeeId,
      this.organizationSiteId,
      this.organizationId,
      this.userroleid,
      this.employmentTypeId,
      this.userfirstname,
      this.usermiddlename,
      this.userlastname,
      this.userdob,
      this.userContactCountryCode,
      this.usercontactno,
      this.userAlternateContactCountryCode,
      this.userAlternateContactNo,
      this.userEmergencyContactCountryCode,
      this.userEmergencyContactNo,
      this.userEmergencyContactPersonName,
      this.userEmergencyContactPersonRelation,
      this.isMobileWhatsapp,
      this.isAlternateMobileWhatsapp,
      this.useremail,
      this.userofficialemail,
      this.userpassword,
      this.userpermanentaddress1,
      this.userpermanentaddress2,
      this.usercommunicationaddressline1,
      this.usercommunicationaddressline2,
      this.userreligion,
      this.usergender,
      this.userprofilephoto,
      this.userdateofjoining,
      this.userPFcode,
      this.userESIcode,
      this.userheight,
      this.userweight,
      this.userBloodTypeId,
      this.userallergies,
      this.useridentificationmarks,
      this.userphysicaldisability,
      this.maritalstatus,
      this.dateofanniversary,
      this.userpermanentpincodeId,
      this.usercommunicationpicodeId,
      this.longLeaveOne,
      this.longLeaveTwo,
      this.satOff,
      this.isHrpolicyaccept,
      this.isNdaAccept,
      this.isResigned,
      this.isProbation,
      this.noticePeriod,
      this.noticePeriodEndDate,
      this.isExit,
      this.nationality,
      this.checkinallowanywhere,
      this.reportCompulsory,
      this.isReportChecker,
      this.status,
      this.browserName,
      this.browserPlatform,
      this.browserVersion,
      this.ipAddress,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.token,
      this.deviceId,
      this.deviceModel,
      this.osVersion,
      this.mobilePlateform,
      this.permanentpincode,
      this.permanentcountry,
      this.permanentdistrict,
      this.permanentstate,
      this.communicationpincode,
      this.communicationcountry,
      this.communicationdistrict,
      this.communicationstate,
      this.orgnizationSiteLat,
      this.orgnizationSiteLong,
      this.orgnizationSite,
      this.hrName,
      this.hrContact,
      this.organizationHrPolicy,
      this.organizationNda,
      this.dateOfJoining,
      this.officialDateOfJoing,
      this.userrole,
      this.isWorkMenuEnable,
      this.distance});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    employeeId = json['employee_id'];
    organizationSiteId = json['organization_site_id'];
    organizationId = json['organization_id'];
    userroleid = json['userroleid'];
    employmentTypeId = json['employment_type_id'];
    userfirstname = json['userfirstname'];
    usermiddlename = json['usermiddlename'];
    userlastname = json['userlastname'];
    userdob = json['userdob'];
    userContactCountryCode = json['user_contact_country_code'];
    usercontactno = json['usercontactno'];
    userAlternateContactCountryCode =
        json['user_alternate_contact_country_code'];
    userAlternateContactNo = json['user_alternate_contact_no'];
    userEmergencyContactCountryCode =
        json['user_emergency_contact_country_code'];
    userEmergencyContactNo = json['user_emergency_contact_no'];
    userEmergencyContactPersonName = json['user_emergency_contact_person_name'];
    userEmergencyContactPersonRelation =
        json['user_emergency_contact_person_relation'];
    isMobileWhatsapp = json['is_mobile_whatsapp'];
    isAlternateMobileWhatsapp = json['is_alternate_mobile_whatsapp'];
    useremail = json['useremail'];
    userofficialemail = json['userofficialemail'];
    userpassword = json['userpassword'];
    userpermanentaddress1 = json['userpermanentaddress1'];
    userpermanentaddress2 = json['userpermanentaddress2'];
    usercommunicationaddressline1 = json['usercommunicationaddressline1'];
    usercommunicationaddressline2 = json['usercommunicationaddressline2'];
    userreligion = json['userreligion'];
    usergender = json['usergender'];
    userprofilephoto = json['userprofilephoto'];
    userdateofjoining = json['userdateofjoining'];
    userPFcode = json['userPFcode'];
    userESIcode = json['userESIcode'];
    userheight = json['userheight'];
    userweight = json['userweight'];
    userBloodTypeId = json['user_blood_type_id'];
    userallergies = json['userallergies'];
    useridentificationmarks = json['useridentificationmarks'];
    userphysicaldisability = json['userphysicaldisability'];
    maritalstatus = json['maritalstatus'];
    dateofanniversary = json['dateofanniversary'];
    userpermanentpincodeId = json['userpermanentpincode_id'];
    usercommunicationpicodeId = json['usercommunicationpicode_id'];
    longLeaveOne = json['long_leave_one'];
    longLeaveTwo = json['long_leave_two'];
    satOff = json['sat_off'];
    isHrpolicyaccept = json['is_hrpolicyaccept'];
    isNdaAccept = json['is_nda_accept'];
    isResigned = json['is_resigned'];
    isProbation = json['is_probation'];
    noticePeriod = json['notice_period'];
    noticePeriodEndDate = json['notice_period_end_date'];
    isExit = json['is_exit'];
    nationality = json['nationality'];
    checkinallowanywhere = json['checkinallowanywhere'];
    reportCompulsory = json['report_compulsory'];
    isReportChecker = json['is_report_checker'];
    status = json['status'];
    browserName = json['browser_name'];
    browserPlatform = json['browser_platform'];
    browserVersion = json['browser_version'];
    ipAddress = json['ip_address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    token = json['token'];
    deviceId = json['device_id'];
    deviceModel = json['deviceModel'];
    osVersion = json['osVersion'];
    mobilePlateform = json['mobile_plateform'];
    permanentpincode = json['permanentpincode'];
    permanentcountry = json['permanentcountry'];
    permanentdistrict = json['permanentdistrict'];
    permanentstate = json['permanentstate'];
    communicationpincode = json['communicationpincode'];
    communicationcountry = json['communicationcountry'];
    communicationdistrict = json['communicationdistrict'];
    communicationstate = json['communicationstate'];
    orgnizationSiteLat = json['orgnization_site_lat'];
    orgnizationSiteLong = json['orgnization_site_long'];
    orgnizationSite = json['orgnization_site'];
    hrName = json['hr_name'];
    hrContact = json['hr_contact'];
    organizationHrPolicy = json['organization_hr_policy'];
    organizationNda = json['organization_nda'];
    dateOfJoining = json['date_of_joining'];
    officialDateOfJoing = json['official_date_of_joing'];
    userrole = json['userrole'];
    isWorkMenuEnable = json['is_work_menu_enable'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['employee_id'] = this.employeeId;
    data['organization_site_id'] = this.organizationSiteId;
    data['organization_id'] = this.organizationId;
    data['userroleid'] = this.userroleid;
    data['employment_type_id'] = this.employmentTypeId;
    data['userfirstname'] = this.userfirstname;
    data['usermiddlename'] = this.usermiddlename;
    data['userlastname'] = this.userlastname;
    data['userdob'] = this.userdob;
    data['user_contact_country_code'] = this.userContactCountryCode;
    data['usercontactno'] = this.usercontactno;
    data['user_alternate_contact_country_code'] =
        this.userAlternateContactCountryCode;
    data['user_alternate_contact_no'] = this.userAlternateContactNo;
    data['user_emergency_contact_country_code'] =
        this.userEmergencyContactCountryCode;
    data['user_emergency_contact_no'] = this.userEmergencyContactNo;
    data['user_emergency_contact_person_name'] =
        this.userEmergencyContactPersonName;
    data['user_emergency_contact_person_relation'] =
        this.userEmergencyContactPersonRelation;
    data['is_mobile_whatsapp'] = this.isMobileWhatsapp;
    data['is_alternate_mobile_whatsapp'] = this.isAlternateMobileWhatsapp;
    data['useremail'] = this.useremail;
    data['userofficialemail'] = this.userofficialemail;
    data['userpassword'] = this.userpassword;
    data['userpermanentaddress1'] = this.userpermanentaddress1;
    data['userpermanentaddress2'] = this.userpermanentaddress2;
    data['usercommunicationaddressline1'] = this.usercommunicationaddressline1;
    data['usercommunicationaddressline2'] = this.usercommunicationaddressline2;
    data['userreligion'] = this.userreligion;
    data['usergender'] = this.usergender;
    data['userprofilephoto'] = this.userprofilephoto;
    data['userdateofjoining'] = this.userdateofjoining;
    data['userPFcode'] = this.userPFcode;
    data['userESIcode'] = this.userESIcode;
    data['userheight'] = this.userheight;
    data['userweight'] = this.userweight;
    data['user_blood_type_id'] = this.userBloodTypeId;
    data['userallergies'] = this.userallergies;
    data['useridentificationmarks'] = this.useridentificationmarks;
    data['userphysicaldisability'] = this.userphysicaldisability;
    data['maritalstatus'] = this.maritalstatus;
    data['dateofanniversary'] = this.dateofanniversary;
    data['userpermanentpincode_id'] = this.userpermanentpincodeId;
    data['usercommunicationpicode_id'] = this.usercommunicationpicodeId;
    data['long_leave_one'] = this.longLeaveOne;
    data['long_leave_two'] = this.longLeaveTwo;
    data['sat_off'] = this.satOff;
    data['is_hrpolicyaccept'] = this.isHrpolicyaccept;
    data['is_nda_accept'] = this.isNdaAccept;
    data['is_resigned'] = this.isResigned;
    data['is_probation'] = this.isProbation;
    data['notice_period'] = this.noticePeriod;
    data['notice_period_end_date'] = this.noticePeriodEndDate;
    data['is_exit'] = this.isExit;
    data['nationality'] = this.nationality;
    data['checkinallowanywhere'] = this.checkinallowanywhere;
    data['report_compulsory'] = this.reportCompulsory;
    data['is_report_checker'] = this.isReportChecker;
    data['status'] = this.status;
    data['browser_name'] = this.browserName;
    data['browser_platform'] = this.browserPlatform;
    data['browser_version'] = this.browserVersion;
    data['ip_address'] = this.ipAddress;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['token'] = this.token;
    data['device_id'] = this.deviceId;
    data['deviceModel'] = this.deviceModel;
    data['osVersion'] = this.osVersion;
    data['mobile_plateform'] = this.mobilePlateform;
    data['permanentpincode'] = this.permanentpincode;
    data['permanentcountry'] = this.permanentcountry;
    data['permanentdistrict'] = this.permanentdistrict;
    data['permanentstate'] = this.permanentstate;
    data['communicationpincode'] = this.communicationpincode;
    data['communicationcountry'] = this.communicationcountry;
    data['communicationdistrict'] = this.communicationdistrict;
    data['communicationstate'] = this.communicationstate;
    data['orgnization_site_lat'] = this.orgnizationSiteLat;
    data['orgnization_site_long'] = this.orgnizationSiteLong;
    data['orgnization_site'] = this.orgnizationSite;
    data['hr_name'] = this.hrName;
    data['hr_contact'] = this.hrContact;
    data['organization_hr_policy'] = this.organizationHrPolicy;
    data['organization_nda'] = this.organizationNda;
    data['date_of_joining'] = this.dateOfJoining;
    data['official_date_of_joing'] = this.officialDateOfJoing;
    data['userrole'] = this.userrole;
    data['is_work_menu_enable'] = this.isWorkMenuEnable;
    data['distance'] = this.distance;
    return data;
  }
}

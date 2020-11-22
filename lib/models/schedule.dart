
class Appointment {
  int id;
   String severity;
  String duration;
  String startTime;
  String endTime;
  String date;
  String doctorsNotes;
  int doctorsRating;
  int patientsRating;
  bool completed;
  String location;
  int sessionReq;

  Appointment(
      {this.id,
         this.severity,
        this.duration,
        this.startTime,
        this.endTime,
        this.date,
        this.doctorsNotes,
        this.doctorsRating,
        this.patientsRating,
        this.completed,
        this.location,
        this.sessionReq, });

  Appointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
      severity = json['severity'];
    duration = json['duration'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    date = json['date'];
    doctorsNotes = json['doctors_notes'];
    doctorsRating = json['doctors_rating'];
    patientsRating = json['patients_rating'];
    completed = json['completed'];
    location = json['location'];
    sessionReq = json['session_req'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;

    data['severity'] = this.severity;
    data['duration'] = this.duration;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['date'] = this.date;
    data['doctors_notes'] = this.doctorsNotes;
    data['doctors_rating'] = this.doctorsRating;
    data['patients_rating'] = this.patientsRating;
    data['completed'] = this.completed;
    data['location'] = this.location;
    data['session_req'] = this.sessionReq;

    return data;
  }
}

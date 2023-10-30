class Temperatures {
    String status;
    String message;
    List<Datum> data;

    Temperatures({
        required this.status,
        required this.message,
        required this.data,
    });

}

class Datum {
    bool isbreakout;
    String schedule;
    int order;
    String facilitator;
    String duration;
    String time;
    List<Session>? sessions;

    Datum({
        required this.isbreakout,
        required this.schedule,
        required this.order,
        required this.facilitator,
        required this.duration,
        required this.time,
        this.sessions,
    });

}

class Session {
    String schedule;
    String venue;
    String time;
    String facilitator;

    Session({
        required this.schedule,
        required this.venue,
        required this.time,
        required this.facilitator,
    });

}



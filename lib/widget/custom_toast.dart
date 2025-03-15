import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class CustomToast extends StatefulWidget {
  final BuildContext context;
  final String message;
  final Duration duration;
  CustomToast({
    Key? key,
    required this.context,
    this.message = "",
    this.duration = const Duration(seconds: 2),
  }) : super();

  static FToast? fToast;

  void ShowToast() {
    if (fToast != null) {
      fToast!.removeQueuedCustomToasts();
      fToast!.removeCustomToast();
    }
    fToast = FToast();
    fToast!.init(context);
    fToast!.showToast(
      child: this,
      toastDuration: duration,
    );
  }

  BoxDecoration toastDecoration() {
    return BoxDecoration(borderRadius: BorderRadius.circular(10));
  }

  Widget toastContent() {
    return Text(
      this.message,
      style: TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
      textAlign: TextAlign.left,
    );
  }

  Widget toastIcon() {
    return Container(
      child: Icon(
        Icons.close,
        color: Colors.black,
        size: 28.0,
      ),
    );
  }

  @override
  State<CustomToast> createState() => _CustomToastState();
}

class _CustomToastState extends State<CustomToast> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: widget.toastDecoration(),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          widget.toastIcon(),
          SizedBox(
            width: 10,
          ),
          Expanded(child: widget.toastContent())
        ],
      ),
    );
  }
}

class WarningToast extends CustomToast {
  WarningToast({
    Key? key,
    required BuildContext context,
    String message = "",
    Duration duration = const Duration(seconds: 2),
  }) : super(context: context, message: message, duration: duration);

  @override
  BoxDecoration toastDecoration() {
    
    return BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(10),
    );
  }

  @override
  Widget toastIcon() {
    return Container(
      child: Icon(
        Icons.close,
        color: Colors.white,
        size: 28.0,
      ),
    );
  }

  @override
  Widget toastContent() {
   
    return Text(
      this.message,
      style: TextStyle(color: Colors.white, fontSize: 16),
    );
  }
}

class SuccessToast extends CustomToast {
  SuccessToast({
    Key? key,
    required BuildContext context,
    String message = "",
    Duration duration = const Duration(seconds: 2),
  }) : super(context: context, message: message, duration: duration);

  @override
  Widget toastIcon() {
    return Container(
      child: Icon(
        Icons.done,
        color: Colors.white,
        size: 28.0,
      ),
    );
  }

  @override
  BoxDecoration toastDecoration() {
    return BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.circular(10),
    );
  }

  @override
  Widget toastContent() {
    return Text(
      message,
      style: TextStyle(color: Colors.white, fontSize: 16),
    );
  }
}

class NotifyToast extends CustomToast {
  NotifyToast({
    Key? key,
    required BuildContext context,
    String message = "",
    Duration duration = const Duration(seconds: 2),
  }) : super(context: context, message: message, duration: duration);

  @override
  Widget toastIcon() {
    return Container(
      child: Icon(
        Icons.info_rounded,
        color: Colors.white,
        size: 28.0,
      ),
    );
  }

  @override
  BoxDecoration toastDecoration() {
    return BoxDecoration(
      color: Colors.lightBlue[300],
      borderRadius: BorderRadius.circular(10),
    );
  }

  @override
  Widget toastContent() {
    return Text(
      message,
      style: TextStyle(color: Colors.white, fontSize: 16),
    );
  }
}
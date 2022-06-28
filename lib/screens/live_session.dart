//import 'package:firebase_ml_vision/firebase_ml_vision.dart';

import 'package:flutter/material.dart';
import '../utlis_scanner.dart';
import '../constants';
//import 'package:camera/camera.dart';
import '../widgets/blurry_title.dart';
import '../widgets/choice_quiz.dart';
import '../widgets/congrats_widget.dart';
import '../widgets/floating_button_quiz_mode.dart';
import '../widgets/live_session_floating_action_button.dart';
import '../widgets/ask_for_break.dart';
import '../widgets/draw_over_apps.dart';

class LiveSession extends StatefulWidget {
  const LiveSession({Key? key, required this.courseName}) : super(key: key);
  //final List<CameraDescription> cameras;
  final String courseName;
  @override
  State<LiveSession> createState() => _LiveSessionState();
}

class _LiveSessionState extends State<LiveSession> {
  //late CameraController cameraController;
  //CameraController? cameraController;
  //bool isDetecting = false;
  //FaceDetector? faceDetector;
  //Size? size;
  //CameraDescription? description;
  //List<Face>? faceList;
  //CameraLensDirection cameraLensDirection = CameraLensDirection.front;
  /*initCamera() async {
    if (widget.cameras == null) {
      print('No camera is found');
    } else {
      //description = await UtilsScanner.getCamera(cameraLensDirection);
      //CameraDescription? description = widget.cameraDescription;
      description = widget.cameras.firstWhere(
          (CameraDescription cameraDirection) =>
              cameraDirection.lensDirection == cameraLensDirection);

      cameraController = CameraController(description, ResolutionPreset.medium,
          enableAudio: false);

      faceDetector =
          FirebaseVision.instance.faceDetector(const FaceDetectorOptions(
        enableClassification: true,
        minFaceSize: 0.1,
        mode: FaceDetectorMode.fast,
      ));
      await cameraController!.initialize().then((value) {
        if (!mounted) {
          return;
        }
        cameraController!.startImageStream((imageFromStream) => {
              if (!isDetecting)
                {
                  isDetecting = true,
                  performDetectionOnStreamFrames(imageFromStream),
                }
            });
      });
    }
  }

  dynamic scanResults;
  performDetectionOnStreamFrames(CameraImage cameraImage) async {
    UtilsScanner.detect(
            image: cameraImage,
            detectInImage: faceDetector!.processImage,
            imageRotation: description!.sensorOrientation)
        .then((dynamic results) {
      setState(() {
        scanResults = results;
      });
    }).whenComplete(() {
      isDetecting = false;
    });
  }
/*
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initCamera();
  }*/

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cameraController.dispose();
    faceDetector!.close();
  }

  Widget buildResult() {
    if (scanResults == null ||
        cameraController == null ||
        cameraController.value.isInitialized) {
      return const Text("");
    }
    final Size imageSize = Size(
      cameraController.value.previewSize!.width,
      cameraController.value.previewSize!.height,
    );

    CustomPainter customPainter =
        FaceDetectorPainter(imageSize, scanResults, cameraLensDirection);

    return CustomPaint(
      painter: customPainter,
    );
  }
  */

/*
  toggleCameraToFrontOrBack() async {
    if (cameraLensDirection == CameraLensDirection.back) {
      cameraLensDirection = CameraLensDirection.front;
    } else {
      cameraLensDirection = CameraLensDirection.back;
    }
    await cameraController!.stopImageStream();
    await cameraController!.dispose();

    setState(() {
      cameraController = null;
    });
    initCamera();
  }*/
/*
  @override
  void initState() {
    super.initState();
    if (widget.cameras == null || widget.cameras.length < 1) {
      print('No camera is found');
    } else {
      cameraController = CameraController(
          widget.cameras[3], ResolutionPreset.max,
          enableAudio: false);
      cameraController.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});

        cameraController.startImageStream((CameraImage img) {
          if (!isDetecting) {
            isDetecting = true;
            int startTime = new DateTime.now().millisecondsSinceEpoch;
          }
        });
      });
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
*/
  bool firstTime = false;

  @override
  Widget build(BuildContext context) {
    /*
    List<Widget> stackwidgetChildren = [];
    size = MediaQuery.of(context).size;

    if (cameraController != null) {
      stackwidgetChildren.add(
        Positioned(
          top: 0,
          left: 0,
          width: size!.width,
          height: size!.height - 250,
          child: Container(
            child: (cameraController.value.isInitialized)
                ? AspectRatio(
                    aspectRatio: cameraController.value.aspectRatio,
                    child: CameraPreview(cameraController),
                  )
                : Container(),
          ),
        ),
      );
      stackwidgetChildren.add(Positioned(
          height: 250,
          width: size!.width,
          left: 0,
          top: size!.height - 250,
          child: Container(
            margin: EdgeInsets.only(bottom: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    //toggleCameraToFrontOrBack();
                  },
                  icon: Icon(
                    Icons.cached,
                    color: Colors.white,
                  ),
                  iconSize: 50,
                  color: Colors.black,
                )
              ],
            ),
          )));
    }
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 0),
        color: Colors.black,
        child: Stack(
          children: stackwidgetChildren,
        ),
      ),
    );
    */
    /*
    if (!cameraController.value.isInitialized) {
      return Container();
    }*/

    final size = MediaQuery.of(context).size;
    //final deviceRatio = size.width / size.height;
    bool normalMode = true;
    return Scaffold(
      floatingActionButton: normalMode ? NormalMode() : QuizMode(),
      floatingActionButtonLocation: normalMode
          ? FloatingActionButtonLocation.endFloat
          : FloatingActionButtonLocation.miniCenterFloat,
      backgroundColor: const Color(0xff1C1C1E),
      appBar: BlurryTitle(
        title: widget.courseName,
      ),
      body: Center(
        child: Container(
          //color: Color(0xffFAFCFE),
          constraints: const BoxConstraints.expand(),
          child: Stack(
            //fit: StackFit.expand,
            children: [
              /*Center(
                child: Transform.scale(
                  //scale: cameraController.value.aspectRatio,
                  filterQuality: FilterQuality.high,
                  alignment: Alignment.center,
                  //child: CameraPreview(cameraController),
                ),
              ),*/
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 16),
                    child: Row(
                      children: [
                        Container(
                          width: 13,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Color(0xffFF453A),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                          ),
                        ),
                        Container(
                          width: 66,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Color(0x996F6F6F),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Image(
                                image: AssetImage("assets/icons/user.png"),
                              ),
                              Text(
                                "38",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "SF Pro Text",
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //AskForBreak(),

              // Ask for a break widget
              // DrawOverApps(),
              // ChoiceQuiz(),
              //CongratsWidget(),
              //FaceDetectionAlert(),
            ],
          ),
        ),
      ),
    );
  }
}
/*
class FaceDetectorPainter extends CustomPainter {
  FaceDetectorPainter(
      this.absoluteImageSize, this.faces, this.cameraLensDirection);
  final Size absoluteImageSize;
  final List<Face> faces;
  final CameraLensDirection cameraLensDirection;

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.2
      ..color = Colors.red;

    for (Face face in faces) {
      canvas.drawRect(
          Rect.fromLTRB(
            CameraLensDirection == CameraLensDirection.front
                ? (absoluteImageSize.width - face.boundingBox.right) * scaleX
                : face.boundingBox.left * scaleX,
            face.boundingBox.top * scaleY,
            cameraLensDirection == CameraLensDirection.front
                ? (absoluteImageSize.width - face.boundingBox.left) * scaleX
                : face.boundingBox.right * scaleX,
            face.boundingBox.bottom * scaleY,
          ),
          paint);
    }
  }

  @override
  bool shouldRepaint(FaceDetectorPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.faces != faces;
  }
}
*/

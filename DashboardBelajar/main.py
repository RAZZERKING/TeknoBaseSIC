# This Python file uses the following encoding: utf-8
import sys
from pathlib import Path

from PySide2.QtCore import QObject, QStringListModel, Slot
from PySide2.QtGui import QGuiApplication, QFontDatabase
from PySide2.QtQml import QQmlApplicationEngine

import os
import json
import uuid

from button_led_control_firdijs import start, selesai_belajar

class Bridge(QObject):
  @Slot(result=bool)
  def closeApp(self):
    QGuiApplication.exit()
    return True

  @Slot(result=bool)
  def shutdown(self):
    os.system('sudo shutdown -P 0')
    return True

  @Slot(result=list)
  def getJadwal(self):
    with open('data.json', 'r') as reader:
      data = json.loads(reader.read())
    return data

  @Slot(int,int,int,result=bool)
  def addJadwal(self, hour, minute, berapaLama):
    with open('data.json', 'r') as reader:
      data = json.loads(reader.read())
      print(data)
      data.append({ 'id': str(uuid.uuid4()), 'jam': str(hour), 'menit': str(minute), 'berapaLama': str(berapaLama) })
    with open('data.json', 'w') as writer:
      writer.write(json.dumps(data))

    return True

  @Slot(int,result=bool)
  def removeJadwal(self, index):
    with open('data.json', 'r') as reader:
      data = json.loads(reader.read())
      del data[index]
    with open('data.json', 'w') as writer:
      writer.write(json.dumps(data))

    return True

  @Slot(int,result=bool)
  def startBeep(self, duration):
    start(duration)

    return True

  @Slot(int,result=bool)
  def selesaiBelajarBeep(self):
    selesai_belajar()

    return True



if __name__ == "__main__":
    os.environ["QT_IM_MODULE"] = "qtvirtualkeyboard"
    os.environ["QML_XHR_ALLOW_FILE_READ"] = "1"

    app = QGuiApplication(sys.argv)


    QFontDatabase.addApplicationFont("font/Inter-Regular.ttf")
    QFontDatabase.addApplicationFont("font/Inter-Light.ttf")
    QFontDatabase.addApplicationFont("font/Inter-SemiBold.ttf")

    engine = QQmlApplicationEngine()

    bridge = Bridge()
    context = engine.rootContext()
    context.setContextProperty("backend", bridge)

    qml_file = Path(__file__).resolve().parent / "main.qml"
    engine.load("content/main.qml")
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())





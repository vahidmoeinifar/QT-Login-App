TEMPLATE = app

QT += qml quick sql

CONFIG += c++11

SOURCES += main.cpp \
    db.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

DISTFILES += \
    System/Data/SQLite/Installer.exe \
    System/Data/SQLite/Installer.pdb \
    System/Data/SQLite/SQLite.Designer.dll \
    System/Data/SQLite/SQLite.Designer.pdb \
    System/Data/SQLite/SQLite.Designer.xml \
    System/Data/SQLite/System.Data.SQLite.dll \
    System/Data/SQLite/System.Data.SQLite.pdb \
    System/Data/SQLite/System.Data.SQLite.xml \
    System/Data/SQLite/test.exe \
    System/Data/SQLite/test.pdb \


FORMS +=




HEADERS += \
    db.h

CONFIG += qmltypes
QML_IMPORT_NAME = backend
QML_IMPORT_MAJOR_VERSION = 1

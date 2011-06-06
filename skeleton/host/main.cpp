#include <QApplication>
#include <QDBusConnection>
#include <QDeclarativeContext>
#include <QUrl>

#include <QDebug>

#include "host.h"
#include "view.h"
#include "adaptor.h"

int main( int argc, char** argv ) {
    QApplication app( argc, argv ) ;

    view::View* view = new view::View() ;

    host::Host* host = new host::Host() ;

    host->setView( view ) ;

    view->rootContext()->setContextProperty( "host", host ) ;
    view->setSource( QUrl("view/root.qml") ) ;

    QDBusConnection::sessionBus().registerService( "me.inputmethod.host" ) ;
    QDBusConnection::sessionBus().registerObject( "/host", host ) ;

    QDBusConnection::sessionBus().connect( "", "", "inputmethod.context", "sendMessage", host->adaptor, SLOT(receiveMessage( const QString& )) ) ;
    QDBusConnection::sessionBus().connect( "", "", "inputmethod.context", "requestSoftwareInputPanel", host->adaptor, SLOT(show()) ) ;
    QDBusConnection::sessionBus().connect( "", "", "inputmethod.context", "closeSoftwareInputPanel", host->adaptor, SLOT(hide()) ) ;

    //qDebug() << QDBusConnection::sessionBus().isConnected() ;

    return app.exec() ;
}

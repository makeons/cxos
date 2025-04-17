#include "browserwindow.h"
#include <QWebEngineView>
#include <QWebEnginePage>
#include <QPushButton>
#include <QVBoxLayout>
#include <QLineEdit>
#include <QUrl>

BrowserWindow::BrowserWindow(QWidget* parent)
    : QMainWindow(parent)
{
    // Web Engine View olu�turuluyor
    view = new QWebEngineView(this);
    view->setUrl(QUrl("https://www.example.com"));

    // URL �ubu�u olu�turuluyor
    urlBar = new QLineEdit(this);
    urlBar->setPlaceholderText("Enter URL");

    // Git butonu olu�turuluyor
    goButton = new QPushButton("Go", this);

    // Layout olu�turuluyor
    QVBoxLayout* layout = new QVBoxLayout;
    layout->addWidget(urlBar);
    layout->addWidget(goButton);
    layout->addWidget(view);

    // Ana pencere widget'�n� yerle�tiriyoruz
    QWidget* container = new QWidget;
    container->setLayout(layout);
    setCentralWidget(container);

    // Go butonuna t�klan�ld���nda sayfa y�kleme
    connect(goButton, &QPushButton::clicked, this, &BrowserWindow::loadPage);
}

BrowserWindow::~BrowserWindow() {}

void BrowserWindow::loadPage()
{
    // URL'yi al�p sayfay� y�kl�yoruz
    QString url = urlBar->text();
    view->setUrl(QUrl(url));
}

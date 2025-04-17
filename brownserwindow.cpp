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
    // Web Engine View oluþturuluyor
    view = new QWebEngineView(this);
    view->setUrl(QUrl("https://www.example.com"));

    // URL çubuðu oluþturuluyor
    urlBar = new QLineEdit(this);
    urlBar->setPlaceholderText("Enter URL");

    // Git butonu oluþturuluyor
    goButton = new QPushButton("Go", this);

    // Layout oluþturuluyor
    QVBoxLayout* layout = new QVBoxLayout;
    layout->addWidget(urlBar);
    layout->addWidget(goButton);
    layout->addWidget(view);

    // Ana pencere widget'ýný yerleþtiriyoruz
    QWidget* container = new QWidget;
    container->setLayout(layout);
    setCentralWidget(container);

    // Go butonuna týklanýldýðýnda sayfa yükleme
    connect(goButton, &QPushButton::clicked, this, &BrowserWindow::loadPage);
}

BrowserWindow::~BrowserWindow() {}

void BrowserWindow::loadPage()
{
    // URL'yi alýp sayfayý yüklüyoruz
    QString url = urlBar->text();
    view->setUrl(QUrl(url));
}

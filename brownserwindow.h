#ifndef BROWSERWINDOW_H
#define BROWSERWINDOW_H

#include <QMainWindow>
#include <QWebEngineView>
#include <QLineEdit>
#include <QPushButton>
#include <QVBoxLayout>

class BrowserWindow : public QMainWindow
{
    Q_OBJECT

public:
    BrowserWindow(QWidget* parent = nullptr);
    ~BrowserWindow();

private slots:
    void loadPage();

private:
    QWebEngineView* view;          // Web sayfas�n� g�r�nt�leyecek olan View
    QLineEdit* urlBar;            // URL �ubu�u
    QPushButton* goButton;        // Git butonu
};

#endif // BROWSERWINDOW_H


#include <QApplication>
#include <QComboBox>
#include <QPushButton>
#include <QVBoxLayout>
#include <QWidget>

int main(int argc, char* argv[]) {
    QApplication app(argc, argv);

    QWidget window;
    QVBoxLayout* layout = new QVBoxLayout(&window);

    QComboBox* appComboBox = new QComboBox(&window);
    appComboBox->addItem("Browser");
    appComboBox->addItem("Terminal");
    appComboBox->addItem("File Manager");

    QPushButton* launchButton = new QPushButton("Launch", &window);

    layout->addWidget(appComboBox);
    layout->addWidget(launchButton);

    QObject::connect(launchButton, &QPushButton::clicked, [&]() {
        QString selectedApp = appComboBox->currentText();
        if (selectedApp == "Browser") {
            system("firefox &");
        }
        else if (selectedApp == "Terminal") {
            system("gnome-terminal &");
        }
        else if (selectedApp == "File Manager") {
            system("nautilus &");
        }
        });

    window.setLayout(layout);
    window.show();

    return app.exec();
}

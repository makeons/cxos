#include <QApplication>
#include <QWidget>
#include <QLabel>
#include <QVBoxLayout>

int main(int argc, char* argv[]) {
    QApplication app(argc, argv);

    QWidget window;
    QVBoxLayout* layout = new QVBoxLayout(&window);
    QLabel* label = new QLabel("CXPanel - Taskbar", &window);

    layout->addWidget(label);
    window.setLayout(layout);
    window.show();

    return app.exec();
}

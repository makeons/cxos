#include <QApplication>
#include <QFileSystemModel>
#include <QTreeView>
#include <QWidget>
#include <QVBoxLayout>

int main(int argc, char* argv[]) {
    QApplication app(argc, argv);

    QWidget window;
    QVBoxLayout* layout = new QVBoxLayout(&window);

    QFileSystemModel* model = new QFileSystemModel;
    model->setRootPath(QDir::rootPath());

    QTreeView* treeView = new QTreeView(&window);
    treeView->setModel(model);
    treeView->setRootIndex(model->index(QDir::rootPath()));

    layout->addWidget(treeView);
    window.setLayout(layout);

    window.show();
    return app.exec();
}

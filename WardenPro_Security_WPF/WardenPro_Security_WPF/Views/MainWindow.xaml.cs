using System.Windows;

namespace WardenPro_Security_WPF.Views
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            pageContainer.Navigate(new AuthPage());
        }
    }
}

using System.Windows;
using System.Windows.Controls;

namespace WardenPro_VisitRequest_WPF.Views
{
    /// <summary>
    /// Логика взаимодействия для MenuPage.xaml
    /// </summary>
    public partial class MenuPage : Page
    {
        public MenuPage()
        {
            InitializeComponent();
        }

        private void ToPersonalRequest_Click(object sender, RoutedEventArgs e)
        {
            this.NavigationService.Navigate(new PersonalRequestPage());
        }

        private void ToGroupRequest_Click(object sender, RoutedEventArgs e)
        {
            this.NavigationService.Navigate(new GroupRequestPage());
        }

        private void ToRegPage_Click(object sender, RoutedEventArgs e)
        {
            this.NavigationService.Navigate(new RegPage());
        }
    }
}

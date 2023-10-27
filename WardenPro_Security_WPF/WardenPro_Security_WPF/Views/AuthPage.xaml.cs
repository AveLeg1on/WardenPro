using System;
using System.IO;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using WardenPro_Security_WPF.Models;
using WardenPro_Security_WPF.Services;

namespace WardenPro_Security_WPF.Views
{
    /// <summary>
    /// Логика взаимодействия для AuthPage.xaml
    /// </summary>
    public partial class AuthPage : Page
    {
        public AuthPage()
        {
            InitializeComponent();
        }

        private void Auth_Click(object sender, RoutedEventArgs e)
        {
            if (!int.TryParse(txtAuthCode.Text, out _))
            {
                MessageBox.Show("Код должен быть целым числом", "Хранитель ПРО - ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            try
            {
                ApiService.Get<WorkerModel>("Account/WorkerLogin/" + txtAuthCode.Text);
                MessageBox.Show("Добро пожаловать!", "Хранитель ПРО - сообщение", MessageBoxButton.OK, MessageBoxImage.Information);
                this.NavigationService.Navigate(new VisitRequestPage());
            }
            catch (WebException ex)
            {
                if (ex.Response != null)
                {
                    if (ex.Response is HttpWebResponse httpWebResponse)
                    {
                        if (httpWebResponse.StatusCode == HttpStatusCode.NotFound)
                        {
                            MessageBox.Show("Сотрудник не найден", "Хранитель ПРО - ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                            return;
                        }

                        using (StreamReader reader = new StreamReader(ex.Response.GetResponseStream()))
                        {
                            MessageBox.Show(reader.ReadToEnd(), "Хранитель ПРО - ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                        }
                    }
                }
                else
                    MessageBox.Show(ex.Message, "Хранитель ПРО - ошибка", MessageBoxButton.OK, MessageBoxImage.Error);

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Хранитель ПРО - ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }
    }
}

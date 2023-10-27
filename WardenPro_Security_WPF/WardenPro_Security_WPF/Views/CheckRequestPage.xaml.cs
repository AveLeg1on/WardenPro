using System;
using System.IO;
using System.Linq;
using System.Media;
using System.Net;
using System.Runtime.Remoting.Messaging;
using System.Windows;
using WardenPro_Security_WPF.Models;
using WardenPro_Security_WPF.Services;

namespace WardenPro_Security_WPF.Views
{
    /// <summary>
    /// Логика взаимодействия для CheckRequestPage.xaml
    /// </summary>
    public partial class CheckRequestPage : Window
    {
        private VisitRequestModel _model;

        public CheckRequestPage(VisitRequestModel model)
        {
            InitializeComponent();
            _model = model;
           
            rbRejected.IsEnabled = model.ArrivedSecurityDate == null;
            rbAccepted.IsChecked = model.ArrivedSecurityDate != null;

            txtDateArrived.IsEnabled = model.ArrivedSecurityDate == null;
            txtDateLeft.IsEnabled = model.LeftSecurityDate == null;
            btnSave.IsEnabled = model.ArrivedSecurityDate == null || model.LeftSecurityDate == null;
            if (model.ArrivedSecurityDate == null)
            {
                model.ArrivedSecurityDate = DateTime.Now;
            }
            else
            {
                if (model.LeftSecurityDate == null)
                {
                    model.LeftSecurityDate = DateTime.Now;
                }
            }

            if (model.VisitDate == null)
            {
                model.VisitDate = DateTime.Now.Date.AddDays(1).AddHours(12);
            }
            this.DataContext = model;

        }

        private void Cancel_Click(object sender, RoutedEventArgs e)
        {
            if (txtDateArrived.IsEnabled) _model.ArrivedSecurityDate = null;
            if (txtDateLeft.IsEnabled) _model.LeftSecurityDate = null;
            this.Close();
        }

        private void Save_Click(object sender, RoutedEventArgs e)
        {
            if (rbAccepted.IsChecked != true)
            {
                MessageBox.Show("Дайте доступ на территорию, чтобы открыть турникет", "Хранитель ПРО - ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            SystemSounds.Beep.Play();

            try
            {
                ApiService.Put("VisitRequest", _model);
                MessageBox.Show("Успешно сохранено!", "Хранитель ПРО - сообщение", MessageBoxButton.OK, MessageBoxImage.Information);
                this.Close();
            }
            catch (WebException ex)
            {
                if (ex.Response != null)
                {
                    if (ex.Response is HttpWebResponse httpWebResponse)
                    {
                        if (httpWebResponse.StatusCode == HttpStatusCode.NotFound)
                        {
                            MessageBox.Show("Данные по заявке не найдены", "Хранитель ПРО - ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
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

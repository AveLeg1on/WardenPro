using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.IO;
using System.Net;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using WardenPro_VisitRequest_WPF.Models;
using WardenPro_VisitRequest_WPF.Services;

namespace WardenPro_VisitRequest_WPF.Views
{
    /// <summary>
    /// Логика взаимодействия для PersonalRequestPage.xaml
    /// </summary>
    public partial class PersonalRequestPage : Page
    {
        public PersonalRequestPage()
        {
            InitializeComponent();

            ClearForm();
            birthDatePicker.DisplayDateEnd = DateTime.Now.AddYears(-16);

            try
            {
                cmbDivisions.ItemsSource = ApiService.Get<List<WorkerDivisionModel>>("Divisions/WorkerDivisions");
            }
            catch (WebException ex)
            {
                if (ex.Response != null)
                {
                    if (ex.Response is HttpWebResponse httpWebResponse)
                    {
                        if (httpWebResponse.StatusCode == HttpStatusCode.NotFound)
                        {
                            MessageBox.Show("Данные не найдены", "Хранитель ПРО - ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
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

        private void ClearForm()
        {
            VisitRequest = new VisitRequestModel()
            {
                DesiredDateStart = DateTime.Now.AddDays(1),
                DesiredDateEnd = DateTime.Now.AddDays(16),
                TypeId = 1,
                Visitors = new List<VisitorModel>()
                {
                    new VisitorModel()
                }
            };

            this.DataContext = VisitRequest;
        }

        public VisitRequestModel VisitRequest { get; set; }
        private void DatePicker_SelectedDateChanged(object sender, SelectionChangedEventArgs e)
        {
            endDatePicker.DisplayDateEnd = VisitRequest.DesiredDateStart.Value.AddDays(15);
            endDatePicker.DisplayDateStart = VisitRequest.DesiredDateStart.Value.AddDays(1);
        }


        private void Cancel_Click(object sender, RoutedEventArgs e)
        {
            this.NavigationService.GoBack();
        }

        private void ClearForm_Click(object sender, RoutedEventArgs e)
        {
            ClearForm();
        }

        private void Save_Click(object sender, RoutedEventArgs e)
        {

            VisitRequestModel model = VisitRequest;

            StringBuilder errors = new StringBuilder();


            if (string.IsNullOrWhiteSpace(model.Purpose))
                errors.AppendLine("Укажите цель визита");

            if (model.Worker == null)
                errors.AppendLine("Сотрудник принимающей стороны не найден");

            if (model.DesiredDateStart == null || model.DesiredDateStart < DateTime.Now.Date || model.DesiredDateStart > DateTime.Now.AddDays(15))
                errors.AppendLine("Неверная желеаемая дата начала действия пропуска");
            if (model.DesiredDateEnd == null || model.DesiredDateEnd < model.DesiredDateStart || model.DesiredDateEnd > model.DesiredDateStart.Value.AddDays(15))
                errors.AppendLine("Неверная желеаемая дата окончания действия пропуска");


            VisitorModel visitor = model.Visitors[0];

            if (string.IsNullOrWhiteSpace(visitor.Firstname))
                errors.AppendLine("Укажите Фамилию");

            if (string.IsNullOrWhiteSpace(visitor.Middlename))
                errors.AppendLine("Укажите Имя");

            if (string.IsNullOrWhiteSpace(visitor.Email))
                errors.AppendLine("Укажите почту");
            else
            {
                if (!new EmailAddressAttribute().IsValid(visitor.Email))
                    errors.AppendLine("Некорректный формат почты");
            }


            if (visitor.PassportNumber < 100000 || visitor.PassportNumber > 999999)
                errors.AppendLine("Укажите номер паспорта");
            if (visitor.PassportSerial < 1000 || visitor.PassportSerial > 9999)
                errors.AppendLine("Укажите серию паспорта");

            if (visitor.DateBirth == null || visitor.DateBirth > DateTime.Now.AddYears(-16))
                errors.AppendLine("Укажите дату рождения гражданина старше 16 лет");

            if (string.IsNullOrWhiteSpace(visitor.Note))
                errors.AppendLine("Укажите примечание");


            if (errors.Length > 0)
            {
                MessageBox.Show(errors.ToString(), "Хранитель ПРО - ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            //VisitRequest.RejectReason = string.Empty;
            try
            {
                ApiService.Post("VisitRequest", VisitRequest);
                MessageBox.Show("Успешно сохранено", "Хранитель ПРО - сообщение", MessageBoxButton.OK, MessageBoxImage.Information);
                this.NavigationService.GoBack();

            }
            catch (WebException ex)
            {
                if (ex.Response != null)
                {
                    if (ex.Response is HttpWebResponse httpWebResponse)
                    {
                        if (httpWebResponse.StatusCode == HttpStatusCode.NotFound)
                        {
                            MessageBox.Show("Данные не найдены", "Хранитель ПРО - ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
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

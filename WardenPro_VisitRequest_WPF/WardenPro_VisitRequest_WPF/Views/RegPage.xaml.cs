using System;
using System.ComponentModel.DataAnnotations;
using System.IO;
using System.Linq;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using WardenPro_VisitRequest_WPF.Models;
using WardenPro_VisitRequest_WPF.Services;

namespace WardenPro_VisitRequest_WPF.Views
{
    /// <summary>
    /// Логика взаимодействия для RegPage.xaml
    /// </summary>
    public partial class RegPage : Page
    {
        public RegPage()
        {
            InitializeComponent();
            birthDatePicker.DisplayDateEnd = DateTime.Now.AddYears(-16);
            this.DataContext = new VisitorModel();

        }

        private void Cancel_Click(object sender, RoutedEventArgs e)
        {
            this.NavigationService.GoBack();
        }

        private void Reg_Click(object sender, RoutedEventArgs e)
        {
            var model = this.DataContext as VisitorModel;
            model.Password = txtPassword.Text;

            StringBuilder errors = new StringBuilder();

            if (string.IsNullOrWhiteSpace(model.Firstname))
                errors.AppendLine("Укажите Фамилию");

            if (string.IsNullOrWhiteSpace(model.Middlename))
                errors.AppendLine("Укажите Имя");

            if (string.IsNullOrWhiteSpace(model.Email))
                errors.AppendLine("Укажите почту");
            else
            {
                if (!new EmailAddressAttribute().IsValid(model.Email))
                    errors.AppendLine("Некорректный формат почты");
            }
            if (model.DateBirth == null || model.DateBirth > DateTime.Now.AddYears(-16))
                errors.AppendLine("Укажите дату рождения гражданина старше 16 лет");


            if (string.IsNullOrWhiteSpace(model.Password))
                errors.AppendLine("Укажите пароль");
            else
            {
                string password = model.Password;
                if (password.Length < 8)
                    errors.AppendLine("Пароль должен содержать более 8 символов");
                if (!password.Any(char.IsDigit))
                    errors.AppendLine("Пароль должен содержать цифры");
                if (!password.Any(char.IsLower) || !password.Any(char.IsUpper))
                    errors.AppendLine("Пароль должен содержать буквы верхнего и нижнего регистра");
                char[] chars = "!@#$%^&*()_+{}|:<>?,./;'][=-'".ToCharArray();
                if (password.Intersect(chars).Count() == 0)
                    errors.AppendLine("Пароль должен содержать спецсимволы");
            }

            if (model.PassportNumber < 100000 || model.PassportNumber > 999999)
                errors.AppendLine("Укажите номер паспорта");
            if (model.PassportSerial < 1000 || model.PassportSerial > 9999)
                errors.AppendLine("Укажите серию паспорта");


            if (string.IsNullOrWhiteSpace(model.Note))
                errors.AppendLine("Укажите примечание");
            if (errors.Length > 0)
            {
                MessageBox.Show(errors.ToString(), "Хранитель ПРО - ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }
            using (MD5CryptoServiceProvider  md5 = new MD5CryptoServiceProvider())
            {
                var bytes = Encoding.Unicode.GetBytes(model.Password);
                bytes = md5.ComputeHash(bytes);
                model.Password = Encoding.Unicode.GetString(bytes);
            }

           

            try
            {
                ApiService.Post("Account/RegVisitor", model);
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

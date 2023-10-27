using System.Collections.Generic;
using System.IO;
using System;
using System.Linq;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using WardenPro_GenDep_WPF.Models;
using WardenPro_GenDep_WPF.Services;

namespace WardenPro_GenDep_WPF.Views
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
            if (model.Visitors.Any(p => p.IsVisitorInBlackList))
            {
                MessageBox.Show("Один или несколько посетителей находятся в черном списке. Заявка автоматически отклонена", "Хранитель ПРО - сообщение", MessageBoxButton.OK, MessageBoxImage.Error);
                model.IsApproved = false;
                model.RejectReason = "Заявка на посещение объекта КИИ отклонена в связи с нарушением Федерального закона от 26.07.2017 № 187 - ФЗ «О безопасности критической информационной инфраструктуры Российской Федерации»";

                try
                {
                    ApiService.Put("VisitRequest", model);
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
            rbAccepted.IsChecked = model.IsApproved;
            rbRejected.IsChecked = !model.IsApproved;

            if (model.VisitDate != null && model.VisitDate < DateTime.Now)
            {
                rbAccepted.IsEnabled = false;
                rbRejected.IsEnabled = false;
            }

            if (model.VisitDate == null)
            {
                model.VisitDate = DateTime.Now.Date.AddDays(1).AddHours(12);
            }
            this.DataContext = model;

        }

        private void Cancel_Click(object sender, RoutedEventArgs e)
        {
            if (!_model.IsApproved)
                _model.VisitDate = null;
            this.Close();
        }

        private void Save_Click(object sender, RoutedEventArgs e)
        {
            if (rbAccepted.IsChecked == true)
            {
                _model.IsApproved = true;
                _model.RejectReason = "одобрена";
            }
            else
            {
                _model.IsApproved = false;
                _model.VisitDate = null;
                _model.RejectReason = "“Заявка на посещение объекта КИИ отклонена в связи с нарушением Федерального закона от 26.07.2017 № 194-ФЗ «О внесении изменений в Уголовный кодекс Российской Федерации и статью 151 Уголовно-процессуального кодекса Российской Федерации в связи с принятием Федерального закона \"О безопасности критической информационной инфраструктуры Российской Федерации\" по причине указания заявителем заведомо недостоверных данных”";
            }

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

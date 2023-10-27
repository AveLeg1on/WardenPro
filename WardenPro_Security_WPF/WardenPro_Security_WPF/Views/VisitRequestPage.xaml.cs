using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using WardenPro_Security_WPF.Models;
using WardenPro_Security_WPF.Services;

namespace WardenPro_Security_WPF.Views
{
    /// <summary>
    /// Логика взаимодействия для VisitRequestPage.xaml
    /// </summary>
    public partial class VisitRequestPage : Page
    {
        private List<VisitRequestModel> _visitRequests;

        public VisitRequestPage()
        {
            InitializeComponent();

            try
            {
                _visitRequests = ApiService.Get<List<VisitRequestModel>>("VisitRequest").Where(p => p.IsApproved).ToList();
                listview.ItemsSource = _visitRequests;
                cmbDivison.ItemsSource = _visitRequests.Select(p => p.Worker.Division).Distinct();
            }
            catch (WebException ex)
            {
                if (ex.Response != null)
                {
                    if (ex.Response is HttpWebResponse httpWebResponse)
                    {
                        if (httpWebResponse.StatusCode == HttpStatusCode.NotFound)
                        {
                            MessageBox.Show("Данные по заявкам не найдены", "Хранитель ПРО - ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
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

        private void CheckRequest_Click(object sender, RoutedEventArgs e)
        {
            var model = ((Button)sender).DataContext as VisitRequestModel;
            var window = new CheckRequestPage(model);
            window.ShowDialog();
            listview.Items.Refresh();
        }

        private void CmbType_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (cmbType.SelectedItem == null) return;

            var item = cmbType.SelectedItem as ComboBoxItem;

            switch (item.Content.ToString())
            {
                case "Личное посещение":
                    listview.ItemsSource = _visitRequests.Where(p => p.TypeId == 1).ToList();
                    break;
                case "Групповое посещение":
                    listview.ItemsSource = _visitRequests.Where(p => p.TypeId == 2).ToList();
                    break;
            }
        }

        private void CmbDivison_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (cmbDivison.SelectedItem == null) return;
            var item = cmbDivison.SelectedItem.ToString();
            listview.ItemsSource = _visitRequests.Where(p => p.Worker.Division == item).ToList();
        }

       
        private void ResetFilters_Click(object sender, RoutedEventArgs e)
        {
            cmbDivison.SelectedItem = null;
            datepickerFilter.SelectedDate = null;
            cmbType.SelectedItem = null;
            txtFind.Text = null;
            listview.ItemsSource = _visitRequests;
        }

        private void DatepickerFilter_SelectedDateChanged(object sender, SelectionChangedEventArgs e)
        {
            if (datepickerFilter.SelectedDate == null) return;

            listview.ItemsSource = _visitRequests.Where(p => p.VisitDate.Value.Date == datepickerFilter.SelectedDate).ToList();
        }

        private void TxtFind_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (txtFind.Text == null) return;
            listview.ItemsSource = _visitRequests.Where(
                p => p.Visitors.Any(
                    v =>
                    v.Firstname.Contains(txtFind.Text) ||
                    v.Middlename.Contains(txtFind.Text) ||
                    (v.PassportNumber.ToString() + v.PassportSerial.ToString()).Contains(txtFind.Text)));
        }
    }
}

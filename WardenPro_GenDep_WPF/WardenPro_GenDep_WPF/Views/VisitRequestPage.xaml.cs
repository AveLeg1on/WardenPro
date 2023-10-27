using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using WardenPro_GenDep_WPF.Models;
using WardenPro_GenDep_WPF.Services;

namespace WardenPro_GenDep_WPF.Views
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
                _visitRequests = ApiService.Get<List<VisitRequestModel>>("VisitRequest");
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

        private void CmbStatus_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (cmbStatus.SelectedItem == null) return;

            var item = cmbStatus.SelectedItem as ComboBoxItem;

            switch (item.Content.ToString())
            {
                case "Одобрена":
                    listview.ItemsSource = _visitRequests.Where(p => p.IsApproved).ToList();
                    break;
                case "На рассмотрении":
                    listview.ItemsSource = _visitRequests.Where(p => !p.IsApproved && p.RejectReason == "на рассмотрении").ToList();
                    break;
                case "Отклонена":
                    listview.ItemsSource = _visitRequests.Where(p => !p.IsApproved && p.RejectReason != "на рассмотрении").ToList();
                    break;
            }
        }

        private void ResetFilters_Click(object sender, RoutedEventArgs e)
        {
            cmbDivison.SelectedItem = null;
            cmbStatus.SelectedItem = null;
            cmbType.SelectedItem = null;
            listview.ItemsSource = _visitRequests;
        }
    }
}

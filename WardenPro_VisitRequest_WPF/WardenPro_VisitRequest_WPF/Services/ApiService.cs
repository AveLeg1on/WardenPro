using Newtonsoft.Json;
using System.Net;
using System.Text;

namespace WardenPro_VisitRequest_WPF.Services
{
    public static class ApiService
    {

        private const string _apiPrefix = "http://localhost:53267/api/";

        public static T Get<T>(string method)
        {
            WebClient client = new WebClient();
            client.Encoding = Encoding.UTF8;
            string json = client.DownloadString(_apiPrefix + method);
            return JsonConvert.DeserializeObject<T>(json);
        }

        public static string Post<T>(string method, T body)
        {
            WebClient client = new WebClient();
            client.Encoding = Encoding.UTF8;
            client.Headers.Add("Content-Type", "application/json");
            string json = JsonConvert.SerializeObject(body);
            return client.UploadString(_apiPrefix + method, "POST", json);
        }
    }
}

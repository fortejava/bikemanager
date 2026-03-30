<%@ WebHandler Language="C#" Class="GetWorkers" %>

using System;
using System.Web;
using System.Linq;
using System.Collections.Generic;
using DBEngine;
using Newtonsoft.Json;

public class GetWorkers : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";

        string name = context.Request["name"].ToString();

        DBEngine.DBEngine connection = new DBEngine.DBEngine();

        //Estraiamo i membri dello staff
        var workers = connection.staffs
                .Where(el => el.first_name.Contains(name) )
                .Select(el => new { el.first_name, el.last_name, el.phone })
                .ToList();
        

        //Serializziamo in Json i risultati della query
        string output = JsonConvert.SerializeObject(workers);

        context.Response.Write(output);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}
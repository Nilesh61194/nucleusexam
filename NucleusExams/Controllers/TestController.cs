using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using NucleusExams.Models;
namespace NucleusExams.Controllers
{
    public class TestController : Controller
    {
        // GET: Paper
        
        public ActionResult Index(decimal examid)
        {
            using (dbEntities entities = new dbEntities())
            {
                var objQue = entities.EA_QuestionMaster.Where(e => e.ExamID == examid).ToList();
                return View(objQue);
            }
        }
    }
}
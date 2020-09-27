using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using NucleusExams.Models;
using System.Web.Http.Results;
using System.Data;
using System.Reflection;
using Newtonsoft.Json;
using System.Data.Entity;

namespace NucleusExams.Controllers
{
    [RoutePrefix("api/Question")]
    public class QuestionController : ApiController
    {
        [HttpPost]
        [Route("InsertQuestion")]
        public int InsertQuestion(QuestionClass Que)
        {
            try
            {
                using (var context = new dbEntities())
                {
                    EA_QuestionMaster obj = new EA_QuestionMaster()
                    {
                        ExamID = Que.ExamID,
                        QuestionMarks = Que.QuestionMarks,
                        QuestionType = Que.QuestionType,
                        EntryBy = Que.StaffID,
                        Question = Que.Question,
                        EntryDate = System.DateTime.Now
                    };

                    context.EA_QuestionMaster.Add(obj);
                    context.SaveChanges();

                    return obj.QuestionID;
                }

            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return 0;
            }
        }

        [HttpPost]
        [Route("UpdateQuestion")]
        public bool UpdateQuestion(QuestionClass Que)
        {
            try
            {
                using (var context = new dbEntities())
                {
                    var Question = context.EA_QuestionMaster.FirstOrDefault(q => q.QuestionID == Que.QuestionID);

                    if (Question != null)
                    {
                        Question.ExamID = Que.ExamID;
                        Question.QuestionMarks = Que.QuestionMarks;
                        Question.QuestionType = Que.QuestionType;
                        Question.UpdatedBy = Que.StaffID;
                        Question.Question = Que.Question;
                        Question.UpdatedDate = System.DateTime.Now;
                        context.SaveChanges();

                        return true;
                    }
                    else
                    {
                        return false;
                    }


                }

            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return false;
            }
        }


        [HttpPost]
        [Route("InsertOptions")]
        public int InsertOptions(List<EA_OptionMaster> options)
        {
            using (dbEntities entities = new dbEntities())
            {

                //Check for NULL.
                if (options == null)
                {
                    options = new List<EA_OptionMaster>();
                }

                //Loop and insert records.
                foreach (EA_OptionMaster option in options)
                {
                    entities.EA_OptionMaster.Add(option);
                }
                int insertedRecords = entities.SaveChanges();

                return insertedRecords;


            }
        }


        [HttpPost]
        [Route("DeleteQuestion")]
        public bool DeleteQuestion(int id)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    var que = entities.EA_QuestionMaster.FirstOrDefault(q => q.QuestionID == id);
                    if (que != null)
                    {
                        entities.EA_QuestionMaster.Remove(que);
                        entities.SaveChanges();
                        return true;

                    }
                    return false;
                }
            }
            catch (Exception ex)
            {

                string msg = ex.Message;
                return false;
            }
        }



        [HttpGet]
        [Route("GetOptionValuesByQuestionID")]

        public IHttpActionResult GetOptionValuesByQuestionID(int QuestionID)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    var que = entities.EA_OptionMaster.Where(e => e.QuestionID == QuestionID);
                    string json = JsonConvert.SerializeObject(que);
                    return Ok(json);
                }
            }
            catch (Exception ex)
            {

                string msg = ex.Message;
                return null;
            }
        }


        [HttpPost]
        [Route("GetQuestionDetailsByID")]
        public DataTable GetQuestionDetailsByID(int id)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    var que = entities.EA_QuestionMaster.Where(e => e.QuestionID == id).ToList<EA_QuestionMaster>();
                    return ToDataTable(que);
                }
            }
            catch (Exception ex)
            {

                string msg = ex.Message;
                return null;
            }
        }

        [HttpPost]
        [Route("UpdateQuestion")]
        public int UpdateQuestion(int id, QuestionClass Que)
        {
            try
            {
                using (var context = new dbEntities())
                {
                    var Question = context.EA_QuestionMaster.FirstOrDefault(e => e.QuestionID == id);

                    if (Question != null)
                    {
                        Question.QuestionMarks = Que.QuestionMarks;
                        Question.QuestionType = Que.QuestionType;
                        Question.EntryBy = Que.StaffID;
                        Question.Question = Que.Question;
                        Question.EntryDate = System.DateTime.Now;
                    }

                    return context.SaveChanges();
                }

            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return 0;
            }
        }


        [HttpPost]
        [Route("UpdateOption")]
        public int UpdateOption(OptionMaster Option)
        {
            try
            {
                using (var context = new dbEntities())
                {
                    var option = context.EA_OptionMaster.FirstOrDefault(e => e.OptionID == Option.OptionID);

                    if (option != null)
                    {
                        option.ExamID = Option.ExamID;
                        option.OptionValue = Option.OptionValue;
                        option.IsRightAnswer = Option.IsRightAnswer;
                        option.UpdatedBy = Option.EntryBy;
                        option.QuestionID = Option.QuestionID;
                        option.UpdatedDate = System.DateTime.Now;
                    }

                    return context.SaveChanges();
                }

            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return 0;
            }
        }


        [HttpPost]
        [Route("DeleteOption")]
        public int DeleteOption(OptionMaster Option)
        {
            try
            {
                using (var context = new dbEntities())
                {
                    var option = context.EA_OptionMaster.FirstOrDefault(e => e.OptionID == Option.OptionID);

                    if (option != null)
                    {
                        context.EA_OptionMaster.Remove(option);
                    }

                    return context.SaveChanges();
                }

            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return 0;
            }
        }


        [HttpPost]
        [Route("DeleteOptionByID")]
        public int DeleteOptionByID(int ID)
        {
            try
            {
                using (var context = new dbEntities())
                {
                    var option = context.EA_OptionMaster.FirstOrDefault(e => e.OptionID == ID);

                    if (option != null)
                    {
                        context.EA_OptionMaster.Remove(option);
                    }

                    return context.SaveChanges();
                }

            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return 0;
            }
        }



        #region code for Collaborative
        [HttpPost]
        [Route("InsertCollaboratives")]
        public int InsertCollaboratives(List<EA_ExamRightsMaster> Collaboratives)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {

                    //Check for NULL.
                    if (Collaboratives == null)
                    {
                        Collaboratives = new List<EA_ExamRightsMaster>();
                    }

                    //Loop and insert records.
                    foreach (EA_ExamRightsMaster Collaborative in Collaboratives)
                    {
                        var data = entities.EA_ExamRightsMaster.FirstOrDefault(e => e.StaffID == Collaborative.StaffID && e.ExamID == Collaborative.ExamID);

                        if (data == null)
                            entities.EA_ExamRightsMaster.Add(Collaborative);
                    }
                    int insertedRecords = entities.SaveChanges();

                    return insertedRecords;
                }
            }
            catch (Exception)
            {
                return 0;
            }
        }

        [HttpGet]
        [Route("GetCollaborativeDetailsByExamID/")]
        public IHttpActionResult GetCollaborativeDetailsByExamID(decimal id)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    var q = (from WS in entities.WorkingStaffList
                             join EA in entities.EA_ExamRightsMaster on WS.StaffMasterID equals EA.StaffID
                             orderby WS.FullName
                             where EA.ExamID == id
                             select new
                             {
                                 WS.FullName,
                                 EA.IsEdit,
                                 EA.IsView,
                                 EA.Id,
                                 EA.StaffID

                             }).Distinct().ToList();

                    //(from EM in entities.EA_ExamMaster
                    // join AY in entities.AcademicYear
                    // on EM.AcademicYearID equals AY.AcademicYearID
                    // select new { AY.AcademicYearID, AY.AcademicYear1 }).Distinct().ToList();

                    string json = JsonConvert.SerializeObject(q);
                    return Ok(json);
                }
            }
            catch (Exception)
            {
                throw;
            }
        }


        [HttpPost]
        [Route("DeleteCollaborativeByID")]
        public int DeleteCollaborativeByID(EA_ExamRightsMaster OBJ)
        {
            try
            {
                using (var context = new dbEntities())
                {
                    var option = context.EA_ExamRightsMaster.FirstOrDefault(e => e.Id == OBJ.Id);

                    if (option != null)
                    {
                        context.EA_ExamRightsMaster.Remove(option);
                    }

                    return context.SaveChanges();
                }

            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return 0;
            }
        }


        [HttpPost]
        [Route("UpdateCollaborativeByID")]
        public int UpdateCollaborativeByID(EA_ExamRightsMaster Collaborative)
        {
            try
            {
                using (var context = new dbEntities())
                {
                    var collaborative = context.EA_ExamRightsMaster.FirstOrDefault(e => e.Id == Collaborative.Id);

                    if (collaborative != null)
                    {

                        collaborative.IsEdit = Collaborative.IsEdit;
                        collaborative.IsView = Collaborative.IsView;
                        collaborative.UpdateBy = Collaborative.UpdateBy;
                        collaborative.UpdateDate = System.DateTime.Now;
                        collaborative.ExamID = Collaborative.ExamID;
                    }

                    return context.SaveChanges();
                }

            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return 0;
            }
        }




        #endregion
        [HttpGet]
        [Route("ToDataTable")]
        public static DataTable ToDataTable<T>(List<T> items)
        {
            DataTable dataTable = new DataTable(typeof(T).Name);

            //Get all the properties
            PropertyInfo[] Props = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance);
            foreach (PropertyInfo prop in Props)
            {
                //Defining type of data column gives proper data table 
                var type = (prop.PropertyType.IsGenericType && prop.PropertyType.GetGenericTypeDefinition() == typeof(Nullable<>) ? Nullable.GetUnderlyingType(prop.PropertyType) : prop.PropertyType);
                //Setting column names as Property names
                dataTable.Columns.Add(prop.Name, type);
            }
            foreach (T item in items)
            {
                var values = new object[Props.Length];
                for (int i = 0; i < Props.Length; i++)
                {
                    //inserting property values to datatable rows
                    values[i] = Props[i].GetValue(item, null);
                }
                dataTable.Rows.Add(values);
            }
            //put a breakpoint here and check datatable
            return dataTable;
        }
    }
}

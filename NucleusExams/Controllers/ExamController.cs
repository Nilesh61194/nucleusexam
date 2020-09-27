using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using NucleusExams.Models;
using System.Data;
using System.Reflection;
using System.Web.Http.Results;
using System.Threading.Tasks;
using Newtonsoft.Json;
using System.Web.Script.Serialization;

namespace NucleusExams.Controllers
{


    [RoutePrefix("api/Exam")]
    public class ExamController : ApiController
    {

        #region Exam Create, Delete and Update Operation
        [HttpPost]
        [Route("insertExamMaster")]
        public bool insertExamMaster(ExamMaster Exm)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    int i = entities.ea_spiEA_ExamMaster(Exm.ExamName, Exm.GradeID, Exm.SubjectName, Exm.Duration, Exm.CreatedBy, Exm.ISExamCode, Exm.ExamCode, Exm.ExamDate, Exm.ExamURL);

                    if (i > 0)
                    {
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
        [Route("updateExamMaster")]
        public bool updateExamMaster(ExamMaster Exm)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    int i = entities.ea_spuEA_ExamMaster(Exm.ExamID, Exm.ExamName, Exm.GradeID, Exm.SubjectName, Exm.Duration, Exm.CreatedBy, Exm.ExamDate, Exm.ExamURL);


                    if (i > 0)
                    {
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

        public bool IsExamAssignToStudent(decimal StudentID, decimal ExamID)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    int i = (from es in entities.EA_StudentEnrollment
                             where es.StudentID == StudentID && es.ExamID == ExamID
                             select es).Count();

                    if (i > 0)
                    {
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

        public DataTable GetExamDetailsByStaffID(int StaffID, bool IsAdmin)
        {
            using (dbEntities entities = new dbEntities())
            {

                DataTable dt = new DataTable();
                return dt = ToDataTable(entities.ea_spgEA_ExamMasterByStaffID(StaffID, IsAdmin).ToList());

            }
        }
        public IEnumerable<Grade> GetGradeList()
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    return entities.Grade.ToList();
                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return null;
            }
        }


        public string getExamMaster()
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    return entities.ea_spgEA_ExamMaster().ToString();
                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return "";
            }
        }

        public bool deleteExamMaster(int ExamID)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    int i = entities.ea_spdEA_ExamMaster(ExamID);

                    if (i > 0)
                    {
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

        public bool updateExamStatus(decimal ExamID)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    bool status = Convert.ToBoolean(entities.EA_ExamMaster.Where(e => e.ExamID == ExamID).Select(e => e.ISActive).Single().Value);

                    if (status)
                    {
                        (from EAE in entities.EA_ExamMaster where EAE.ExamID == ExamID select EAE).ToList().ForEach(e => e.ISActive = false);
                        entities.SaveChanges();
                    }
                    else
                    {
                        (from EAE in entities.EA_ExamMaster where EAE.ExamID == ExamID select EAE).ToList().ForEach(e => e.ISActive = true);
                        entities.SaveChanges();
                    }

                }
                return true;
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return false;
            }
        }



        public DataTable GetExamByExamID(decimal ExamID)
        {
            DataTable dt = new DataTable();
            using (dbEntities entities = new dbEntities())
            {
                return dt = ToDataTable(entities.ea_spgEA_ExamMasterByExamID(ExamID).ToList());
                //return entities.ea_spgEA_ExamMasterByExamID(ExamID).ToList();
            }
        }



        public decimal getExamIdOfActiveExam(decimal GradeID)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    return Convert.ToDecimal(entities.EA_ExamMaster.Where(e => e.ISActive == true && e.GradeID == GradeID).Select(e => e.ExamID).Single());
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
        [Route("CheckEditRightsOnExambyExamIDStaffID")]
        public bool CheckEditRightsOnExambyExamIDStaffID(decimal ExamID, decimal CreatedBy)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    var data = entities.EA_ExamMaster.Where(e => e.CreatedBy == CreatedBy && e.ExamID == ExamID).FirstOrDefault();
                    if (data != null)
                    {
                        return true;
                    }
                    else
                    {
                        var Edit = entities.EA_ExamRightsMaster.Where(m => m.StaffID == CreatedBy && m.ExamID == ExamID && m.IsEdit == true).FirstOrDefault();
                        if (Edit != null)
                        {
                            return true;
                        }
                        else
                        {
                            return false;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return false;
            }
        }


        [HttpGet]
        [Route("GetAcademicYear")]
        public DataTable GetAcademicYearForExamMaster()
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    var result = (from EM in entities.EA_ExamMaster
                                  join AY in entities.AcademicYear
                                  on EM.AcademicYearID equals AY.AcademicYearID
                                  select new { AY.AcademicYearID, AY.AcademicYear1 }).Distinct().ToList();


                    return ToDataTable(result);
                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return null;
            }
        }

        [HttpGet]
        [Route("GetExamDetailByGradeID")]
        public DataTable GetExamDetailByGradeID(decimal GradeID, decimal AcademicYearID, decimal StaffID)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    var result = entities.ea_spgEA_ExamMasterByStaffIdGradeIdAcademicYearID(GradeID, AcademicYearID, StaffID).ToList();

                    return ToDataTable(result);
                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return null;
                // throw ex;
            }
        }

        [HttpGet]
        [Route("GetGradeDetailByAcademicYearID")]
        public DataTable GetGradeDetailByExamID(int AcademicYearID)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    var result = (from EM in entities.EA_ExamMaster
                                  join G in entities.Grade
                                  on EM.GradeID equals G.GradeID
                                  where EM.AcademicYearID == AcademicYearID
                                  select new { G.GradeID, G.GradeName }).Distinct().ToList();
                    return ToDataTable(result);
                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return null;
            }
        }

        [HttpGet]
        [Route("GetSectionByGradeID")]
        public DataTable GetSectionByGradeID(int GradeID)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    var result = (from GS in entities.GradeSectionMapping
                                  join S in entities.Section
                                  on GS.SectionID equals S.SectionID
                                  where GS.GradeID == GradeID
                                  select new { S.SectionID, S.SectionName }).Distinct().ToList();
                    return ToDataTable(result);
                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return null;
            }
        }

        [HttpGet]
        [Route("GetStudentDetailBySectionID")]
        public DataTable GetStudentDetailBySectionID(string SectionID)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    var result = entities.spgStudentCurrentGradeSectionDetailsBySectionID(SectionID).ToList();
                    return ToDataTable(result);
                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return null;
            }
        }

        [HttpPost]
        [Route("insertEA_StudentEnrollment")]
        public bool insertEA_StudentEnrollment(decimal StudentID, decimal ExamID, decimal StaffID)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    var result = entities.ea_spiEA_StudentEnrollment(StudentID, ExamID, StaffID);
                    if (result > 0)
                    {
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

        [HttpGet]
        [Route("getworkingstafflist")]
        public DataTable GetWorkingStaffList()
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    var result = entities.WorkingStaffList.Select(x => new { x.FullName, x.StaffMasterID }).ToList();
                    return ToDataTable(result);
                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return null;
            }
        }

        [HttpPost]
        [Route("insertEA_TeacherEnrollment")]
        public bool insertEA_TeacherEnrollment(decimal StaffID, decimal ExamID, decimal EntryBy)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    var result = entities.ea_spiEA_TeacherEnrollment(StaffID, ExamID, EntryBy);
                    if (result > 0)
                    {
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
        [Route("insertEA_ExamAnswerMaster")]
        public bool insertEA_ExamAnswerMaster(EA_ExamAnswerMaster EAM)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    if (string.IsNullOrEmpty(EAM.Answer.ToString()))
                    {
                        return true;
                    }
                    else
                    {

                        var result = entities.ea_spiEA_ExamAnswerMaster(EAM.QID, EAM.StudentID, EAM.Answer, EAM.ExamID);

                        if (result > 0)
                        {
                            return true;
                        }
                        else
                        {
                            return false;
                        }

                    }
                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return false;
            }
        }

        [HttpGet]
        [Route("getEA_ExamAnswerMasterByQuestionIDStudentIDExamID")]
        public DataTable getEA_ExamAnswerMasterByQuestionIDStudentIDExamID(decimal StudentID, decimal ExamID)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    var result = entities.ea_spgEA_ExamAnswerMasterByStudentIDExamID(StudentID, ExamID).ToList();
                    ///string result =  entities.EA_ExamAnswerMaster.Where(e => e.QID == QID && e.StudentID == StudentID && e.ExamID == ExamID).Select(e => e.Answer).ToString();
                    return ToDataTable(result);
                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return null;
            }
        }


        [HttpGet]
        [Route("getEA_ExamAnswerMasterByStudentIDExamID")]
        public string getEA_ExamAnswerMasterByStudentIDExamID(decimal StudentID, decimal ExamID)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    var result = (from AM in entities.EA_ExamAnswerMaster
                                  from QM in entities.EA_QuestionMaster.Where(x => AM.ExamID == x.ExamID && x.QuestionID == AM.QuestionNumber && AM.StudentID == StudentID && AM.ExamID == ExamID)
                                  orderby AM.QuestionNumber
                                  select new { QM.QuestionType, AM.QID, AM.Answer }).ToList();


                    var json = new JavaScriptSerializer().Serialize(result);

                    return json;


                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return null;
            }
        }





        public DataTable getLogInStaffDetailsByEmailID(string EmailID)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    var result = entities.WorkingStaffList.Where(x => x.WorkEmail == EmailID).ToList();
                    return ToDataTable(result);
                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return null;
            }
        }

        public DataTable getLogInStudentDetailsByEmailID(string EmailID)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    var result = entities.StudentCurrentGradeSectionDetails.Where(x => x.SchoolEmailID == EmailID).ToList();
                    return ToDataTable(result);
                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return null;
            }
        }


        public bool InsertRightsToTeacher(decimal StaffID, bool Rights, bool AdminRights, decimal AssignBy)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    int result = entities.ea_spiEA_StaffRights(StaffID, Rights, AdminRights, AssignBy);

                    if (result > 0)
                    {
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



        public string GetAnswerByExamIDStudentIDQuestionID(decimal ExamID, decimal StudentID, string QuestionID)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    string result = entities.EA_ExamAnswerMaster.Where(x => x.ExamID == ExamID && x.StudentID == StudentID && x.QID == QuestionID).Select(x => x.Answer).Single().ToString();

                    if (result != "")
                    {
                        return result;
                    }
                    else
                    {
                        return "";
                    }

                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return "";
            }
        }

        public DataTable getEA_StaffRights()
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    var result = (from SR in entities.EA_StaffRights
                                  join W in entities.WorkingStaffList
                                  on SR.StaffID equals W.StaffMasterID
                                  select new { W.FullName, SR.RightsID, SR.ISRights, SR.ISAdminRights, SR.AssignBy }).Distinct().ToList();
                    return ToDataTable(result);
                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return null;
            }
        }

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



        // Code for commet and marks 

        #region Code For Comment and Marks

        [HttpPost]
        [Route("insertEA_ExamCommentScoreMaster")]
        public bool insertEA_ExamCommentScoreMaster(EA_ExamCommentScoreMaster ECS)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    var result = entities.ea_spiEA_ExamCommentScoreMaster(ECS.ExamID, ECS.QID, ECS.StudentID, ECS.Comment, ECS.ScoreType, ECS.ObtainScore, ECS.CommentBy);
                    if (result > 0)
                    {
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

        [HttpGet]
        [Route("getEA_ExamCommentScoreMasterStudentIDExamID")]
        public string getEA_ExamCommentScoreMasterStudentIDExamID(decimal StudentID, decimal ExamID)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    var result = entities.EA_ExamCommentScoreMaster.Where(e => e.StudentID == StudentID && e.ExamID == ExamID).ToList();
                    var json = new JavaScriptSerializer().Serialize(result);
                    return json;

                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return null;
            }
        }


        #endregion

    }

}

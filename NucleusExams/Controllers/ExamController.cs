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
                    int i = entities.ea_spuEA_ExamMaster(Exm.ExamID, Exm.ExamName, Exm.GradeID, Exm.SubjectName, Exm.Duration, Exm.CreatedBy, Exm.ISExamCode, Exm.ExamCode, Exm.ExamDate, Exm.ExamURL);

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
                    int i = (from es in entities.EA_StudentEnrollment where es.StudentID == StudentID && es.ExamID == ExamID select es).Count();

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



        public decimal getExamIdOfActiveExam()
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    return Convert.ToDecimal(entities.EA_ExamMaster.Where(e => e.ISActive == true).Select(e => e.ExamID).Single());
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
        public DataTable GetExamDetailByGradeID(int GradeID)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    var result = entities.EA_ExamMaster.Where(e => e.GradeID == GradeID).
                        Select(e => new { e.ExamID, e.ExamName }).ToList();
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
        public bool insertEA_StudentEnrollment(decimal StudentID, decimal ExamID)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    var result = entities.ea_spiEA_StudentEnrollment(StudentID, ExamID);
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
        public bool insertEA_TeacherEnrollment(decimal StaffID, decimal ExamID)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    var result = entities.ea_spiEA_TeacherEnrollment(StaffID, ExamID);
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


    }
}

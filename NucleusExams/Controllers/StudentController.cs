using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Reflection;
using System.Web.Http;

namespace NucleusExams.Controllers
{
    [RoutePrefix("api/Student")]
    public class StudentController : ApiController
    {
        [HttpGet]
        [Route("IsExamActiveByExamID")]
        public bool IsExamActiveByExamID(decimal ExamID)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    return Convert.ToBoolean(entities.EA_ExamMaster.Where(e => e.ExamID == ExamID).Select(e => e.ISActive).FirstOrDefault());
                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return false;
            }
        }

        public bool IsExamActiveByExamIDExamURL(decimal ExamID, string ExamURL)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    return Convert.ToBoolean(entities.EA_ExamMaster.Where(e => e.ExamID == ExamID && e.ExamURL.Contains(ExamURL)).Select(e => e.ISActive).FirstOrDefault());
                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return false;
            }
        }

        [HttpGet]
        [Route("IsExamActiveByExamIDStudentID")]
        public bool IsExamActiveByExamIDStudentID(decimal ExamID, decimal StudentID)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {

                    return Convert.ToBoolean(entities.EA_StudentEnrollment.Where(e => e.ExamID == ExamID && e.StudentID == StudentID).Select(e => e.ISExamEnable).FirstOrDefault());

                    //  return Convert.ToBoolean(entities.ea_spgEA_StudentEnrollmentCheckExamActiveByStudentIDExamID(ExamID, StudentID));
                    //if (result != null)
                    //{
                    //    return true;
                    //}
                    //else
                    //{
                    //    return false;
                    //}
                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return false;
            }
        }




        [HttpGet]
        [Route("IsExamStartByStudent")]
        public bool IsExamStartByStudent(decimal ExamID, decimal StudentID)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    var result = entities.EA_StudentEnrollment.Where(e => e.StudentID == StudentID && e.ExamID == ExamID).Select(e => e.ActualStartTime).Single();
                    if (result != null)
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
        [Route("getExamStartTimeByStudent")]
        public DateTime getExamStartTimeByStudent(decimal ExamID, decimal StudentID)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    var result = entities.EA_StudentEnrollment.Where(e => e.StudentID == StudentID && e.ExamID == ExamID).Select(e => e.ActualStartTime).Single();
                    return Convert.ToDateTime(result);
                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return System.DateTime.Now;
            }
        }

        [HttpPost]
        [Route("UpdateExamStartTimeByExamIDStudentID")]
        public void UpdateExamStartTimeByExamIDStudentID(decimal ExamID, decimal StudentID)
        {
            try
            {

                using (dbEntities entities = new dbEntities())
                {
                    (from EAS in entities.EA_StudentEnrollment where EAS.ExamID == ExamID && EAS.StudentID == StudentID select EAS).ToList().ForEach(e => e.ActualStartTime = System.DateTime.Now);
                    entities.SaveChanges();
                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                //    return false;
            }
        }

        [HttpPost]
        [Route("UpdateExamEndTimeByExamIDStudentID")]
        public bool UpdateExamEndTimeByExamIDStudentID(decimal ExamID, decimal StudentID)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    (from EAS in entities.EA_StudentEnrollment where EAS.ExamID == ExamID && EAS.StudentID == StudentID select EAS).ToList().ForEach(e =>
                    {
                        e.ActualEndTime = System.DateTime.Now;
                        e.ISExamFinish = true;
                        e.ISExamEnable = false;
                    });
                    entities.SaveChanges();
                    return true;
                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return false;
            }
        }

        [HttpGet]
        [Route("GetStudentIDByMD5HashCode")]
        public decimal GetStudentIDByMD5HashCode(string MD5HashCode)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    var result = entities.ea_spgStudentIDByMD5HashCode(MD5HashCode).SingleOrDefault().Value;
                    if (result != null)
                    {
                        return result;
                    }
                    else
                    {
                        return 0;
                    }
                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return 0;
            }
        }


        [HttpGet]
        [Route("GetStudentDetailsByStudentID")]
        public DataTable GetStudentDetailsByStudentID(decimal StudentID)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    var result = entities.StudentCurrentGradeSectionDetails.Where(e => e.StudentID == StudentID).ToList();

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
        [Route("GetStudentDetailsByExamID")]
        public DataTable GetStudentDetailsByExamID(decimal ExamID)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    var result = entities.ea_spgEA_StudentEnrollmentByExamID(ExamID).ToList();

                    return ToDataTable(result);

                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return null;
            }
        }



        public bool UpdateEnableExamByStudentIDExamID(decimal StudentID, decimal ExamID)
        {
            try

            {
                using (dbEntities entities = new dbEntities())
                {
                    var result = entities.ea_spuEA_StudentEnrollmentEnableByStudentIDExamID(StudentID, ExamID);
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


        public bool UpdateDisableExamByStudentIDExamID(decimal StudentID, decimal ExamID)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    var result = entities.ea_spuEA_StudentEnrollmentDisableByStudentIDExamID(StudentID, ExamID);
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


        public bool DeleteStudentEnrollment(decimal StudentID, decimal ExamID)
        {
            try
            {
                using (dbEntities entities = new dbEntities())
                {
                    var result = entities.ea_spdEA_StudentEnrollment(StudentID, ExamID);
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

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NucleusExams.Controllers
{
    public class LoginController : Controller
    {

        [Route("api/IsValidStudentEmailID")]
        [HttpGet]
        public Boolean IsValidStudentEmailID(string StudentMailID)
        {
            try
            {
                dbEntities obj = new dbEntities();

                var result = obj.StudentCurrentGradeSectionDetails.Where(x => x.SchoolEmailID == StudentMailID).FirstOrDefault();

                if (result == null)
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return false;
            }
        }


        [Route("api/IsValidStffEmailID")]
        [HttpGet]
        public Boolean IsValidStffEmailID(string StaffMailID)
        {
            try
            {
                dbEntities obj = new dbEntities();

                var result = obj.WorkingStaffList.Where(x => x.WorkEmail == StaffMailID).FirstOrDefault();

                if (result == null)
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return false;
            }
        }


        [Route("api/IsRightsOnExam")]
        [HttpGet]
        public Boolean IsRightsOnExam(string StaffMailID)
        {
            
            try
            {
                dbEntities obj = new dbEntities();

                int staffID = obj.WorkingStaffList.Where(x => x.WorkEmail == StaffMailID).Select(x => x.StaffMasterID).SingleOrDefault();

                if (staffID != 0)
                {
                    var result = obj.EA_StaffRights.Where(x => x.StaffID == staffID && x.ISRights == true).FirstOrDefault();
                    if (result == null)
                    {
                        return false;
                    }
                    else
                    {
                        return true;
                    }
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                return false;
            }
        }

    }
}
package controller;

import annotation.Controller;
import annotation.Param;
import annotation.ToJson;
import annotation.UrlMapping;
import dao.InsertionDao;
import model.Medicin;
import model.Patient;
import util.Mysession;
import view.ModelAndView;
import java.util.List;
@Controller
public class LoginController {
    private final InsertionDao dao = new InsertionDao();

    @UrlMapping(path = "/login", methode = "POST")
    public ModelAndView login(@Param("email") String username, @Param("mdp") String password , Mysession session) {
        
        ModelAndView modelAndView = new ModelAndView();
        Patient patient = dao.find(Patient.class, List.of("email" , "mdp"), List.of(username, password));
        if (patient != null) {
            session.add("1" , "patient");
            session.add("id", patient.getId());
        //    List<Patient> patients = dao.findAll(Patient.class);

            modelAndView.setViewName("patient/patient-fiche");
            modelAndView.setAttribute("patient", patient);
            return modelAndView;

            
        } else {
            modelAndView.setViewName("login");
            modelAndView.setAttribute("message", "Email ou mot de passe incorrect.");
            return modelAndView;
        }
    }
} 

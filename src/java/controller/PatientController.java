package controller;

import annotation.Controller;
import annotation.Param;
import annotation.ToJson;
import annotation.UrlMapping;
import dao.InsertionDao;
import model.Medicin;
import model.Patient;
import model.Sexe;
import view.ModelAndView;
import java.time.LocalDate;
import java.util.List;
import util.Mysession;
import annotation.Roles;

@Controller
public class PatientController {
    private final InsertionDao dao = new InsertionDao();

    


    @UrlMapping(path = "/inscription/patient", methode = "POST")
    public ModelAndView inscrirePatient(Patient patient) {

        dao.insert(patient);

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("patient/patient");
        modelAndView.setAttribute("message", "Inscription reussie.");
        return modelAndView;
    }

    @UrlMapping(path = "/patient", methode = "GET")
    public ModelAndView afficherPatient() {
        List<Patient> patient = dao.findAll(Patient.class);

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("patient/patient");
        modelAndView.setAttribute("patient", patient);
        return modelAndView;
    }

    @UrlMapping(path = "/patient/delete", methode = "GET")
    @ToJson
    // @Roles({"admin"})
    public ModelAndView supprimerPatient(@Param("id") int id) {
        Patient patient = dao.findById(Patient.class, id);
        if (patient != null) {
            dao.delete(patient);
        }

        ModelAndView modelAndView = new ModelAndView();
        
        modelAndView.setAttribute("message", "Patient supprimé avec succès.");
        return modelAndView;
    }

    @UrlMapping(path = "/patient/edit", methode = "GET")
    public ModelAndView modifierPatient(@Param("id") int id) {
        Patient patient = dao.findById(Patient.class, id);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("patient/patientEdit");
        modelAndView.setAttribute("patient", patient);
        return modelAndView;
    }

    @UrlMapping(path = "/patient/update", methode = "POST")
    public ModelAndView modifierPatient(Patient patient) {
        dao.update(patient);

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("patient/patient");
        modelAndView.setAttribute("Patient", patient);
        return modelAndView;
    }

    @UrlMapping(path = "/patient/fiche", methode = "GET")
    public ModelAndView afficherFichePatient(Mysession session) {
        Integer patientId = (Integer) session.get("id");
        Patient patient = dao.findById(Patient.class, patientId);

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("patient/patient-fiche");
        modelAndView.setAttribute("patient", patient);
        return modelAndView;
    }

    @UrlMapping(path = "/patient/qr", methode = "GET")
    @ToJson
    public List<Patient> patients(){
        return dao.findAll(Patient.class);
    }

     
}

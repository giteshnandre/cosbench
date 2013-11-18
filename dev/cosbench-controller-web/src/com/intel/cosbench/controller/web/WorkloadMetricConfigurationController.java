package com.intel.cosbench.controller.web;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;

import com.intel.cosbench.config.Workload;
import com.intel.cosbench.config.castor.CastorConfigTools;
import com.intel.cosbench.controller.web.WorkloadMetricConfigurationController.TXTView;
import com.intel.cosbench.service.ControllerService;
import com.intel.cosbench.web.AbstractController;

public class WorkloadMetricConfigurationController extends AbstractController {
	private static final View TXT = new TXTView();    

    protected ControllerService controller;

    public void setController(ControllerService controller) {
        this.controller = controller;
    }
    
    private static class TXTView implements View {

        @Override
        public String getContentType() {
            return "application/text";
        }

        @Override
        public void render(Map<String, ?> model, HttpServletRequest req,
                HttpServletResponse res) throws Exception {
            String txt = (String)model.get("txt");
            res.setHeader("Content-Length", String.valueOf(txt.length()));
            res.setHeader("Content-Disposition",
                    "attachment; filename=\"metrcis.txt\"");

            try {
                IOUtils.write(txt, res.getOutputStream());
            } finally {
            }
        }

    }

    @Override
    protected ModelAndView process(HttpServletRequest req,
            HttpServletResponse res) {
        
    	WorkloadMetric workloadMetric = null;
    	String txt = "";
    	
        try {
            workloadMetric = constructWorkloadMetricFromPostData(req);             
        	txt =  CastorConfigTools.getWorkloadWriter().toXmlString(workloadMetric);

        } catch (Exception e) {
            return createErrResult(txt, e.getMessage());
        }

        return createSuccResult(txt);
    }

	private WorkloadMetric constructWorkloadMetricFromPostData(HttpServletRequest req) {
		
		return null;
	}
	
	 private ModelAndView createErrResult(String txt, String msg) {
	        ModelAndView result = new ModelAndView("config", "xml", txt);
	        result.addObject("error", "ERROR: " + msg);
	        
	        return result;
	    }

	    private ModelAndView createSuccResult(String txt) {    	
	        ModelAndView result = new ModelAndView(TXT, "xml", txt);

	        return result;
	    }
	    

}

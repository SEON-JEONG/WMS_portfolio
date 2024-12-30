package wms_project.controller;
public class javascript {
	String output = null;
	public String ok(String aa, String bb ) {
		this.output = "<script>"
				+ "alert('"+aa+"');"
				+ "location.href='"+bb+"';"
				+ "</script>";
		return this.output;
	}
	
	public String no(String aa) {
		this.output = "<script>"
				+ "alert('"+aa+"');"
				+ "history.go(-1);"
				+ "</script>";
		return this.output;
	}

	public String script(String aa) {
		this.output = "<script>"
				+ ""+aa+";"
				+ "</script>";
		return this.output;
	}
	public String confirm(String aa) {
		this.output = "<script>"
				+ "confirm('"+aa+"');"
				+ "</script>";
		return this.output;
	}
}

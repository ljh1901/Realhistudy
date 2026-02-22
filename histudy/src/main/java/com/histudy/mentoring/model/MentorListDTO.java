package com.histudy.mentoring.model;


public class MentorListDTO {

    private int mentor_idx;
    private String user_name;
    private int sc_idx;
    private String mentor_intro;
    private String mentor_link;
    private String mentor_tel;
    private String profile_img;

    public MentorListDTO() {
    }

	public int getMentor_idx() {
		return mentor_idx;
	}

	public void setMentor_idx(int mentor_idx) {
		this.mentor_idx = mentor_idx;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public int getSc_idx() {
		return sc_idx;
	}

	public void setSc_idx(int sc_idx) {
		this.sc_idx = sc_idx;
	}

	public String getMentor_intro() {
		return mentor_intro;
	}

	public void setMentor_intro(String mentor_intro) {
		this.mentor_intro = mentor_intro;
	}

	public String getMentor_link() {
		return mentor_link;
	}

	public void setMentor_link(String mentor_link) {
		this.mentor_link = mentor_link;
	}

	public String getMentor_tel() {
		return mentor_tel;
	}

	public void setMentor_tel(String mentor_tel) {
		this.mentor_tel = mentor_tel;
	}

	public String getProfile_img() {
		return profile_img;
	}

	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}

	public MentorListDTO(int mentor_idx, String user_name, int sc_idx, String mentor_intro, String mentor_link,
			String mentor_tel, String profile_img) {
		super();
		this.mentor_idx = mentor_idx;
		this.user_name = user_name;
		this.sc_idx = sc_idx;
		this.mentor_intro = mentor_intro;
		this.mentor_link = mentor_link;
		this.mentor_tel = mentor_tel;
		this.profile_img = profile_img;
	}
}

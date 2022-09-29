package kr.co.shop.vo;

public class ReviewVO {
   private int id, star;
   private String pcode,content,title,userid,writeday,ptitle,pimg;
   
   public String getPimg() {
	return pimg;
}
public void setPimg(String pimg) {
	this.pimg = pimg;
}
public String getPtitle() {
	return ptitle;
}
public void setPtitle(String ptitle) {
	this.ptitle = ptitle;
}
// gumae테이블의 id
   private int gid;
   
   private int avg; // 별점의 평균값(반올림)
   
   
   
public int getAvg() {
	return avg;
}
public void setAvg(int avg) {
	this.avg = avg;
}
public int getGid() {
	return gid;
}
public void setGid(int gid) {
	this.gid = gid;
}
public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
public int getStar() {
	return star;
}
public void setStar(int star) {
	this.star = star;
}
public String getPcode() {
	return pcode;
}
public void setPcode(String pcode) {
	this.pcode = pcode;
}
public String getContent() {
	return content;
}
public void setContent(String content) {
	this.content = content;
}
public String getTitle() {
	return title;
}
public void setTitle(String title) {
	this.title = title;
}
public String getUserid() {
	return userid;
}
public void setUserid(String userid) {
	this.userid = userid;
}
public String getWriteday() {
	return writeday;
}
public void setWriteday(String writeday) {
	this.writeday = writeday;
}
   
   
}

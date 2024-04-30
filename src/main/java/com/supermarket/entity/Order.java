package com.supermarket.entity;

import java.util.Date;

import org.springframework.stereotype.Component;

@Component
public class Order {
	private Integer id;
	private String code;
	private String remark;
	private Integer supplier_id;
	private Integer state;
	private Date createdate;
	private Date paydate;
	private float paymoney;

	private String name;
	private String contact;
	private String number;
	private String releaseStr;
	private String releaseStrPay;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public Integer getSupplier_id() {
		return supplier_id;
	}

	public void setSupplier_id(Integer supplier_id) {
		this.supplier_id = supplier_id;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Date getCreatedate() {
		return createdate;
	}

	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}

	public Date getPaydate() {
		return paydate;
	}

	public void setPaydate(Date paydate) {
		this.paydate = paydate;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public float getPaymoney() {
		return paymoney;
	}

	public void setPaymoney(float paymoney) {
		this.paymoney = paymoney;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getReleaseStr() {
		return releaseStr;
	}

	public void setReleaseStr(String releaseStr) {
		this.releaseStr = releaseStr;
	}

	public String getReleaseStrPay() {
		return releaseStrPay;
	}

	public void setReleaseStrPay(String releaseStrPay) {
		this.releaseStrPay = releaseStrPay;
	}

}

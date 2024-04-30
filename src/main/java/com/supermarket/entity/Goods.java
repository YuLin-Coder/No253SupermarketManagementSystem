package com.supermarket.entity;

import org.springframework.stereotype.Component;

@Component
public class Goods {

	private Integer id;

	private Integer inventory_quantity;

	private float last_purchasing_price;

	private Integer min_num;

	private String model;

	private String name;

	private String producer;

	private float purchasing_price;

	private String remarks;

	private float selling_price;

	private Integer state;

	private String unit;

	private Integer type_id;

	private String typeName;

	private Integer number;

	private Integer salenumber;

	private Integer returnnumber;

	private Integer numbers;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getInventory_quantity() {
		return inventory_quantity;
	}

	public void setInventory_quantity(Integer inventory_quantity) {
		this.inventory_quantity = inventory_quantity;
	}

	public float getLast_purchasing_price() {
		return last_purchasing_price;
	}

	public void setLast_purchasing_price(float last_purchasing_price) {
		this.last_purchasing_price = last_purchasing_price;
	}

	public Integer getMin_num() {
		return min_num;
	}

	public void setMin_num(Integer min_num) {
		this.min_num = min_num;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getProducer() {
		return producer;
	}

	public void setProducer(String producer) {
		this.producer = producer;
	}

	public float getPurchasing_price() {
		return purchasing_price;
	}

	public void setPurchasing_price(float purchasing_price) {
		this.purchasing_price = purchasing_price;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public float getSelling_price() {
		return selling_price;
	}

	public void setSelling_price(float selling_price) {
		this.selling_price = selling_price;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public Integer getType_id() {
		return type_id;
	}

	public void setType_id(Integer type_id) {
		this.type_id = type_id;
	}

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

	public Integer getSalenumber() {
		return salenumber;
	}

	public void setSalenumber(Integer salenumber) {
		this.salenumber = salenumber;
	}

	public Integer getReturnnumber() {
		return returnnumber;
	}

	public void setReturnnumber(Integer returnnumber) {
		this.returnnumber = returnnumber;
	}

	public Integer getNumbers() {
		return numbers;
	}

	public void setNumbers(Integer numbers) {
		this.numbers = numbers;
	}

}

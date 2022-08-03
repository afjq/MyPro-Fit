package com.lzy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.lzy.domain.Ptype;

@Mapper
public interface PtypeMapper {

	List<Ptype> findAll();

	Ptype findById(Integer ptypeId);

}
package com.lzy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.lzy.domain.Clas;

@Mapper
public interface ClasMapper {
//	单纯查找所有班级
	List<Clas> findAll();

//	根据Id找一个班级
	Clas findById(Integer classId);
}
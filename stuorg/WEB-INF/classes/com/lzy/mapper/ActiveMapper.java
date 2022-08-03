package com.lzy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.lzy.domain.Active;

@Mapper
public interface ActiveMapper {

	List<Active> findAll();
}
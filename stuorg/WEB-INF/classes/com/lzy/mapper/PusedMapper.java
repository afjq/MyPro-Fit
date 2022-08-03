package com.lzy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.lzy.domain.Pused;

@Mapper
public interface PusedMapper {
	List<Pused> findByPlaceId(Integer placeId);

	int insertPused(@Param("pused") Pused pused);
}
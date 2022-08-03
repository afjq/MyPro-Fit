package com.lzy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.lzy.domain.Place;

@Mapper
public interface PlaceMapper {
//	通过场地ID查找
	Place findById(Integer placeId);

//	通过场地ID修改场地
	int updateById(Integer placeId);

//	通过场地ID删除场地
	int delById(Integer placeId);

//	新增场地
	int insertPlace(@Param("place") Place place);

//	通过场地类型ID查找场地
	List<Place> findByPtypeId(Integer ptypeId);
}
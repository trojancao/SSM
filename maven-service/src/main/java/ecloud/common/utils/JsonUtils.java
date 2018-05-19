package ecloud.common.utils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.JsonParser.Feature;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;

import ecloud.com.base.model.BaseModel;
import net.sf.ezmorph.object.DateMorpher;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONUtils;

/**
 * @author xlj
 * @version 2014年9月17日 下午4:44:00
 */
public class JsonUtils {

	/**
	 * 将list转换成json对象
	 * @param inList
	 * @return
	 */
	public static String getJsonByList2(List inList) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", inList.size());
		map.put("rows", inList);
		JSONObject jsonObj = JSONObject.fromObject(map);
		String jsonString = jsonObj.toString();
		return jsonString == null ? "{}" : jsonString;
	}

	/**
	 * 从一个JSON数组得到一个java对象集合，其中对象中包含有集合属性
	 * 
	 * @param object
	 * @param clazz
	 * @param map
	 *            集合属性的类型
	 * @return
	 */
	public static List getListByJson(String jsonString, Class clazz) {
		setDataFormat2JAVA();
		JSONArray array = JSONArray.fromObject(jsonString);
		List list = new ArrayList();
		for (Iterator iter = array.iterator(); iter.hasNext();) {
			JSONObject jsonObject = (JSONObject) iter.next();
			list.add(JSONObject.toBean(jsonObject, clazz));
		}
		return list;
	}
	
	/**
	 * 设置日期格式
	 */
	private static void setDataFormat2JAVA(){
		//设定日期转换格式
		JSONUtils.getMorpherRegistry().registerMorpher(new DateMorpher(new String[] {"yyyy-MM-dd", "yyyy-MM-dd HH:mm:ss"}));
	}
	
	public String beanToJson(BaseModel baseModel) throws JsonGenerationException, JsonMappingException, IOException{
		ObjectMapper objectMapper = new ObjectMapper();
		return objectMapper.writeValueAsString(baseModel);
		//输出格式化后的字符串(有性能损耗)
//		mapper.defaultPrettyPrintingWriter().writeValueAsString(user);
//		mapper.writeValue(new File("c:\\user.json"), user); //指定文件写入
	}
	
	public BaseModel jsonToBean(BaseModel baseModel,String json) throws JsonGenerationException, JsonMappingException, IOException{
		ObjectMapper objectMapper = new ObjectMapper();
		return objectMapper.readValue(json, baseModel.getClass());
	}
	
	public Map<?, ?> jsonToMap(String json) throws JsonParseException, JsonMappingException, IOException{
		ObjectMapper mapper = new ObjectMapper();
		//解析器支持解析单引号
		mapper.configure(Feature.ALLOW_SINGLE_QUOTES,true);
		//解析器支持解析结束符
		mapper.configure(Feature.ALLOW_UNQUOTED_CONTROL_CHARS,true);
		return mapper.readValue(json,HashMap.class); //转换为HashMap对象
	}
}

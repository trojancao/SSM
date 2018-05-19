/**
 * Title: PaginationResp.java Package com.linggou.net.base All rights Reserved,
 * Designed By soyo Copyright: Copyright(C) 2010-2015 Company: soyo SuZhou LTD.
 * Create By shensuoyao Create Date 2014年8月15日 下午1:29:31 Version V1.0
 */
package ecloud.com.base.dto;

/**
 * @ClassName: PaginationResp
 * @Description: 分页放返回结果
 * @author shensuoyao
 */
public class PaginationResp extends JsonResp {

	/**
	 * @Fields currpage : 当前页
	 */
	private int currpage;

	/**
	 * @Fields nextpage : 下一页
	 */
	private int nextpage;

	/**
	 * @Fields hasnext : 是否有下一页
	 */
	private boolean hasnext;

	public PaginationResp() {
		this(false);
	}

	public PaginationResp(int _result, String _code, String _msg, Object data) {
		this(_result, _code, _msg, false, data);
	}

	public PaginationResp(int _result, String _code, String _msg, boolean _hasnext, Object data) {
		super(_result, _code, _msg, data);
		this.hasnext = _hasnext;
	}

	public PaginationResp(boolean _hasnext) {
		super();
		this.hasnext = _hasnext;
	}

	/**
	 * @return currpage
	 */
	public int getCurrpage() {
		return currpage;
	}

	/**
	 * @param currpage
	 *            要设置的 currpage
	 */
	public void setCurrpage(int currpage) {
		this.currpage = currpage;
	}

	/**
	 * @return nextpage
	 */
	public int getNextpage() {
		return nextpage;
	}

	/**
	 * @param nextpage
	 *            要设置的 nextpage
	 */
	public void setNextpage(int nextpage) {
		this.nextpage = nextpage;
	}

	/**
	 * @return hasnext
	 */
	public boolean isHasnext() {
		return hasnext;
	}

	/**
	 * @param hasnext
	 *            要设置的 hasnext
	 */
	public void setHasnext(boolean hasnext) {
		this.hasnext = hasnext;
	}

}

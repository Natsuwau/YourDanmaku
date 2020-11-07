package yours.info;

import org.apache.commons.fileupload.ProgressListener;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**文件上传进度监听类*/
public class MineProgressListener implements ProgressListener {
	public final static String SESSION_PROGRESS_INFO_NAME = "MINE_PROGRESS_INFO";
	
	private HttpSession session;
	
	private long startTime = System.currentTimeMillis();//开始时间
	
	public MineProgressListener(HttpServletRequest request){
		this.session = request.getSession();
	}

    /** 
     * pBytesRead  到目前为止读取文件的比特数
     * pContentLength 文件总大小
     * pItems 目前正在读取第几个文件
     * 只要在session中实时保存文件上传的状态（这里我用fileUploadStatus类来封装）
     */
	@Override
	public void update(long pBytesRead, long pContentLength, int pItems) {
		MineProgressInfo info = new MineProgressInfo();
		info.setReadBytes(pBytesRead);
		info.setContentLength(pContentLength);
		info.setNowItems(pItems);
		info.setStartTime(this.startTime);
		info.setNowTime(System.currentTimeMillis());
		this.session.setAttribute(MineProgressListener.SESSION_PROGRESS_INFO_NAME, info);
	}

}

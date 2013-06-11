package com.palDeveloppers.ane;

import java.util.HashMap;
import java.util.Map;

import android.media.MediaPlayer;
import android.media.MediaPlayer.OnBufferingUpdateListener;
import android.media.MediaPlayer.OnCompletionListener;
import android.media.MediaPlayer.OnErrorListener;
import android.media.MediaPlayer.OnInfoListener;
import android.media.MediaPlayer.OnPreparedListener;
import android.media.MediaPlayer.OnSeekCompleteListener;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

public class MediaPlayerContext extends FREContext implements OnPreparedListener, OnSeekCompleteListener, OnInfoListener, OnErrorListener, OnCompletionListener, OnBufferingUpdateListener {
	
	private MediaPlayer mp;
	private MediaPlayerContext instance;

	public MediaPlayerContext() {
		mp = new MediaPlayer();
		mp.setOnPreparedListener(this);
		mp.setOnCompletionListener(this);
		mp.setOnSeekCompleteListener(this);
		mp.setOnErrorListener(this);
		
		instance = this;
	}
	
	@Override
	public void dispose() {
		if (mp != null) {
			mp.release();
			mp = null;
		}
		
		instance = null;
	}

	@Override
	public Map<String, FREFunction> getFunctions() {
		Map<String, FREFunction> map = new HashMap<String, FREFunction>(17);
		map.put("getCurrentPosition", new GetCurrentPositionFunction());
		map.put("getDuration", new GetDurationFunction());
		map.put("isLooping", new IsLoopingFunction());
		map.put("isPlaying", new IsPlayingFunction());
		map.put("pause", new PauseFunction());
		map.put("prepare", new PrepareFunction());
		map.put("prepareAsync", new PrepareAsyncFunction());
		map.put("reset", new ResetFunction());
		map.put("seekTo", new SeekToFunction());
		map.put("setAudioStreamType", new SetAudioStreamTypeFunction());
		map.put("setDataSource", new SetDataSourceFunction());
		map.put("setLooping", new SetLoopingFunction());
		map.put("setVolume", new SetVolumeFunction());
		map.put("start", new StartFunction());
		map.put("stop", new StopFunction());
		
		map.put("setInfoListener", new SetInfoListenerFunction());
		map.put("setBufferListener", new SetBufferListenerFunction());
		
		return map;
	}
	
	@Override
	public void onBufferingUpdate(MediaPlayer arg0, int arg1) {
		this.dispatchStatusEventAsync("onBufferingUpdate", Integer.toString(arg1));
	}

	@Override
	public void onCompletion(MediaPlayer mp) {
		this.dispatchStatusEventAsync("onCompletion", "");
	}

	@Override
	public boolean onError(MediaPlayer arg0, int arg1, int arg2) {
		this.dispatchStatusEventAsync("onError", Integer.toString(arg1) + ";" + Integer.toString(arg2));
		
		return false;
	}

	@Override
	public boolean onInfo(MediaPlayer arg0, int arg1, int arg2) {
		this.dispatchStatusEventAsync("onInfo", Integer.toString(arg1) + ";" + Integer.toString(arg2));
		
		return false;
	}

	@Override
	public void onSeekComplete(MediaPlayer arg0) {
		this.dispatchStatusEventAsync("onSeekComplete", "");
	}

	@Override
	public void onPrepared(MediaPlayer mp) {
		this.dispatchStatusEventAsync("onPrepared", "");
	}

	private class GetCurrentPositionFunction implements FREFunction {
		@Override
	    public FREObject call(FREContext context, FREObject[] args) {
			try {
				return FREObject.newObject(mp.getCurrentPosition());
			} catch (Exception ex) {
			}
			
			return null;
		}
		
	}

	private class GetDurationFunction implements FREFunction {
		@Override
	    public FREObject call(FREContext context, FREObject[] args) {
			try {
				return FREObject.newObject(mp.getDuration());
			} catch (Exception ex) {
			}
		
			return null;
		}
		
	}

	private class IsLoopingFunction implements FREFunction {
		@Override
	    public FREObject call(FREContext context, FREObject[] args) {
			try {
				return FREObject.newObject(mp.isLooping());
			} catch (Exception ex) {
			}
			
			return null;
		}
		
	}

	private class IsPlayingFunction implements FREFunction {
		@Override
	    public FREObject call(FREContext context, FREObject[] args) {
			try {
				return FREObject.newObject(mp.isPlaying());
			} catch (Exception ex) {
			}
			
			return null;
		}
		
	}

	private class PauseFunction implements FREFunction {
		@Override
	    public FREObject call(FREContext context, FREObject[] args) {
			try {
				mp.pause();
			} catch (Exception ex) {
			}
			
			return null;
		}
		
	}

	private class PrepareFunction implements FREFunction {
		@Override
	    public FREObject call(FREContext context, FREObject[] args) {
			try {
				mp.prepare();
			} catch (Exception ex) {
			}
			
			return null;
		}
		
	}

	private class PrepareAsyncFunction implements FREFunction {
		@Override
	    public FREObject call(FREContext context, FREObject[] args) {
			mp.prepareAsync();
			
			return null;
		}
		
	}

	private class ResetFunction implements FREFunction {
		@Override
	    public FREObject call(FREContext context, FREObject[] args) {
			mp.reset();
			
			return null;
		}
		
	}

	private class SeekToFunction implements FREFunction {
		@Override
	    public FREObject call(FREContext context, FREObject[] args) {
			try {
				mp.seekTo(args[0].getAsInt());
			} catch (Exception ex) {
			}
			
			return null;
		}
		
	}

	private class SetAudioStreamTypeFunction implements FREFunction {
		@Override
	    public FREObject call(FREContext context, FREObject[] args) {
			try {
				mp.setAudioStreamType(args[0].getAsInt());
			} catch (Exception ex) {
			}
			
			return null;
		}
		
	}

	private class SetDataSourceFunction implements FREFunction {
		@Override
	    public FREObject call(FREContext context, FREObject[] args) {
			try {
				mp.setDataSource(args[0].getAsString());
			} catch (Exception ex) {
			}
			
			return null;
		}
		
	}

	private class SetLoopingFunction implements FREFunction {
		@Override
	    public FREObject call(FREContext context, FREObject[] args) {
			try {
				mp.setLooping(args[0].getAsBool());
			} catch (Exception ex) {
			}
			
			return null;
		}
		
	}

	private class SetVolumeFunction implements FREFunction {
		@Override
	    public FREObject call(FREContext context, FREObject[] args) {
			try {
				mp.setVolume((float)(args[0].getAsDouble()), (float)args[1].getAsDouble());
			} catch (Exception ex) {
			}
			
			return null;
		}
		
	}

	private class StartFunction implements FREFunction {
		@Override
	    public FREObject call(FREContext context, FREObject[] args) {
			mp.start();
			
			return null;
		}
		
	}

	private class StopFunction implements FREFunction {
		@Override
	    public FREObject call(FREContext context, FREObject[] args) {
			mp.stop();
			
			return null;
		}
		
	}

	private class SetInfoListenerFunction implements FREFunction {
		
		
		@Override
	    public FREObject call(FREContext context, FREObject[] args) {
			try {
				if (args[0].getAsBool())
					mp.setOnInfoListener(instance);
				else
					mp.setOnInfoListener(null);
			} catch (Exception ex) {}
			
			return null;
		}
		
	}

	private class SetBufferListenerFunction implements FREFunction {
		
		@Override
	    public FREObject call(FREContext context, FREObject[] args) {
			try {
				if (args[0].getAsBool())
					mp.setOnBufferingUpdateListener(instance);
				else
					mp.setOnBufferingUpdateListener(null);
			} catch (Exception ex) {}
			
			return null;
		}
		
	}

}

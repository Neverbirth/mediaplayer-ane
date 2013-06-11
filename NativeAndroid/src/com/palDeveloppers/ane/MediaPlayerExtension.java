package com.palDeveloppers.ane;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;


public class MediaPlayerExtension implements FREExtension {

	private FREContext context;
	
	@Override
	public FREContext createContext(String arg0) {
		return context = new MediaPlayerContext();
	}

	@Override
	public void dispose() {
		if (context != null)
			context.dispose();
		
		context = null;
	}

	@Override
	public void initialize() {

	}

}

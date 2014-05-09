package com.intel.cosbench.client.swauth.utils;

import java.io.InterruptedIOException;
import java.net.SocketTimeoutException;

import org.apache.http.conn.ConnectTimeoutException;

import com.intel.cosbench.api.auth.AuthException;
import com.intel.cosbench.api.auth.AuthInterruptedException;
import com.intel.cosbench.api.auth.AuthTimeoutException;
import com.intel.cosbench.api.context.AuthContext;
import com.intel.cosbench.client.swauth.SwiftAuthClient;
import com.intel.cosbench.client.swauth.SwiftAuthClientException;
import com.intel.cosbench.driver.model.WorkerContext;

public class SwiftTokenCacheImpl {
	
	private static SwiftTokenCache latestTokenCache = new SwiftTokenCache();

	
    public static synchronized void loadSwiftTokenCache(SwiftAuthClient client, SwiftTokenCache currentTokenCache) {
        // Actual operation to load token cache from server
		if(currentTokenCache.getVersion() == latestTokenCache.getVersion())
		{
			try {
			    	client.login();
					latestTokenCache.setToken(client.getAuthToken());
					latestTokenCache.setStorageURL(client.getStorageURL());
					latestTokenCache.incrementVersion();
			} catch (SocketTimeoutException ste) {
			    throw new AuthTimeoutException(ste);
			} catch (ConnectTimeoutException cte) {
			    throw new AuthTimeoutException(cte);
			} catch (InterruptedIOException ie) {
			    throw new AuthInterruptedException(ie);
			} catch (SwiftAuthClientException se) {
			    throw new AuthException(se.getMessage(), se);
			} catch (Exception e) {
			    throw new AuthException(e);
			}
	     }
		//setting AuthContext again when token at server side is changed
		if(currentTokenCache.getVersion()!=0)
		{
			AuthContext authContext = new AuthContext();
	    	SwiftTokenCache tokenCache = SwiftTokenCacheImpl.getSwiftTokenCache(client);
	    	authContext.put("token",tokenCache.getToken());
	        authContext.put("storage_url", tokenCache.getStorageURL());
			for (WorkerContext workerContext : missionContext.getWorkerRegistry())
	            workerContext.getStorageApi().setAuthContext(authContext);
		}
	}

    public static SwiftTokenCache getSwiftTokenCache(SwiftAuthClient client) {
		if(latestTokenCache.getVersion()==0)
			loadSwiftTokenCache(client,latestTokenCache);
            	return latestTokenCache;
    }
}

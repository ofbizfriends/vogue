<#--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->

<#assign useMultitenant = Static["org.ofbiz.base.util.UtilProperties"].getPropertyValue("general.properties", "multitenant")>

<center>
    <div class="password-screenlet">
        <div class="center header">
            <h3>${uiLabelMap.CommonForgotYourPassword}?</h3>
        </div>
        <div class="login-screenlet-body login-container">
	       <div class="row">
                <div class="col-xs-12 col-md-4 col-md-offset-4"> 
                    <form class="log-page" method="post" action="<@ofbizUrl>forgotPassword${previousParams?if_exists}</@ofbizUrl>" name="forgotpassword" id="forgotpassword">
	                    <div class="form-group m-b-20">				        
	                        <input class="required email form-control input-lg" placeholder="Username or Email" type="text" id="userName" name="USERNAME" value="<#if requestParameters.USERNAME?has_content>${requestParameters.USERNAME}<#elseif autoUserLogin?has_content>${autoUserLogin.userLoginId}</#if>"/>
	                    </div>
		              
	          
	                    <div class="login-buttons"> 
		                   <input type="submit" name="GET_PASSWORD_HINT" class="btn btn-info btn-block btn-lg" value="${uiLabelMap.CommonGetPasswordHint}"/>
	                    </div><br>
	                    <div class="login-buttons">
		                   <input type="submit" name="EMAIL_PASSWORD" class="btn btn-primary btn-block btn-lg" value="${uiLabelMap.CommonEmailPassword}"/>              
	                    </div>
		                <a href='<@ofbizUrl>authview</@ofbizUrl>' class="btn btn-link">${uiLabelMap.CommonGoBack}</a><hr>
			            <input type="hidden" name="JavaScriptEnabled" value="N"/>
	                </form>
	            </div>
	        </div>
	    </div>
    </div>
</center>

<script>
$("#forgotpassword").validate();
</script>

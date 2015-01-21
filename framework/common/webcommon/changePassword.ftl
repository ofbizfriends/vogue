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

<#assign username = requestParameters.USERNAME?default((sessionAttributes.autoUserLogin.userLoginId)?default(""))>

<div class="row">
    <div class="col-xs-12 col-md-6 col-md-offset-3">
		<div class="screenlet">
		  <div class="screenlet-title-bar">
    <h3>${uiLabelMap.CommonPasswordChange}</h3>
  </div>
  <div class="screenlet-body">
			  <div class="screenlet-main">
			    <form method="post" action="<@ofbizUrl>login</@ofbizUrl>" name="loginform" class="form">
      <input type="hidden" name="requirePasswordChange" value="Y"/>
      <input type="hidden" name="USERNAME" value="${username}"/>
			      <div cellspacing="0">
			        <div class="form-group">
			          <h4>${username}</h4>
			        </div>
			        <div class="form-group">
			          <label class="control-label">${uiLabelMap.CommonCurrentPassword}</label>
			          <div class="controls"><input class="form-control" type="password" name="PASSWORD" value="" size="20"/></div>
			        </div>
			        <div class="form-group">
			          <label class="control-label">${uiLabelMap.CommonNewPassword}</label>
			          <div class="controls"><input class="form-control" type="password" name="newPassword" value="" size="20"/></div>
			        </div>
			        <div class="form-group">
			          <label class="control-label">${uiLabelMap.CommonNewPasswordVerify}</label>
			          <div class="controls"><input class="form-control" type="password" name="newPasswordVerify" value="" size="20"/></div>
			        </div>
			        <div class="form-actions">
			          <div>
			            <input type="submit" value="${uiLabelMap.CommonSubmit}" class="btn btn-info"/>
			          </div>
			        </div>
			      </div>
    </form>
  </div>
		  </div><#-- /screenlet-body -->
		</div>
    </div>		
</div>

<script language="JavaScript" type="text/javascript">
  document.loginform.PASSWORD.focus();
</script>

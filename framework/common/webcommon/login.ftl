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


<#if requestAttributes.uiLabelMap?exists><#assign uiLabelMap = requestAttributes.uiLabelMap></#if>

<#assign username = requestParameters.USERNAME?default((sessionAttributes.autoUserLogin.userLoginId)?default(""))>
<#if username != "">
  <#assign focusName = false>
<#else>
  <#assign focusName = true>
</#if>


    <!-- begin login -->
    <div class="login bg-black animated fadeInDown">
        <!-- begin brand -->
        <div class="login-header">
            <div class="brand">
                <div class="media media-xs">
                    <span class="pull-left">
                             <img src="/images/ofbiz_logo.gif" />
                    </span>
                    <div class="media-body">
                        <div class="pull-left"> 
                        
                        <small></small>
                        </div>
                    </div>
                </div>
            </div>   
            
            
                            
                            
        </div>
        <!-- end brand -->
        <div class="login-content">
            <form method="post" action="<@ofbizUrl>login</@ofbizUrl>" name="loginform" id="loginform" class="margin-bottom-0">
                
                ${screens.render("component://common/widget/CommonScreens.xml#EventMessages")}
                
        <input type="hidden" name="JavaScriptEnabled" value="N"/>
                <div class="form-group m-b-20">
                    <input type="text" class="required form-control input-lg" placeholder="Email Address" id="userName" name="USERNAME" value="<#if requestParameters.USERNAME?has_content>${requestParameters.USERNAME}<#elseif autoUserLogin?has_content>${autoUserLogin.userLoginId}</#if>"/>      
                </div>
                <div class="form-group m-b-20">
                    <input type="password" class="required form-control input-lg" placeholder="Password" id="password" name="PASSWORD" />
                </div>
                <div class="login-buttons">
                    <button type="submit" class="btn btn-warning btn-block btn-lg">Sign me in</button>
                </div>
                
            </form>
        <br />
            <p >
                <a href="<@ofbizUrl>forgotPassword</@ofbizUrl>">${uiLabelMap.CommonForgotYourPassword}?</a>
            </p>

  </div>
    </div>
    <!-- end login -->

    

<script>
$("#loginform").validate();
</script>

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

<#assign nowTimestamp = Static["org.ofbiz.base.util.UtilDateTime"].nowTimestamp()>

<br />
<div class="footer">
    <div class="container">
        <div class="col-md-3 col-md-6">    
	        <div>
	            <a href="http://ofbiz.apache.org">${uiLabelMap.EcommerceAboutUs}</a>        
	        </div>
	        
	        <div>
	           <strong>Policies </strong> <a href="<@ofbizUrl>policies</@ofbizUrl>">${uiLabelMap.EcommerceSeeStorePoliciesHere}</a>
	        </div>
        </div>
    </div>      
</div>
<br />
<div id="copyright">
    <div class="container">
        <div class="col-md-12">
            <p class="pull-left">Copyright (c) 2001-${nowTimestamp?string("yyyy")} The Apache Software Foundation - <a href="http://www.apache.org">www.apache.org</a>.</p>
            <p class="pull-right">
                <img src="/images/payment.png" alt="payments accepted">
            </p>

        </div>
    </div>
</div>

<#if layoutSettings.VT_FTR_JAVASCRIPT?has_content>
    <#list layoutSettings.VT_FTR_JAVASCRIPT as javaScript>
        <script type="text/javascript" src="<@ofbizContentUrl>${StringUtil.wrapString(javaScript)}</@ofbizContentUrl>"></script>
    </#list>
</#if>
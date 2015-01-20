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



    <#if layoutSettings.VT_FTR_JAVASCRIPT?has_content>
      <#list layoutSettings.VT_FTR_JAVASCRIPT as javaScript>
        <script src="<@ofbizContentUrl>${StringUtil.wrapString(javaScript)}</@ofbizContentUrl>" type="text/javascript"></script>
      </#list>
    </#if>      
    <#if layoutSettings.VT_EXTRA_HEAD?has_content>
        <#list layoutSettings.VT_EXTRA_HEAD as extraHead>
            ${extraHead}
        </#list>
    </#if>
    <#if layoutSettings.WEB_ANALYTICS?has_content>
      <script language="JavaScript" type="text/javascript">
        <#list layoutSettings.WEB_ANALYTICS as webAnalyticsConfig>
          ${StringUtil.wrapString(webAnalyticsConfig.webAnalyticsCode?if_exists)}
        </#list>
      </script>
    </#if>
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    
    <!--[if lt IE 9]>       
        <script src="/images/js/html5shiv.js"></script>
        <script src="/images/js/respond.min.js"></script>
        <script src="/images/js/excanvas.min.js"></script>      
    <![endif]-->  



    <script>
        $(document).ready(function() {
            App.init();            
        });
    </script>
    
    <script>
    if (navigator.userAgent.match(/IEMobile\/10\.0/)) {
      var msViewportStyle = document.createElement('style')
      msViewportStyle.appendChild(
        document.createTextNode(
          '@-ms-viewport{width:auto!important}'
        )
      )
      document.querySelector('head').appendChild(msViewportStyle)
    }   
    
    var nua = navigator.userAgent
    var isAndroid = (nua.indexOf('Mozilla/5.0') > -1 && nua.indexOf('Android ') > -1 && nua.indexOf('AppleWebKit') > -1 && nua.indexOf('Chrome') === -1)
    if (isAndroid) {
      $('select.form-control').removeClass('form-control').css('width', '100%')
    }
    </script>   

	<script type="text/javascript">
	        if("ontouchend" in document) document.write("<script src='/images/jquery/jquery.mobile.custom.min.js'>"+"<"+"/script>");
	        //Go to top button   
			$(document).ready(function (e) {
			    $(window).scroll(function () {
			        if ($(this).scrollTop() != 0) {
			            $('#toTop').fadeIn();
			        } else {
			            $('#toTop').fadeOut();
			        }
			    });
			    $('#toTop').click(function () {
			        $('body,html').animate({
			            scrollTop: 0
			        }, 800);
			    });
			});
	</script>

    
</body>
</html>

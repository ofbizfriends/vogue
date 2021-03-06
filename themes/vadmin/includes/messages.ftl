<#--
kenolisystems.com
-->

<#if requestAttributes.errorMessageList?has_content><#assign errorMessageList=requestAttributes.errorMessageList></#if>
<#if requestAttributes.eventMessageList?has_content><#assign eventMessageList=requestAttributes.eventMessageList></#if>
<#if requestAttributes.serviceValidationException?exists><#assign serviceValidationException = requestAttributes.serviceValidationException></#if>
<#if requestAttributes.uiLabelMap?has_content><#assign uiLabelMap = requestAttributes.uiLabelMap></#if>

<#if !errorMessage?has_content>
  <#assign errorMessage = requestAttributes._ERROR_MESSAGE_?if_exists>
</#if>
<#if !errorMessageList?has_content>
  <#assign errorMessageList = requestAttributes._ERROR_MESSAGE_LIST_?if_exists>
</#if>
<#if !eventMessage?has_content>
  <#assign eventMessage = requestAttributes._EVENT_MESSAGE_?if_exists>
</#if>
<#if !eventMessageList?has_content>
  <#assign eventMessageList = requestAttributes._EVENT_MESSAGE_LIST_?if_exists>
</#if>

<#-- display the error messages -->
<#if (errorMessage?has_content || errorMessageList?has_content)>
  <div id="content-messages" class="content-messages" onclick="document.getElementById('content-messages').parentNode.removeChild(this)">    
    <div class="alert alert-danger">
        <button type="button" class="close" data-dismiss="alert"><i class="fa fa-remove"></i></button>
        <b><i class="fa fa-remove"></i> ${uiLabelMap.ERROR}</b>    
    <#--
    <p>${uiLabelMap.CommonFollowingErrorsOccurred}:</p>
    -->
    <#if errorMessage?has_content>
      <p>${errorMessage}</p>
    </#if>
    <#if errorMessageList?has_content>
      <#-- start of modification -->
      <#list errorMessageList as errorMsg>
      <#if errorMsg?length &lt; 400>
        <p>${errorMsg}</p>
      <#else>
        <p>${uiLabelMap.ErrorInTrasaction}</p>        
      </#if>
      </#list>
    </#if>
    </div>
  </div>
</#if>

<#-- display the event messages -->
<#if (eventMessage?has_content || eventMessageList?has_content)>
  <div id="content-messages" class="content-messages" onclick="document.getElementById('content-messages').parentNode.removeChild(this)">
    <div class="alert alert-success">
        <button type="button" class="close" data-dismiss="alert"><i class="fa fa-remove"></i></button>
	    <#--
	    <p><b>${uiLabelMap.CommonFollowingOccurred}</b></p>	    
	    -->
	    <#if eventMessage?has_content>
	      <p>${eventMessage}</p>
	    </#if>
	    <#if eventMessageList?has_content>
	      <#list eventMessageList as eventMsg>
	        <p>${eventMsg}</p>
	      </#list>
	    </#if>
    </div>
  </div>
</#if>

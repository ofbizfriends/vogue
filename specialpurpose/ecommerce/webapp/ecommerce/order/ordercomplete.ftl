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
<div class="col-md-12 clearfix">
    <ul class="breadcrumb">
        <li><a href="<@ofbizUrl>main</@ofbizUrl>">${uiLabelMap.CommonHome}</a>
        </li>
        <li>${uiLabelMap.EcommerceOrderConfirmation}</li>
    </ul>

    <div class="box text-center">

        <div class="row">
            <div class="col-sm-10 col-sm-offset-1">
                <h1>${uiLabelMap.EcommerceOrderConfirmation}</h1>
            </div>
        </div>
    </div>
</div>
<#if !isDemoStore?? || isDemoStore><p>${uiLabelMap.OrderDemoFrontNote}.</p></#if>
    <#if orderHeader?has_content>
        ${screens.render("component://ecommerce/widget/OrderScreens.xml#orderheader")}
        ${screens.render("component://ecommerce/widget/OrderScreens.xml#orderitems")}
        <a href="<@ofbizUrl>main</@ofbizUrl>" class="btn btn-default">${uiLabelMap.EcommerceContinueShopping}</a>
    <#else>
        <h3>${uiLabelMap.OrderSpecifiedNotFound}.</h3>
</#if>

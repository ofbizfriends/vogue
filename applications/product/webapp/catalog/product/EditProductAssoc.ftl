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
<div class="screenlet">
    <div class="screenlet-title-bar">
        <h3>${uiLabelMap.PageTitleEditProductAssociations}</h3>
    </div>
    <div class="screenlet-body">
        <form action="<@ofbizUrl>UpdateProductAssoc</@ofbizUrl>" method="post" style="margin: 0;" name="editProductAssocForm">
        <input type="hidden" name="productId" value="${productId!}" />

        <#if !(productAssoc??)>
            <#if productId?? && productIdTo?? && productAssocTypeId?? && fromDate??>
                <div><b><#assign uiLabelWithVar=uiLabelMap.ProductAssociationNotFound?interpret><@uiLabelWithVar/></b></div>
                <input type="hidden" name="UPDATE_MODE" value="CREATE" />
                <table cellspacing="0" class="table">
                <tr>
                <td align="right" class="label">${uiLabelMap.ProductProductId}</td>
                <td>&nbsp;</td>
                <td><input type="text" name="PRODUCT_ID" size="20" maxlength="40" value="${productId!}" /></td>
                </tr>
                <tr>
                <td align="right" class="label">${uiLabelMap.ProductProductIdTo}</td>
                <td>&nbsp;</td>
                <td><input type="text" name="PRODUCT_ID_TO" size="20" maxlength="40" value="${productIdTo!}" /></td>
                </tr>
                <tr>
                <td align="right" class="label">${uiLabelMap.ProductAssociationTypeId}</td>
                <td>&nbsp;</td>
                <td>
                    <select name="PRODUCT_ASSOC_TYPE_ID" size="1">
                    <#if productAssocTypeId?has_content>
                        <#assign curAssocType = delegator.findOne("ProductAssocType", Static["org.ofbiz.base.util.UtilMisc"].toMap("productAssocTypeId", productAssocTypeId), false)>
                        <#if curAssocType??>
                            <option selected="selected" value="${(curAssocType.productAssocTypeId)!}">${(curAssocType.get("description",locale))!}</option>
                            <option value="${(curAssocType.productAssocTypeId)!}"></option>
                        </#if>
                    </#if>
                    <#list assocTypes as assocType>
                        <option value="${(assocType.productAssocTypeId)!}">${(assocType.get("description",locale))!}</option>
                    </#list>
                    </select>
                </td>
                </tr>
                <tr>
                <td align="right" class="label">${uiLabelMap.CommonFromDate}</td>
                <td>&nbsp;</td>
                <td>
                    <div>
                        <@htmlTemplate.renderDateTimeField name="FROM_DATE" event="" action="" value="${fromDate!}" className="" alert="" title="Format: yyyy-MM-dd HH:mm:ss.SSS" size="25" maxlength="30" id="fromDate1" dateType="date" shortDateInput=false timeDropdownParamName="" defaultDateTimeString="" localizedIconTitle="" timeDropdown="" timeHourName="" classString="" hour1="" hour2="" timeMinutesName="" minutes="" isTwelveHour="" ampmName="" amSelected="" pmSelected="" compositeType="" formName=""/>
                        ${uiLabelMap.CommonSetNowEmpty}
                    </div>
                </td>
                </tr>
            <#else>
                <input type="hidden" name="UPDATE_MODE" value="CREATE" />
                <table cellspacing="0" class="table">
                <tr>
                <td align="right" class="label">${uiLabelMap.ProductProductId}</td>
                <td>&nbsp;</td>
                <td><input type="text" name="PRODUCT_ID" size="20" maxlength="40" value="${productId!}" /></td>
                </tr>
                <tr>
                <td align="right" class="label">${uiLabelMap.ProductProductIdTo}</td>
                <td>&nbsp;</td>
                <td>
                  <@htmlTemplate.lookupField formName="editProductAssocForm" name="PRODUCT_ID_TO" id="PRODUCT_ID_TO" fieldFormName="LookupProduct"/>
                </td>
                </tr>
                <tr>
                <td align="right" class="label">${uiLabelMap.ProductAssociationTypeId}</td>
                <td>&nbsp;</td>
                <td>
                    <select name="PRODUCT_ASSOC_TYPE_ID" size="1">
                    <!-- <option value="">&nbsp;</option> -->
                    <#list assocTypes as assocType>
                        <option value="${(assocType.productAssocTypeId)!}">${(assocType.get("description",locale))!}</option>
                    </#list>
                    </select>
                </td>
                </tr>
                <tr>
                <td align="right" class="label">${uiLabelMap.CommonFromDate}</td>
                <td>&nbsp;</td>
                <td>
                    <div>
                        ${fromDate!}
                        <@htmlTemplate.renderDateTimeField name="FROM_DATE" event="" action="" value="${fromDate!}" className="" alert="" title="Format: yyyy-MM-dd HH:mm:ss.SSS" size="25" maxlength="30" id="fromDate2" dateType="date" shortDateInput=false timeDropdownParamName="" defaultDateTimeString="" localizedIconTitle="" timeDropdown="" timeHourName="" classString="" hour1="" hour2="" timeMinutesName="" minutes="" isTwelveHour="" ampmName="" amSelected="" pmSelected="" compositeType="" formName=""/>
                        ${uiLabelMap.CommonSetNowEmpty}
                    </div>
                </td>
                </tr>
            </#if>
        <#else>
            <#assign isCreate = false>
            <#assign curProductAssocType = productAssoc.getRelatedOne("ProductAssocType", true)>
            <input type="hidden" name="UPDATE_MODE" value="UPDATE" />
            <input type="hidden" name="PRODUCT_ID" value="${productId!}" />
            <input type="hidden" name="PRODUCT_ID_TO" value="${productIdTo!}" />
            <input type="hidden" name="PRODUCT_ASSOC_TYPE_ID" value="${productAssocTypeId!}" />
            <input type="hidden" name="FROM_DATE" value="${fromDate!}" />
            <table cellspacing="0" class="table">
            <tr>
                <td align="right" class="label">${uiLabelMap.ProductProductId}</td>
                <td>&nbsp;</td>
                <td><b>${productId!}</b> ${uiLabelMap.ProductRecreateAssociation}</td>
            </tr>
            <tr>
                <td align="right" class="label">${uiLabelMap.ProductProductIdTo}</td>
                <td>&nbsp;</td>
                <td><b>${productIdTo!}</b> ${uiLabelMap.ProductRecreateAssociation}</td>
            </tr>
            <tr>
                <td align="right" class="label">${uiLabelMap.ProductAssociationType}</td>
                <td>&nbsp;</td>
                <td><b><#if curProductAssocType??>${(curProductAssocType.get("description",locale))!}<#else> ${productAssocTypeId!}</#if></b> ${uiLabelMap.ProductRecreateAssociation}</td>
            </tr>
            <tr>
                <td align="right" class="label">${uiLabelMap.CommonFromDate}</td>
                <td>&nbsp;</td>
                <td><b>${fromDate!}</b> ${uiLabelMap.ProductRecreateAssociation}</td>
            </tr>
        </#if>
        <tr>
            <td width="26%" align="right" class="label">${uiLabelMap.CommonThruDate}</td>
            <td>&nbsp;</td>
            <td width="74%">
            <div>
              <#if useValues> 
                <#assign value = productAssoc.thruDate!>
              <#else> 
                <#assign value = (request.getParameter("THRU_DATE"))!>
              </#if>            
                <@htmlTemplate.renderDateTimeField name="THRU_DATE" event="" action="" value="${value}" className="" alert="" title="Format: yyyy-MM-dd HH:mm:ss.SSS" size="25" maxlength="30" id="thruDate1" dateType="date" shortDateInput=false timeDropdownParamName="" defaultDateTimeString="" localizedIconTitle="" timeDropdown="" timeHourName="" classString="" hour1="" hour2="" timeMinutesName="" minutes="" isTwelveHour="" ampmName="" amSelected="" pmSelected="" compositeType="" formName=""/>                
            </div>
            </div>
            </td>
        </tr>
        <tr>
            <td width="26%" align="right" class="label">${uiLabelMap.ProductSequenceNum}</td>
            <td>&nbsp;</td>
            <td width="74%"><input type="text" name="SEQUENCE_NUM" <#if useValues>value="${(productAssoc.sequenceNum)!}"<#else>value="${(request.getParameter("SEQUENCE_NUM"))!}"</#if> size="5" maxlength="10" /></td>
        </tr>
        <tr>
            <td width="26%" align="right" class="label">${uiLabelMap.ProductReason}</td>
            <td>&nbsp;</td>
            <td width="74%"><input type="text" name="REASON" <#if useValues>value="${(productAssoc.reason)!}"<#else>value="${(request.getParameter("REASON"))!}"</#if> size="60" maxlength="255" /></td>
        </tr>
        <tr>
            <td width="26%" align="right" class="label">${uiLabelMap.ProductInstruction}</td>
            <td>&nbsp;</td>
            <td width="74%"><input type="text" name="INSTRUCTION" <#if useValues>value="${(productAssoc.instruction)!}"<#else>value="${(request.getParameter("INSTRUCTION"))!}"</#if> size="60" maxlength="255" /></td>
        </tr>

        <tr>
            <td width="26%" align="right" class="label">${uiLabelMap.ProductQuantity}</td>
            <td>&nbsp;</td>
            <td width="74%"><input type="text" name="QUANTITY" <#if useValues>value="${(productAssoc.quantity)!}"<#else>value="${(request.getParameter("QUANTITY"))!}"</#if> size="10" maxlength="15" /></td>
        </tr>

        <tr>
            <td colspan="2">&nbsp;</td>
            <td><input type="submit" <#if isCreate>value="${uiLabelMap.CommonCreate}"<#else>value="${uiLabelMap.CommonUpdate}"</#if> /></td>
        </tr>
        </table>
        </form>
    </div>
</div>
<#if productId?? && product??>
<div class="screenlet">
    <div class="screenlet-title-bar">
        <h3>${uiLabelMap.ProductAssociationsFromProduct}</h3>
    </div>
    <div class="screenlet-body">
        <table cellspacing="0" class="table">
            <tr class="header-row">
            <td><b>${uiLabelMap.ProductProductId}</b></td>
            <td><b>${uiLabelMap.ProductName}</b></td>
            <td><b>${uiLabelMap.CommonFromDateTime}</b></td>
            <td><b>${uiLabelMap.CommonThruDateTime}</b></td>
            <td><b>${uiLabelMap.ProductSeqNum}</b></td>
            <td><b>${uiLabelMap.CommonQuantity}</b></td>
            <td><b>${uiLabelMap.ProductAssociationType}</b></td>
            <td><b>&nbsp;</b></td>
            <td><b>&nbsp;</b></td>
            </tr>
            <#assign rowClass = "2">
            <#list assocFromProducts as assocFromProduct>
            <#assign listToProduct = assocFromProduct.getRelatedOne("AssocProduct", true)>
            <#assign curProductAssocType = assocFromProduct.getRelatedOne("ProductAssocType", true)>
            <tr valign="middle"<#if rowClass == "1"> class="alternate-row"</#if>>
                <td><a href="<@ofbizUrl>EditProduct?productId=${(assocFromProduct.productIdTo)!}</@ofbizUrl>" class="btn btn-link">${(assocFromProduct.productIdTo)!}</a></td>
                <td><#if listToProduct??><a href="<@ofbizUrl>EditProduct?productId=${(assocFromProduct.productIdTo)!}</@ofbizUrl>" class="btn btn-link">${(listToProduct.internalName)!}</a></#if>&nbsp;</td>
                <td <#if (assocFromProduct.getTimestamp("fromDate"))?? && nowDate.before(assocFromProduct.getTimestamp("fromDate"))> style="color: red;"</#if>>
                ${(assocFromProduct.fromDate)!}&nbsp;</td>
                <td <#if (assocFromProduct.getTimestamp("thruDate"))?? && nowDate.after(assocFromProduct.getTimestamp("thruDate"))> style="color: red;"</#if>>
                ${(assocFromProduct.thruDate)!}&nbsp;</td>
                <td>&nbsp;${(assocFromProduct.sequenceNum)!}</td>
                <td>&nbsp;${(assocFromProduct.quantity)!}</td>
                <td><#if curProductAssocType??> ${(curProductAssocType.get("description",locale))!}<#else>${(assocFromProduct.productAssocTypeId)!}</#if></td>
                <td>
                <a href="<@ofbizUrl>UpdateProductAssoc?UPDATE_MODE=DELETE&amp;productId=${productId}&amp;PRODUCT_ID=${productId}&amp;PRODUCT_ID_TO=${(assocFromProduct.productIdTo)!}&amp;PRODUCT_ASSOC_TYPE_ID=${(assocFromProduct.productAssocTypeId)!}&amp;FROM_DATE=${(assocFromProduct.fromDate)!}&amp;useValues=true</@ofbizUrl>" class="btn btn-link">
                ${uiLabelMap.CommonDelete}</a>
                </td>
                <td>
                <a href="<@ofbizUrl>EditProductAssoc?productId=${productId}&amp;PRODUCT_ID=${productId}&amp;PRODUCT_ID_TO=${(assocFromProduct.productIdTo)!}&amp;PRODUCT_ASSOC_TYPE_ID=${(assocFromProduct.productAssocTypeId)!}&amp;FROM_DATE=${(assocFromProduct.fromDate)!}&amp;useValues=true</@ofbizUrl>" class="btn btn-link">
                ${uiLabelMap.CommonEdit}</a>
                </td>
            </tr>
            <#-- toggle the row color -->
            <#if rowClass == "2">
                <#assign rowClass = "1">
            <#else>
                <#assign rowClass = "2">
            </#if>
            </#list>
        </table>
    </div>
</div>
<div class="screenlet">
    <div class="screenlet-title-bar">
        <h3>${uiLabelMap.ProductAssociationsToProduct}</h3>
    </div>
    <div class="screenlet-body">
        <table cellspacing="0" class="table">
            <tr class="header-row">
            <td><b>${uiLabelMap.ProductProductId}</b></td>
            <td><b>${uiLabelMap.ProductName}</b></td>
            <td><b>${uiLabelMap.CommonFromDateTime}</b></td>
            <td><b>${uiLabelMap.CommonThruDateTime}</b></td>
            <td><b>${uiLabelMap.ProductAssociationType}</b></td>
            <td><b>&nbsp;</b></td>
            </tr>
            <#assign rowClass = "2">
            <#list assocToProducts as assocToProduct>
            <#assign listToProduct = assocToProduct.getRelatedOne("MainProduct", true)>
            <#assign curProductAssocType = assocToProduct.getRelatedOne("ProductAssocType", true)>
            <tr valign="middle"<#if rowClass == "1"> class="alternate-row"</#if>>
                <td><a href="<@ofbizUrl>EditProduct?productId=${(assocToProduct.productId)!}</@ofbizUrl>" class="btn btn-link">${(assocToProduct.productId)!}</a></td>
                <td><#if listToProduct??><a href="<@ofbizUrl>EditProduct?productId=${(assocToProduct.productId)!}</@ofbizUrl>" class="btn btn-link">${(listToProduct.internalName)!}</a></#if></td>
                <td>${(assocToProduct.getTimestamp("fromDate"))!}&nbsp;</td>
                <td>${(assocToProduct.getTimestamp("thruDate"))!}&nbsp;</td>
                <td><#if curProductAssocType??> ${(curProductAssocType.get("description",locale))!}<#else> ${(assocToProduct.productAssocTypeId)!}</#if></td>
                <td>
                <a href="<@ofbizUrl>UpdateProductAssoc?UPDATE_MODE=DELETE&amp;productId=${(assocToProduct.productIdTo)!}&amp;PRODUCT_ID=${(assocToProduct.productId)!}&amp;PRODUCT_ID_TO=${(assocToProduct.productIdTo)!}&amp;PRODUCT_ASSOC_TYPE_ID=${(assocToProduct.productAssocTypeId)!}&amp;FROM_DATE=${(assocToProduct.fromDate)!}&amp;useValues=true</@ofbizUrl>" class="btn btn-link">
                ${uiLabelMap.CommonDelete}</a>
                </td>
            </tr>
            <#-- toggle the row color -->
            <#if rowClass == "2">
                <#assign rowClass = "1">
            <#else>
                <#assign rowClass = "2">
            </#if>
            </#list>
        </table>
    </div>
</div>
</#if>
<br />
<span class="tooltip">${uiLabelMap.CommonNote} : ${uiLabelMap.ProductHighlightedExplanation}</span>

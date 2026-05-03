<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
	<c:set var="registerFlag" value="${empty sampleVO.id ? 'create' : 'modify'}"/>
    <title>Sample <c:if test="${registerFlag == 'create'}"><spring:message code="button.create" /></c:if>
                  <c:if test="${registerFlag == 'modify'}"><spring:message code="button.modify" /></c:if>
    </title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />    

	<!-- eGovFrame Common import -->        
	<link rel="stylesheet" href="<c:url value="/css/egovframework/mbl/cmm/jquery.mobile-1.4.5.css" />" />
	<link rel="stylesheet" href="<c:url value="/css/egovframework/mbl/cmm/EgovMobile-1.4.5.css" />" />
	<script src="<c:url value="/js/egovframework/mbl/cmm/jquery-1.11.2.min.js" />"></script>
	<script src="<c:url value="/js/egovframework/mbl/cmm/jquery.mobile-1.4.5.min.js" />"></script>
	<script src="<c:url value="/js/egovframework/mbl/cmm/EgovMobile-1.4.5.js" />"></script>

	<!--For Custom Validation-->
	<script type="text/javascript" src="<c:url value='/js/egovframework/mbl/cmm/EgovValidation.js'/>" defer></script>

		<script>
			/* 글 목록 화면 function */
		    function sampleList() {
		    	document.detailForm.action = "<c:url value='/egovSampleList.do'/>";
		       	document.detailForm.method = 'get';
		       	document.detailForm.submit();
		    }
		
		    function sampleAdd() {
		        if (confirm('등록하시겠습니까?')) {
		            let frm = document.detailForm;
		            if (!validateSampleVO(frm)) {
		                return;
		            } else {
		            	frm.action = "<c:url value='/addSample.do'/>";
		                frm.submit();
		            }
		        }
		    }
		
		    function sampleUpdate() {
		        if (confirm('수정하시겠습니까?')) {
		            let frm = document.detailForm;
		            if (!validateSampleVO(frm)) {
		                return;
		            } else {
		            	frm.action = "<c:url value='/updateSample.do'/>";
		                frm.submit();
		            }
		        }
		    }

		    function sampleDelete() {
		        if (confirm('삭제하시겠습니까?')) {
		        	document.detailForm.action = "<c:url value='/deleteSample.do'/>";
		           	document.detailForm.submit();
		        }
		    }
		</script>
	</head>
	
	<body>
		<!-- page start -->
		<div data-role="page" data-theme="d">
           
            <!-- header start -->
            <div data-role="header" data-theme="g">
                <h1>
	                <c:if test="${registerFlag == 'create'}"><spring:message code="button.create" /></c:if>
					<c:if test="${registerFlag == 'modify'}"><spring:message code="button.modify" /></c:if>
                </h1>
                <a href="<c:url value="/egovSampleList.do"/>"  data-ajax="false" data-icon="grid" class="ui-btn-right"><spring:message code="button.list" /></a>
            </div>  
            <!-- header end -->
            
            <!-- content start -->      
            <div data-role="content">
            	
	<form:form id="detailForm" name="detailForm" modelAttribute="sampleVO">
	<spring:message code="confirm.required.name" var="placeholderName"/>
	<spring:message code="confirm.required.description" var="placeholderDescription"/>
	<spring:message code="confirm.required.user" var="placeholderUser"/>
            		<c:if test="${registerFlag == 'modify'}">
	            	<div data-role="fieldcontain">
						<label for="id"><spring:message code="title.sample.id" /></label>
                        <form:input id="id" path="id" maxlength="10" readonly="true"/>	
	            	</div>
	            	</c:if>
            		<div data-role="fieldcontain">
                        <label for="name"><spring:message code="title.sample.name" /></label>
                        <form:input id="name" path="name" maxlength="30" />
                    </div>  
                    <div data-role="fieldcontain">
                        <label for="description"><spring:message code="title.sample.description" /></label>
                        <form:textarea id="description" path="description" cols="58" rows="5" />
                    </div>  
                    <div data-role="fieldcontain">
                        <label for="useYn"><spring:message code="title.sample.useYn" /></label>
                        <form:select path="useYn" id="useYn">
								<form:option value="Y">Yes</form:option>
								<form:option value="N">No</form:option>
						</form:select>
                    </div>  
                    <div data-role="fieldcontain">
                        <label for="regUser"><spring:message code="title.sample.regUser" /></label>
                        <c:if test="${registerFlag == 'modify'}">
                        	<form:input id="regUser" path="regUser" maxlength="10" readonly="true"/>
                        </c:if>
                        <c:if test="${registerFlag == 'create'}">
                        	<form:input id="regUser" path="regUser" maxlength="10"/>
                        </c:if>
                    </div> 
        			
        			<fieldset class="ui-grid-a">
	                    <c:if test="${registerFlag == 'modify'}">
	                    	<div class="ui-block-a"><a href="javascript:sampleUpdate();" data-role="button" data-theme="b"><spring:message code="button.modify" /></a></div>
							<div class="ui-block-b"><a href="javascript:sampleDelete();" data-role="button"><spring:message code="button.delete" /></a></div>
						</c:if>
					</fieldset>
                    
                    <c:if test="${registerFlag == 'create'}">
                    	<a href="javascript:sampleAdd();" data-role="button" data-theme="b"><spring:message code="button.create" /></a>
                    </c:if>

            	</form:form>
            	
            </div>	
            <!-- content end --> 
            
		    <!-- footer start -->
            <div data-role="footer" data-theme="g">
                 <h4 class="main">EgovMobile</h4>
            </div>
            <!-- footer end -->   
         
         </div>
         <!-- page end -->
	</body>
</html>
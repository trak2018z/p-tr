<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<t:layout>
    <jsp:body>
        <h1>Typy praktyk</h1>
        <!--Formularz wyszukiwania -->
        <form:form method="post" modelAttribute="search" >
            <form:input path="type" id="type" type="text"></form:input>
                <button type="submit" class="btn btn-info">
                    <span class="glyphicon glyphicon-search"></span> Szukaj
                </button>
        </form:form>

        <c:if test="${not empty msg}">           
            <div class="alert alert-success" role="alert">	<div class="text-center">
                    <span class="glyphicon glyphicon-ok"></span>
                    ${msg}
                </div>
            </div>
        </c:if>
        <!--Button nowej encji -->
        <a class="btn btn-primary" href="<c:url
               value="/TypPraktyk/nowy"/>">
            <span class="glyphicon glyphicon-plus"></span> Dodaj nowy typ praktyk
        </a>
        <c:choose>
            <c:when test="${empty elements}">
                <div role="alert">			
                    <strong>Nie znaleziono żadnych typów praktyk.</strong>
                </div>
            </c:when>
            <c:otherwise>

                <table class="table table-hover table-striped table-responsive">
                    <thead>
                        <tr>
                            <th>Typ Praktyk</th>
                            <th>Stan</th>
                            <th>Edytuj</th>
                            <th>Zmień stan</th>
                            <th>Usuń</th>
                        </tr>

                    </thead>
                    <tbody>
                        <c:forEach var="element" items="${elements}">
                            <tr>
                                <td>
                                    <a class="btn btn-link" href="<c:url
                                           value="/TypPraktyk/widok/${element.internshipTypeId}"/>">
                                       ${element.type}
                                       <br/>
                                       ${element.duration}
                                    </a>
                                </td>
                                <td><c:choose>
                                        <c:when test="${element.enabled}">  
                                            Aktywna
                                        </c:when> 
                                        <c:otherwise>
                                            Zablokowana
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <!--Edytuj -->
                                    <a class="btn btn-link" href="<c:url
                                           value="/TypPraktyk/edycja/${element.internshipTypeId}"/>">
                                        <span class="glyphicon glyphicon-edit" aria-label="Edytuj"></span>
                                    </a>
                                </td>
                                <td>
                                    <!--Zablokuj -->
                                    <c:if test="${element.enabled}">
                                        <c:url var="zablokujUrl" value="/TypPraktyk/${element.internshipTypeId}/zablokuj"/>
                                        <form action="${zablokujUrl}" method="post">                       
                                            <button class="btn btn-link" type="submit"> 
                                                <span class="glyphicon glyphicon-ban-circle" aria-label="Zablokuj"></span>
                                            </button>                                          
                                        </form>
                                    </c:if> 
                                    <!--Odblokuj -->
                                    <c:if test="${!element.enabled}">
                                        <c:url var="odblokujUrl" value="/TypPraktyk/${element.internshipTypeId}/odblokuj"/>
                                        <form action="${odblokujUrl}" method="post">                         
                                            <button class="btn btn-link" type="submit"> 
                                                <span class="glyphicon glyphicon-ok-circle" aria-label="Odblokuj"></span>
                                            </button>                     
                                        </form> 
                                    </c:if>   
                                </td>
                                <td>
                                    <!--Usuń -->
                                    <c:url var="usunUrl" value="/TypPraktyk/${element.internshipTypeId}/usun"/>
                                    <form action="${usunUrl}" method="post"
                                          onsubmit="return confirm('Czy chcesz usunąć wybrany typ praktyk?') ? true : false;">                    
                                        <c:choose>
                                            <c:when test="${empty element.internshipCollection}">  
                                                <button class="btn btn-link" type="submit"> 
                                                    <span class="glyphicon glyphicon-trash" style="color:red" aria-label="Usuń"></span>
                                                </button>
                                            </c:when>    
                                            <c:otherwise>
                                                <button class="btn btn-link" type="submit" disabled="disabled"> 
                                                    <span class="glyphicon glyphicon-trash" style="color:lightgrey" 
                                                          aria-label="Usunięcie niemożliwe"></span>
                                                </button>
                                                <br />
                                            </c:otherwise>
                                        </c:choose>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>


                <!--Paginacja -->
                <c:if test="${endIndex >1 }">                                            
                    <c:url var="firstUrl" value="/TypPraktyk/lista/1" />
                    <c:url var="lastUrl" value="/TypPraktyk/lista/${thePage.totalPages}" />
                    <c:url var="prevUrl" value="/TypPraktyk/lista/${currentIndex - 1}" />
                    <c:url var="nextUrl" value="/TypPraktyk/lista/${currentIndex + 1}" />

                    <div class="text-center">
                        <ul class="pagination">
                            <c:choose>
                                <c:when test="${currentIndex == 1}">
                                    <li class="disabled"><a href="#">&lt;&lt;</a></li>
                                    <li class="disabled"><a href="#">&lt;</a></li>
                                    </c:when>
                                    <c:otherwise>
                                    <li><a href="${firstUrl}">&lt;&lt;</a></li>
                                    <li><a href="${prevUrl}">&lt;</a></li>
                                    </c:otherwise>
                                </c:choose>
                                <c:forEach var="i" begin="${beginIndex}" end="${endIndex}">
                                    <c:url var="pageUrl" value="/TypPraktyk/lista/${i}" />
                                    <c:choose>
                                        <c:when test="${i == currentIndex}">
                                        <li class="active"><a href="${pageUrl}"><c:out value="${i}" /></a></li>
                                        </c:when>
                                        <c:otherwise>
                                        <li><a href="${pageUrl}"><c:out value="${i}" /></a></li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                                <c:choose>
                                    <c:when test="${currentIndex == thePage.totalPages}">
                                    <li class="disabled"><a href="#">&gt;</a></li>
                                    <li class="disabled"><a href="#">&gt;&gt;</a></li>
                                    </c:when>
                                    <c:otherwise>
                                    <li><a href="${nextUrl}">&gt;</a></li>
                                    <li><a href="${lastUrl}">&gt;&gt;</a></li>
                                    </c:otherwise>
                                </c:choose>
                        </ul>
                    </div>
                </c:if>
                <!--Paginacja KONIEC-->
            </c:otherwise>
        </c:choose>
    </jsp:body>
</t:layout>
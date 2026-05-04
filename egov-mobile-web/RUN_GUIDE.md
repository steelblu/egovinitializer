# egov-mobile-web 실행 가이드

## 사전 요구사항
- Java 17 이상
- Maven 3.9+ (프로젝트 내 `egov-web/apache-maven-3.9.9` 사용 가능)
- Git (히스토리 정리 시 필요)

---

## 1. 프로젝트 준비

### 1.1 히스토리 정리 (최초 1회)
GitHub 푸시 시 대용량 파일(100MB 초과) 제한으로 인해 `egov-web` 디렉토리를 히스토리에서 제거해야 함:

```bash
# git-filter-repo 설치
python -m ensurepip --upgrade
python -m pip install git-filter-repo

# egov-web 디렉토리를 히스토리에서 완전 제거
cd C:\git\egov2
git filter-repo --path egov-web/ --invert-paths --force

# 원격 저장소에 강제 푸시
git push -f -u origin2 main
```

### 1.2 빌드
```bash
cd C:\git\egov2\egov-mobile-web
"C:\git\egov2\egov-web\apache-maven-3.9.9\bin\mvn" clean package -DskipTests
```

---

## 2. 실행 방법

### 2.1 Maven Jetty 플러그인 사용 (권장)
`pom.xml`에 Jetty 플러그인이 설정되어 있음:

```xml
<plugin>
    <groupId>org.eclipse.jetty</groupId>
    <artifactId>jetty-maven-plugin</artifactId>
    <version>11.0.15</version>
    <configuration>
        <httpConnector>
            <port>8080</port>
        </httpConnector>
        <webApp>
            <contextPath>/${project.artifactId}-${project.version}</contextPath>
        </webApp>
        <securityHandler>
            <securityHandlerType>org.eclipse.jetty.security.SecurityHandler$NoOp</securityHandlerType>
        </securityHandler>
    </configuration>
</plugin>
```

실행 명령:
```bash
cd C:\git\egov2\egov-mobile-web
"C:\git\egov2\egov-web\apache-maven-3.9.9\bin\mvn" jetty:run
```

### 2.2 접속 URL
- 기본 URL: `http://localhost:8080/egovframe-project-1.0.0/`
- 게시판 목록: `http://localhost:8080/egovframe-project-1.0.0/egovSampleList.do`

---

## 3. 문제 해결

### 3.1 503/404 에러 발생 시
원인: `web.xml`의 BASIC 인증 설정 또는 `error.jsp` 파일 누락

해결:
1. `src/main/webapp/WEB-INF/web.xml`에서 `<login-config>` 섹션 주석 처리:
```xml
<!-- <login-config>
    <auth-method>BASIC</auth-method>
</login-config> -->
```

2. `src/main/webapp/common/error.jsp` 파일 생성:
```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head><title>Error</title></head>
<body>
    <h2>An error occurred.</h2>
    <p>Error: ${exception}</p>
</body>
</html>
```

### 3.2 포트 충돌 시
다른 포트로 실행:
```bash
mvn jetty:run -Djetty.http.port=8082
```

### 3.3 실행 중인 Jetty 프로세스 종료 (Windows)
```bash
wmic process where "CommandLine like '%java%' and CommandLine like '%Jetty%'" delete
```

---

## 4. 데이터베이스 설정
현재 `src/main/resources/egovframework/spring/context-datasource.xml`에서 **HSQL 임베디드 DB** 사용 중 (개발용):

```xml
<jdbc:embedded-database id="dataSource" type="HSQL">
    <jdbc:script location="classpath:/db/sampledb.sql"/>
</jdbc:embedded-database>
```

다른 DB 사용 시 해당 섹션의 주석을 해제하고 설정 변경.

---

## 5. 주요 설정 파일
| 파일 | 설명 |
|------|------|
| `pom.xml` | Maven 빌드 및 Jetty 플러그인 설정 |
| `src/main/webapp/WEB-INF/web.xml` | 서블릿, 필터, 보안 설정 |
| `src/main/webapp/WEB-INF/config/egovframework/springmvc/dispatcher-servlet.xml` | Spring MVC 설정 |
| `src/main/resources/egovframework/spring/context-*.xml` | Spring 컨텍스트 설정 (데이터소스, 트랜잭션 등) |

---

## 6. 빌드 및 실행 요약
```bash
# 1. 빌드
cd C:\git\egov2\egov-mobile-web
"C:\git\egov2\egov-web\apache-maven-3.9.9\bin\mvn" clean package -DskipTests

# 2. 실행
"C:\git\egov2\egov-web\apache-maven-3.9.9\bin\mvn" jetty:run

# 3. 접속
# 브라우저에서 http://localhost:8080/egovframe-project-1.0.0/ 열기
```

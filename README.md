# histudy
- 개요

  ### [1. Introduction](#Introduction)
  
  ### [2. Skill](#Archiecture) 


  ### [3. Site Map](#Site-Map)

  <br>
## Introduction
<h1>스터디 & 멘토링 통합 관리 플랫폼</h1>

📆 개발 기간 : 2026.01.19 ~ 2026.02.25  
👨‍👩‍👧‍👦 개발 인원 : 6명 (팀 프로젝트)

### 📖 프로젝트 개요
기존 스터디 카페 예약 시스템과 멘토링 매칭 시스템이 분리되어 있는 문제를 해결하기 위해  
스터디 공간 예약, 멘토 매칭, 결제, 리뷰 기능을 하나의 플랫폼으로 통합 구현

사용자는 스터디 카페 좌석을 실시간으로 조회 및 예약할 수 있으며,  
멘토링 신청 및 결제, 리뷰 작성까지 하나의 서비스 내에서 처리할 수 있도록 설계

### 프로젝트 목표
- 역할 기반 접근 제어 (사용자 / 관리자)
- MVC 패턴 기반 3-Tier 아키텍처 설계
- MyBatis 기반 SQL 매핑 구조 설계
- 유지보수성을 고려한 계층 분리

## Architecture

### 3-Tier Architecture 기반 설계

| Presentation Tier | Application Tier | Data Tier |
|-------------------|------------------|-----------|
| HTML/CSS/JS       | Servlet (Controller) | Oracle DB |
| JSP (View)        | Service (Business Logic) | MyBatis |
|                   | Spring Legacy Framework | DAO |
|                   | Tomcat 9.0 (WAS) | |

### 설계 특징
- MVC 패턴 적용 (Controller / Service / DAO 분리)
- Service 계층에서 비즈니스 로직 집중 처리
- MyBatis 기반 SQL Mapper 구조 설계
- Zero Configuration 자동 설정에 의존하기 보다, 개발자가 직접 설정 함으로서, 데이터의 흐름을 명확히 파악하기 위해 Spring Legacy 사용

### PPT 소개
[2팀_PPT.pdf](https://github.com/user-attachments/files/25600895/2._PPT.pdf)
<hr>

# Site Map
<img width="1121" height="1019" alt="image" src="https://github.com/user-attachments/assets/f43cc575-d75d-4858-8425-9013cfbbacb0" />

### 사용자
- 회원가입 / 로그인
- 스터디 카페 조회
- 좌석 예약 및 결제
- 멘토 검색 및 신청
- 리뷰 작성

### 관리자
- 스터디 카페 등록/수정
- 좌석 관리
- 멘토 승인 관리
- 신고 처리 및 리뷰 관리

# Use Case Diagram
사용자는 예약, 결제, 리뷰, 스터디 개설, 멘토링 개설 등 수행 가능
관리자는 공간 관리 및 사용자 활동을 관리 가능

- 사용자 유즈케이스
<img width="1303" hght="701" alt="image" src="https://github.com/user-attachments/assets/01166b7f-471f-4fa5-8859-17460e9858f5" />

- 관리자 유즈케이스
<img width="1268" height="806" alt="image" src="https://github.com/user-attachments/assets/b0096210-1b4e-4834-9a14-b50a4ac5b384" />

주요 Use Case:
- 좌석 예약
- 결제 처리
- 멘토링 신청
- 리뷰 작성
- 관리자 승인 및 신고 처리
# FlowChart

# 요구사항 정의서

# 요구사항 세부 계획서


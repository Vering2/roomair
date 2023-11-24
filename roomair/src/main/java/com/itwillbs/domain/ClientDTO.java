package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ClientDTO {

private String clientType;
private String clientCode;
private String clientCompany;
private String clientNumber;
private String clientDetail;
private String clientCeo; 
private String clientName;
private String clientAddr1;
private String clientAddr2;
private String clientTel;
private String clientPhone;
private String clientFax;
private String clientEmail;
private String clientMemo;

private String aliasAddr1;
private String aliasMemo;
private int clientSale;


}
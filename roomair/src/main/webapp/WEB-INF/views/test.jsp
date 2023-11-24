<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<thead>
  <tr>
    <th class="tg-3xi5"><label for="clientType_label"><b>구분</b> </label></th>
    <th class="tg-3xi5"><input type="text" name="clientType" id="clientType"><br>		<br><br>		<span id="buy_name_msg"></span></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-c3ow"><label for="clientCode_label"><b>거래처코드</b></label></td>
    <td class="tg-c3ow"><input type="text" name="clientCode" id="clientCode"><br>		<br> <br>		<span id="clientCode_msg"></span></td>
  </tr>
  <tr>
    <td class="tg-c3ow"><label for="clientCompany_label"><b>거래처명</b> </label></td>
    <td class="tg-c3ow"><input type="text" name="clientCompany" id="clientCompany"><br>		<br><br>		<span id="clientCompany_msg"></span></td>
  </tr>
  <tr>
    <td class="tg-c3ow"><label for="clientNumber_label"><b>사업자번호</b> </label></td>
    <td class="tg-c3ow"><input type="text" name="clientNumber" id="clientNumber"><br>		<br><br>		<span id="clientNumber_msg"></span></td>
  </tr>
  <tr>
    <td class="tg-c3ow"><label for="clientDetail_label"><b>업태</b> </label></td>
    <td class="tg-c3ow"><input type="text" name="clientDetail" id="clientDetail"><br>		<br><br>		<span id="clientDetail_msg"></span></td>
  </tr>
  <tr>
    <td class="tg-0lax"><label for="clientCeo"><b>거래처대표</b></label></td>
    <td class="tg-0lax"><input type="text" name="clientCeo" id="clientCeo"><br>		<br><br>		<span id="clientCeo_msg"></span></td>
  </tr>
  <tr>
    <td class="tg-0lax"><label for="clientName_label"><b>거래담당자</b></label></td>
    <td class="tg-0lax"><input type="text" name="clientName" id="clientName"><br><br> <br>		<span id="clientName_msg"></span><br></td>
  </tr>
  <tr>
    <td class="tg-0lax"><label for="clientAddress_label"><b>우편주소</b></label></td>
    <td class="tg-0lax"><input type="text" id="sample4_postcode" placeholder="우편번호" name="clientAddr1"  readonly required><br><br><input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" required><br><br></td>
  </tr>
  <tr>
    <td class="tg-0lax"><label for="clientAddress_label"><b>상세 주소</b></label></td>
    <td class="tg-0lax"><input type="text" id="sample4_roadAddress" placeholder="도로명주소" name="clientAddr2" size="60"  readonly required><br></td>
  </tr>
  <tr>
    <td class="tg-0lax"><label for="clientTel"><b>거래처번호</b></label></td>
    <td class="tg-0lax"><input type="text" name="clientTel" id="clientTel"><br>		<br><br>		<span id="clientTel_msg"></span></td>
  </tr>
  <tr>
    <td class="tg-0lax"><label for="clientPhone"><b>담당자번호</b></label></td>
    <td class="tg-0lax"><input type="text" name="clientPhone" id="clientPhone"><br><br>		<span id="clientPhone_msg"></span></td>
  </tr>
  <tr>
    <td class="tg-0lax"><label for="clientFax"><b>팩스자번호</b></label></td>
    <td class="tg-0lax"><input type="text" name="clientFax" id="clientFax"><br><br>		<span id="clientFax_msg"></span></td>
  </tr>
  <tr>
    <td class="tg-0lax"><label for="clientEmail"><b>이메일</b></label></td>
    <td class="tg-0lax"><input type="text" name="clientEmail" id="clientEmail"><br>		<br><br>		<span id="clientEmail_msg"></span></td>
  </tr>
  <tr>
    <td class="tg-0lax"><label for="clientMemo_label"><b>비고</b> </label></td>
    <td class="tg-0lax"><input type="text" name="clientMemo" id="clientMemo"><br>		<br><br>		<span id="clientMemo_msg"></span></td>
  </tr>
</tbody>
</table>

</body>
</html>
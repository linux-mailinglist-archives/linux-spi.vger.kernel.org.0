Return-Path: <linux-spi+bounces-5970-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6CE9E8B02
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2024 06:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40C08162B8F
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2024 05:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592F84594D;
	Mon,  9 Dec 2024 05:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aCLOd3am"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE7A46B8;
	Mon,  9 Dec 2024 05:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733722362; cv=none; b=Puw2E8bbw16FQdhJ/mpKInmrtq/XEMTyEmszu9F/nra3CGW8R4h9aGi2ifTYa3wNDKYtYjuNXBf4lD+XcaaCJ7mLBYziWf+HBbws69CN7nQnGJuwfQBaSZg1Nj32mWuI2K42Z0Gd4WRAujzaLg5iny3rN7F+QoIbAg8Z5UMJOTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733722362; c=relaxed/simple;
	bh=RQ5oQo8SxDBtePLqfOBk4lGNufZRMIUd4JHmtubNLNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ahUgWQAOgc77uosNtAjMhSV6EHjE3gHXBrocQSSLbhAby9V8NzfwsxGnevyv1AYFHpM9qGW4/ygCXkjlmFGrXI66w09+v9DuWuxmv1AyGC914F5Aot1W5h2mJ5KNL7peq7x8x/CvQbFv+jzY3PSE9fIOYUCVug/oh9ARlUqmPPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aCLOd3am; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8LgcYl014795;
	Mon, 9 Dec 2024 05:32:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	loJ2PPIiOAPLRSCVZCnNH0CdMiAT0SPjFo21iTGHqUw=; b=aCLOd3amVCjSumKH
	VekaGnFqozdX+FgK4ZLv1Ou3NCOhF6Q9iFjWMwfc05pz8VONzAZy0rT67S0Zhk8K
	zzeA0CMBPiU3N9XnOpNL1lahdIjdVCXti9ITqBlhMUjUfOFQ2MCJQSeV/wspS4BS
	yomD1SvV0mtJ3IDbuD7jIR4ZO2l/tO/m+uZV31Pq8GE3bv0M7zHlo+ZKeR0AhPy1
	5QIkHXt8LtJTPUM6mKnTmmA5vWOceDB8eT2Zw228GQKgwuNNK2qdkjqMUGhn0ixC
	UlM5yfHwFjE7Y7OrBp8Q6PQ8RAL5spOLsPLA+/7ETbEskVyw2Ic7Q8tu3XH9/OGy
	YqvsiA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cbqn3nah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 05:32:20 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B95WJx0022049
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 05:32:19 GMT
Received: from [10.151.36.43] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 8 Dec 2024
 21:32:13 -0800
Message-ID: <569d2c24-daa9-65e2-e5a4-2c2ced2a3b57@quicinc.com>
Date: Mon, 9 Dec 2024 11:02:11 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v14 7/8] arm64: dts: qcom: ipq9574: Add SPI nand support
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, <broonie@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20241120091507.1404368-1-quic_mdalam@quicinc.com>
 <20241120091507.1404368-8-quic_mdalam@quicinc.com>
 <4c1fe789-5190-465d-bb41-3fe1534d2523@oss.qualcomm.com>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <4c1fe789-5190-465d-bb41-3fe1534d2523@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: j5vlEIXgkChl_JlH7o1N1NsBaDlrhm4m
X-Proofpoint-GUID: j5vlEIXgkChl_JlH7o1N1NsBaDlrhm4m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090043



On 12/5/2024 10:49 PM, Konrad Dybcio wrote:
> On 20.11.2024 10:15 AM, Md Sadre Alam wrote:
>> Add SPI NAND support for ipq9574 SoC.
>>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
> 
> [...]
> 
> Feel free to put dt patches in a separate series after Miquel picks
> up the mtd changes
Ok
> 
>>   &usb_0_dwc3 {
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> index d1fd35ebc4a2..45fb26bc9480 100644
> 
> board and dtsi patches should be 2 separate ones
Ok
> 
>> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> @@ -330,6 +330,33 @@ tcsr: syscon@1937000 {
>>   			reg = <0x01937000 0x21000>;
>>   		};
>>   
>> +		qpic_bam: dma-controller@7984000 {
>> +			compatible = "qcom,bam-v1.7.0";
>> +			reg = <0x7984000 0x1c000>;
> 
> Please pad the address part to 8 hex digits with leading zeroes
Ok
> 
>> +			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_QPIC_AHB_CLK>;
>> +			clock-names = "bam_clk";
>> +			#dma-cells = <1>;
>> +			qcom,ee = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		qpic_nand: spi@79b0000 {
>> +			compatible = "qcom,ipq9574-snand";
>> +			reg = <0x79b0000 0x10000>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			clocks = <&gcc GCC_QPIC_CLK>,
>> +				 <&gcc GCC_QPIC_AHB_CLK>,
>> +				 <&gcc GCC_QPIC_IO_MACRO_CLK>;
>> +			clock-names = "core", "aon", "iom";
>> +			dmas = <&qpic_bam 0>,
>> +			       <&qpic_bam 1>,
>> +			       <&qpic_bam 2>;
>> +			dma-names = "tx", "rx", "cmd";
> 
> Please make clock/dma names a vertical list, like clocks/dmas
Ok
> 
> Also, is it okay not to use any of the GCC_QPIC_BCR/
> GCC_QPIC_AHB_ARES/GCC_QPIC_ARES resets found in GCC?
It's recommended by HW team, will check once again with HW
team.
> 
> Konrad


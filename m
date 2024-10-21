Return-Path: <linux-spi+bounces-5267-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1339A5C2C
	for <lists+linux-spi@lfdr.de>; Mon, 21 Oct 2024 09:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD941F221C3
	for <lists+linux-spi@lfdr.de>; Mon, 21 Oct 2024 07:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B511D0E3F;
	Mon, 21 Oct 2024 07:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pHuDOKZU"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168721940A2;
	Mon, 21 Oct 2024 07:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729494872; cv=none; b=E+yrUNxZLwDSpFB7KRW9eN4SLb4UV76txvy6NVWioHpsi04nDSUb3LhUD2Z/aUriI5+2Vc5FcMq1pPb6++NyS3Fh1860XgRsf9FPYz8SGOUY2dKvp8RMGo36z97rOsCKjImiBWOZF+uIoraenE7VEc3b0V7NIofBjW0nNAL0eSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729494872; c=relaxed/simple;
	bh=+MdlbUTKWEtQqviIJ/ksqh2lJGVuwINgG4Sytyx9wH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oH3d0rzTBATSC/ii+EWC5vHcu/s0xnhomSXTzMVjkz3pdE7Bs4xHJgcZGqOVGUqmqoG3sfPnoC9fdRrLfkzZdVgTw1vThmoqKUKEtbhxQgUbG/alvavMuyih50BHkNicOEh6fn5E3Me5pq6xCapVHuM9fXDHP3jD1eqn5eYWe9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pHuDOKZU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49KNdnZD006185;
	Mon, 21 Oct 2024 07:13:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hBRCfPgu1vyB4VjNQILG00Eqs1DLwICYXQAWTx5WmFE=; b=pHuDOKZUR0it44Q/
	nHr7IGkZ4rHwX4zxV3HIaEc2MN7USMIBZ5VEAFvfoUTLvuyuPDy0Y5t6Hy0FyZ/j
	JdJFzRcUz/69DlVb+cWKTx+e6xnlSCyHAnXEZlzKXK8HNJNiV1TMhC7Soloj8Eem
	Pnw48cmP67eUaILBIyZJrhMQCO3K7mr99Pn3xwA6zpzCXNA0wRX8OYKWOyM9z7+a
	RPfHX+Wp02yx/2wmUP4mqxvM0jcc1N4g/n14Q6s/KkpP7UJZ1DC/GMdx1CuCdkVl
	piDeZs2Sn6173WlG9wxGrQrvS5yaplRnELYMx3KebW9/jnQGMvESU/9he1wQERD2
	YRHIfA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6w1kftv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 07:13:52 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49L7DpjO027079
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 07:13:51 GMT
Received: from [10.151.37.94] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 21 Oct
 2024 00:13:45 -0700
Message-ID: <78820059-a1fa-2402-1e7c-0a9445b4fe1f@quicinc.com>
Date: Mon, 21 Oct 2024 12:43:24 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v11 8/8] arm64: dts: qcom: ipq9574: Disable eMMC node
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, <broonie@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <arnd@arndb.de>,
        <esben@geanix.com>, <nikita.shubin@maquefel.me>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20241010070510.1504250-1-quic_mdalam@quicinc.com>
 <20241010070510.1504250-9-quic_mdalam@quicinc.com>
 <0bde12c0-0c36-4d7c-9538-25d1b55d2fa9@oss.qualcomm.com>
Content-Language: en-US
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <0bde12c0-0c36-4d7c-9538-25d1b55d2fa9@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lfY6icX4uid13RR-7aJTQUo6jJtK_pud
X-Proofpoint-ORIG-GUID: lfY6icX4uid13RR-7aJTQUo6jJtK_pud
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=556 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210050



On 10/19/2024 2:55 PM, Konrad Dybcio wrote:
> On 10.10.2024 9:05 AM, Md Sadre Alam wrote:
>> Disable eMMC node for rdp433, since rdp433
>> default boot mode is norplusnand
>>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
> 
> If eMMC is absent on this board, remove the whole &sdhc_1{} section
Ok, will remove in the next revision.
> 
> Konrad


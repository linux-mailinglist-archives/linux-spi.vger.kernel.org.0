Return-Path: <linux-spi+bounces-4929-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D82C97E954
	for <lists+linux-spi@lfdr.de>; Mon, 23 Sep 2024 12:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56F991C212DC
	for <lists+linux-spi@lfdr.de>; Mon, 23 Sep 2024 10:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D42519580F;
	Mon, 23 Sep 2024 10:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B5xC5zV7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B360C39AE3;
	Mon, 23 Sep 2024 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727085943; cv=none; b=psxdBwmufXTWfNPXRiX2HuupA6U4yvYMChBNnPptOMiIcFRX0cbyPmn++4jWwGFJ4M8ZiauTuMLf/gbJV0LfLbHUdC1wyOClDxgUy7nKBygTeazq+bQSZWqq+j3jO8alw1nHHXZ+yQPDms0zMlW44BvfQnBmJUrz0QCZ2mA3meI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727085943; c=relaxed/simple;
	bh=xJM7EG7cYKyfnELtnHenPtJt2QutNSZZBKlHYs+vaBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KpGaJt3Pl8P/M9FM27ttKmk1iG/57thJxkMoDsOD+OazIS6VxDp2IIZ3d8i61pfwI3bYgPKIXDFsSk1DRLDYvjvYlWNwa1zcvpO5AVZUa7n13ODCGeJVmezMuheIohwzZOokacppV9/6Er2QgmAO7e2qWRJbh4NR/GB09RB/Bhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B5xC5zV7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48MNhLlP007866;
	Mon, 23 Sep 2024 10:05:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eSxU2k9NCbNUH2pf9Tm0ETZbHPtkd038byigFo8KTng=; b=B5xC5zV7dwltOMj5
	vIuvg1AIUKpFLgKliL4Ii1k+KK+joATUL/rBQ5KXIztaV2f0qOL62jdtuSbFLlVn
	85ZBmbYCtq76U3NCrJ6ZnjFROeIx1iQPy39U6cx1BqZVbVwaIv6KBsdWk7czaW40
	bks0T2ZIsD+a+zmIg4p36UAMZ/aiYQWUJ2eV+JIkuZUoplsDSU9LkIqdKM4bSybf
	/+/z+2pLJ3YtC0QPQmVD1FrbJjxtjkbccnk4XeMZtDa3HBn+aICBjfjf92u0d8QW
	AQxQrb1qRExMDm6mtCoSQQfXFb25RMMo/HdNV59u+Hnzykcdo7w1mT7pAcda2Ny5
	2+dBGQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sn5bmkpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 10:05:14 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48NA5DWX013041
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 10:05:13 GMT
Received: from [10.216.21.87] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 23 Sep
 2024 03:05:06 -0700
Message-ID: <15cc4380-9ca7-c558-2aaf-7cc845c28854@quicinc.com>
Date: Mon, 23 Sep 2024 15:34:55 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v10 1/8] spi: dt-bindings: Introduce qcom,spi-qpic-snand
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <vkoul@kernel.org>,
        <nikita.shubin@maquefel.me>, <esben@geanix.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>
References: <20240922113351.2390195-1-quic_mdalam@quicinc.com>
 <20240922113351.2390195-2-quic_mdalam@quicinc.com>
 <k3id2ywyghhmoiekehko7ear2nef5ygmizvkax5s6sdi2zhn5d@yfhgl5xte4dw>
Content-Language: en-US
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <k3id2ywyghhmoiekehko7ear2nef5ygmizvkax5s6sdi2zhn5d@yfhgl5xte4dw>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fy0GyvuLSc280jdhAX0gFWgmbOmFECCu
X-Proofpoint-GUID: fy0GyvuLSc280jdhAX0gFWgmbOmFECCu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 mlxlogscore=889
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409230074



On 9/23/2024 2:02 AM, Krzysztof Kozlowski wrote:
> On Sun, Sep 22, 2024 at 05:03:44PM +0530, Md Sadre Alam wrote:
>> Document the QPIC-SPI-NAND flash controller present in the IPQ SoCs.
>> It can work both in serial and parallel mode and supports typical
>> SPI-NAND page cache operations.
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
>>
>> Change in [v10]
>>
>> * No change
> 
> ...
> 
>> +title: Qualcomm QPIC NAND controller
>> +
>> +maintainers:
>> +  - Md sadre Alam <quic_mdalam@quicinc.com>
>> +
>> +description:
>> +  The QCOM QPIC-SPI-NAND flash controller is an extended version of
>> +  the QCOM QPIC NAND flash controller. It can work both in serial
>> +  and parallel mode. It supports typical SPI-NAND page cache
>> +  operations in single, dual or quad IO mode with pipelined ECC
>> +  encoding/decoding using the QPIC ECC HW engine.
>> +
>> +allOf:
>> +  - $ref: /schemas/spi/spi-controller.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,spi-qpic-snand
> 
> Recently it turned out that Qualcomm generic compatibles are not
> generic... That was odd, but to me it is a clear signal that something
> should not be called generic if it is not generic enough.
> 
> Please switch to soc-specific compatibles (and drop my reviewed-by, so
> this will appear in my review queue).
Ok , will add in next revision.
> 
> Best regards,
> Krzysztof
> 


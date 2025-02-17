Return-Path: <linux-spi+bounces-6839-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC298A37B15
	for <lists+linux-spi@lfdr.de>; Mon, 17 Feb 2025 06:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF02516B633
	for <lists+linux-spi@lfdr.de>; Mon, 17 Feb 2025 05:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E780D187FEC;
	Mon, 17 Feb 2025 05:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j6YEceJO"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAE9433A8;
	Mon, 17 Feb 2025 05:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739771769; cv=none; b=F2Bkp8SfL11mq/lmkzwtW0T0TDlaadeeqacXhCtizuaBS1mGa53IVorV818miUn5lkBxKKKnwYM1GcKAQXwlWSqxhy8SwTON2jVsXqXzz3mGyAhMRAlfyfaAVqi2KTipUcWwn3126RdHBzg5V609o0og+ccLrFNirQOwvJyk+10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739771769; c=relaxed/simple;
	bh=b+8hriF469cfb+t94uCSbE5w+P/WRPLJmthYrEtAgr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gJZZozqS+kIWA0xYr/339G1Ug4PslyoH/8QI64mOIePDgGTPiOAUWHtGtrTwG5gAOHz4fEhQJDn1q7G2QRAcXIUuwkCOFhy0IcF8BhYiHmypsgbRf6rgK581E9GDOaCZ1Iq+Gnp9I6wna1hUdPde6TCjrDOW+LeFgEfW1+ZtBI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j6YEceJO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51H031RR018869;
	Mon, 17 Feb 2025 05:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eHguWXkBimmyRN92Oh4qZPvucUjc1G+/2HYqq30agk0=; b=j6YEceJO0uy52dyl
	7YvsPWT/lH4EWYRC5BKXLRWbkBzY+IZ/2I/cQbyjX2WhHmKCurvz/1MZCWeBrcoE
	0lOXYA7TN2/HZsxvtPFawBVGDp9SZNXuEgYqB9/NMS/mloTlFpuRDN5qwadNYLaZ
	YpItCCc5ReHO/c+FGXcTA77UXXLJdB5oV1gEFtYELkCSoRFN0NhvAPbkniOagtk3
	nNyDGIqhGTk5ULK2MUZJM2/4EENxRvgTqeZvdFwDcyQzjBcFG4Uvip0GwOyFDNYu
	PXlnigXU3JhZ4juw9kp4H7LA2OMYLUuNC3s/MLjDDGj3K/myBYaKL/MTqXEYXqWq
	oefQig==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ut7srku3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 05:55:41 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51H5tf5M026998
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 05:55:41 GMT
Received: from [10.151.36.43] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 16 Feb
 2025 21:55:36 -0800
Message-ID: <80746729-2b32-9a13-93f5-8d5c222ce4d8@quicinc.com>
Date: Mon, 17 Feb 2025 11:25:24 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [GIT PULL] mtd: topic branch for spi with Qcom changes
To: Mark Brown <broonie@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>
CC: <andersson@kernel.org>, <konradybcio@kernel.org>, <richard@nod.at>,
        <vigneshr@ti.com>, <manivannan.sadhasivam@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        "Tudor
 Ambarus" <Tudor.Ambarus@linaro.org>,
        Frieder Schrempf
	<frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        "Pratyush
 Yadav" <pratyush@kernel.org>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>
References: <87jzbp9hnt.fsf@bootlin.com> <87bjwkoxwh.fsf@bootlin.com>
 <96bdefb1-4607-4a4a-8bed-b4d9b5971171@sirena.org.uk>
Content-Language: en-US
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <96bdefb1-4607-4a4a-8bed-b4d9b5971171@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jgdh1FUKxTE_jVPzebr2GOblQCrCd6wj
X-Proofpoint-ORIG-GUID: jgdh1FUKxTE_jVPzebr2GOblQCrCd6wj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_03,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 spamscore=0 clxscore=1011
 mlxscore=0 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502170049

Hi Mark,

On 1/6/2025 9:06 PM, Mark Brown wrote:
> On Mon, Jan 06, 2025 at 02:49:18PM +0100, Miquel Raynal wrote:
>> On 24/12/2024 at 17:20:38 +01, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
>>> I'm merging the Qcom series, in case you need a topic branch to apply
>>> the spi bits (binding and driver), here it is.
> 
>> There is a breakage on x86 with this series, I'm applying another patch
>> from Md Sadre Alam on top, so I'd suggest to not merge this branch and
>> wait for the next cycle to take the spi bits if you're happy with them.
> 
> Thanks for the heads up - I didn't pull it yet so as you suggest I can
> just leave it and pick things up from mainline.
The QPIC raw nand patches are available in the linux-next. could you 
please pick the QPIC SPI NAND patches [1]
[1] 
https://lore.kernel.org/all/20241120091507.1404368-7-quic_mdalam@quicinc.com/

Thanks,
Alam.


Return-Path: <linux-spi+bounces-2955-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F34D8C9B12
	for <lists+linux-spi@lfdr.de>; Mon, 20 May 2024 12:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 326992810E0
	for <lists+linux-spi@lfdr.de>; Mon, 20 May 2024 10:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195E31CD02;
	Mon, 20 May 2024 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T12CGJkF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B655A14285;
	Mon, 20 May 2024 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716200134; cv=none; b=CYVYUTrY7egnUnW9A580PaMMxqNMLaVHi4VZ3laACWTb1sxVs0Ko0knpWvGgivHxAZV9qJkmmge5wpxrSHJ1ETYoTVoxK8qSMcUhTADzAZshI4JiHvb+uBewfFflrks0HZ825Ut7Nb6zCKjLQhPMtuUiZaMlCMAClMj3fjrHGkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716200134; c=relaxed/simple;
	bh=quscQVhGYECqWdN6pmPjH9Lcvjms9S+zA4L3I3EqjiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=igUzGU/oyBUOXmJQgLdBNI2Tn/nPZwHELZhFVx126d2yl6SAXEnSrI1eQBBSqWQgL1C7BgqTJzuGb4IgLDXcWYmGxPCiHWTZYV3d3DkvvVf7J6dgzRsqzlUO4IXrkqosYI9azUxI9iZnL5CF+skxjbgv3qIh2WNiusawwyVgZ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T12CGJkF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44JNwfm3030497;
	Mon, 20 May 2024 10:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=hKiodN63Z0RVsc8gXW3IiXso5pHhoSGv7lkZ5eTB99E=; b=T1
	2CGJkFyF80nsOUBOS4vzcG24n2OQWSDySie8JV1bRvWy/hiAmEkXG3dddzYq/7o+
	bKl2tAY5oeLoBlwDnFqqMBnLr9gkLvO/mGxrO09qt2cRB4juMSOT+I9hbYfTww0t
	LyDNxArrhjEg4DGMoh/Km7cWI9iGAUYEjY6JmzQeiRbRxJ4Ksk6rgdUp7IjWnuvH
	SyZrr+y1ZY7uHXmpg0ggxMhnZLnzLWejav5QQUwpmnY4NPBaKk29ChxnZmUagVg/
	HiTqbHBGQO2v0wNjly5ee1yzY+RjVGNTbFNbltDEEzum2kKnrzAS7fsUi6AzCzkN
	DaElI0tuw8WXK2cLlLog==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6pq5avt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 10:15:20 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44KAFJwU014001
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 10:15:19 GMT
Received: from [10.216.4.5] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 20 May
 2024 03:15:13 -0700
Message-ID: <bdfd0704-ac8f-45c2-e292-a5bc416e6610@quicinc.com>
Date: Mon, 20 May 2024 15:45:10 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v5 7/7] arm64: dts: qcom: ipq9574: Disable eMMC node
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
References: <20240508083637.3744003-1-quic_mdalam@quicinc.com>
 <20240508083637.3744003-8-quic_mdalam@quicinc.com>
 <20240516145915.10adca29@xps-13>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20240516145915.10adca29@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GIfhyrBYp1lFuQVrWvmXxsU1Z8Tk9sjo
X-Proofpoint-ORIG-GUID: GIfhyrBYp1lFuQVrWvmXxsU1Z8Tk9sjo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-20_05,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 clxscore=1015 mlxlogscore=528 mlxscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405200085



On 5/16/2024 6:29 PM, Miquel Raynal wrote:
> Hi,
> 
> quic_mdalam@quicinc.com wrote on Wed,  8 May 2024 14:06:37 +0530:
> 
>> Disable eMMC node
> 
> Please explain why or remove this patch from this series, because at a
> first glance there is no reason to link this patch with the others.
  rdp433 default boot mode is norplusnand and GPIOs are shared b/w eMMC
  and NAND so we can't keep both.So we are disabling the eMMC for rdp433.
> 
> Thanks,
> Miquèl


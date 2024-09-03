Return-Path: <linux-spi+bounces-4529-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E149C96A03A
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2024 16:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99BF32859CD
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2024 14:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0546F076;
	Tue,  3 Sep 2024 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h234HtXn"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D8257CB1;
	Tue,  3 Sep 2024 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373274; cv=none; b=ofAjqNuTQLmY33pitWfJ+H5tEO60vL/cKFcZ0ekeuS2BkjkiyCvJWSdEO1NeicTGYZ92zlFLPAPz9V1B9IOAccHmSSJc/kcD6UtnoYSrCb9nEtaZh7TW1b+f06n3boDu0VZ9HvPE/XkLilyB26cGjzaxcCiT/DUVisRn3MPqRzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373274; c=relaxed/simple;
	bh=i9SA9sYcW47JT0EdjfF+/zlZw9kvF/ULNqmShlQVxY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z0vIsMUhyTNaBKtr9d/l2KuLgkDscTYHEj1szv4ckkaiUJKi8ScmnAQmZClWweo97IBDOWvHMyoaXDqjeDZml4D/ELzSzZ4JyU5QAo1rqrSD//cgIhdThnmYp09aAlZPd3Uh5WKPW1xzz/JH7fa0b49RqJWABeWHvZasPbwJBLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h234HtXn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4838R7AC020929;
	Tue, 3 Sep 2024 14:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	44ZenkOsuRdWbJkYILWBtuSlvXtFq9Y0l8/3H8KjMRU=; b=h234HtXng3G752zd
	EpaXh+8bPMhNeDv7ECr1Rbzq5KVF5eTj9PsfpredkPe0Vc5yOcJIB40ITkI06/Mq
	akLMCsERb8eZC3BXMp9lnlQ4DfxQcy/JvipcbLEbwyt/mfyoefcZPhEw0W5Cs3XX
	IGGzj3LJLlpdMp2PXhidwcqWCiMxzu0jdoB+k7BMKVF2slJuUb5KM6zJl2dDXTtW
	AKeb0I7PNpOoXTW3t/k31nHYuuRb9A29S4vIeDl1Q1MvTsSVEBdxF7DEVEEsgC57
	E6Z7Q4oKcROTkZRUdQCxYoGZ0qo2wt3ceWzAP4lKeqIVS8zWo7/pzYj29dH1Xuak
	84BGRA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41dxy20y50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 14:20:44 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 483EKhvl006075
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Sep 2024 14:20:43 GMT
Received: from [10.216.9.110] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Sep 2024
 07:20:38 -0700
Message-ID: <9989334b-cd91-9493-6097-c1f94c518cb8@quicinc.com>
Date: Tue, 3 Sep 2024 19:50:34 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v8 0/8] Add QPIC SPI NAND driver
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <esben@geanix.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
References: <20240820104239.1774600-1-quic_mdalam@quicinc.com>
 <5169761b-422d-70ab-ba53-a898cb7bfa2f@quicinc.com>
 <20240903150826.749b8560@xps-13>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20240903150826.749b8560@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XjxU3FVBARlC6hh-Q6OUfpodIPFZY2Z4
X-Proofpoint-ORIG-GUID: XjxU3FVBARlC6hh-Q6OUfpodIPFZY2Z4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_02,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=974 spamscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409030117



On 9/3/2024 6:38 PM, Miquel Raynal wrote:
> Hi,
> 
> quic_mdalam@quicinc.com wrote on Tue, 3 Sep 2024 14:45:15 +0530:
> 
>> Hi Miquel,
>>
>> On 8/20/2024 4:12 PM, Md Sadre Alam wrote:
>>> v8:
>>>    * Fixed compilation warning reported by kernel test robot
>>>    * Added "chip" description in nandc_set_read_loc_first()
>>>    * Added "chip" description" in nandc_set_read_loc_last()
>>>    * Changed data type of read_location0, read_location1,
>>>      read_location2, read_location3, addr0, addr1, cmd, cfg0,
>>>      cfg1, ecc_bch_cfg, ecc_buf_cfg, clrflashstatus, clrreadstatus,
>>>      orig_cmd1, orig_vld to __le32 to fix compilation warning.
>>>    * Included bitfield.h header file in spi-qpic-snand.c to
>>>      fix compilation warning
>>>    * Removed unused variable "steps" variable from
>>>      qcom_spi_ecc_init_ctx_pipelined()
>>>    
>>       I have addressed your comments to v6 and further posted till v8.
>>       Could you please let me know if this is fine.
>>       and how to get this merged ?
> 
> There are still kernel test robot reports, so this means there are
> issues in your code that I don't need to point out explicitly, but I am
> actively waiting for them to be fixed.

   Sorry I missed it, will fix and post next revision.
> 
> Thanks,
> Miquèl


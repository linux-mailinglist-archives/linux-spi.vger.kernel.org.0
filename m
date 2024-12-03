Return-Path: <linux-spi+bounces-5887-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5729E1A4B
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2024 12:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A3631612DC
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2024 11:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BE81E2318;
	Tue,  3 Dec 2024 11:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W3qUl5Wt"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B541E0E13;
	Tue,  3 Dec 2024 11:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733223904; cv=none; b=P78GUynB/RcsXq52JX58SlJ3SNlyzXxSj4kqr5jvYAgRD6p27PFjY3PILCx108oHKnvS+lx+oVhcEPml4HiHKMc58Lb0rMPzYhC5qnkDFJ5wfgE5QJMBUhdgr9oKDcYNsltJyuXlpU2TF21NeGWvH+fx1wyO6EI93VST71Ixkcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733223904; c=relaxed/simple;
	bh=UXqhP6SUgW2/ozvu0lhett25qlygR77ER7pLs3VvEIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=m4q62X7ESbXRojMMuwRWMxurS7buWaAJCktie2rjc0e5CD5WM3fOUmMVim/MYtPjroArl8hfakPQKu1NlzCw+4vq00OmRebpOPTVEQT9s9vB93VNFq3MWsgRyWaK+rKaG25WLUJ+rbwAfqufAB6bBc3zjBoAs6wAogzYqPPoYts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W3qUl5Wt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B38tmMU010851;
	Tue, 3 Dec 2024 11:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9KhuAO45BpGUJQh6ai96J1rGFDAPsljoRBrp3z4py8Q=; b=W3qUl5Wt9kYDTdvA
	qciAg6ePv0EDGxkuOFckIdSLXkFi7fiGfo7Mbyg5HNdAzt24EK4eio0MFXECT4jM
	KUDFNSZyRP4pQ76AKTplz/QpxpW6UMXpm6KsOufrRY+T+cie98C9t8OKW8wu3YG5
	Fk+8QLaL4gq23vnWFR8naci+2no+q+WeragMDrLS6gvpOMyqLfoC4tBZto9RjFUw
	7mJO10mr9sfmtzvPESwGDAsUuRthUykQrismf1ZisZWbIr80s0ZSm7rBt/rQsdz5
	4qflIW+MZvCaykTCtkHODYU371sEO6lPiRC9bXtSD2dPdcocml1UhRat5XmxE7kN
	zPsCIw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4393mpcs38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 11:04:44 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B3B4iVv004429
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Dec 2024 11:04:44 GMT
Received: from [10.151.36.201] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Dec 2024
 03:04:39 -0800
Message-ID: <11ed6654-5362-4529-88a0-801e770e164b@quicinc.com>
Date: Tue, 3 Dec 2024 16:34:35 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 0/8] Add QPIC SPI NAND driver
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20241120091507.1404368-1-quic_mdalam@quicinc.com>
 <87mshe58gq.fsf@bootlin.com>
Content-Language: en-US
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <87mshe58gq.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HMFqzdjarEFsMZ_sJpFyTTzJmtl81YBi
X-Proofpoint-GUID: HMFqzdjarEFsMZ_sJpFyTTzJmtl81YBi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412030094



On 12/2/2024 10:27 PM, Miquel Raynal wrote:
> Hi Marc,
> 
> On 20/11/2024 at 14:44:58 +0530, Md Sadre Alam <quic_mdalam@quicinc.com> wrote:
> 
>> v14:
>>   * Updated commit message
>>   * Fix spelling mistake
>>   * Remove "inline" from multiple APIs from qcom_nandc.c file
>>   * Move '|' in qcom_param_page_type_exec() APIs at the end of line
> 
> I guess it is now time to move on, I can apply patches 2-5 and share an
> immutable tag. However, due to the frequent inconsistencies observed
> during the lifetime of this patchset, we might be slightly more
> conservative than usual and split the patches over two kernel
> releases. I fear there might be annoying fixes on the mtd side needed
> because of some side effects. Without these, the spi tree might have
> broken qcom support for several weeks. What do you think?
Sorry for the delayed response. I'm fine with merging patches 2 to 5. I 
tested them on today's linux-next, and the driver performed as expected.
> 
> Cheers,
> Miquèl



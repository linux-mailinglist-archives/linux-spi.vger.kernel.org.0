Return-Path: <linux-spi+bounces-7036-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ABAA4FD8F
	for <lists+linux-spi@lfdr.de>; Wed,  5 Mar 2025 12:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A8F73A67FE
	for <lists+linux-spi@lfdr.de>; Wed,  5 Mar 2025 11:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80ADD230BD9;
	Wed,  5 Mar 2025 11:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e9z5ulmS"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B9221421B;
	Wed,  5 Mar 2025 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741173946; cv=none; b=CNfbirXHzH7U6YLzATyonL0BSinz2mw0+eyRFqeuXP7cokRzIo/kT95KG/ngyDaEwk308RQ45WZS7DMzz5HHlNuIq6Ont9dtQ0osAwQdL+kRB0uQmDr9OT9pwqO/3CpaLUvLLMpLBRsFhsf4oG35PsM+/nTqnb5XE+yyTuQgnKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741173946; c=relaxed/simple;
	bh=80mzRx1gZi6s/i8Tc9zi6G0YP5JCRzmj8kgPBqzBKZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Msvrx9Zx9dU8c1zXGbNnry2dwCPKHn0eELlnWtfkh0mqaO9iKtlXdhQgF2aDGD4nMlU/uvRmvlvSW/hkRkIbOxqroQ05f4mcITkzOHjkA0sKo6jwQ9BkcnfL7oLsPaVNuP6aoTqhTkCPCHMbzeN01DDPzABB6UzLTgIGMcl764k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e9z5ulmS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525B1B13029016;
	Wed, 5 Mar 2025 11:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ggpKhzhXasTU/fGYnPTZ/bmi5BaVyOLTD83OpA3mNRo=; b=e9z5ulmS8wpuk7sv
	3KDlZj0VtKQJFj1MJm8wYDJbYMZXEKIWV56UjtDAheVEvmbFIqwMeSR+gMuLGe96
	X20KOiq7xD9Xn4pJosj1xToeARUSlYkE7sdyLIxO1ANrjqanh/caiT/aJev3m/Bm
	fhNTEzFL5Exv/pixMcatdsKeQrswZ2sfZIhfZXcAGIPbwIzK3v2JEBp7AEceqIL7
	JwBrLNOJXOYLBSV5a7Nh7G9Da39J02w3lR1wDveMP4Q6SieJykGNUq4rFTsTjwGw
	tQbnZ1ou8gEEWHnzviZK3UZHP2VMmzSvHLxr/vKqY8Zv5/UdV7cR+2kHK390NO1Q
	d1+M1w==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6tn5jh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 11:25:25 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 525BPOJO032203
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Mar 2025 11:25:24 GMT
Received: from [10.152.201.53] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 5 Mar 2025
 03:25:20 -0800
Message-ID: <04ca77f0-55de-3f1d-7cc8-5a7b9aa70b33@quicinc.com>
Date: Wed, 5 Mar 2025 16:55:07 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v15 0/2] Add QPIC SPI NAND driver
To: Mark Brown <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
References: <20250224111414.2809669-1-quic_mdalam@quicinc.com>
 <174109164799.27220.16782141488752139254.b4-ty@kernel.org>
Content-Language: en-US
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <174109164799.27220.16782141488752139254.b4-ty@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=PMb1+eqC c=1 sm=1 tr=0 ts=67c834a5 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=PR9Bvw7T5Ps_q21Qd_UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -NSwt4c7gjvIN-N7JVhRMFkvSfB5O153
X-Proofpoint-GUID: -NSwt4c7gjvIN-N7JVhRMFkvSfB5O153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_04,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=918
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503050092



On 3/4/2025 6:04 PM, Mark Brown wrote:
> On Mon, 24 Feb 2025 16:44:12 +0530, Md Sadre Alam wrote:
>> v15:
>>   * Skipping the following patches
>> 	Merged:-
>> 		mtd: rawnand: qcom: cleanup qcom_nandc driver
>> 		mtd: rawnand: qcom: Add qcom prefix to common api
>> 		mtd: nand: Add qpic_common API file
>> 		mtd: rawnand: qcom: use FIELD_PREP and GENMASK
>>
>> [...]
> 
> Applied to
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> 
> Thanks!
> 
> [1/2] spi: dt-bindings: Introduce qcom,spi-qpic-snand
>        commit: fd6bc2ba410bf7828dc2104bf78b51ccbb216c40
> [2/2] spi: spi-qpic: add driver for QCOM SPI NAND flash Interface
>        commit: 7304d1909080ef0c9da703500a97f46c98393fcd
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.

Thanks Mark for pulling this ! I will follow it up

Regards,
Alam


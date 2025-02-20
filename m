Return-Path: <linux-spi+bounces-6880-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FB9A3D8D8
	for <lists+linux-spi@lfdr.de>; Thu, 20 Feb 2025 12:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D24F1888736
	for <lists+linux-spi@lfdr.de>; Thu, 20 Feb 2025 11:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BF01D5CC6;
	Thu, 20 Feb 2025 11:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SMG7YHHV"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB6B1EB9E5;
	Thu, 20 Feb 2025 11:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740051265; cv=none; b=cMwXLupAHobm6MUeAasUcfCHNh45z4rI9CB9yBOWQz1718sTUF6sfJEHizwGRrhJnn8MNpWGY1OhaN/cIktYW6D4vsHLGolf8ItBUAVglc4BlxquUV97TlnOFOYiQuiG/3QtjNDh1CHmQSrszefhQVBYknCMhVID3f/b8U1dCPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740051265; c=relaxed/simple;
	bh=L4ur7hyj+TYrQe6s5H1vLxLu0G7YH2mB8YWHXQZIOJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SVrxDIz5/FwyB9VB54suRwMP3f5EO7S8LvHsZuEtPJgme4XB9XLXKTUbmVUPMQ3rxvP2zLmcUKOF8TN/+lJhQQ9yJLcUCw+FDCo2f1V8aAWNnRwHyJ7/DwiaMcVUgliT5lfWF986CMLgV31zvHd+N9+wIUdZutSmcMksR4Gdzkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SMG7YHHV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K6BJTN009745;
	Thu, 20 Feb 2025 11:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LU+sgihTDEVzhC8SvCsP/tL9QzmmAqy0PpSwPVODcQ0=; b=SMG7YHHVQcMogakw
	nUXgiUQGPClSOigRwZNG70vXhsWf+Ua806w14/1A+V6QWAfcdxOSeMoieZtihJaN
	390TRR/ZloWL9liVtXA4aFJ2u5ISAdy9F0W+82476FeMijg7LxN1HEMq3ppCXPLf
	5kB6FGUBjLFzRP/xaBPHfRUszPqFGW6J970i1XE+C2klToHcBlf9K49Mwv6OPH3y
	+bqkIGxhGDNVcZY/az67atHRoEtf/EzKIizksM4RqwRw9jCP3o3wslX+H4gOV8se
	x/L/UCLbvqB76JKPOu7a/WrnwkO/bTDxuKXuVMUNFUzY3XEylL6sXjeaiCWTaVe1
	uzfhtw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy1x17w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 11:34:03 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51KBY23X021125
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 11:34:02 GMT
Received: from [10.152.201.53] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Feb
 2025 03:33:56 -0800
Message-ID: <5022bc8c-a6ac-3782-43cc-19b0ca644a6a@quicinc.com>
Date: Thu, 20 Feb 2025 17:03:34 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [GIT PULL] mtd: topic branch for spi with Qcom changes
To: Mark Brown <broonie@kernel.org>
CC: Miquel Raynal <miquel.raynal@bootlin.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>,
        Tudor Ambarus <Tudor.Ambarus@linaro.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle
	<michael@walle.cc>,
        Pratyush Yadav <pratyush@kernel.org>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>
References: <87jzbp9hnt.fsf@bootlin.com> <87bjwkoxwh.fsf@bootlin.com>
 <96bdefb1-4607-4a4a-8bed-b4d9b5971171@sirena.org.uk>
 <80746729-2b32-9a13-93f5-8d5c222ce4d8@quicinc.com>
 <Z7SfQ4lu2fponEiX@finisterre.sirena.org.uk>
Content-Language: en-US
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <Z7SfQ4lu2fponEiX@finisterre.sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6Hy-Y5cOnKZrdX0E3d5Gp5-E9paq87xl
X-Proofpoint-ORIG-GUID: 6Hy-Y5cOnKZrdX0E3d5Gp5-E9paq87xl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200087



On 2/18/2025 8:24 PM, Mark Brown wrote:
> On Mon, Feb 17, 2025 at 11:25:24AM +0530, Md Sadre Alam wrote:
>> On 1/6/2025 9:06 PM, Mark Brown wrote:
> 
>>> Thanks for the heads up - I didn't pull it yet so as you suggest I can
>>> just leave it and pick things up from mainline.
> 
>> The QPIC raw nand patches are available in the linux-next. could you please
>> pick the QPIC SPI NAND patches [1]
>> [1]
>> https://lore.kernel.org/all/20241120091507.1404368-7-quic_mdalam@quicinc.com/
> 
> That looks like it was posted back in November, I'd have expected
> anything for this release to have been posted after the merge window...
> 
> Please don't send content free pings and please allow a reasonable time
> for review.  People get busy, go on holiday, attend conferences and so
> on so unless there is some reason for urgency (like critical bug fixes)
> please allow at least a couple of weeks for review.  If there have been
> review comments then people may be waiting for those to be addressed.
> 
> Sending content free pings adds to the mail volume (if they are seen at
> all) which is often the problem and since they can't be reviewed
> directly if something has gone wrong you'll have to resend the patches
> anyway, so sending again is generally a better approach though there are
> some other maintainers who like them - if in doubt look at how patches
> for the subsystem are normally handled.
Sorry, will rebase, test and post a new version.

Thanks,
Alam.


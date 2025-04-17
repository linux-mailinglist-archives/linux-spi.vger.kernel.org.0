Return-Path: <linux-spi+bounces-7647-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FD7A9229E
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 18:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66E817AF847
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 16:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682DA254AEC;
	Thu, 17 Apr 2025 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V3Rfaq32"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D27253944;
	Thu, 17 Apr 2025 16:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744906941; cv=none; b=uQ6tuWM/nA1VOVHkfar1wEG7D1fDmAsfCVZ/RYp1RT8VsjKDM7vZHf6ZZpPD6U3s7AI331vZHQ0cywTu/MExg1CrlQmzJVxlP9DeZ0RW/W+WVjHsKUzPaGnCsJHQyarz/uw0rwRsWeB2U8+0DVg0WNb0x4OC1gc/TSnX6FotAbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744906941; c=relaxed/simple;
	bh=bDa/rH8Ry3QTTEGBrimeA+PJkNogZR5madrUnxo/lXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nFYt8rou5WHXTJmmJ+jQwOUgV0rlfDzph1glZl8pUm3r6DfMLe0qTXk5I+2lpaXPvrG+WBX6vLX1w0nb67Er5YnIAHdYQDc9UJHwCb3vi9wH315UBCfMOZ7WUhBx/wB/PqiLNe+nOFJUdyfU/s5m9FG6ZtWm7l5OfBtbO2sXot0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V3Rfaq32; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HCld0A008818;
	Thu, 17 Apr 2025 16:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+tyaPfggl3NKsrf6rIcBYHuQAViZpRCVotLYqRJT9b4=; b=V3Rfaq32iRuHoYsL
	vhXsQNmIxzty8CsFCUKv63mGXM8MqohDHF2opuWIvL1aDqLZ1A8YURxrmdyalR0j
	7slIJuQjy9egzaTMnTw8yMMi1bi1H4C3JkxWRNHZrqy4bpbVhgR+52dTv/WFC0Ri
	4AH8OTsoUd0ak20WnFZynJVnPbVLaHdrVY2aolmO6A2ZmmCoduW2g3//hN5xZKD3
	VpHuOCw2hoKq7a0kbUOE9ef+i1JJfea4XWzc/8FeNBMYvKvAmlmjLuNIQmlQCKnr
	kSXcaT2osDQ3Uv/z4V+bTgveCFAjPXPsCrVTEASvPOai8XsVhERH+jznQ8uh4v86
	HVFsTw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygxk7e3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 16:22:14 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53HGMD03025196
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 16:22:13 GMT
Received: from [10.216.33.21] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 17 Apr
 2025 09:22:11 -0700
Message-ID: <4fbc3fc6-df2e-4d13-a152-47fc4d77a082@quicinc.com>
Date: Thu, 17 Apr 2025 21:52:04 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] spi: Introduce and use spi_bpw_to_bytes()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown
	<broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: David Lechner <dlechner@baylibre.com>
References: <20250417152529.490582-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <20250417152529.490582-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=68012ab6 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=tzvkvtfgrtsM4S2kMOoA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: KyMHB6vgmRrXks39WOBZ3x-DcFVcC1ng
X-Proofpoint-ORIG-GUID: KyMHB6vgmRrXks39WOBZ3x-DcFVcC1ng
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_05,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=850 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170120



On 4/17/2025 8:54 PM, Andy Shevchenko wrote:
> Recently in the discussion with David the idea of having
> a common helper popped up. The helper converts the given
> bits per word to bytes. The result will always be power-of-two
> (e.g. for 37 bits it returns 8 bytes) or 0 for 0 input.
> More details are in the respective code comment.
> 
> This mini-series introduces it and replaces current users
> under drivers/spi and we expect more (and possibly some
> lurking in other subsystems).
> 
> Mark, if you okay with the idea, please, make this to be
> an immutable branch or tag for others to pull.
> 
> In v3:
> - fixed the typos in the examples
> 
> In v2:
> - improved examples in the code comment and commit message (David)
> 
> Andy Shevchenko (2):
>    spi: Add spi_bpw_to_bytes() helper and use it
>    spi: dw: Use spi_bpw_to_bytes() helper
> 
>   drivers/spi/spi-dw-core.c |  2 +-
>   drivers/spi/spi.c         |  2 +-
>   include/linux/spi/spi.h   | 26 ++++++++++++++++++++++++++
>   3 files changed, 28 insertions(+), 2 deletions(-)
> 
Acked-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>



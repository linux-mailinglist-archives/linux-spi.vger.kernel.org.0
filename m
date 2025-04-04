Return-Path: <linux-spi+bounces-7399-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12732A7B7E8
	for <lists+linux-spi@lfdr.de>; Fri,  4 Apr 2025 08:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3773B6E07
	for <lists+linux-spi@lfdr.de>; Fri,  4 Apr 2025 06:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE4A1624CE;
	Fri,  4 Apr 2025 06:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ToaEabsq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7632E17A31B;
	Fri,  4 Apr 2025 06:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743748815; cv=none; b=D2ITa8b6gIcr55FQBkcej7lNVo5YOgk0seEJIrbI0cA+tMuAFIeu6mATMISClK2T9YByNwNpmLVBqdrZIQo1nuBhLfw344AevMCtnbxoPKSn3mDEG7z53AacCxGVHlYsd3kVUDTJXC8yRlX/CD6ll5V+K/8bGa+SFL/87XApeUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743748815; c=relaxed/simple;
	bh=LvXOJwYpeCUDmWDFM30zJvFIxLATT3JGqRx/e4h8Lug=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dhxYT5OEX/pDl632Bk/MROvjApygdl1taCFrRs3MOQQ1ZMW75t3gxM+/jFKNUqiF83w70UZiFcR78K1tTKdSA2wbQtbPVEiVQemlBzMHVr/9ObaPlXM+HvHXeqjryt2aSRmsWgFrFFadLNjKffNnBrIBWPIHvdp2MPL3zqkxiMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ToaEabsq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53433wkc016767;
	Fri, 4 Apr 2025 06:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HnTgQtPaAwIxPjdthGCDs1XTMfTKRZ4L7EzRuelR8oE=; b=ToaEabsq8cC+HROV
	pjMnmbgL0fRwIfCO+CsgqAZaFUHpuax5CRmh5dWNz1qEHC/YCIMPVeQgudAB1J7E
	AWQ7T7c/I7nngZPryQh2pTeMZL47U72ffdDx+Bco/WrTAPcWS27w0NtX+Fios95C
	FCm0du7eh2RYWRBss+ssYUfNAL6tWe41X9T1y6KKpfpawwohDcVxJcrufb/Ruyb3
	CEmWWbu1qvAbFkJvJpyZcOWP5Ix4JIsrbL411H4NAmuZW9ZJRML6jKRsM2qc+7Rf
	s90pg7IWOFKAXSdSom7MftrpMqa93t2gYRPF5x1WF5huHZuljlmRmGH4IM1LZYyq
	iC/d3Q==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45t2d98whg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Apr 2025 06:40:00 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5346dxHC013652
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 4 Apr 2025 06:39:59 GMT
Received: from [10.151.36.43] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 3 Apr 2025
 23:39:57 -0700
Message-ID: <97500c11-18a6-c9ab-fc95-cfb0d62c9c31@quicinc.com>
Date: Fri, 4 Apr 2025 12:09:44 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: linux-next: Tree for Apr 3 (drivers/spi/spi-qpic-snand)
To: Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell
	<sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
References: <20250403171248.219e0e61@canb.auug.org.au>
 <4b964eb4-7d0f-40f5-bbc9-5039e075ff65@infradead.org>
Content-Language: en-US
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <4b964eb4-7d0f-40f5-bbc9-5039e075ff65@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5j_G_FJd8EpXTIGKOktW6JFjG15jsn1f
X-Authority-Analysis: v=2.4 cv=cpybk04i c=1 sm=1 tr=0 ts=67ef7ec0 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=rUSp2p67hj3hLfAB3vEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 5j_G_FJd8EpXTIGKOktW6JFjG15jsn1f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_02,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 impostorscore=0 malwarescore=0 clxscore=1011
 phishscore=0 suspectscore=0 mlxlogscore=732 bulkscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504040043

Hi,

On 4/4/2025 6:54 AM, Randy Dunlap wrote:
> 
> 
> On 4/2/25 11:12 PM, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20250402:
>>
> 
> on x86_64:
> 
> ERROR: modpost: "qcom_nandc_unalloc" [drivers/spi/spi-qpic-snand.ko] undefined!
Change already posted for this error at [1]
[1] 
https://lore.kernel.org/lkml/99eef91c334f3f2314c2f5671e1eb55211a5ff19.1743150196.git.geert+renesas@glider.be/T/

Thanks,
Alam.


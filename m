Return-Path: <linux-spi+bounces-7319-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53967A7186E
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 15:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B908A17373E
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 14:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B731F2BAE;
	Wed, 26 Mar 2025 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LUTOVDdR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D191F2B82;
	Wed, 26 Mar 2025 14:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742999119; cv=none; b=UUSCuyVlAki+fQs2r54AsQx0Fq4/IOD2EwMT6BJEtfm6vqgvvQrk9VrxoJHtcXbWI1YG/H/7gGHJNHfxWyaZeLpeFRNCsXTlvnrfYmT5AW/58cFiAMHg2ARMI9NMywqywFM68v5+WaVQyOvqS1RRDew6zwOfZuQ9XhUog28K0hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742999119; c=relaxed/simple;
	bh=qjWuzFHgEwL+qxYzT+A12kERjAuSvmVJb908btbQJ7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Cp9zdSHVJSz8naW+vgm5O6fiIkfWzxszeY5lOKLv3/hL9gpIubjRq5mBLfxaVOGdN4M4tI7Hru6B502Q2vrBq/vcK1o9Y8OeUoZoFyYi4JF6VcnuS/HEQSQoWulI1FbSxApyO8sKPoyYW99XFEgPD98gi5gJrRkTNFdnwEjzhC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LUTOVDdR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q73cL2029945;
	Wed, 26 Mar 2025 14:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tDN7gw8peZOEhd9lEduRhnUdBsUJTsMplkIPZz28VeQ=; b=LUTOVDdRQZr1INT9
	r4gkAN5EK67IyjMy0ryHVkmHvXfPTsQH/o3PFC7KK3DqyLPDHTwqzdzPBJUUhzgn
	2+AHzJt94Ryyq1lqTjxV8el22cBznz95Ya4zAH2aeyKqztoR555SjpNQo3zQ5iPM
	pg4vllbKpTyoiyxdIpk136KnMF/uF/lGJGS0HXkeKNZrM22jDt/H2to0ED/Htspf
	iFlCkNyuEng/8pMBiN+gIE67ntyOr3B3r/IphJeBVVb5yG8g7NYx1QGrUukInI4a
	hx4lwPZiDHb2KeAU/HKBlf7yY8pMXgGplo/mgkaiVN9THOh4W4kYb4iKdG5QE73y
	TyBUtg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ktenc2tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 14:25:13 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52QEPCD8030765
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 14:25:12 GMT
Received: from [10.217.219.207] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Mar
 2025 07:25:10 -0700
Message-ID: <c89603b7-b70c-4b55-ac87-f84ce5be2c6c@quicinc.com>
Date: Wed, 26 Mar 2025 19:55:05 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] spi: Add support for Double Transfer Rate (DTR) mode
To: Mark Brown <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>
References: <20250326083954.3338597-1-quic_msavaliy@quicinc.com>
 <40db39ef-7ef3-4720-9c85-ccfe1c11c299@sirena.org.uk>
Content-Language: en-US
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <40db39ef-7ef3-4720-9c85-ccfe1c11c299@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=TuvmhCXh c=1 sm=1 tr=0 ts=67e40e49 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=PtKPgYgoDCFFhr4Q3nIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: l-uhFskSsocJJBAz4n5ME7ZhJWxJw7Su
X-Proofpoint-ORIG-GUID: l-uhFskSsocJJBAz4n5ME7ZhJWxJw7Su
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_07,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=858
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 mlxscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260087

Hi Mark, thanks for your comment.

On 3/26/2025 6:34 PM, Mark Brown wrote:
> On Wed, Mar 26, 2025 at 02:09:54PM +0530, Mukesh Kumar Savaliya wrote:
> 
>> This change introduces a new field `dtr_mode` in the `spi_transfer`
>> structure. The `dtr_mode` field allows protocol drivers to indicate if
>> Double Transfer Rate (DTR) mode is supported for a given transfer. When
>> `dtr_mode` is set to true, the SPI controller will use DTR mode
>> otherwise, it will default to single transfer mode.
> 
>> The QSPI controller driver uses this flag and configures single or double
>> transfer rate using the controller register.
> 
> We should have a flag in the controller indicating if it supports this,
> and code in the core which returns an error if a driver attempts to use
> it when the controller doesn't support it.
Have added below in spi.h which can be set by client and controller 
driver should be using it to decide mode.

+ bool        dtr_mode;

since default it's false, should continue with SDR.
I believe for QSPI, it supports SDR or DDR, but it's not applicable to 
standard SPI right ? So not sure in which case we should return an error ?





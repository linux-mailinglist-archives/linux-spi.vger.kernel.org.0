Return-Path: <linux-spi+bounces-7338-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FA7A72D41
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 11:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238F11888158
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 10:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C5E20DD64;
	Thu, 27 Mar 2025 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Sw8auwoS"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213A820E01D;
	Thu, 27 Mar 2025 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743069805; cv=none; b=oP56ljksqrfGcij8b5ekHn1eT4bOR5qgiqK+7POaEc3iu8ooSFCPfxgaleG3FNv4HGx8EJrGQtlVczkVAOVuOinrVzJkGYQJJKndSi/NQsGJtxzE9LqsrkB2em7DD0Xj0wiR1nF3ado2NEbCzphwNdyTsj+247jWE+PZoh/itII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743069805; c=relaxed/simple;
	bh=go4UBCXgE/0g2fcNmMQWe9XQzoLUyVwN+ZYXGjMEv8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TytspDHIlcE9I74h4EuEZ+xEC1GjgaYT+Fj4WZ0ANdg5frPSTt4xRe2n0mT6zAFnRgciXtwLj9oI7/5Mr0kUV2/mbmJ51sMy7XX6OkUo9MPmHHmkrjge4tw0N75FAu/PKqdIwVFaVJJ2UHaR3Ze2Qqc2jV4KPy+9jhw4NMtExMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Sw8auwoS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R5jagD023247;
	Thu, 27 Mar 2025 10:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+Oce+4CvNI900ByCYlhAiujBCHbQ75PUA1zQV+2XxPs=; b=Sw8auwoSSBhRW5qF
	ZzwmCLoNA1a3hSHYEhiqpCIDHlHOg2d2hI5jRTGyRfkDFngDXIwNTovtIlquyQR5
	/MxEwbI7zqV8772qUVMkYHqaxWAvRbtPsCfCvv6e+iTGX5DE91H2NodWGD9Njj1t
	HmM+jwi6rZQIl7YR9tfAnqfUD4I9vV80qL0eEgWEsY3lrO7cIRPPPQmOUtowkQlP
	bDgwGBBWO0QzPGxSCHPDWDNze5S3NL3DueGIuYgTL1jEncoQbvfOoE1LnHH0r8R1
	8oLTYI3KC16YaCtJC0yBYjzrJQJ0bM5er3/HMkboYlWHhLEx67ob4wEvY1mt6/Tb
	F7pjkg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45mb9mvb2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 10:03:20 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52RA3Jco020457
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 10:03:19 GMT
Received: from [10.217.219.207] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 27 Mar
 2025 03:03:18 -0700
Message-ID: <8435b037-8b54-401a-b4f6-b4b497c4c3eb@quicinc.com>
Date: Thu, 27 Mar 2025 15:33:15 +0530
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
 <c89603b7-b70c-4b55-ac87-f84ce5be2c6c@quicinc.com>
 <3aa2c190-ce4d-4805-943b-f65e98ce762c@sirena.org.uk>
Content-Language: en-US
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <3aa2c190-ce4d-4805-943b-f65e98ce762c@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=cs+bk04i c=1 sm=1 tr=0 ts=67e52268 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=hBaITGTWXoLUBLf3d8gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: PwVBJPQT-tSjDn9LLedsD2ZQxpO_uOa2
X-Proofpoint-ORIG-GUID: PwVBJPQT-tSjDn9LLedsD2ZQxpO_uOa2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270068

Thanks Mark !

On 3/26/2025 8:12 PM, Mark Brown wrote:
> On Wed, Mar 26, 2025 at 07:55:05PM +0530, Mukesh Kumar Savaliya wrote:
>> On 3/26/2025 6:34 PM, Mark Brown wrote:
> 
>>> We should have a flag in the controller indicating if it supports this,
>>> and code in the core which returns an error if a driver attempts to use
>>> it when the controller doesn't support it.
> 
>> Have added below in spi.h which can be set by client and controller driver
>> should be using it to decide mode.
> 
>> + bool        dtr_mode;
> 
>> since default it's false, should continue with SDR.
>> I believe for QSPI, it supports SDR or DDR, but it's not applicable to
>> standard SPI right ? So not sure in which case we should return an error ?
> 
> Standard SPI is the main thing I'm thinking of here, or possibly some
> limited QSPI controller that doesn't support DTR.  It's not something
> that should actually come up really, it's more error handling if things
> aren't set up properly.

IIUC, It comes to the point of first identifying if it's in context of 
QSPI controller or SPI controller right ?

Identify if SPI/QSPI controller has this capability using dtr_caps = 
true/false. Then check if it's supporting SDR/DDR mode. Can we then 
introduce below struct to first mark capability as true/false and then 
process dtr_mode ?

if not supported (dtr_caps = false), then don't care dtr_mode.
struct spi_caps {
	bool dtr_mode;
	bool dtr_caps;
};

OR we can have an API spi_controller_dtr_caps() which returns this flag 
set by individual SPI/QSPI controller. We can use above struct OR 
separate  struct spi_controller_dtr_caps { bool dtr_caps };.

Please confirm if i am correct OR suggest more. Else you may approve one 
of the above option. (Sorry if i am missing anything ).


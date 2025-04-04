Return-Path: <linux-spi+bounces-7400-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5938FA7BE68
	for <lists+linux-spi@lfdr.de>; Fri,  4 Apr 2025 15:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9600D3BA778
	for <lists+linux-spi@lfdr.de>; Fri,  4 Apr 2025 13:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95021F12F9;
	Fri,  4 Apr 2025 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hzpfFXHR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D431EE7B1;
	Fri,  4 Apr 2025 13:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743774833; cv=none; b=mbgdcwNQ7KPYZ+XpbA/xsCRkjrHc0+x8oL6AMAG4tqGOqAtzn19mtZwh2M5x3TeAFTb23TTZKl6P9XkyAzlEIUh+RDb1WJKgRT3HYsiw9o/JLB2FyWtvLKjoyY52TQ121+PKItRdimh8QsH19yyA/E7Lmg+AG1xLbzOJwyFEQgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743774833; c=relaxed/simple;
	bh=p8rx4DvKHuiWLCW5BhOxMGRORIoDJG/rcapRZ8TljNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BNhaWa7OVAkiSI1KrXYBhRig7hwOxVU25p4HQbgQStuO26gUwYZ3tQkrxB37lvGaVgXIbnkNhPY1MOthTnAQMgA8/Q06cuYbRd2w7iJ1a+Lx2MRs9zKg0zk2f306IeBcjvuaofU+F5IlAyFAO+sVrOrVclQqHEms+0RGjNEK+rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hzpfFXHR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 534DeOmV012515;
	Fri, 4 Apr 2025 13:53:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FF/G+62gbziLK/MLsC90I1hCGvLPbivGzK2fBOYHZV8=; b=hzpfFXHR3p6rlnCh
	aOmtzgqESPz1qhMtbs9KHJ68jlXcYBFpEvlogibUxADnzu49eaWWS0gD68y9qVZl
	XcGX701tEPR7WSQl2E9VCSixAgOgfzeyQqYDcw+XQ9Q74kSR+bM+jlHyDKawe6Re
	0Z00Gi3h884/cAyDHzqpB3hh2+PDEUDeJFPAjJCV8IJ4uDsbVcpYya87TdywQ2OO
	vw3u0CyFG6+up6WFhoujDiO2JnOJcay1fLWUlpoiS5x4VSi8QjHFYgkAUmH80ZZX
	l+5Og3x78slWn9CjnfggI8IzwXa/iU9mNegRLBi5l7bG3HANr4GJbkO7NxkLtaxU
	5lxHfw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45t2d520a6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Apr 2025 13:53:47 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 534DrkrO005331
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 4 Apr 2025 13:53:46 GMT
Received: from [10.216.18.202] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 4 Apr 2025
 06:53:44 -0700
Message-ID: <e7b19ae8-9619-412c-8aec-fb822c44384d@quicinc.com>
Date: Fri, 4 Apr 2025 19:23:40 +0530
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
 <8435b037-8b54-401a-b4f6-b4b497c4c3eb@quicinc.com>
 <f3115251-8fa9-4019-8fb0-145daf32cfa2@sirena.org.uk>
Content-Language: en-US
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <f3115251-8fa9-4019-8fb0-145daf32cfa2@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: U7JyMVzf47frauUsck6HSgkKF6DHevM9
X-Proofpoint-GUID: U7JyMVzf47frauUsck6HSgkKF6DHevM9
X-Authority-Analysis: v=2.4 cv=Cvu/cm4D c=1 sm=1 tr=0 ts=67efe46b cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=FzMNM0dDwMXFT6OeTboA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_06,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=993 malwarescore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504040096

Thanks Mark !

On 3/27/2025 7:37 PM, Mark Brown wrote:
> On Thu, Mar 27, 2025 at 03:33:15PM +0530, Mukesh Kumar Savaliya wrote:
> 
>> IIUC, It comes to the point of first identifying if it's in context of QSPI
>> controller or SPI controller right ?
> 
>> Identify if SPI/QSPI controller has this capability using dtr_caps =
>> true/false. Then check if it's supporting SDR/DDR mode. Can we then
>> introduce below struct to first mark capability as true/false and then
>> process dtr_mode ?
> 
>> if not supported (dtr_caps = false), then don't care dtr_mode.
> 
> We should complain if the device requsted anything the controller can't
> support.
> 
Yes, makes sense. i have added dtr_caps into controller data structure 
and validating it inside the __spi_validate().
>> struct spi_caps {
>> 	bool dtr_mode;
>> 	bool dtr_caps;
>> };
> 
> The controller capabilities are currently mainly advertised via the
> SPI_CONTROLLER_ flags but adding some bools also works, some things
> already do use that.  I'm not sure we need to wrap things in a further
> struct though.
Uploaded Patch V2. Please help review and suggest next. it may require 
still some fine stunning.



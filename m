Return-Path: <linux-spi+bounces-7717-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D69E7A96EDC
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 16:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 951814023DE
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 14:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F372857E2;
	Tue, 22 Apr 2025 14:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Rf1XlH3+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3242857C9;
	Tue, 22 Apr 2025 14:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745332085; cv=none; b=EXCphxjlzF4UrarKZo7KO4j9IdWWqHqwPQWWzi7zoUO1efnswGbe5KabRZseBWTJCs5EU/VppWk0IOeUfMfhOMlkMGhptYHCw2rZlxSRyUbpds0Afv+Qeu44o8lqrGok4VxYZQxzFOPVtyWSvHs7CAj35OjHSVuDfb7MQiUW4NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745332085; c=relaxed/simple;
	bh=U/R0BsuQuORF/6oIhwZ9wDXys+niyTjDfgkmwQTJaA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JTco2HBEc+TwpYvwgjueGzF7dHgX5EP29/Mru4dSLyb5EzTgkDRy3SRn1gvvNALiQru2DmjEsncRGW7E1UmbgAE28ZhCyaFsiDJX6gWvMdQjSkUzaaiyOxcjARodjgu0t3gR9n4ni39zuid1pA1ik+CYkIzoS3FmdtXZ8mcLIt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Rf1XlH3+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MCx0J5003163;
	Tue, 22 Apr 2025 14:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qoJ96jYkSgPaHptZsGWVbi3MtdmvdrbQa2LOZfnJDsM=; b=Rf1XlH3+CpsGHpLl
	Jk04pw8Sok0pvspmS0UI4fuYDVP7y8hmyfLsj28Ph8BgaaYrtvARS4+UEENtoUDn
	kdy9misYWgB5PFsmQ4lwt8fAYTaNYYhycfDaCPGps9FZCylBdTd6cjt7BckoPeGA
	3U++e/e9S4Y/Ip8wo//JxRNYyfCTafKLL+Kc6EPXjuu/KSlz7evzJmkq9WTEnthx
	oZOyNGVUrZfbgq5TeVgTdZhCzehGt1IWfSWu+Jyy3b4jnDjMaOh2f645O4U1LeCN
	CCpLhBHDjj/3Jz1msPaYUZl7vktsLOa6okgXd2SgTDUjAK/hSzRD76bh3JTWhoqr
	cIOm/g==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4642u9fwvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 14:27:49 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53MERnbn019825
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 14:27:49 GMT
Received: from [10.216.5.195] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 22 Apr
 2025 07:27:45 -0700
Message-ID: <12156f1c-2dcd-49d8-9297-7bf249923832@quicinc.com>
Date: Tue, 22 Apr 2025 19:57:41 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 3/3] SPI: Add virtio SPI driver
To: Mark Brown <broonie@kernel.org>
CC: Haixu Cui <quic_haixcui@quicinc.com>, <virtio-dev@lists.oasis-open.org>,
        <viresh.kumar@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hdanton@sina.com>,
        <qiang4.zhang@linux.intel.com>, <alex.bennee@linaro.org>,
        <quic_ztu@quicinc.com>
References: <20250401033621.1614194-1-quic_haixcui@quicinc.com>
 <20250401033621.1614194-4-quic_haixcui@quicinc.com>
 <74698d99-db5b-4ec7-a965-eea2a29e54b1@quicinc.com>
 <4ba22af1-fffc-46f4-bf42-675b5cda9ddc@sirena.org.uk>
Content-Language: en-US
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <4ba22af1-fffc-46f4-bf42-675b5cda9ddc@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=TYaWtQQh c=1 sm=1 tr=0 ts=6807a766 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=_tHetAC08h0EZe0waBoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GpWn1YEVtKQVHSIDViissGDhS1p5v0UU
X-Proofpoint-GUID: GpWn1YEVtKQVHSIDViissGDhS1p5v0UU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_07,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=833 mlxscore=0 malwarescore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220109



On 4/22/2025 7:49 PM, Mark Brown wrote:
>> Please maintain reverse christmas tree alingment.
>> int cs_word_delay_xfer;
>> int cs_word_delay_spi;
>> int cs_change_delay;
>> int cs_inactive;
>> int cs_setup;
>> int cs_hold;
>> int delay;
> That's not a requirement for the SPI subsystem at all.
> 
Thanks Mark for correcting me. I thought it was unique to Linux.
> Please delete unneeded context from mails when replying.  Doing this
> makes it much easier to find your reply in the message, helping ensure
> it won't be missed by people scrolling through the irrelevant quoted
> material.
Sure, will take care !


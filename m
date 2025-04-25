Return-Path: <linux-spi+bounces-7754-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F76AA9BD54
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 05:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85CFB1B67B93
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 03:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C63B194A67;
	Fri, 25 Apr 2025 03:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OZWHiR3v"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB6B1ADC97;
	Fri, 25 Apr 2025 03:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745552767; cv=none; b=g+qzXY0dye12XqrWYjRjh26lpkIIf69S2XL2DfoDz2W2wYa1vOCpPDfK/Yf5dEzDsU66ufHmjjUpJ9HQyHD7QekrfsMlPILjZoZMWCt9hxC8KRbYdl7JjhjEp8u+klWesLrV++I3LrbcjZljBFYDUNPmoS94Xih7RKNR3aJGUY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745552767; c=relaxed/simple;
	bh=xhVNRHduzZjRRUfRq3/T2oiC9yTO/0pmfgrW1d0MUHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rqNnpG/P2gEagKzlQ9+5j078xbRQsGvhgNnNquQk1zSV7LMNpb1EzxfE88eIwJla3C+yqclYFTC+5FVzjC2TVT0Kg0Ckfy+fXawgvgIrD60hssK8gij8QTU15f1KoUj3RcklCM47HVeSnlBelw4e0FINtRPchAN9VRxOEHKr55c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OZWHiR3v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P17gaJ017817;
	Fri, 25 Apr 2025 03:45:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4DFsysEFYC/b80s/A2U/Fnblh0O4u+KWny7r9scaEvU=; b=OZWHiR3v9QOItA/1
	2x2b0mqC09hZejkiEYUDf2/k53fVVCw9HcPRnOmmxjuDHOCFo490QjoZzFql9veh
	gNiYkNvFgBlwaR6Ldcgyq7058RdHoYTJv2WivMScK5aBQW7Bv67b7niNrMJYjgrK
	0kGLdheAPSK4XTNPYISN/3wPjmlwIf21ZC6OojekGq1sqnt6XuOiZc8CX6V9gejA
	7NPNALbUwCUN69ZTXYRy85+1DEqBfTBRyQZ/CAyUkqIVaazJt3gm/Ytlo9IKaeWj
	NQ3kx1T1zc2onal1CGxK35oiDNp/W2LwKnypa5ZXS1I9odEfBuDFnE38yBBqNwEr
	zISs2Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh3qj06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 03:45:51 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53P3joe2025519
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 03:45:50 GMT
Received: from [10.239.105.140] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 24 Apr
 2025 20:45:47 -0700
Message-ID: <b5a6a9d6-50da-4ab9-878d-d4dbad270f22@quicinc.com>
Date: Fri, 25 Apr 2025 11:45:44 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 3/3] SPI: Add virtio SPI driver
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>, <broonie@kernel.org>,
        <virtio-dev@lists.oasis-open.org>, <viresh.kumar@linaro.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hdanton@sina.com>, <qiang4.zhang@linux.intel.com>,
        <alex.bennee@linaro.org>
CC: <quic_ztu@quicinc.com>
References: <20250401033621.1614194-1-quic_haixcui@quicinc.com>
 <20250401033621.1614194-4-quic_haixcui@quicinc.com>
 <74698d99-db5b-4ec7-a965-eea2a29e54b1@quicinc.com>
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <74698d99-db5b-4ec7-a965-eea2a29e54b1@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qHEw8uJ7dZuoow54j3tNEJotXUfkIQe7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDAyNSBTYWx0ZWRfX6qww51k3oV0B JgeEUQLvScGC0jACtH58xaWiwVnE0zrTdZFTOsNPrKn8GSD9u9iLlL72BuhLWYjisZJLmi3PKnZ zjyjpjASMof2w8R+D1B85+ABZPsd/rjsIdYBPRmxwc/fwpDJykgEoyAg9/syxdHx4o2C2Tj3QCU
 AlV6MNQ9OuiKvONd+vkeDH1CWGdKcn3Guld4rtV2/1T9D+sECy/8/KDdbTL6kM4nK+ANagiOssA n1Bse2Rr0kAVnl/1fxzp8oTgqvt4xHA2pT62aWA3HWMjB/F8jTlZ9IyrTpjrvd/AeV200zCb9fY wnvBnaobpxcl41/EK86ayUulfF31Qu4AmoGIc+G+RsanHKCfB6powwBrl3+Irmi+T9WjVXkw5mM
 GYgLQmWMa3sNZXyPHIdq5ZIvOjB8IvGDh3BCowHzhRdtmLjBnBXghUU9/4ec8J/l6clHGmu8
X-Authority-Analysis: v=2.4 cv=ELgG00ZC c=1 sm=1 tr=0 ts=680b056f cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VOKzCr2XFDUyxE7n414A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: qHEw8uJ7dZuoow54j3tNEJotXUfkIQe7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250025

Hi Mukesh,

Thank you for your detailed review and valuable feedback.
I have carefully considered your comments and would like to
address them as follows:


> Could you please help add exact function description which can help 
> understand below details with some background/purpose ?
> 

Different delay parameters impact various phases of SPI transfers,
governing the assertion/deassertion of the CS and the timing intervals
between adjacent words in a single transfer or between consecutive
transfers.

Some delays are inherent device attributes, such as word_delay and
cs_setup in the spi_device structure, while others are specified
per-transfer via fields in the spi_transfer structure, such as
cs_change_delay and delay.

Although virtio SPI cannot directly configure transfer-stage delays by
manipulating hardware registers or precisely control CS signal behavior,
it can indirectly achieve fine-grained transfer control by passing
parameters like cs_delay_hold_ns and cs_setup_ns in the
spi_transfer_head structure to the host.

Function virtio_spi_set_delays is designed to implement this feature,
and will add description like:

/*
  * virtio_spi_set_delays - Set delay parameters for SPI transfer
  *
  * This function sets various delay parameters for SPI transfer,
  * including delay after CS asserted, timing intervals between
  * adjacent words within a transfer, delay before abdafter CS
  * deasserted. It converts these delay parameters to nanoseconds using
  * spi_delay_to_ns and stores the results in spi_transfer_head
  * structure.
  * If the conversion fails, the function logs a warning message and
  * returns an error code.
  */

Could you please review this comment and let me know if it's clear
and easy to understand? Your feedback will be greatly appreciated.



>> + * E => struct spi_device -> cs_inactive
>> + * F => struct spi_transfer -> cs_change_delay

> Alignment of single line arrow  -> .

Alignment is now consistent with "=>", could you please confirm if it 
also needs to be aligned with "->"?



>> + *
>> + * So the corresponding relationship:
>> + * A <===> cs_setup_ns (after CS asserted)
>> + * B <===> word_delay_ns (no matter with CS)
> what does it mean when you say "no matter with CS" ? Any other 
> simplified statement ?
> Delay from sending actual data /Clock generation ?

"no matter with CS" means this delay is not related to CS actually.
B is the timing interval between 2 words, during which the CS remains 
asserted.

I agree this description is unclear, just update as:

B <===> word_delay_ns (delay between adjacent words within a transfer)

>> + * C+D <===> cs_delay_hold_ns (before CS deasserted)
>> + * E+F <===> cs_change_delay_inactive_ns (after CS deasserted, these two
>> + * values are also recommended in the Linux driver to be added up)
> Alignment of all double dashed line arrows <===> to left side symbols .

OK, will update to be aligned with "<===>".


>> +    err = virtio_spi_find_vqs(priv);
>> +    if (err) {
>> +        dev_err(&vdev->dev, "Cannot setup virtqueues\n");
>> +        return err;
> Use dev_err_probe()
>> +    }

Yes, will update as:

dev_err_probe(&vdev->dev, err, "Cannot setup virtqueues\n");


Thanks & BR
Haixu Cui


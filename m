Return-Path: <linux-spi+bounces-8293-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42950AC3A39
	for <lists+linux-spi@lfdr.de>; Mon, 26 May 2025 08:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A5D3A6B9A
	for <lists+linux-spi@lfdr.de>; Mon, 26 May 2025 06:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32C7148832;
	Mon, 26 May 2025 06:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lPVQQnCf"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483FCEAF1;
	Mon, 26 May 2025 06:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748242458; cv=none; b=aFUi5GZ/uhc4POHbS6yWSDXvt3/v2wwIifBYdwZ23+6XmFEfYCZ9is5gtM2BlSRBqMYkpdk+8DAu2UqwRmdu51YG4c3M+gw8ODEnudra654o1I/+LLRQBPDRPqpyCcBMAQC+sBBz/ZsXwgq2tf/R9gkLRW7nqcus3jT834IO330=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748242458; c=relaxed/simple;
	bh=oKhW0vMC/gTm8fO8J52tIb0lpCIexlz/f6XZfrMRC2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JVrM/m4vkEMMKRFqRAxPko6n2yjMOcrJEfUb3kbmLEWG9/cJF4lq4HPTvKTGsMB7SHFALUVZwIh2Uln0K4bI+KT1jv2tzdqTqovbmpnbSeHnqLuUs2rn7LWnRXck/R8NtDPauwPjP/hK0JPRfkTOw/DFjA/uQ/yRzUfBw1S9UkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lPVQQnCf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54PNhrIx009222;
	Mon, 26 May 2025 06:53:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K8X+G7OVif2Hyi+wYo4fU0ZlnLfPPCyOrafETyvYiyU=; b=lPVQQnCfxytJqtb2
	iX4YFQkAGjA0+I+6v7DckaVc2YB2TeWyZZaj3KtAquWMftv4EcpFF4v63dBpysbo
	wlE+SdiQeRy7CzUQ2YaimetO0jzVJmrIFxtWnpt23yDaQYgOYNTdULdqYbkvvst7
	QPHZynGp19WW29J/ZqmepbQ8yZdQwV+ontpr0ohV/XBccih4NY/FRhZDpCn62AQi
	hqDE7H8YdhPxOeKruMYC8WdiORSlgveFFyLxMWSVChVtQcw1O3Zr0qpyxL+If0yd
	guvPSdqr5T+sH0nPNPf7gK8dqW7Yj3SNCzD+iPBYyhsjBzW+NmLnDsIZmtrxuQz0
	iUbkTQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u79p35qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 May 2025 06:53:53 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54Q6rel1027719
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 May 2025 06:53:40 GMT
Received: from [10.151.36.184] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 25 May
 2025 23:53:36 -0700
Message-ID: <8ab1e48a-f698-9859-3992-6a26f63d62f1@quicinc.com>
Date: Mon, 26 May 2025 12:23:33 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] mtd: nand: qpic_common: prevent out of bounds access
 of BAM arrays
Content-Language: en-US
To: Gabor Juhos <j4g8y7@gmail.com>, Mark Brown <broonie@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Sricharan Ramabadhran
	<quic_srichara@quicinc.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC: <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Lakshmi
 Sowjanya D" <quic_laksd@quicinc.com>
References: <20250525-qpic-snand-avoid-mem-corruption-v1-0-5fe528def7fb@gmail.com>
 <20250525-qpic-snand-avoid-mem-corruption-v1-2-5fe528def7fb@gmail.com>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20250525-qpic-snand-avoid-mem-corruption-v1-2-5fe528def7fb@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RXjusBSknU5VieHskKnvNYTVDr6AQ9GF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDA1NyBTYWx0ZWRfX0l/1e2sMK6lJ
 nR0nUd07ROoAO++yCFr3iLzu3LsxFsjn+9j3YAyKvWvZsK1QToGIEOO245ymg0Gx+IO/cunuAgw
 VGQy+OpwbInCFffETybswzmwZnN3F6PTOtx3So3H7U9iNBKZUQN66JQ8nC7OAfuT5TuafaiTvFt
 S3Lp6vD3czDkGWahR0SUATM/3jepvVVaz+N9OEp2s9cuZGn4Futxx22e5zKWk/mKrj8nyAz8M8i
 +gHhDEk8DtwaYGFt99N1VYwoqNNpT497fTTdeqBNLCwZHPnWkOjlLRRcosOLwnCgWdKX+w9LijX
 6hVeQC+sMOxe3pcPvlDsR1FSS4w3ZgLC/Jr8K/rk4IUgOesmkCfoaIU3FHUDPooUho7k7tjwLj0
 CJUhpP+lYiXIsEtZEPnTC+GtSBV/8fhE9ELnFInzzvzS32IrADfiEwoDotCgj/T055wup+JF
X-Authority-Analysis: v=2.4 cv=HNnDFptv c=1 sm=1 tr=0 ts=68341001 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=5Abef97-AoBQRPTZQeIA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: RXjusBSknU5VieHskKnvNYTVDr6AQ9GF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_03,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=990 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505260057

Hi,

On 5/25/2025 10:35 PM, Gabor Juhos wrote:
> The common QPIC code does not do any boundary checking when it handles
> the command elements and scatter gater list arrays of a BAM transaction,
> thus it allows to access out of bounds elements in those.
> 
> Although it is the responsibility of the given driver to allocate enough
> space for all possible BAM transaction variations, however there can be
> mistakes in the driver code which can lead to hidden memory corruption
> issues which are hard to debug.
> 
> This kind of problem has been observed during testing the 'spi-qpic-snand'
> driver. Although the driver has been fixed with a preceding patch, but it
> still makes sense to reduce the chance of having such errors again later.
> 
> In order to prevent such errors, change the qcom_alloc_bam_transaction()
> function to store the number of elements of the arrays in the
> 'bam_transaction' strucutre during allocation. Also, add sanity checks to
> the qcom_prep_bam_dma_desc_{cmd,data}() functions to avoid using out of
> bounds indices for the arrays.
> 
> Tested with the 'spi-qpic-snand' driver only.
I recommend testing this patch on both the IPQ and SDX platforms,
as the QPIC raw NAND driver are utilized across both.

If you have access to IPQ and SDX devices with raw NAND, please proceed
with testing on both.

Otherwise, I can handle testing on the IPQ raw NAND device and 
coordinate with Lakshmi Sowjanya D (quic_laksd@quicinc.com)
for testing on the SDX platform.

Thanks,
Alam.


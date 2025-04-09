Return-Path: <linux-spi+bounces-7492-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 575D0A82F34
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 20:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221DB880852
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 18:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB991DFFD;
	Wed,  9 Apr 2025 18:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iZglN0FM"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC801C5F23;
	Wed,  9 Apr 2025 18:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224277; cv=none; b=SxtXgxzqUmrRXVz8z4L9nyOUUi0qySS9d+OamP9DYTXilCxC38JhO9KKMxDz09pKMTpwaDpbpfeCTvokyaeKpWCWgXEDPYY8xP4KKC1XxH2QGSvS2SVh2ggD7X/peTITnGgM/l7arj12fjMnBatyasLm7XnuxU0kY+isz6xpMQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224277; c=relaxed/simple;
	bh=SsOVTIymYW0rbKzadjR3LPmscl8wGqMHGgYE1NNeHZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DQfx6vljP17CdUuO090x2MOFIetGmd2zN6w5+e2M+dBG9J5JSarrqnwPGBTeGkyGp4i3RSRj66fsx7tiuuWA6LsW/+5+m4iM5Y0xnT2NNm8htfkdXi+wgQpNsPNkZhxFsCjGv9JXxMD0RztK7B3FBsls9aHYsNyOcZPmYBt4Tyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iZglN0FM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539HGwMu016747;
	Wed, 9 Apr 2025 18:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7DuW50LDJP2LvdpQYzrMBw8Dy7yzEyqrEuV9zAPb5DY=; b=iZglN0FMxooe7vuj
	q2u6yzA+T04ZIKSruBUyuz4Pslgx7/FQsSDnZanGLw0WHjROCPYxVUqIYq8LUdTT
	5CvtMNkSCtboB0q0S14fa7EP7FOkpMshBv/gK9pBrygQaL3ITSZnpojEzrxJOkiF
	cBimmS5LvuNhIZwmTH0NOsuSG2p/hlbGGcsl4ugRSKVj252gTY1Xq4GbaSfvao7j
	7YD+dujWshQap1Kp4SfM1mZ3PCldYYCZerZ+O1h7ijMzsWUpOha7xGMPIzMbou8p
	5ALVvpEYnYX9ecO1qgj3CLv37V0Op0XSHkzgLaXELDIMmbr+AFKJELU+3flYD9+Y
	A05KZg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twd2vdmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 18:44:30 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 539IiUFH005869
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 9 Apr 2025 18:44:30 GMT
Received: from [10.216.43.112] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 9 Apr 2025
 11:44:27 -0700
Message-ID: <93e6ae6d-0573-4475-b004-52dd24906ff0@quicinc.com>
Date: Thu, 10 Apr 2025 00:14:25 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] spi: spi_amd: Fix an IS_ERR() vs NULL check in probe
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Raju Rangoju
	<Raju.Rangoju@amd.com>
CC: Mark Brown <broonie@kernel.org>,
        Akshata MukundShetty
	<akshata.mukundshetty@amd.com>,
        Krishnamoorthi M <krishnamoorthi.m@amd.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <0e0f5ede-8993-4fac-967c-51e46b095416@stanley.mountain>
Content-Language: en-US
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <0e0f5ede-8993-4fac-967c-51e46b095416@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9bwc96xrjpM1x_ECg4c68V7atLK00waH
X-Proofpoint-GUID: 9bwc96xrjpM1x_ECg4c68V7atLK00waH
X-Authority-Analysis: v=2.4 cv=NaLm13D4 c=1 sm=1 tr=0 ts=67f6c00f cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=fVdgpoan2q-YNdFqOm0A:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_06,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 clxscore=1011 phishscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090123

Looks good to me.

On 4/9/2025 4:30 PM, Dan Carpenter wrote:
> The devm_ioremap() function returns NULL on error, it doesn't
> return error pointers.  Update the error checking to match.
> 
> Fixes: b644c2776652 ("spi: spi_amd: Add PCI-based driver for AMD HID2 SPI controller")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/spi/spi-amd-pci.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-amd-pci.c b/drivers/spi/spi-amd-pci.c
> index e1ecab755fe9..e5faab414c17 100644
> --- a/drivers/spi/spi-amd-pci.c
> +++ b/drivers/spi/spi-amd-pci.c
> @@ -46,8 +46,8 @@ static int amd_spi_pci_probe(struct pci_dev *pdev,
>   	io_base_addr = (io_base_addr & AMD_SPI_BASE_ADDR_MASK) + AMD_HID2_PCI_BAR_OFFSET;
>   	amd_spi->io_remap_addr = devm_ioremap(dev, io_base_addr, AMD_HID2_MEM_SIZE);
>   
> -	if (IS_ERR(amd_spi->io_remap_addr))
> -		return dev_err_probe(dev, PTR_ERR(amd_spi->io_remap_addr),
> +	if (!amd_spi->io_remap_addr)
> +		return dev_err_probe(dev, -ENOMEM,
>   				"ioremap of SPI registers failed\n");
>   
>   	dev_dbg(dev, "io_remap_address: %p\n", amd_spi->io_remap_addr);
Acked-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>


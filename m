Return-Path: <linux-spi+bounces-7074-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81169A5634D
	for <lists+linux-spi@lfdr.de>; Fri,  7 Mar 2025 10:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0831E3A428B
	for <lists+linux-spi@lfdr.de>; Fri,  7 Mar 2025 09:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579BA1E1E13;
	Fri,  7 Mar 2025 09:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="xlqJ5gvN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D2E1D9A66;
	Fri,  7 Mar 2025 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741338679; cv=none; b=cT7JSmIifdzYIAhxq4VJQEjMXBNNXECZur22y0rkPIJYY96gpgIa6v3wUl2rSRzgYCTyTfKuCGVIXWnZXj60b/a5co0KZbGz8rVm1ytyOCZI4U1fdaeq4EcWBTwpnvL98q0yMQoUSGC3gMZ0BnOgw9NZYGTq48mGzaXgksb+SKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741338679; c=relaxed/simple;
	bh=ltgoNzgYtxsbymD9vskeFxGtQHUnteTdUfDu3zc5wGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nbpfmVbRb1HeZt3AU2Rav0EQz417pESPdDCPOlBIJ/+wEHSXcAZy1t9dC4HbAr06dnGdon8GCG8JegZDVRoW+jUQiQOHVDs6MuX5uVXBFPDCc6WpvG0cxMFJU3FhfemF+u5wrS8grRz+wrjBy5feqtIDugNlNBHliRjn807BliE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=xlqJ5gvN; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5277MpKU029564;
	Fri, 7 Mar 2025 10:10:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	MbwoBFfg5pVaSdi+Qssvq+8QdxwNch8vbgxAm8z822M=; b=xlqJ5gvN1TnsNDm4
	1CT8YWBcB/a5XeRyb/I/ol1Rnvx1KlSG991Qw5SL25FfA+1/kLwJCEKmhodmujYx
	Y2oqilb2hWxwhZaDMWoVY+oGOHvBRR9/bM7nyfENFeJH+NcnoqkSC2rgyPz3XeJA
	z4v/Hjo3D6+Ub91QfXyPTJ9ak1QUGkh7wJ5pG6ZSvXqe+BMz5gEDdvS6B2UIUdr4
	BVdL6T8kFTVlSVXmOdA+q1/Kjx48ChQS/0S4f607E9DC0nMECo2GmM8H1O0jm9TN
	D4p+lrEDeU0e9xh6Zai9P+OLCH1h0ueMxQ47Smx8JPj5MkkgCArHduDdDTp3aS9l
	44j1dA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 457286vefq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 10:10:43 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A1001400F0;
	Fri,  7 Mar 2025 10:09:23 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BABD85AC8BC;
	Fri,  7 Mar 2025 09:59:43 +0100 (CET)
Received: from [10.252.19.16] (10.252.19.16) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 09:59:43 +0100
Message-ID: <dfd831ec-e004-4132-94f0-3bdc755907cd@foss.st.com>
Date: Fri, 7 Mar 2025 09:59:42 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: stm32: Fix a NULL vs IS_ERR() bug
To: Charles Han <hanchunchao@inspur.com>, <broonie@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>
CC: <linux-spi@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250307032530.116837-1-hanchunchao@inspur.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250307032530.116837-1-hanchunchao@inspur.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_03,2025-03-06_04,2024-11-22_01



On 3/7/25 04:25, Charles Han wrote:
> The devm_ioremap() function doesn't return error pointers, it may
> returns NULL.  Update the error checking to match.
> 
> Fixes: 79b8a705e26c ("spi: stm32: Add OSPI driver")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>  drivers/spi/spi-stm32-ospi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
> index 8eadcb64f34a..a544d7897edf 100644
> --- a/drivers/spi/spi-stm32-ospi.c
> +++ b/drivers/spi/spi-stm32-ospi.c
> @@ -835,10 +835,10 @@ static int stm32_ospi_get_resources(struct platform_device *pdev)
>  	if (rmem) {
>  		ospi->mm_size = rmem->size;
>  		ospi->mm_base = devm_ioremap(dev, rmem->base, rmem->size);
> -		if (IS_ERR(ospi->mm_base)) {
> +		if (!ospi->mm_base) {
>  			dev_err(dev, "unable to map memory region: %pa+%pa\n",
>  				&rmem->base, &rmem->size);
> -			ret = PTR_ERR(ospi->mm_base);
> +			ret = -ENOMEM;
>  			goto err_dma;
>  		}
>  

Hi

No need to copy/paste other contributor's patch by just swapping some 
words in title/commit message.

This fix has already sent By Dan Carpenter and merged.

Patrice


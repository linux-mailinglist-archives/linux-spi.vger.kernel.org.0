Return-Path: <linux-spi+bounces-7056-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778BEA547C6
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 11:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D48172BF9
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 10:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2528200BB2;
	Thu,  6 Mar 2025 10:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="wfBPq9TJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF97018A6B5;
	Thu,  6 Mar 2025 10:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256926; cv=none; b=HYlTiKnLV9zAUn+KhFSyhlxKJ779hQaKL5bJNhilRCCw9AI4+AJOKskoEwLD1Y6VaPO51Inj6G0vNv0NXORPXfLrQ25YvhBUHwq0qJyo3EDqBVR4m+TmeUJrMDv0kq2bQsYhjtYqKjaISnzMFKk40Vz6oAfUv+3Dz1jed1Dqv28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256926; c=relaxed/simple;
	bh=syoPIVjbFQmqD3mbzC8x+6wk935HiQWfR8keZLGGyIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=vFhRWH/znf7+yKd7QFcMysRTDxPpNMKNxW0HANiVz+Eskqb4hSX5be6qaJorTNyVvrHGNlbNuCdWQrVmroAho/wf2O803QeOm1M16kGtybslGe6lMVjbw5XZY/+i/0+BJtlMldDmFwDZ1EzNlBF/HlmxVqTM62s4TI6dyQh0XMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=wfBPq9TJ; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526ACxeE029564;
	Thu, 6 Mar 2025 11:28:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	rZJvAb4lK5uj98yPaFX83j04iTuIZ3/ioDN8111skDE=; b=wfBPq9TJ5MvlEFn3
	mZA90YzxSdloBvCkeNRJhxamXLJU4+sZWPZqkSOZtK8iTa3ICqGl4deYzBahNLuR
	EuaSEgCCGqEH72P7AUtfBIS/yh+5tq9pptsgmrEJG67FjmPos7s/Cw2fc0IrG9UH
	4Quo29IpeYsJGvIfNqT0UcKZ15C5QD7CvB4KlhraJ2FbRo/9xg4JADacOHbihn98
	fX3fSWjEMbCIhLE3TctrV8AW/ieOEWsYCBSjxheqssJvx1XnGDmqxniM1osO1oJd
	yODNHZ3DoLCdq2cPMo/h4B9u6wfOyKwZw+p9SCG0j9E+i3YEjzWlnt127bYg3c4I
	5zIVpQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 457286kh4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 11:28:32 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1C3BF4007F;
	Thu,  6 Mar 2025 11:27:33 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 665CD51A119;
	Thu,  6 Mar 2025 11:27:00 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 11:26:59 +0100
Message-ID: <f681046c-449f-42fd-8c97-36c459fdb3e6@foss.st.com>
Date: Thu, 6 Mar 2025 11:26:58 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] spi: stm32-ospi: Fix an IS_ERR() vs NULL bug in
 stm32_ospi_get_resources()
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Mark Brown <broonie@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <bc4c9123-df43-4616-962f-765801d30b4c@stanley.mountain>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <bc4c9123-df43-4616-962f-765801d30b4c@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01



On 3/6/25 10:48, Dan Carpenter wrote:
> The devm_ioremap() function returns NULL on error, it doesn't return
> error pointers.  Fix the check to match.
> 
> Fixes: 79b8a705e26c ("spi: stm32: Add OSPI driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
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


Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice


Return-Path: <linux-spi+bounces-8896-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F20B9AEDB96
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 13:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4550188E17C
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 11:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B632283CA3;
	Mon, 30 Jun 2025 11:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="cFNtvq2G"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3F1283C91;
	Mon, 30 Jun 2025 11:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751284133; cv=none; b=im6PzjmzberAvco940KHCI/gdAhl0vfLjmfjZyR5x3R5JhDYbXOg3cofGzsRcn52AZYjpd/CL6zDPKuSkhl3cfsZG/mD8Zamg03lNsAInbMgEcy6q93RByJXD+vRjJYYfHmFYPG51tssv4oYSNSjloJI5zjgZR+8lOCXmv9mlaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751284133; c=relaxed/simple;
	bh=DUJjBO7T5MaF7dBk+qD2Lmzq5qH9wDFK0AwvSWOj9Bs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biUkwsWm2d2JO4r/5NJikSls8xFJarInpzTfZQBrjMQy7a1eldH7AAZ/9aL7nJyXbycFAUPrnSzRz+4BXawp+y0ud4ysVeciq7UulUk38+FXzHUYXxYiscbW1ueVmRBWVxAmGs7UKsnx7Ik0+gCUuIpG28i1dhqM8ly8zbgLhq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=cFNtvq2G; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55U7x1gK025447;
	Mon, 30 Jun 2025 13:48:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	91jH5cFvvocFD9cZk0oZNMRRI8Lu1LwSiDDduj/iv9Q=; b=cFNtvq2G6gSzql0A
	9toSeVBYzuHhPRn3p4gNSVQ6W6jAkSgqNetkM09uJ8qpEOncJd5IJZlDB6zf+WOO
	A8hcTWHKsVQV5inpukGA+dgpKqGzNMWzXh6wo2ea/VLU/wcWDeGWXAy81n4RQcPo
	yLyqI/J90HIom9VcxytldkfLF5ZeN5w8y+6PEuEXht5LKk5Qeg7/lw+r1FPb8Au5
	vFBp8TjpQHTEr4keKHkx+N4V+8rYOcqUeqmKCmy7j3Q22voEx71SBs+RdTUFatK/
	1IdrP7bn69pDx3XrZQ5LuDrGI6DpPM9BI6TaoLZqiFvNGLW5AsDq7WdyuuQr89vE
	Jn4Inw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47jsy4myxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 13:48:39 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id F1A2C4004B;
	Mon, 30 Jun 2025 13:47:40 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D89CDB28C48;
	Mon, 30 Jun 2025 13:47:10 +0200 (CEST)
Received: from gnbcxd0016.gnb.st.com (10.130.77.119) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Jun
 2025 13:47:10 +0200
Date: Mon, 30 Jun 2025 13:47:09 +0200
From: Alain Volmat <alain.volmat@foss.st.com>
To: =?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>
CC: Mark Brown <broonie@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Dan
 Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] spi: stm32: fix sram pool free in probe error path
Message-ID: <20250630114709.GB398774@gnbcxd0016.gnb.st.com>
References: <20250630-spi-fix-v1-1-2e671c006e15@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250630-spi-fix-v1-1-2e671c006e15@foss.st.com>
X-Disclaimer: ce message est personnel / this message is private
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_03,2025-06-27_01,2025-03-28_01

Hi Clément,

On Mon, Jun 30, 2025 at 10:20:13AM +0200, Clément Le Goffic wrote:
> Add a test to check whether the sram_pool is NULL before freeing it.
> 
> Fixes: d17dd2f1d8a1 ("spi: stm32: use STM32 DMA with STM32 MDMA to enhance DDR use")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
> ---
>  drivers/spi/spi-stm32.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
> index 3d20f09f1ae7..858470a2cab5 100644
> --- a/drivers/spi/spi-stm32.c
> +++ b/drivers/spi/spi-stm32.c
> @@ -2486,7 +2486,9 @@ static int stm32_spi_probe(struct platform_device *pdev)
>  	if (spi->mdma_rx)
>  		dma_release_channel(spi->mdma_rx);
>  err_pool_free:
> -	gen_pool_free(spi->sram_pool, (unsigned long)spi->sram_rx_buf, spi->sram_rx_buf_size);
> +	if (spi->sram_pool)
> +		gen_pool_free(spi->sram_pool, (unsigned long)spi->sram_rx_buf,
> +			      spi->sram_rx_buf_size);
>  err_dma_release:
>  	if (spi->dma_tx)
>  		dma_release_channel(spi->dma_tx);
> 

Looks good to me. Thanks.
Acked-by: Alain Volmat <alain.volmat@foss.st.com>

Regards,
Alain

> ---
> base-commit: 045719b1d0aab98e6abdd7715e8587b997d1cefa
> change-id: 20250630-spi-fix-860416bfb96d
> 
> Best regards,
> -- 
> Clément Le Goffic <clement.legoffic@foss.st.com>
> 


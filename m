Return-Path: <linux-spi+bounces-8880-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974AEAED74D
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 10:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95F093B5F3A
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 08:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC9E20FAB2;
	Mon, 30 Jun 2025 08:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="pN/5zQWC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F9F1F1317;
	Mon, 30 Jun 2025 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751272234; cv=none; b=e8mxKUtZYJPAX35egEus3+IBGl9gCrdeaU+ucyhqCdJXMx886v1rDniPz3y0Fu+CP4qF9Cy0dUGIfNeh7oq63yKm7PdDgR3KoDooSQO0k77hLRc4VJ1VuQGIldewA0q5ukS2J0LAG2LhRsoGuA4GugOmKThgROTY+ueBUnB/jRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751272234; c=relaxed/simple;
	bh=WhUH3kd8yTWl4hqtKNADtnS30bPb+kigzXqNcalUCds=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gN6mHmyBY/BvFyFQ4Q5ZuDQ8awg4YACGOfFzNo0HUkcG1tMRVbNRihsq2VWgWeWXeHaj5xtt8UpRNDjTy+pFs+Cr2OQgmE3mscKhZCROiLN6YNp7wbpD9ROx6dxMEhXfb3pbzZoce0RT47xJnNZA/koDGy/07C0rErRE9ZRYfPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=pN/5zQWC; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55U7pr62007947;
	Mon, 30 Jun 2025 10:30:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	MMhEswzfz6Tdga1zQpQyWh8QYxmL/LddetOQ1V55ux0=; b=pN/5zQWCnOEyU639
	+qKc397SzTfJYoQP9dKXkQCFh5cqxElAX4z1jItyu3OExiThXPfQ+TXlXVGATpEx
	yVy7GcyeoDpKa7RVik4OQtTmjYrGo75a0vZF/3zTFZndMDZWTZFxcSpzVxKbNAch
	YqpoNI8XNHy9LkLuSrQ+ligkl+Wl+TGkl0woYBmxdHDO7DYqsSW7E/ERhIPwJAPP
	Ftz/mEwNhbdMW9oNIAt/NyFLJjZV2JP+5MCE/NXaaBXCvf0WHkSZpSUu5KrSWzyZ
	Kzbp21wHS64tB41Rn5XCykFeJb5ne7ZQAE+3Moni0R1Pr6rREDOAn5BeRCaF6udC
	vtO8qw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47j5tkxsvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 10:30:20 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9F8324002D;
	Mon, 30 Jun 2025 10:29:21 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E4DA16F3FFE;
	Mon, 30 Jun 2025 10:28:51 +0200 (CEST)
Received: from [10.252.20.7] (10.252.20.7) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Jun
 2025 10:28:51 +0200
Message-ID: <5e61da51-cd02-41fd-9773-8bd776e1db62@foss.st.com>
Date: Mon, 30 Jun 2025 10:28:50 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: stm32: fix pointer-to-pointer variables usage
To: Antonio Quartulli <antonio@mandelbit.com>, <linux-spi@vger.kernel.org>
CC: <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alain Volmat
	<alain.volmat@foss.st.com>
References: <20250630081253.17294-1-antonio@mandelbit.com>
Content-Language: en-US
From: Clement LE GOFFIC <clement.legoffic@foss.st.com>
In-Reply-To: <20250630081253.17294-1-antonio@mandelbit.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_01,2025-06-27_01,2025-03-28_01

On 6/30/25 10:12, Antonio Quartulli wrote:
> In stm32_spi_prepare_rx_dma_mdma_chaining() both rx_dma_desc
> and rx_mdma_desc are passed as pointer-to-pointer arguments.
> 
> The goal is to pass back to the caller the value returned
> by dmaengine_prep_slave_sg(), when it is not NULL.
> 
> However, these variables are wrongly handled as simple pointers
> during later assignments and checks.
> 
> Fix this behaviour by introducing two pointer variables
> which can then be treated accordingly.
> 
> Fixes: d17dd2f1d8a1 ("spi: stm32: use STM32 DMA with STM32 MDMA to enhance DDR use")
> Addresses-Coverity-ID: 1644715 ("Null pointer dereferences (REVERSE_INULL)")
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
> 
> ---
> Changes from v1:
> * introduce *_mdma_desc and *_dma_desc for better readability
> * fix another instance of rx_dma_desc bogus assignment in case of
>    failure of sg_alloc_table()
> * commit title/message reworded accordingly to the previous point
> ---
>   drivers/spi/spi-stm32.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
> index 3d20f09f1ae7..4b7f074fdba9 100644
> --- a/drivers/spi/spi-stm32.c
> +++ b/drivers/spi/spi-stm32.c
> @@ -1474,6 +1474,8 @@ static int stm32_spi_prepare_rx_dma_mdma_chaining(struct stm32_spi *spi,
>   						  struct dma_async_tx_descriptor **rx_dma_desc,
>   						  struct dma_async_tx_descriptor **rx_mdma_desc)
>   {
> +	struct dma_async_tx_descriptor *_mdma_desc = *rx_mdma_desc;
> +	struct dma_async_tx_descriptor *_dma_desc = *rx_dma_desc;
>   	struct dma_slave_config rx_mdma_conf = {0};
>   	u32 sram_period, nents = 0, spi_s_len;
>   	struct sg_table dma_sgt, mdma_sgt;
> @@ -1524,18 +1526,18 @@ static int stm32_spi_prepare_rx_dma_mdma_chaining(struct stm32_spi *spi,
>   		}
>   	}
>   
> -	*rx_dma_desc = dmaengine_prep_slave_sg(spi->dma_rx, dma_sgt.sgl,
> -					       dma_sgt.nents, rx_dma_conf->direction,
> -					       DMA_PREP_INTERRUPT);
> +	_dma_desc = dmaengine_prep_slave_sg(spi->dma_rx, dma_sgt.sgl,
> +					    dma_sgt.nents, rx_dma_conf->direction,
> +					    DMA_PREP_INTERRUPT);
>   	sg_free_table(&dma_sgt);
>   
> -	if (!rx_dma_desc)
> +	if (!_dma_desc)
>   		return -EINVAL;
>   
>   	/* Prepare MDMA slave_sg transfer MEM_TO_MEM (SRAM>DDR) */
>   	ret = sg_alloc_table(&mdma_sgt, nents, GFP_ATOMIC);
>   	if (ret) {
> -		rx_dma_desc = NULL;
> +		_dma_desc = NULL;
>   		return ret;
>   	}
>   
> @@ -1558,13 +1560,13 @@ static int stm32_spi_prepare_rx_dma_mdma_chaining(struct stm32_spi *spi,
>   		}
>   	}
>   
> -	*rx_mdma_desc = dmaengine_prep_slave_sg(spi->mdma_rx, mdma_sgt.sgl,
> -						mdma_sgt.nents, rx_mdma_conf.direction,
> -						DMA_PREP_INTERRUPT);
> +	_mdma_desc = dmaengine_prep_slave_sg(spi->mdma_rx, mdma_sgt.sgl,
> +					     mdma_sgt.nents, rx_mdma_conf.direction,
> +					     DMA_PREP_INTERRUPT);
>   	sg_free_table(&mdma_sgt);
>   
> -	if (!rx_mdma_desc) {
> -		rx_dma_desc = NULL;
> +	if (!_mdma_desc) {
> +		_dma_desc = NULL;
>   		return -EINVAL;
>   	}
>   

Thank you, LGTM
You can add my Reviewed-by

Best regards,
Clément


Return-Path: <linux-spi+bounces-8875-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 907A2AED5D3
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 09:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3ED3188A15F
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 07:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D146F18E20;
	Mon, 30 Jun 2025 07:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="QA9ziUH7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B202221DB1;
	Mon, 30 Jun 2025 07:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751268966; cv=none; b=gzTAfPcKeElm6/sed6X/uoOPW3cZ3bFlXC+G5r/TAoM+Rtigmp2s5ONQrqTtmDGXGOqoNA3ZptQpULr/I+c4KvhwNHXOjzWJWjPL4YseHkVpjuVtKrpxJYxyyVgunKurJ8FV8Q3wIJFCdhVWn2fj8ixxZi2styGL33uXDPEnla0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751268966; c=relaxed/simple;
	bh=iNDrjh0tpRqFMUceSM9T2AlLoJiEFqU5pz2vsAYwVxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X0h/W4TdyZg7aLjX10dw/Lu9iyiD0Iu6zUmkXS6ncqv4NhYbAKy7jIrGV2a6jsjQ3qJynXAY/B/kg3ZPJCkpsn1NSqY6ZJdCvwgCsgjKoYPc0tXpDGNLYV0zcqoZltYpVtimZpMopQiHCMsbX0NRuCTgEfnaaFguI9Jau7Hghvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=QA9ziUH7; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55U7AniW028032;
	Mon, 30 Jun 2025 09:35:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	3TeFS+uiHYd7t7KK/aAu0N/KEC1YUemvKeluUuOfecA=; b=QA9ziUH74nPr8B5h
	tSCcx7WJc5TajZUH1r7XpOAseYVJXtyyrECAhoHZ1w7H621FQsd/wZuiOntoOLux
	xVb1f3Sq4tnnJX0KF9NbhrT7jrH06muly99q0vw2j8PJgb6cw7X3NQ9vQ6mYIzS7
	FBVzTYysav1JdMt27wULU2nz24Dd7lfN8oNojqaj8xy/D1X7A3XL2xPzl1Tmm8T4
	BhKW6UfEbWYU+dQrmaO10MTQwPFFPtS+ruX6uTVqgBZadAunJcSSjXzMMAfwlpiA
	ANXefcNTmfzo4SoFirZNEOK8fZZWvUkGHf+r+v7WVek7sRmgn+VWHIAHWBqTlFPX
	+f5lqA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47j79h5udb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 09:35:43 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id ACD4540047;
	Mon, 30 Jun 2025 09:34:43 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D342946AD15;
	Mon, 30 Jun 2025 09:34:15 +0200 (CEST)
Received: from [10.252.20.7] (10.252.20.7) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Jun
 2025 09:34:15 +0200
Message-ID: <1f49b8f3-44c9-43f3-a3bf-b931fb0726f4@foss.st.com>
Date: Mon, 30 Jun 2025 09:34:13 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: stm32: fix NULL check on pointer-to-pointer variable
To: Antonio Quartulli <antonio@mandelbit.com>, <linux-spi@vger.kernel.org>
CC: <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alain Volmat
	<alain.volmat@foss.st.com>
References: <20250628000227.22895-1-antonio@mandelbit.com>
Content-Language: en-US
From: Clement LE GOFFIC <clement.legoffic@foss.st.com>
In-Reply-To: <20250628000227.22895-1-antonio@mandelbit.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_01,2025-06-27_01,2025-03-28_01

Hi Antonio,

On 6/28/25 02:02, Antonio Quartulli wrote:
> In stm32_spi_prepare_rx_dma_mdma_chaining() both rx_dma_desc
> and rx_mdma_desc are passed as pointer-to-pointer arguments.
> 
> The goal is to pass back to the caller the value returned
> by dmaengine_prep_slave_sg(), when it is not NULL.
> 
> However, the NULL check on the result is erroneously
> performed without dereferencing the pointer.
> 
> Add the proper dereference operator to both checks.
> 
> Fixes: d17dd2f1d8a1 ("spi: stm32: use STM32 DMA with STM32 MDMA to enhance DDR use")
> Addresses-Coverity-ID: 1644715 ("Null pointer dereferences (REVERSE_INULL)")
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
> ---
>   drivers/spi/spi-stm32.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
> index 3d20f09f1ae7..e9fa17e52fb0 100644
> --- a/drivers/spi/spi-stm32.c
> +++ b/drivers/spi/spi-stm32.c
> @@ -1529,7 +1529,7 @@ static int stm32_spi_prepare_rx_dma_mdma_chaining(struct stm32_spi *spi,
>   					       DMA_PREP_INTERRUPT);
>   	sg_free_table(&dma_sgt);
>   
> -	if (!rx_dma_desc)
> +	if (!*rx_dma_desc)
>   		return -EINVAL;
>   
>   	/* Prepare MDMA slave_sg transfer MEM_TO_MEM (SRAM>DDR) */
> @@ -1563,8 +1563,8 @@ static int stm32_spi_prepare_rx_dma_mdma_chaining(struct stm32_spi *spi,
>   						DMA_PREP_INTERRUPT);
>   	sg_free_table(&mdma_sgt);
>   
> -	if (!rx_mdma_desc) {
> -		rx_dma_desc = NULL;
> +	if (!*rx_mdma_desc) {
> +		*rx_dma_desc = NULL;
>   		return -EINVAL;
>   	}
>   

Good catch for both pointers !

For readability, I would suggest to define two dma_async_tx_descriptor 
ptr at the beginning of the function such as :
	struct dma_async_tx_descriptor *_mdma_desc = *rx_mdma_desc;
	struct dma_async_tx_descriptor *_dma_desc = *rx_dma_desc;

And then use them all along the function even in the assignation.

Best regards,
Clément


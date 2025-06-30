Return-Path: <linux-spi+bounces-8895-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DF7AEDB75
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 13:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2F04189B715
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 11:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9E62627EC;
	Mon, 30 Jun 2025 11:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="MkYrRgjb"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DD826059F;
	Mon, 30 Jun 2025 11:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751283759; cv=none; b=hWBlyaaQkIF/fKNM+0HuPD5zkQs+9umYZGY6pbuUmG8gpYLB2KQN1TzvFBTWdueCSBM/XQ+hMyvsCeiu0CwgffuMg/nEbOEYyDb7iszVvgkG/D5lsw6T9upKC17PKSVJsemiaPGXR1JCrXN+Wz8j3EjsRnp2y4WWh09K+JFBXJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751283759; c=relaxed/simple;
	bh=mZFzArsRJyrG8k03mRKECaPQ6JaZ31L3+yrSlxdo7S4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJV6mlI1Xfliwcla4Vapudz4if2G+dGwQD86qCigeyenN/gQn+/JKvfAJGxG7/Te72mtQXty3co7ROVvnt/ugh32sinZYz8C+yWfCVqWTwdQTF5r6lzXRcBYuvEc2TcOmVidIKuBykkEWleg3EzuL/u0whtK5+VDYVEv0Qghj8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=MkYrRgjb; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UA9NFN023997;
	Mon, 30 Jun 2025 13:42:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=selector1; bh=8pycezctstuz3BFlNIxQMNF0
	K5ylVdmwNgA8PPuNOE4=; b=MkYrRgjbalPM0VOOV78JMBpg6f3AhTUePQ8VeYVZ
	1TMtJouX6Eq4sVkrc8PHVpBOmp/Ngy7OrS/fKgugQLkvjtwCN6AMVK9yfT2d6m/1
	aKpW/SgEOXBmc0JQIRAK6jD6PB9o7JYle/NhL1Xkh+GsB9ykA8aMd3u1WtkrqrlK
	j7ySLnqKHhIGsyTMRG9i5J9T8R5hrc0ngrPL3U8DMk5RKFVpLZicJmKuxyd9v25+
	by19Hcuyrsbo/4bv3+NJ48pJNi/vG7OtVImPJnZu7cf3mSq8LEG6ey/85XERtJfp
	l2C1QUdrraL4uNa6ubG8Ucv0Mg9yYR61zHH3wDzoaV9Q0Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47jubnmqrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 13:42:23 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3830E40059;
	Mon, 30 Jun 2025 13:41:27 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ACD70B2379E;
	Mon, 30 Jun 2025 13:40:57 +0200 (CEST)
Received: from gnbcxd0016.gnb.st.com (10.130.77.119) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Jun
 2025 13:40:57 +0200
Date: Mon, 30 Jun 2025 13:40:51 +0200
From: Alain Volmat <alain.volmat@foss.st.com>
To: Antonio Quartulli <antonio@mandelbit.com>
CC: <linux-spi@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] spi: stm32: fix pointer-to-pointer variables usage
Message-ID: <20250630114051.GA398774@gnbcxd0016.gnb.st.com>
References: <1f49b8f3-44c9-43f3-a3bf-b931fb0726f4@foss.st.com>
 <20250630081253.17294-1-antonio@mandelbit.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250630081253.17294-1-antonio@mandelbit.com>
X-Disclaimer: ce message est personnel / this message is private
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_03,2025-06-27_01,2025-03-28_01

Hi Antonio,

Thank you for the patch.

On Mon, Jun 30, 2025 at 10:12:53AM +0200, Antonio Quartulli wrote:
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
>   failure of sg_alloc_table()
> * commit title/message reworded accordingly to the previous point
> ---
>  drivers/spi/spi-stm32.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
> index 3d20f09f1ae7..4b7f074fdba9 100644
> --- a/drivers/spi/spi-stm32.c
> +++ b/drivers/spi/spi-stm32.c
> @@ -1474,6 +1474,8 @@ static int stm32_spi_prepare_rx_dma_mdma_chaining(struct stm32_spi *spi,
>  						  struct dma_async_tx_descriptor **rx_dma_desc,
>  						  struct dma_async_tx_descriptor **rx_mdma_desc)
>  {
> +	struct dma_async_tx_descriptor *_mdma_desc = *rx_mdma_desc;
> +	struct dma_async_tx_descriptor *_dma_desc = *rx_dma_desc;
>  	struct dma_slave_config rx_mdma_conf = {0};
>  	u32 sram_period, nents = 0, spi_s_len;
>  	struct sg_table dma_sgt, mdma_sgt;
> @@ -1524,18 +1526,18 @@ static int stm32_spi_prepare_rx_dma_mdma_chaining(struct stm32_spi *spi,
>  		}
>  	}
>  
> -	*rx_dma_desc = dmaengine_prep_slave_sg(spi->dma_rx, dma_sgt.sgl,
> -					       dma_sgt.nents, rx_dma_conf->direction,
> -					       DMA_PREP_INTERRUPT);
> +	_dma_desc = dmaengine_prep_slave_sg(spi->dma_rx, dma_sgt.sgl,
> +					    dma_sgt.nents, rx_dma_conf->direction,
> +					    DMA_PREP_INTERRUPT);
>  	sg_free_table(&dma_sgt);
>  
> -	if (!rx_dma_desc)
> +	if (!_dma_desc)
>  		return -EINVAL;
>  
>  	/* Prepare MDMA slave_sg transfer MEM_TO_MEM (SRAM>DDR) */
>  	ret = sg_alloc_table(&mdma_sgt, nents, GFP_ATOMIC);
>  	if (ret) {
> -		rx_dma_desc = NULL;
> +		_dma_desc = NULL;
>  		return ret;
>  	}
>  
> @@ -1558,13 +1560,13 @@ static int stm32_spi_prepare_rx_dma_mdma_chaining(struct stm32_spi *spi,
>  		}
>  	}
>  
> -	*rx_mdma_desc = dmaengine_prep_slave_sg(spi->mdma_rx, mdma_sgt.sgl,
> -						mdma_sgt.nents, rx_mdma_conf.direction,
> -						DMA_PREP_INTERRUPT);
> +	_mdma_desc = dmaengine_prep_slave_sg(spi->mdma_rx, mdma_sgt.sgl,
> +					     mdma_sgt.nents, rx_mdma_conf.direction,
> +					     DMA_PREP_INTERRUPT);
>  	sg_free_table(&mdma_sgt);
>  
> -	if (!rx_mdma_desc) {
> -		rx_dma_desc = NULL;
> +	if (!_mdma_desc) {
> +		_dma_desc = NULL;
>  		return -EINVAL;
>  	}
>  

Acked-by: Alain Volmat <alain.volmat@foss.st.com>

Regards,
Alain
> -- 
> 2.49.0
> 


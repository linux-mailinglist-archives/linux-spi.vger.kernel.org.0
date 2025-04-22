Return-Path: <linux-spi+bounces-7709-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3FDA95E84
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 08:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7849F188D563
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 06:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651C722D4C0;
	Tue, 22 Apr 2025 06:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="uOsCyW+1"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2AB2192F5;
	Tue, 22 Apr 2025 06:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745304155; cv=none; b=D4v2b7jm70CLgxm+C9l3OkDm4qiYD+Yk1exgCTOjxKWH+0g3Ob6NOBLWTX0PITpVKrOQRSRugmlpPEH07Cmugr4nsBkqKI+GXGeWCxpp7SGn3/RH4/WShTgQMOydSj+b4f5/A0ftr9RqIdd2al61+vYzgHj4hmMQCO6jZ3/1a4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745304155; c=relaxed/simple;
	bh=mZ0qEmUZS33nqxAV6p/zjgzzmHR9BzxnkRL/IcSJ9EA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aLAkiUYW/3Y34tCZWi8hU9d6Pe5w26CU2mTlQSx2jupXQgAMuTI7NEfWsr+q6vXXczOqsjJQBTLii2gBJtCgi8Oe6mfMlKcTCMejHSt8EkRq/oFpF6ntv5zZTRk8EL7v/mpL2J487gM/hqigarcJhJiJ2yDQCdzF0In4AtsR8uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=uOsCyW+1; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53LNPgGE019258;
	Tue, 22 Apr 2025 08:42:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	Xi+JitXGAmFnZDuGwAZkV7H6E509qk6CX9yji9WUBzc=; b=uOsCyW+1InSqYn2g
	Cx/G5SxzaZIEV88d7LOotKXgI5Fr9o7T4X1BpTbu/e8JRVPUzT5If7A4GPdlY3LS
	HtE48oiPu4j9pwjmUbLTvsGLAErTnmj1Dek3MxxAcPCB2h3cuxRh6d91mq5mWa9P
	eFKarYQYFy6ZUyRgJRhS/5vx++fGeUVnhcxTkfsMmHHGgWmhtU+hK/7UuaHQx1+v
	sWdZQOkgtAXyQEpShuDd96smn4WMmxW9CHRu9KrTYwr9oFC3dLIOuAdNQnq/cIza
	uZb44K9YHDSls0b0VU9Wm6m0EApUkX9gvFGkSs+5oHWL3UFL2slk9kxlJxIB4Owe
	yvwztA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 464psp670n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 08:42:08 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2D34740044;
	Tue, 22 Apr 2025 08:41:08 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E3B918AD2F4;
	Tue, 22 Apr 2025 08:39:47 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Apr
 2025 08:39:47 +0200
Message-ID: <c875e526-c60b-4063-9a98-c344443fdc96@foss.st.com>
Date: Tue, 22 Apr 2025 08:39:46 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: stm32-ospi: Fix an error handling path in
 stm32_ospi_probe()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mark Brown
	<broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <2674c8df1d05ab312826b69bfe9559f81d125a0b.1744975624.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <2674c8df1d05ab312826b69bfe9559f81d125a0b.1744975624.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_03,2025-04-21_02,2024-11-22_01



On 4/18/25 13:27, Christophe JAILLET wrote:
> If an error occurs after a successful stm32_ospi_dma_setup() call, some
> dma_release_channel() calls are needed to release some resources, as
> already done in the remove function.
> 
> Fixes: 79b8a705e26c ("spi: stm32: Add OSPI driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested-only
> ---
>  drivers/spi/spi-stm32-ospi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
> index 668022098b1e..9ec9823409cc 100644
> --- a/drivers/spi/spi-stm32-ospi.c
> +++ b/drivers/spi/spi-stm32-ospi.c
> @@ -960,6 +960,10 @@ static int stm32_ospi_probe(struct platform_device *pdev)
>  err_pm_enable:
>  	pm_runtime_force_suspend(ospi->dev);
>  	mutex_destroy(&ospi->lock);
> +	if (ospi->dma_chtx)
> +		dma_release_channel(ospi->dma_chtx);
> +	if (ospi->dma_chrx)
> +		dma_release_channel(ospi->dma_chrx);
>  
>  	return ret;
>  }
Hi Christophe

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks


Return-Path: <linux-spi+bounces-8925-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FA0AEE875
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 22:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9FC03A6540
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 20:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA85823506D;
	Mon, 30 Jun 2025 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="rlAa3eTM"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7471DB125;
	Mon, 30 Jun 2025 20:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751316248; cv=none; b=heIprK2W8xNYoZOMunPocend7zkoT/shgtQdGAECj6p46MhLo5qrzGOsG+4SYw/cBLb3MeYlEAMV5B27WQZkmU45yKhXBNWyBf5BqMdzi1Ar61BewJOYr//sSpYEzSomLwB+tbg++cVVWBp1J3N68PvbXXgQhzRCyvVjcDn7APE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751316248; c=relaxed/simple;
	bh=fJ9Omhbf3gY9igah+t3oj+rQpDdG4CzeMw7aL4HSHHY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufd7Oxlfomj5wjWPJV+IoWJBcw7SbVfitqrTnk9g4pEqHtxlbVdX1TKB5uMN71JTwOHq51//ZH2rBX0QQbm+46DFShCo6EFdu5buO4rYXD6+QkXF97teofVJXPywS0AEV/7O7vV1jBEv6IR76iG8Vd93X7HR4iZBDyvWweJ2G9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=rlAa3eTM; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UIER08016451;
	Mon, 30 Jun 2025 22:43:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=selector1; bh=AQKCJ04siddRBG+IxS9aOk0K
	rq1ez5qBC2vqbCHaW2I=; b=rlAa3eTMj2MhjAVRNMno0xIZa0U3bhDxcRktwj2T
	Lze+UVuHk/rTCuDlw1OXP/+EiKk3XQjXnpMT/KGt9ZP71emNkHlW9dhX5P3D1d1F
	r5pCLMbQi3vxP4djavoTZyxCOf02qJR8tJxOGFmyHfn3NE4dk/ykFR1BxKEOJYU5
	RgAlViTXOpDwKq/uQO9+3W/6jKjLL6zJlteBJzk+RHaELSgLQIMZH/aGl6heW5mM
	aMEhD1IYLqmar40BzAojWG6H+Fx24NVtKCUZ2p+CbTyLNg+wHcXQcUIaP/nn4oMK
	cF03K7AQWkiHVuzA1A+tJAse+2jEn/fhUQ+waz8J0RxN8g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47j5tm1j7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 22:43:52 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B127F40055;
	Mon, 30 Jun 2025 22:42:56 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7F7A4B2BD0B;
	Mon, 30 Jun 2025 22:42:26 +0200 (CEST)
Received: from gnbcxd0016.gnb.st.com (10.130.77.119) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Jun
 2025 22:42:26 +0200
Date: Mon, 30 Jun 2025 22:42:20 +0200
From: Alain Volmat <alain.volmat@foss.st.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: =?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>,
        Mark
 Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] spi: stm32: delete stray tabs in
 stm32h7_spi_data_idleness()
Message-ID: <20250630204220.GA522704@gnbcxd0016.gnb.st.com>
References: <2033b9fa-7b0f-4617-b94e-7b0a51c5c4b1@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2033b9fa-7b0f-4617-b94e-7b0a51c5c4b1@sabinyo.mountain>
X-Disclaimer: ce message est personnel / this message is private
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_04,2025-06-27_01,2025-03-28_01

Hi Dan,

Thanks for this patch. Indeed.

On Mon, Jun 30, 2025 at 02:35:25PM -0500, Dan Carpenter wrote:
> These lines were indented one tab more than they should be.  Delete
> the stray tabs.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/spi/spi-stm32.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
> index 3d20f09f1ae7..afb54198bde7 100644
> --- a/drivers/spi/spi-stm32.c
> +++ b/drivers/spi/spi-stm32.c
> @@ -1895,8 +1895,8 @@ static void stm32h7_spi_data_idleness(struct stm32_spi *spi, struct spi_transfer
>  		if (spi_delay_ns) {
>  			dev_warn(spi->dev, "Overriding st,spi-midi-ns with word_delay_ns %d\n",
>  				 spi_delay_ns);
> -				spi->cur_midi = spi_delay_ns;
> -			}
> +			spi->cur_midi = spi_delay_ns;
> +		}
>  	} else {
>  		spi->cur_midi = spi_delay_ns;
>  	}

Acked-by: Alain Volmat <alain.volmat@foss.st.com>

Regards,
Alain

> -- 
> 2.47.2
> 


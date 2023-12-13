Return-Path: <linux-spi+bounces-261-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AFB811937
	for <lists+linux-spi@lfdr.de>; Wed, 13 Dec 2023 17:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206C31F2158A
	for <lists+linux-spi@lfdr.de>; Wed, 13 Dec 2023 16:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E8033CFA;
	Wed, 13 Dec 2023 16:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIJE5uiR"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1DC321B1
	for <linux-spi@vger.kernel.org>; Wed, 13 Dec 2023 16:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2F9C433C9;
	Wed, 13 Dec 2023 16:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702484690;
	bh=cQvT0wz+oneOOh5CrCw+RHK1QND2TJBTm/VK+5Hia2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MIJE5uiRHb9ODiDDTJniymoRd6+s2IJzM6n9XEAxpabGeQGxbeq7ezGMa7cwyo4vU
	 3l2zilNN614MLOxNrSFkAOezjFp8/74BL4cRM3/6uTOZRvNRWaUh/XgWHDPj1RjZsh
	 fwTblrVPGI2LR2fHQhvipBvNk6VuVQmnKp6lr9d6OKKnS6MknWAU0IoOWzOJtwuAEq
	 C6LWWNlVsU1JrSWvjd2rICWIe/9tk1UsUy26PatCQsnHwPoaIiaEKppPiWRQzNsurZ
	 IAXFYcq4cvH3/xHnRv1U/PIKXelwyM/NPUbDGgP4EVORDuVM32CraT+ZDyLrwlHGfQ
	 sGd0ttqWTHDQg==
From: Michael Walle <mwalle@kernel.org>
To: haibo.chen@nxp.com
Cc: broonie@kernel.org,
	han.xu@nxp.com,
	linux-imx@nxp.com,
	linux-spi@vger.kernel.org,
	yogeshgaur.83@gmail.com,
	Michael Walle <mwalle@kernel.org>
Subject: Re: [PATCH 2/5] spi: spi-nxp-fspi: change the default lut index
Date: Wed, 13 Dec 2023 17:24:36 +0100
Message-Id: <20231213162436.2770068-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231213091346.956789-2-haibo.chen@nxp.com>
References: <20231213091346.956789-2-haibo.chen@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The fspi dynamic lut use the last lut for all IPS operations, the
> imx8ulp only supports 15 luts, so change the last lut index from

It's 16 LUTs, no? There's also index 0.

> 31 to 15.
> 
> Signed-off-by: Han Xu <han.xu@nxp.com>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/spi/spi-nxp-fspi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index 0feecf5ba010..9d6b4d22263c 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -64,9 +64,9 @@
>  /*
>   * The driver only uses one single LUT entry, that is updated on
>   * each call of exec_op(). Index 0 is preset at boot with a basic
> - * read operation, so let's use the last entry (31).
> + * read operation, so let's use the last entry (15).

Please add the information about the imx8mulp to the comment.
Otherwise, the comment will be confusing for SoCs where there
are 32 LUTs.

-michael

>   */
> -#define	SEQID_LUT			31
> +#define	SEQID_LUT			15
>  
>  /* Registers used by the driver */
>  #define FSPI_MCR0			0x00
> -- 
2.34.1




Return-Path: <linux-spi+bounces-973-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B412B845C2A
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 16:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651641F23876
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 15:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EFF5F47B;
	Thu,  1 Feb 2024 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A48nECb+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFCA5F49A
	for <linux-spi@vger.kernel.org>; Thu,  1 Feb 2024 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802746; cv=none; b=gBEyK7L2I50OPvc2F9Ek3lWSOe0CN6w8qvCgGgnubhwNU3ia8Ehl6OPCKeQ5GHjBlR5ujCGV3dC9UMtrwTC4a5m8M1YiaSpkQwceCy2DGH+guqZLL1In30SAGxDbYrZDTiWe0ziF4X6oaTjoJAzPeAAD0OTTz9BmTjm3TB6tYLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802746; c=relaxed/simple;
	bh=2/AojWD+CrpOQOqoCp64pVCyI8pGCkagokdqYkpe8Z8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=D1h3qe7DNQ4f27SbopbFqTGM6o2NY8TzXKxZti/FM9UKi2tgP/ec3xnr0pIXGtQ7Mp4GsXEJHSmGhhqlffGPYQLkN/92+FtYXpiaTCrsrJB+sX4k5B7IWFzlz1E5tXWE/+SyKCn221jW1+FYfqVH03Mmlb4bOgV7ZWE2KMhM9mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A48nECb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B789DC433F1;
	Thu,  1 Feb 2024 15:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706802746;
	bh=2/AojWD+CrpOQOqoCp64pVCyI8pGCkagokdqYkpe8Z8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A48nECb+SqzHro49ljFl17DaxY51KAwpNEP/lWFPOGJ2dZInmG5exVS53tJUAKX1o
	 jNfbW1xzr6sDf7T+kBWJMyJ67hw5i2w8Ffn5EKVmU+WkiCygeF3FF8gyTeLmx9VXBB
	 c4Md4QYWyJV81VsrpIQBgTb32e6gDKEdDkt8FpRpImzeWwa/XwN1uhwqM2k3H0soF+
	 7gUFDulbrAa2qMyPmGzhZX5521LNZ+irRre8VM1wJnmlamkYLP0JBCzAE9Sbh841zi
	 RT3MzXjjLoLtwYZat70wSs1FVmz9L92ea6Zt+ziD2F0dgK+ZZ8SfovwIsj3htKN4AS
	 181B2O1X7mjRg==
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 01 Feb 2024 16:52:21 +0100
From: Michael Walle <mwalle@kernel.org>
To: Jaime Liao <jaimeliao.tw@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
 tudor.ambarus@linaro.org, pratyush@kernel.org, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com, broonie@kernel.org, leoyu@mxic.com.tw,
 jaimeliao@mxic.com.tw
Subject: Re: [PATCH v8 9/9] mtd: spi-nor: add support for Macronix Octal flash
 MX66 series
In-Reply-To: <20240201094353.33281-10-jaimeliao.tw@gmail.com>
References: <20240201094353.33281-1-jaimeliao.tw@gmail.com>
 <20240201094353.33281-10-jaimeliao.tw@gmail.com>
Message-ID: <8b80cf233ea0065adf9841408e59f6a2@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi,

> --- a/drivers/mtd/spi-nor/macronix.c
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -262,6 +262,13 @@ static const struct flash_info 
> macronix_nor_parts[] = {
>  		.id = SNOR_ID(0xc2, 0x80, 0x3a),
>  	}, {
>  		.id = SNOR_ID(0xc2, 0x85, 0x3a),
> +	}, {
> +		.id = SNOR_ID(0xc2, 0x80, 0x3b),
> +	}, {
> +		.id = SNOR_ID(0xc2, 0x85, 0x3b),

These and all of patch 8/9 is not needed because you add the whole
manufacturer in the next line.

> +	}, {
> +		/* Need the manufacturer fixups. Keep this last */
> +		.id = SNOR_ID(0xc2),
>  	}
>  };

Replace patch 8/9 and 9/9 with just the following:

+	/* Need the manufacturer fixups. Keep this last */
+	{ .id = SNOR_ID(0xc2) }



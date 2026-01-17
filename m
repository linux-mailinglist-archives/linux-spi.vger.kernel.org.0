Return-Path: <linux-spi+bounces-12475-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDB3D391C0
	for <lists+linux-spi@lfdr.de>; Sun, 18 Jan 2026 00:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6415C300500E
	for <lists+linux-spi@lfdr.de>; Sat, 17 Jan 2026 23:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85EE223339;
	Sat, 17 Jan 2026 23:48:36 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE9D264602;
	Sat, 17 Jan 2026 23:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768693716; cv=none; b=Pj6KW+6xNtlTcubj5BGk1viZXCEfkf3BYGxX9mOEkaZQV/Sjf980mrrTUG9kU4owQ6PBdG0iBtP6C753LDwwY7mQ20XXrxo6o1BjGoI6F2M0aMYa7Xz3iSlAgDSlB1sXqy73lBbGFqkZHojUCyzxQyj5tF6cKgu57Iss/kTYuqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768693716; c=relaxed/simple;
	bh=+3XM+SZuxRFfVw8pqqU9rmBMD0i2wEZYG6QVsMGfg5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=N9tcBqdQY0Be09BrGmXaDCsrsCWa8swsPC2DmgOa6QWDTwCDk4ktTXZxSOhMGQFqFOG1mEyLczS8zV3IyJJraQ//hVEOsocv18gstglJzRsTjWa1IHsip9vYHpwyNWguWnVeIIhTA2Lbs8OrDV04PP3b0hQK17mSPPfba+03KCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.0.57.151] (unknown [62.214.191.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 30E864C4430066;
	Sun, 18 Jan 2026 00:47:01 +0100 (CET)
Message-ID: <ccb6b5b3-84cd-4197-a770-7e626c1ddcf3@molgen.mpg.de>
Date: Sun, 18 Jan 2026 00:46:57 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] spi: spi-mem: Protect dirmap_create() with
 spi_mem_access_start/end
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
References: <20260117134216.595436-1-chin-ting_kuo@aspeedtech.com>
 <20260117134216.595436-2-chin-ting_kuo@aspeedtech.com>
Content-Language: en-US
Cc: clg@kaod.org, broonie@kernel.org, boris.brezillon@bootlin.com,
 joel@jms.id.au, andrew@codeconstruct.com.au, linux-aspeed@lists.ozlabs.org,
 openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 BMC-SW@aspeedtech.com
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260117134216.595436-2-chin-ting_kuo@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Chin-Ting,


Thank you for your patch.

Am 17.01.26 um 14:42 schrieb Chin-Ting Kuo:
> spi_mem_dirmap_create() may reconfigure controller-wide settings,
> which can interfere with concurrent transfers to other devices
> sharing the same SPI controller but using different chip selects.
> 
> Wrap the ->dirmap_create() callback with spi_mem_access_start() and
> spi_mem_access_end() to serialize access and prevent cross-CS
> interference during dirmap creation.

Do you have a reproducer for this issue to test your patch? If yes, it’d 
be great, if you documented it.

> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> ---
>   drivers/spi/spi-mem.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index c8b2add2640e..85702a77b3c8 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -708,9 +708,18 @@ spi_mem_dirmap_create(struct spi_mem *mem,
>   
>   	desc->mem = mem;
>   	desc->info = *info;
> -	if (ctlr->mem_ops && ctlr->mem_ops->dirmap_create)
> +	if (ctlr->mem_ops && ctlr->mem_ops->dirmap_create) {
> +		ret = spi_mem_access_start(mem);
> +		if (ret) {
> +			kfree(desc);
> +			return ERR_PTR(ret);
> +		}
> +
>   		ret = ctlr->mem_ops->dirmap_create(desc);
>   
> +		spi_mem_access_end(mem);
> +	}
> +
>   	if (ret) {
>   		desc->nodirmap = true;
>   		if (!spi_mem_supports_op(desc->mem, &desc->info.op_tmpl))

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul


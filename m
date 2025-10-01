Return-Path: <linux-spi+bounces-10390-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24278BB029A
	for <lists+linux-spi@lfdr.de>; Wed, 01 Oct 2025 13:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D348F4A4CBB
	for <lists+linux-spi@lfdr.de>; Wed,  1 Oct 2025 11:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4223A2C15A0;
	Wed,  1 Oct 2025 11:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qOewgJOB"
X-Original-To: linux-spi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75D72C3770;
	Wed,  1 Oct 2025 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759318210; cv=none; b=XCk3tf5chvhu6MKDu6DNwbguacbzZioX90DuvbR6D4HU3dNlv4cvcqxSO4qDpR/a3Ce2ylYhzcSvdwJ/GdM3AsJnQmAc948LVv0aFokgmZV3M+qgvjTnnf3xth7Ky7Wjhu6t3oUxllCj6GF6D81lp7A/YWeC02G7LEU6QM8uBcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759318210; c=relaxed/simple;
	bh=TSN7wdoIY+RSiBU4VS9HFoh1mDkmc2W2ztVCZNYeegY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tRBSTpc/dASOYmi0Hh6CsPpf+05r7Mv6zPPEwHOm1YT/19OYj/KvqBmUyVCNAlW/Qr6KrVss8N9ojk9HUyhiOZsX0qfd48wGk6eQzbd9IPY0waXIMOtM75OtM4qkElp2GvpfqFz07EUJWeCbwz/CD1nCyQ44Dqqg+nrbrIEdI80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qOewgJOB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759318203;
	bh=TSN7wdoIY+RSiBU4VS9HFoh1mDkmc2W2ztVCZNYeegY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qOewgJOBumdbTEqeUO+6E1ND+PzsymTS1jyCR9u4D4PNk0/7VIvuKWOte+j5h8V08
	 VQyDcA/1MO0Zzr2sVf+4ScAw2q7ENE3D/ESv/XBjIRh7ClnZ4S+7V8lRF7Pl5MmNfg
	 kCEyIRSavX5f+sNvLQXJt6HqoLRNzKORTKXYBNSS2kIEXX+gIUCUPc1U7cB+Hf/pEZ
	 +bR8w7RQPeFQjIUiS2GZnTzMwgX26J6uLKJOgNektxGbRBSN/EVxRliw+JsF0im0Qn
	 Ns3ZHNP/oMvKkQeOjKQ7WTTBxJUlFUkdArcWjGcqGU/lXzVkJgAbcuxK15J/iV2OgT
	 juAORtLROMc6g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9EC1C17E00AC;
	Wed,  1 Oct 2025 13:30:02 +0200 (CEST)
Message-ID: <7909d937-aa93-44bf-a4d3-12849a14fdf4@collabora.com>
Date: Wed, 1 Oct 2025 13:30:01 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 13/13] spi: airoha: buffer must be 0xff-ed
 before writing
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
 Mark Brown <broonie@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>
References: <20250930022658.1485767-1-mikhail.kshevetskiy@iopsys.eu>
 <20250930022658.1485767-14-mikhail.kshevetskiy@iopsys.eu>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250930022658.1485767-14-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/09/25 04:26, Mikhail Kshevetskiy ha scritto:
> During writing, the entire flash page (including OOB) will be updated
> with the values from the temporary buffer, so we need to fill the
> untouched areas of the buffer with 0xff value to prevent accidental
> data overwriting.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>   drivers/spi/spi-airoha-snfi.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
> index 437ab6745b1a..57b1950e853f 100644
> --- a/drivers/spi/spi-airoha-snfi.c
> +++ b/drivers/spi/spi-airoha-snfi.c
> @@ -776,6 +776,7 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
>   		return -EOPNOTSUPP;
>   	}
>   
> +	memset(txrx_buf, 0xff, bytes);

As you are refactoring this a bit, reading the function isn't straightforward
without applying the series locally.

It looks like you're filling the entire txrx_buf with 0xff.

While that will work for sure, for the sake of performance you should change this
to memset(0xff) only the portions of buffer that the next memcpy call will not
overwrite, avoiding to effectively write twice to that buffer.

Is there any reason why you didn't do just that?

...also because, your commit message really looks like saying what I'm proposing
to do here.

Cheers,
Angelo

>   	memcpy(txrx_buf + offs, buf, len);
>   
>   	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);




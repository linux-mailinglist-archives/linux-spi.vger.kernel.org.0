Return-Path: <linux-spi+bounces-5722-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5151B9CFA47
	for <lists+linux-spi@lfdr.de>; Fri, 15 Nov 2024 23:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CD87B3D307
	for <lists+linux-spi@lfdr.de>; Fri, 15 Nov 2024 22:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606D9202630;
	Fri, 15 Nov 2024 21:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="WkU4eDBm"
X-Original-To: linux-spi@vger.kernel.org
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB771FF05F;
	Fri, 15 Nov 2024 21:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731707627; cv=none; b=fU0hhofHH/c1LxEfQw4TkNXt/8kaf1fwm2WPPVXqpFRy+Hm+hv1iycu3OwEgWAKrDWXiUdwKNF7if50RdmIgqB+zLzKrI+XLx+O31dLYGqQYjOVRF6Gudx9HHMJ87ZCr1l/I3RGC4Ja4ejUJdU8tXp5a64thnwKoiuTVEQeM330=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731707627; c=relaxed/simple;
	bh=Zc3jub9AseieKkXFd7dNqYp5WdAhShCU0Si0Xo4Io/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bq/E7shjolP5+k4IELE1guxeQcG2qd0Hm2UPUyxoPdt7mb+3WrL4CKlcbNqNLMDMbBYrPfDcg25PsG2z4pvMQdKRRf+hCwVb/lnaP+GmSRJ7RoipmDmfdNLGquOfSKiLIze6wZ2wIupld2pqqgSNtu/RbMXwTZJs3hUE8UuSf+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=WkU4eDBm; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1731707622; bh=Zc3jub9AseieKkXFd7dNqYp5WdAhShCU0Si0Xo4Io/E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WkU4eDBmIOVQQ7JlaQGv5TuWpytYOEt01AQ522wbU2g1HNC1PxoSKKWKPfNj6xsFx
	 Hihsg3sqXeKt3ef+YWZKeByQ+MdOkSQj68STs81TtUbHjdbvoiyFgS5ISw9DXlht5x
	 5E8TvYZw2sNpAhBKFralW4ULkSC/5WdA/DIgCnDlHXh7WGRnuPVQ9cKHC4fn1CMuvL
	 TOEz7eLs8LfQ+uEUNJUCAIsvwnaCXBhE89PM/dxtZGPwOMpuHg8N6PxZ9Av8ZPhMUU
	 FzHUKKiub1GK0NXYeTTepcJA9zwCY2mHPxeEdA2AhOLLOIuhqNzcNEspOvNraMxC4C
	 DVxFfegrZ8N9D7tJMXOm2K40gfj7P0m7D7lG0+VA3d7p/4qZu0ci6civcb/0YBEEPu
	 NlG43J+bhRLwQkyzxl8wvCQk4OwuvfTwfanU4l4wAp6UrpCF1tAG2R+Fd3IwcjrfC8
	 6w41uRfK2GP9NVKjRjV87csn5eS17meS16K8Oz/9ZHWeVH68Fr7dOkbY4uk+/A9CVy
	 rlFIbzfZ+ZXAsPIgs70nsuE0chRN5w6woRbCdrFyEIZvvygyJN9dwSaAzLsacyrV2i
	 cb3aviIfH4VWqJdp5D3s/tX9Ne/rKfl3FjlPfzqOyam6sYYPlWMu2ajEhszzwseMqG
	 Bi/76fk38NyqpgxujFw+w0d4=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id BA5D218E010;
	Fri, 15 Nov 2024 22:53:42 +0100 (CET)
Message-ID: <1d3623ee-1f16-487c-98cb-ca2647e7239d@ijzerbout.nl>
Date: Fri, 15 Nov 2024 22:53:39 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] spi: imx: support word delay
To: Jonas Rebmann <jre@pengutronix.de>, Mark Brown <broonie@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: kernel@pengutronix.de, linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241113-imx-spi-word-delay-v2-0-2b65b737bf29@pengutronix.de>
 <20241113-imx-spi-word-delay-v2-2-2b65b737bf29@pengutronix.de>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <20241113-imx-spi-word-delay-v2-2-2b65b737bf29@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Op 13-11-2024 om 13:18 schreef Jonas Rebmann:
> Implement support for the word delay feature of i.MX51 (and onwards) via
> the ECSPI interface.
>
> Convert the requested delay to SPI cycles and account for an extra
> inter-word delay inserted by the controller in addition to the requested
> number of cycles, which was observed when testing this patch.
>
> Disable dynamic burst when word delay is set. As the configurable delay
> period in the controller is inserted after bursts, the burst length must
> equal the word length.
>
> Account for word delay in the transfer time estimation for
> polling_limit_us.
>
> Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
> ---
>   drivers/spi/spi-imx.c | 95 +++++++++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 85 insertions(+), 10 deletions(-)
>
> [...]
> +static unsigned int spi_imx_transfer_estimate_time_us(struct spi_transfer *transfer)
> +{
> +	u64 result;
> +
> +	result = DIV_U64_ROUND_CLOSEST((u64)USEC_PER_SEC * transfer->len * BITS_PER_BYTE,
> +				       transfer->effective_speed_hz);
> +	if (transfer->word_delay.value) {
> +		unsigned int word_delay_us;
> +		unsigned int words;
> +
> +		words = DIV_ROUND_UP(transfer->len * BITS_PER_BYTE, transfer->bits_per_word);
> +		word_delay_us = DIV_ROUND_CLOSEST(spi_delay_to_ns(&transfer->word_delay, transfer),
> +						  NSEC_PER_USEC);
> +		result += words * word_delay_us;
If the multiplication can overflow 32 bits to need to force a 64 bits 
multiply.
     result += (u64)words * word_delay_us;

But I'm wondering if `result` needs to be u64.
> +	}
> +
> +	return min(result, U32_MAX);
Do you really expect this much? You're clipping to U32_MAX.
U32_MAX microsecs is already more than an hour.
> +}
> [...]


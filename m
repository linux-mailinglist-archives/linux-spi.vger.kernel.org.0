Return-Path: <linux-spi+bounces-2672-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC8A8B858D
	for <lists+linux-spi@lfdr.de>; Wed,  1 May 2024 08:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0159B20EC2
	for <lists+linux-spi@lfdr.de>; Wed,  1 May 2024 06:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98C94C3C3;
	Wed,  1 May 2024 06:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="fSq62hQS"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [94.124.121.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3C54B5AE
	for <linux-spi@vger.kernel.org>; Wed,  1 May 2024 06:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714544751; cv=none; b=U+qMjvlF5Y1OmhH6g18dl0c7QogyhsGjokCRJGF9bJaG4y9tXKhfQ31SWDuLC8wQW98TLQG3dfEWtIG20rK/CkLPpHvjQQ0xp28Fged9y9ao9wTFRI5q0V8AsNvewcmxiurR9WSryyysidLjPvWYZUfR7gIIt8piTh39bxITSTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714544751; c=relaxed/simple;
	bh=ABVbL4CjFgS6XTJqWv4IOxxhEEWCvrdgsnThRZaQjbU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DiAX0DSZNuuEUeoBs0e+bedN1ARGTZWxlhdc9wA1alg02OQVBQZmT/DSnZfN7VRRpDujTahEnuxAwfQ9DNfZp8OzNguUCLSa51ivdvp2kGGhtIABFPHc+3sNUNeOYwS03olf22REPxdo8XRCcSQRZJlfXx3lL3jfXGA+OsJ8g+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=fSq62hQS; arc=none smtp.client-ip=94.124.121.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=ms98ZHn1S2cRldbNXsXSYmq2DHmzRS3EHVbV0GdKlUc=;
	b=fSq62hQSWOaElGJI90IuDRQTxj5jPTPw8Eyt1rTsMG3F6OVilM6ZI9tAt/Nw7gwvUNmXQeOHRiq9/
	 ykQjdq1d2u1X5NU4zvcH7Mp0XhXcpnLRWlPXa5axSbf4lckPF9GfjQ4Qq69gUzWWT3HWtk401KE9AQ
	 do/yGcdiuGDrIdBm1AjJDFDC9gctXJTdtBwegSLz47iJ1d9PjgcizGKGmmpY3KM2/7j+k03nyIkVmv
	 lx//rD58bvPID3X+HXYirHREVqf+FZVa1iVhY7ZJewxiQJNPZF4I24suXIZgJI2HAN9MhDBrWNSRCS
	 +Hi0j/7mp84nn5EvimksUepaj7xFhpg==
X-MSG-ID: 7b1ced9b-0783-11ef-93d5-005056817704
Date: Wed, 1 May 2024 08:24:35 +0200
From: David Jander <david@protonic.nl>
To: Mans Rullgard <mans@mansr.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: fix null pointer dereference within spi_sync
Message-ID: <20240501082435.4e3eafb9@erd003.prtnl>
In-Reply-To: <20240430182705.13019-1-mans@mansr.com>
References: <20240430182705.13019-1-mans@mansr.com>
Organization: Protonic Holland
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi Mans,

On Tue, 30 Apr 2024 19:27:05 +0100
Mans Rullgard <mans@mansr.com> wrote:

> If spi_sync() is called with the non-empty queue and the same spi_message
> is then reused, the complete callback for the message remains set while
> the context is cleared, leading to a null pointer dereference when the
> callback is invoked from spi_finalize_current_message().
> 
> With function inlining disabled, the call stack might look like this:
> 
>   _raw_spin_lock_irqsave from complete_with_flags+0x18/0x58
>   complete_with_flags from spi_complete+0x8/0xc
>   spi_complete from spi_finalize_current_message+0xec/0x184
>   spi_finalize_current_message from spi_transfer_one_message+0x2a8/0x474
>   spi_transfer_one_message from __spi_pump_transfer_message+0x104/0x230
>   __spi_pump_transfer_message from __spi_transfer_message_noqueue+0x30/0xc4
>   __spi_transfer_message_noqueue from __spi_sync+0x204/0x248
>   __spi_sync from spi_sync+0x24/0x3c
>   spi_sync from mcp251xfd_regmap_crc_read+0x124/0x28c [mcp251xfd]
>   mcp251xfd_regmap_crc_read [mcp251xfd] from _regmap_raw_read+0xf8/0x154
>   _regmap_raw_read from _regmap_bus_read+0x44/0x70
>   _regmap_bus_read from _regmap_read+0x60/0xd8
>   _regmap_read from regmap_read+0x3c/0x5c
>   regmap_read from mcp251xfd_alloc_can_err_skb+0x1c/0x54 [mcp251xfd]
>   mcp251xfd_alloc_can_err_skb [mcp251xfd] from mcp251xfd_irq+0x194/0xe70 [mcp251xfd]
>   mcp251xfd_irq [mcp251xfd] from irq_thread_fn+0x1c/0x78
>   irq_thread_fn from irq_thread+0x118/0x1f4
>   irq_thread from kthread+0xd8/0xf4
>   kthread from ret_from_fork+0x14/0x28
> 
> Fix this by also setting message->complete to NULL when the transfer is
> complete.
> 
> Fixes: ae7d2346dc89 ("spi: Don't use the message queue if possible in spi_sync")
> 
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
>  drivers/spi/spi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 34fca94b2b5b..ca13ca47e745 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -4521,6 +4521,7 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
>  		wait_for_completion(&done);
>  		status = message->status;
>  	}
> +	message->complete = NULL;
>  	message->context = NULL;
>  
>  	return status;

Nice catch. Looks good to me. Thanks.

Best regards,

-- 
David Jander


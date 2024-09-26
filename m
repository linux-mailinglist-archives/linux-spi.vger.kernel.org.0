Return-Path: <linux-spi+bounces-4996-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3A0986FE7
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 11:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D251F21BCA
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 09:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59FB1AB6EE;
	Thu, 26 Sep 2024 09:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="DfFMyMS9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52B31AB6C5;
	Thu, 26 Sep 2024 09:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342480; cv=none; b=AYbskO5uoIS80+qPjHr9Cl18SlOm/1mYKiRpOe4lm2CT45l97KeVXIMY0UJkrdlHK1YGxFknflyPuWq1yvdkNOcsNzqj0oQ9lQbuIWjWA+yPjKWyTt31O1nKj5oqmPxUaCzUKOic/37zRHfphJqOWy11TOOwefLmKnT0HCDAOvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342480; c=relaxed/simple;
	bh=mffQzKoMWpBJMB21073rFmLkAp1CB2/7L0IqrazkCEQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=shszjYRQ/hOeqTEUPA+ht81+2FdWNtk3IcOajOqxuML0efoWyI7Lh/2UOw27tsoWWozjG8/N8nqKDDenVPt5Gq2yACc0rPHBYyobxZ1pHPpE6bfjLGlC5zad6CSpHar32a4YrR6C+/PPGYIaFs8IHzKAcs6F4zCPZ7MGeoMO7UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=DfFMyMS9; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1727342476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nMmluLyTjEgaln/FZKQzxk5gQXsgrah771N+44zT8oE=;
	b=DfFMyMS98/iUnrXmXyxSQCBaLiuQrD0UF9xpMuxV1sB7rqZoB8ajxxbWekH4GnT/Jby0kv
	V2Dy/V/YrBgBsoP9LNJiB7cPMa7Omeg4SGGnFXx3XCZ/QN7xGGZvTa9PrFDlIFiQtqXYAj
	4id9YLyfV/Pp844cELnRCQ+XfRZMw3UtIwBYcqvMZH/bIhkfrKiuNgvMBZZnWN8Xx6VAyM
	3H9XuaDINzJU5QP+9BCAmxFd70HwA4aOvdr96BdVEnObtf3i/UGD6ggSeDPG/EOWfhrkWg
	YyGvmvn2TX+Cqxen5BO81q3l4riJljtibD+9AbsSzH49Vb69JihIrX9IwSXp5w==
Date: Thu, 26 Sep 2024 11:21:16 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org,
 broonie@kernel.org, oss@helene.moe, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] spi: rockchip: Use dev_err_probe() in the probe path
In-Reply-To: <6673004.tM3a2QDmDi@phil>
References: <cover.1727337732.git.dsimic@manjaro.org>
 <8bc905ff3c47ed458d8c65a031822ba6b9df8a07.1727337732.git.dsimic@manjaro.org>
 <6673004.tM3a2QDmDi@phil>
Message-ID: <b24f6ee033c4f466f58264696d1a4206@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Heiko,

On 2024-09-26 11:00, Heiko Stuebner wrote:
> Am Donnerstag, 26. September 2024, 10:38:15 CEST schrieb Dragan Simic:
>> Use function dev_err_probe() in the probe path instead of dev_err() 
>> where
>> appropriate, to make the code a bit more uniform and compact, and to 
>> improve
>> error handling for the TX and RX DMA channel requests.
>> 
>> Previously, deferred requests for the TX and RX DMA channels produced 
>> no
>> debug messages, and the final error messages didn't include the error 
>> codes,
>> which are all highly useful when debugging permanently failed DMA 
>> channel
>> requests, such as when the required drivers aren't enabled.
>> 
>> Suggested-by: Hélene Vulquin <oss@helene.moe>
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>  drivers/spi/spi-rockchip.c | 25 ++++++++++++-------------
>>  1 file changed, 12 insertions(+), 13 deletions(-)
>> 
>> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
>> index 28879fed03f8..6b5c67a357bb 100644
>> --- a/drivers/spi/spi-rockchip.c
>> +++ b/drivers/spi/spi-rockchip.c
>> @@ -853,22 +853,21 @@ static int rockchip_spi_probe(struct 
>> platform_device *pdev)
>> 
>>  	ctlr->dma_tx = dma_request_chan(rs->dev, "tx");
>>  	if (IS_ERR(ctlr->dma_tx)) {
>> -		/* Check tx to see if we need defer probing driver */
>> -		if (PTR_ERR(ctlr->dma_tx) == -EPROBE_DEFER) {
>> -			ret = -EPROBE_DEFER;
>> +		/* Check tx to see if we need to defer driver probing */
>> +		ret = dev_err_probe(rs->dev, PTR_ERR(ctlr->dma_tx),
>> +				    "Failed to request TX DMA channel\n");
> 
> you're upgrading here from a warning to an error log level.
> As it seems the controller may actually provide some level of 
> functionality
> even without dma, is this approriate?
> 
> Same for rx below.

Thanks for your quick responses.

You're right about the driver still working without the DMA channels,
so emitting warnings would be much more appropriate.

We'd basically need dev_warn_probe() as a new function to cover these
two cases, but I'm not really sure how to proceed?  I could go ahead
and implement dev_warn_probe() in a good way, but I wonder what would
be the chances to have that accepted upstream?  Perhaps there would
be other users for dev_warn_probe().

>> +		if (ret == -EPROBE_DEFER)
>>  			goto err_disable_pm_runtime;
>> -		}
>> -		dev_warn(rs->dev, "Failed to request TX DMA channel\n");
>>  		ctlr->dma_tx = NULL;
>>  	}
>> 
>>  	ctlr->dma_rx = dma_request_chan(rs->dev, "rx");
>>  	if (IS_ERR(ctlr->dma_rx)) {
>> -		if (PTR_ERR(ctlr->dma_rx) == -EPROBE_DEFER) {
>> -			ret = -EPROBE_DEFER;
>> +		/* Check rx to see if we need to defer driver probing */
>> +		ret = dev_err_probe(rs->dev, PTR_ERR(ctlr->dma_rx),
>> +				    "Failed to request RX DMA channel\n");
>> +		if (ret == -EPROBE_DEFER)
>>  			goto err_free_dma_tx;
>> -		}
>> -		dev_warn(rs->dev, "Failed to request RX DMA channel\n");
>>  		ctlr->dma_rx = NULL;
>>  	}


Return-Path: <linux-spi+bounces-7673-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79227A93710
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 14:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C128A3FC9
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 12:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8097227465F;
	Fri, 18 Apr 2025 12:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="c3UDLAiN"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA67C26FD91;
	Fri, 18 Apr 2025 12:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744979394; cv=none; b=tayFO0wUvOebyC0GsJv9wRwgvySbWr+q8s2dhXrnPuKr1LlSkl7rYj0Nhuoq2/8nMMzLQ3w76aY1nwOsRK5Lo603jU465ZGS91x9aTUnYDKArpcWAG1fqZVR6hoqJpfSvjpOjy0k0EFKDXdW4+SyiZm9fu4FzB4p+Qw6VA1oLR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744979394; c=relaxed/simple;
	bh=XaIY/xQVxAgcWLZ8epbYfw6+SNdjl9PnTABlVOKgxAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QIIUjJzlnmOguX3bj0ybA/bLFZsu5xxuXsr/v4Nn0VcsITVWgx15GZlKkzZjnapnbBWjzzhw6IzsfbqFb7EX6Ic62vOfgYiPwY5+V7bmE865vcKPpDHLxNS3JzwJAmQiyNAesbcR84c/GBLY0cbjb1uGDm3wFu49o/meHVEU4iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=c3UDLAiN; arc=none smtp.client-ip=80.12.242.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 5khfuawZP2zsA5khiuLkN8; Fri, 18 Apr 2025 14:20:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1744978824;
	bh=8k3JMAls+GQlxYkbc31pLWubjNcA+n4tKYL4qcb01q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=c3UDLAiNAdgLs93k5n13OjKXU1eQHkZjqRYCwDjFQw+hJZJbMhcK/Q2vEba2GECIH
	 jQ4C6zqdYrmkkDi7pwNdezlK7smSs4yzSj1rTs0jMUS1Hxou6Y/0HwPKaZaDD73A+b
	 ceSBDUulm6zB6g9E1tayiI2McCbCLGTPmREqzUbMjuGDpSyaoAs+eP4siDFK/np4iO
	 pO7elE6u7+2f6Z8aBd7joo7wnH7Ha/asmqLEpKSoc6srKHVRvf4O1w3zfjIO41idG9
	 cV54wdfcI8N85nLHUdhjYiwCKTWOpeDBydRNIYb4BVMFZIoJS8plNeBAYMrDqyV0se
	 dsZp2sO0Ms/CQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 18 Apr 2025 14:20:24 +0200
X-ME-IP: 90.11.132.44
Message-ID: <e148faa8-6ee0-45bd-8cd8-37ea42a1de2a@wanadoo.fr>
Date: Fri, 18 Apr 2025 14:20:19 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: stm32-ospi: Fix an error handling path in
 stm32_ospi_probe()
To: quic_msavaliy@quicinc.com
Cc: alexandre.torgue@foss.st.com, broonie@kernel.org,
 christophe.jaillet@wanadoo.fr, kernel-janitors@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 mcoquelin.stm32@gmail.com, patrice.chotard@foss.st.com
References: <2674c8df1d05ab312826b69bfe9559f81d125a0b.1744975624.git.christophe.jaillet@wanadoo.fr>
 <72f49447-5c99-4028-90cf-3f5cc11e8b53@quicinc.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <72f49447-5c99-4028-90cf-3f5cc11e8b53@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 18/04/2025 à 14:09, Mukesh Kumar Savaliya a écrit :
> 
> 
> On 4/18/2025 4:57 PM, Christophe JAILLET wrote:
> [...]
>> diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
>> index 668022098b1e..9ec9823409cc 100644
>> --- a/drivers/spi/spi-stm32-ospi.c
>> +++ b/drivers/spi/spi-stm32-ospi.c
>> @@ -960,6 +960,10 @@ static int stm32_ospi_probe(struct 
>> platform_device *pdev)
>>   err_pm_enable:
>>       pm_runtime_force_suspend(ospi->dev);
>>       mutex_destroy(&ospi->lock);
>> +    if (ospi->dma_chtx)
>> +        dma_release_channel(ospi->dma_chtx);
> why can't you move to devm_dma_request_chan ? No need to cleanup.

Unless I miss something obvious, this function does not exist.

CJ

>> +    if (ospi->dma_chrx)
>> +        dma_release_channel(ospi->dma_chrx);
>>       return ret;
>>   }
> 
> 
> 



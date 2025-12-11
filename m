Return-Path: <linux-spi+bounces-11861-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D90A5CB4A52
	for <lists+linux-spi@lfdr.de>; Thu, 11 Dec 2025 04:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CBF1300E00E
	for <lists+linux-spi@lfdr.de>; Thu, 11 Dec 2025 03:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4AC22A4CC;
	Thu, 11 Dec 2025 03:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="w0FRR332"
X-Original-To: linux-spi@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521E424EF76;
	Thu, 11 Dec 2025 03:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765424696; cv=none; b=geSC01j/OpyxD822Mf+YKBmkKcodGc/NdkZvRn5ODt3NWj1a7etm4/n2cKYhMDjXtPOXXTCyiRy3NF373zZaW3xH+ZknPI0X7JWT++DbXUjzM2hCGCuLaEFWO+mTlOJAJxfijs0uUrJYxYVkjfGAp+MT0nNMPg0fQAp3cnJljgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765424696; c=relaxed/simple;
	bh=Okf615NoLbuj49cgl50OsDXDzzydfQDDKJhb21RzF6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZ8jy7DkBVCBMq2LPbowVEoEwbkn1njHLpTxqCTPIzByQGcmokqP5105tDTCoItL0hltC9syEyfdVY9ZX5IC9R3bkwSTZmvHTl7K9v60ca2pXR4+vsE8hd+ycuAaia8wyKag8QxOT9d/MRLR23cp3xTwBk/xjnoAuvubC1euJsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=w0FRR332; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765424691; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=OqQO9X5XlOOO5UEJ7b2IuaRxVCW95ZXtea/SQgcb8bI=;
	b=w0FRR3328AedXHXM/7KHIehDUTF0lRmC56UdI6a4bYYbb3oCB5ookveeKp332nz+0PNk0/Dy8MaX6pOXbTGbzgL0JHLhY8xUdisENRMDSldUOwzP4kbluVkcbYJKvNfcXGLa6TBZre1D2XP4+BaGQO6H3RqHJawi8aM2vquriqc=
Received: from 30.178.82.227(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WuYoyi6_1765424689 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Dec 2025 11:44:50 +0800
Message-ID: <969efdcd-567e-4b4a-bfe5-d75bdbd37208@linux.alibaba.com>
Date: Thu, 11 Dec 2025 11:44:49 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] spi: tegra210-quad: downgrade the log when fall back to
 PIO
To: Jon Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@kernel.org>
Cc: linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org
References: <20251127130207.43754-1-kanie@linux.alibaba.com>
 <e2b2288e-e8fb-484e-9675-39a0d14441fa@nvidia.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <e2b2288e-e8fb-484e-9675-39a0d14441fa@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/10 12:24, Jon Hunter 写道:
>
> On 27/11/2025 13:02, Guixin Liu wrote:
>> When the machine boots using ACPI, Tegra cannot use DMA and falls back
>> to PIO. In this case, logging these messages as "Error" may confuse
>> users into thinking it is an actual error; therefore, these two log
>> messages should be downgraded to "Info" level.
>
> Which Tegra device are you using?
Tegra194.
The error log are:
     tegra-i2c NVDA0301:00 cannot use DMA: -19
     tegra-i2c NVDA0301:00 failling back to PIO
>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>   drivers/spi/spi-tegra210-quad.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/spi/spi-tegra210-quad.c 
>> b/drivers/spi/spi-tegra210-quad.c
>> index 3be7499db21e..2189904b931d 100644
>> --- a/drivers/spi/spi-tegra210-quad.c
>> +++ b/drivers/spi/spi-tegra210-quad.c
>> @@ -823,8 +823,8 @@ static int tegra_qspi_init_dma(struct tegra_qspi 
>> *tqspi)
>>       tegra_qspi_deinit_dma(tqspi);
>>         if (err != -EPROBE_DEFER) {
>> -        dev_err(tqspi->dev, "cannot use DMA: %d\n", err);
>> -        dev_err(tqspi->dev, "falling back to PIO\n");
>> +        dev_info(tqspi->dev, "cannot use DMA: %d\n", err);
>> +        dev_info(tqspi->dev, "falling back to PIO\n");
>>           return 0;
>>       }
>
> This change would potentially hide an actual case where the DMA 
> initialisation fails when booting with device-tree.
>
> Jon
>
Could we downgrade this to warning? This will not potentially hide an 
actual DMA fail case, and also tell users that we can still work, don't 
worry.

Best Regards,
Guixin Liu



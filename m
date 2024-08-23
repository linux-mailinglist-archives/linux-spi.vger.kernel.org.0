Return-Path: <linux-spi+bounces-4270-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1E795C34B
	for <lists+linux-spi@lfdr.de>; Fri, 23 Aug 2024 04:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41EEF1C225EC
	for <lists+linux-spi@lfdr.de>; Fri, 23 Aug 2024 02:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96B718B14;
	Fri, 23 Aug 2024 02:31:26 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8936A94B;
	Fri, 23 Aug 2024 02:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724380286; cv=none; b=PIe8LmtHepgBU0jLPv0oMDTdR+CIkXg0lXti5OKstpE+bZFYS6WgtPDng29s+2D1SUZxwmZeeg4f0uYC3sjvG9IkAz0OKUAa8li/OB7ireLU3PWbvZFcC28iata+ClZG9ddKUV5fNS6KDTbllgV58+PKcVkQlhWqxbvz+fPphx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724380286; c=relaxed/simple;
	bh=pYu6ITAd0EFro1ZiueuAY/aGqWugS4B28OBEIA2RjPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eL565BpeJ827OeKZX+gqyjAhqC0ufedRC7HRoh5faWXIqVad1oOv6Ate03kv5gPhcdfun6Ce/8zV5J9GPU1LcUKkiOXlz4S+wXwb+TeO18sprAWuTXeAFXKwZWbJC6O0qLZU20sYg4pOumh4TRrhIYcZXcjRHwQlug1U2woltRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WqkY15t0Sz1xvr5;
	Fri, 23 Aug 2024 10:29:25 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 0F7CF1400E8;
	Fri, 23 Aug 2024 10:31:21 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 23 Aug 2024 10:31:20 +0800
Message-ID: <ef36a703-929b-2fb1-6d8b-58c17f37c964@huawei.com>
Date: Fri, 23 Aug 2024 10:31:19 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] spi: stm32-qspi: Simpify resource lookup
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
CC: <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
	<linux-spi@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240820123707.1788370-1-ruanjinjie@huawei.com>
 <ZsdR-G9S5nYbQX4s@finisterre.sirena.org.uk>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <ZsdR-G9S5nYbQX4s@finisterre.sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/8/22 22:58, Mark Brown wrote:
> On Tue, Aug 20, 2024 at 08:37:07PM +0800, Jinjie Ruan wrote:
>> Use the devm_platform_ioremap_resource_byname() helper instead of
>> calling platform_get_resource_byname() and devm_ioremap_resource()
>> separately.
> 
> This breaks boot on the Avenger96 board, it causes a NULL pointer
> dereference:
> 
> [    2.350480] Unable to handle kernel NULL pointer dereference at virtual address 00000000 when read
> 
> ...
> 
> [    2.695787] Call trace:
> [    2.695807]  stm32_qspi_probe from platform_probe+0x5c/0xb0
> [    2.703914]  platform_probe from really_probe+0xc8/0x2c8
> [    2.709284]  really_probe from __driver_probe_device+0x88/0x19c
> [    2.715145]  __driver_probe_device from driver_probe_device+0x30/0x104
> 
> https://lava.sirena.org.uk/scheduler/job/650792
> 
>> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi");
>> -	qspi->io_base = devm_ioremap_resource(dev, res);
>> +	qspi->io_base = devm_platform_ioremap_resource_byname(pdev, "qspi");
>>  	if (IS_ERR(qspi->io_base))
>>  		return PTR_ERR(qspi->io_base);
>>  
>>  	qspi->phys_base = res->start;
>>  
>> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi_mm");
>> -	qspi->mm_base = devm_ioremap_resource(dev, res);
>> +	qspi->mm_base = devm_platform_ioremap_resource_byname(pdev, "qspi_mm");
>>  	if (IS_ERR(qspi->mm_base))
>>  		return PTR_ERR(qspi->mm_base);
> 
> I can't identify any obvious error here, these look like a direct
> subsitution - the implementation of devm_platform_ioremap_resource_byname()
> looks to be the same as the replaced code and dev is set to &pdev->dev
> but I'm seeing the above behaviour.

Mark, thank you very much, I can't identify the error here too. This bug
may be easy to locate if have a reproduction environment, but it's good
to keep it the way it is.



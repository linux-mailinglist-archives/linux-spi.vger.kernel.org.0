Return-Path: <linux-spi+bounces-4216-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3BA956532
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 10:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 813F428268A
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 08:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE7115AADA;
	Mon, 19 Aug 2024 08:07:16 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98117A41;
	Mon, 19 Aug 2024 08:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724054836; cv=none; b=fOLjqbE0pAi+Tt+db/0nZqc+ZjH8NfMqyS6F77NrE6PC+6LcrOO0k1iaYICynjkR+6Rb2XkS3Rt+1wa/0ix4/Yl7fEWCYFwJh6BlGE1l+9XBXLHs6+0hB7FARgrVKxPpFY/lq4kfEnivgKhCsjbCeCkCUSyknRhi7con+2vuQqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724054836; c=relaxed/simple;
	bh=KNZax9cbBKckqa2gW95GJYWsMaHz3ZspcOY2W+SsHeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PoGABE+sAuUanXPA+yPWyJJyE4RXcL7i1aBohqUx/CA75BqUBiDBp/GotA2FUKznQpHcMe4ko65o5j/34e5YtxziC51qkHWp26owNdbosnHPcWoKx5xLD4FLzbNBqP8Xqtp+fDUVOOvCft4lZULVWnkeXeTfywYUqHLiSyYLBoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WnQBs5KVBzpSsh;
	Mon, 19 Aug 2024 16:05:41 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id E124E18007C;
	Mon, 19 Aug 2024 16:07:09 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 19 Aug 2024 16:07:09 +0800
Message-ID: <635009b1-df79-2549-8f81-37a5a9913d49@huawei.com>
Date: Mon, 19 Aug 2024 16:07:08 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] spi: bcm63xx: Fix missing pm_runtime_disable()
To: Jonas Gorski <jonas.gorski@gmail.com>
CC: <broonie@kernel.org>, <noltari@gmail.com>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240819040310.2801422-1-ruanjinjie@huawei.com>
 <CAOiHx=mqS+r9PZJEQETVU-2GdgsZoFQ0fFAJ1zTVXPmZCBP0PA@mail.gmail.com>
Content-Language: en-US
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <CAOiHx=mqS+r9PZJEQETVU-2GdgsZoFQ0fFAJ1zTVXPmZCBP0PA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/8/19 15:52, Jonas Gorski wrote:
> Hi,
> 
> On Mon, 19 Aug 2024 at 05:55, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>
>> The pm_runtime_disable() is missing in the remove function, add it to
>> align with the probe error path.
>>
>> Fixes: 2d13f2ff6073 ("spi: bcm63xx-spi: fix pm_runtime")
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  drivers/spi/spi-bcm63xx.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
>> index 289f8a94980b..0531b6f3eef3 100644
>> --- a/drivers/spi/spi-bcm63xx.c
>> +++ b/drivers/spi/spi-bcm63xx.c
>> @@ -614,6 +614,8 @@ static void bcm63xx_spi_remove(struct platform_device *pdev)
>>         /* reset spi block */
>>         bcm_spi_writeb(bs, 0, SPI_INT_MASK);
>>
>> +       pm_runtime_disable(&pdev->dev);
>> +
> 
> How about using devm_pm_runtime_enable() instead in the probe path?
> Then we don't need to call _disable() manually.

Hi, Jonas

I think that is good. I grep the commit log and there is a example:

https://lore.kernel.org/all/20240605131533.20037-2-raag.jadav@intel.com/

I'll change it to use devm_pm_runtime_enable() to fix it, thank you!

> 
>>         /* HW shutdown */
>>         clk_disable_unprepare(bs->clk);
>>  }
>> --
>> 2.34.1
>>
> 
> Best Regards,
> Jonas Gorski


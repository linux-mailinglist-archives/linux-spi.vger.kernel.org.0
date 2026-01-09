Return-Path: <linux-spi+bounces-12236-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A536D094AF
	for <lists+linux-spi@lfdr.de>; Fri, 09 Jan 2026 13:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B6C463028713
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jan 2026 12:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2AE338911;
	Fri,  9 Jan 2026 12:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ksmbnqyi"
X-Original-To: linux-spi@vger.kernel.org
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A44334C24;
	Fri,  9 Jan 2026 12:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767960496; cv=none; b=byd8+6b/wCKU+P9950+b2lXJo0j8/GpuF7IP+6G2XxxKsXoW+ODdIn79Nvxymb7xXbugS1m0eB6UCUWNu7KFxoIg2pmnU4safbcN9Mx4ljmeUGINKNi9khdzuP13jIxuHZHOjdF4ngvAtVYkagzEttCW0mJ8uDla6sjQ8Fmp03M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767960496; c=relaxed/simple;
	bh=euX/y/xIVvoAf8PJaHDf3v0XLofp3e3N0vboYleW93Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tyCuDWM5ZSL2cXvTwERO+H5q7nZtm0U6v7N959RHS9XDwmx8Qpejl5x5cU0fx5huss5hTfVdI+stMEY1u6EqMrAFZRKyHRq2jQ5Jt4qx0NjRpuz9T2AbszzXjGAyxSYsE14lqVdmZyIGD+8SZ9lbh++MVzGo17wPb2106rwfPy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ksmbnqyi; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1767960488; bh=PN2+k9WXdSkQxmh4KVDGxBfjhS1mBp0jv6sQGMX1qSA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ksmbnqyixGCYZbx9UixaCOEHpS6+GqiUfEqKeja62O5+fEMa4joLBj7YNxgm8pBbg
	 ailvXr1a2ktx1dvxitSq7yMxlkfmmshkSmYfcO4wglZ6nBfyBSs370kWR9aCgkIWw3
	 f5PHT9r5j5KDJe50QEjyk6ZRvNVuKm2Lr+tHbwG8=
Received: from [198.18.0.1] ([223.167.147.103])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 202B48F4; Fri, 09 Jan 2026 20:08:02 +0800
X-QQ-mid: xmsmtpt1767960482t6x9cc25r
Message-ID: <tencent_6FE7974351445022117CFBCC5E8D4D38AB07@qq.com>
X-QQ-XMAILINFO: MzNwb/pqyJTkMAxnGGdOnwJhaZbRiO0iFhqJySO+UDowhInNtOMrogN5IuChGL
	 Z5iEJdXUC/AyijV+UwbIL4vPbVq/Ss9JVbyAUpJ0WeDaCppy24fl0yRFEBgX+xs76Zbcr+FSojHl
	 WJOPT7dwd0OiVR90OcKr4HSf7Rb82tsdd5kAZKYZev2AjqojckuUNGN9qriXdw/Wueqfqf2oYdDX
	 hFkbkacCjmVvgCFL+q0166LcWcYUfK5iELOB9xfP4TTYRkbaaJfYjox00bqSD2Dyx/Kkr2q0nsfh
	 HTCroY8ShWAnsCCB5+zAeBi4h7y6v5EpxKoEAH9OGs+9Ar71FKiFLeidyqlc34Zk/b2c/3zR5Xkw
	 lPPM/kH35WR4s6qfdbXZZvcqnLof5nsoRFw2UMuLlDiCzCoTDjeYcpuT7oBhjCRebOiRlGqVVn5G
	 GWUvbQmiVA08HcZHSeKbRLCQ453hK4Q1XgWSmp3sAQO8ysOQuCt60UdIb7r2Rse13ALz0RVGvJad
	 K6J/CSct49ftTGzLDmlBDqQ3UJEebEIYAgs2R1plx7fNjmp6G96xOKe/lnm5mpr3H4loxB2K+piI
	 su5q6XuiAp4yNwudMavfZ8xQtRCiBn9otcu7yOm8UnkE11Vyt5Y9k2EldlGfzOmrU4q5TUJyvQs/
	 YJChu91OOI74YuNjS1hhc4LYULgWOsSwf8oOZjgm+1NtoEY7DHXcVw9V+zcqOWe/Jwu3zGyoAyZg
	 CzW/OvrLV6fhzLN2TS4Hicf+Sg1oS4wV+SBRjcCEbA3uqfUdDuyh54JO1ubhdAiW6e4BR5iks8UQ
	 DpCDWPaogHccdYySOGeqmaYc57ilk4b6d4MUEO7dAgHXy3XAzZsQ+75iGmuSfc1NX/9jCJ7cB4Cp
	 A5ZSLnBUzq42fVPHwzeBR46hR5DUZrEgxEbJeURAYsx+7yBW1mxRuec8xjuo4SfypurPVGGWiWIf
	 xM05iC2N80WSOY+XMI9qWSz25E5YKHidcK0T1FAeyCC04G0zo4aeuvUrB1hg374Op+beIp8jLULM
	 3CmUCPq0yGrZwApa5xS0FM7fRdbTY=
X-QQ-XMRINFO: NI4Ajvh11aEjoAV6SChxQ8I/MNQdR8IWyQ==
X-OQ-MSGID: <5123d8b7-7a83-41e6-ab55-1b3bc6019af4@qq.com>
Date: Fri, 9 Jan 2026 20:06:52 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: spi-sprd-adi: Fix double free in probe error path
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Mark Brown <broonie@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_4588081F26734D4306AEE239F31016318205@qq.com>
 <076ffcce-86d4-4047-9edb-cbc24f64e62b@linux.alibaba.com>
From: Felix Gu <gu_0233@qq.com>
In-Reply-To: <076ffcce-86d4-4047-9edb-cbc24f64e62b@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Baolin,

Thanks for review, I will fix it in V2.


Best regards,

Felix Gu

在 2026/1/9 8:41, Baolin Wang 写道:
>
>
> On 1/9/26 12:12 AM, Felix Gu wrote:
>> The driver currently uses spi_alloc_host() to allocate the controller
>> but registers it using devm_spi_register_controller().
>>
>> If devm_register_restart_handler() fails, the code jumps to the
>> put_ctlr label and calls spi_controller_put(). However, since the
>> controller was registered via a devm function, the device core will
>> automatically call spi_controller_put() again when the probe fails.
>> This results in a double-free of the spi_controller structure.
>>
>> Fix this by switching to devm_spi_alloc_host() and removing the
>> manual spi_controller_put() call.
>>
>> Signed-off-by: Felix Gu <gu_0233@qq.com>
>> ---
>
> Thanks. Can you add a 'Fixes:' tag? With that, you can add:
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>
>>   drivers/spi/spi-sprd-adi.c | 33 ++++++++++-----------------------
>>   1 file changed, 10 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
>> index 262c11d977ea..f25b34a91756 100644
>> --- a/drivers/spi/spi-sprd-adi.c
>> +++ b/drivers/spi/spi-sprd-adi.c
>> @@ -528,7 +528,7 @@ static int sprd_adi_probe(struct platform_device 
>> *pdev)
>>       pdev->id = of_alias_get_id(np, "spi");
>>       num_chipselect = of_get_child_count(np);
>>   -    ctlr = spi_alloc_host(&pdev->dev, sizeof(struct sprd_adi));
>> +    ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(struct sprd_adi));
>>       if (!ctlr)
>>           return -ENOMEM;
>>   @@ -536,10 +536,8 @@ static int sprd_adi_probe(struct 
>> platform_device *pdev)
>>       sadi = spi_controller_get_devdata(ctlr);
>>         sadi->base = devm_platform_get_and_ioremap_resource(pdev, 0, 
>> &res);
>> -    if (IS_ERR(sadi->base)) {
>> -        ret = PTR_ERR(sadi->base);
>> -        goto put_ctlr;
>> -    }
>> +    if (IS_ERR(sadi->base))
>> +        return PTR_ERR(sadi->base);
>>         sadi->slave_vbase = (unsigned long)sadi->base +
>>                   data->slave_offset;
>> @@ -551,18 +549,15 @@ static int sprd_adi_probe(struct 
>> platform_device *pdev)
>>       if (ret > 0 || (IS_ENABLED(CONFIG_HWSPINLOCK) && ret == 0)) {
>>           sadi->hwlock =
>> devm_hwspin_lock_request_specific(&pdev->dev, ret);
>> -        if (!sadi->hwlock) {
>> -            ret = -ENXIO;
>> -            goto put_ctlr;
>> -        }
>> +        if (!sadi->hwlock)
>> +            return -ENXIO;
>>       } else {
>>           switch (ret) {
>>           case -ENOENT:
>>               dev_info(&pdev->dev, "no hardware spinlock supplied\n");
>>               break;
>>           default:
>> -            dev_err_probe(&pdev->dev, ret, "failed to find hwlock 
>> id\n");
>> -            goto put_ctlr;
>> +            return dev_err_probe(&pdev->dev, ret, "failed to find 
>> hwlock id\n");
>>           }
>>       }
>>   @@ -579,26 +574,18 @@ static int sprd_adi_probe(struct 
>> platform_device *pdev)
>>       ctlr->transfer_one = sprd_adi_transfer_one;
>>         ret = devm_spi_register_controller(&pdev->dev, ctlr);
>> -    if (ret) {
>> -        dev_err(&pdev->dev, "failed to register SPI controller\n");
>> -        goto put_ctlr;
>> -    }
>> +    if (ret)
>> +        return dev_err_probe(&pdev->dev, ret, "failed to register 
>> SPI controller\n");
>>         if (sadi->data->restart) {
>>           ret = devm_register_restart_handler(&pdev->dev,
>>                               sadi->data->restart,
>>                               sadi);
>> -        if (ret) {
>> -            dev_err(&pdev->dev, "can not register restart handler\n");
>> -            goto put_ctlr;
>> -        }
>> +        if (ret)
>> +            return dev_err_probe(&pdev->dev, ret, "can not register 
>> restart handler\n");
>>       }
>>         return 0;
>> -
>> -put_ctlr:
>> -    spi_controller_put(ctlr);
>> -    return ret;
>>   }
>>     static struct sprd_adi_data sc9860_data = {
>>
>> ---
>> base-commit: fc4e91c639c0af93d63c3d5bc0ee45515dd7504a
>> change-id: 20260108-spi-sprd-adi-fix-c071bf124bf6
>>
>> Best regards,



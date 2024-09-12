Return-Path: <linux-spi+bounces-4784-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE03C975FE1
	for <lists+linux-spi@lfdr.de>; Thu, 12 Sep 2024 05:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E131F23BBF
	for <lists+linux-spi@lfdr.de>; Thu, 12 Sep 2024 03:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CDA187FF3;
	Thu, 12 Sep 2024 03:53:26 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F68716BE17;
	Thu, 12 Sep 2024 03:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726113206; cv=none; b=EbpOX4KTCTveyHxb2a2w3F9AmY3qZtnAQ3rnK6R9BcHScSFqFRTWrXm/gqrM1m1BO09h2yAqy3LAI6R+A7CUQUhv8maSac2nbxF1vcIweDMeMKaVxJIeNg8A1SrJ+w3GEBTQWmDTQn+CktQmJ+qVx8mCAffHj2bShDCfyH4AsMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726113206; c=relaxed/simple;
	bh=04aZRYrtm8kYQYqDApOMz2M5HoYXYctrlv4NHXiyWOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eKmX/lQkgYbGiZNlRaPuhf7f/INGKF0lqSSE495gBcTcrPWCtXJ/Zwq1eHudfqFDSGBY5QEZTxG3ooIjfWOJTaOB32eqyuUTEHZZ/cTU8sj2nxTOyI0fjB5JuusFv/InVyzWc/rN7m7tvMSgqKS1Xr10+NMDGYqYK/74qfZo5R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4X43ST6VjZz69SX;
	Thu, 12 Sep 2024 11:53:13 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id D7D0618006C;
	Thu, 12 Sep 2024 11:53:20 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 12 Sep 2024 11:53:20 +0800
Message-ID: <c662f0b9-31dc-8b97-ef3f-ea33f9fc62af@huawei.com>
Date: Thu, 12 Sep 2024 11:53:19 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 3/3] spi: geni-qcom: Use devm functions to simplify
 code
Content-Language: en-US
To: Doug Anderson <dianders@chromium.org>
CC: <broonie@kernel.org>, <akashast@codeaurora.org>, <vkoul@kernel.org>,
	<linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240909132810.1296786-1-ruanjinjie@huawei.com>
 <20240909132810.1296786-4-ruanjinjie@huawei.com>
 <CAD=FV=XQ7uf_Y_WTv_6-DX1Mo=+RycKSyxf=E-f3TOKiuE5RMA@mail.gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <CAD=FV=XQ7uf_Y_WTv_6-DX1Mo=+RycKSyxf=E-f3TOKiuE5RMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/9/12 6:53, Doug Anderson wrote:
> Hi,
> 
> On Mon, Sep 9, 2024 at 6:19 AM Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>
>> Use devm_pm_runtime_enable(), devm_request_irq() and
>> devm_spi_register_controller() to simplify code.
>>
>> And also register a callback spi_geni_release_dma_chan() with
>> devm_add_action_or_reset(), to release dma channel in both error
>> and device detach path, which can make sure the release sequence is
>> consistent with the original one.
>>
>> 1. Unregister spi controller.
>> 2. Free the IRQ.
>> 3. Free DMA chans
>> 4. Disable runtime PM.
>>
>> So the remove function can also be removed.
>>
>> Suggested-by: Doug Anderson <dianders@chromium.org>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>> v4:
>> - Correct the "data" of devm_add_action_or_reset().
>> v3:
>> - Land the rest of the cleanups afterwards.
>> ---
>>  drivers/spi/spi-geni-qcom.c | 37 +++++++++++++------------------------
>>  1 file changed, 13 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
>> index 6f4057330444..5cb002d7d4a6 100644
>> --- a/drivers/spi/spi-geni-qcom.c
>> +++ b/drivers/spi/spi-geni-qcom.c
>> @@ -632,8 +632,10 @@ static int spi_geni_grab_gpi_chan(struct spi_geni_master *mas)
>>         return ret;
>>  }
>>
>> -static void spi_geni_release_dma_chan(struct spi_geni_master *mas)
>> +static void spi_geni_release_dma_chan(void *data)
>>  {
>> +       struct spi_geni_master *mas = data;
>> +
>>         if (mas->rx) {
>>                 dma_release_channel(mas->rx);
>>                 mas->rx = NULL;
>> @@ -1132,6 +1134,12 @@ static int spi_geni_probe(struct platform_device *pdev)
>>         if (ret)
>>                 return ret;
>>
>> +       ret = devm_add_action_or_reset(dev, spi_geni_release_dma_chan, mas);
>> +       if (ret) {
>> +               dev_err(dev, "Unable to add action.\n");
>> +               return ret;
>> +       }
> 
> Use dev_err_probe() to simplify.
> 
> ret = devm_add_action_or_reset(dev, spi_geni_release_dma_chan, mas);
> if (ret)
>   return dev_err_probe(dev, ret, "Unable to add action.\n");

It seems that if it only return -ENOMEM or 0, using dev_err_probe() has
not not much value for many community maintainers.

> 
> 
> Personally I'd also rather that you do the devm_add_action_or_reset()
> call straight in spi_geni_grab_gpi_chan(). That makes it much more

Yes, it will be more clear.

> obvious what's happening. You can still use dev_err_probe() in there
> since it's called (indirectly) from probe. In that case you'd probably
> replace the "return 0;" in that function with just "return
> dev_err_probe(...)".
> 
> 
>> @@ -1146,33 +1154,15 @@ static int spi_geni_probe(struct platform_device *pdev)
>>         if (mas->cur_xfer_mode == GENI_GPI_DMA)
>>                 spi->flags = SPI_CONTROLLER_MUST_TX;
>>
>> -       ret = request_irq(mas->irq, geni_spi_isr, 0, dev_name(dev), spi);
>> +       ret = devm_request_irq(dev, mas->irq, geni_spi_isr, 0, dev_name(dev), spi);
>>         if (ret)
>> -               goto spi_geni_release_dma;
>> +               return ret;
>>
>> -       ret = spi_register_controller(spi);
>> +       ret = devm_spi_register_controller(dev, spi);
>>         if (ret)
>> -               goto spi_geni_probe_free_irq;
>> +               return ret;
>>
>>         return 0;
> 
> You no longer need the "if" statement or even to assign to "ret". Just:
> 
> return devm_spi_register_controller(dev, spi);

Right!

> 
> 
> Those are just nits, though. I'd be OK with:
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> ...since Mark has already landed the first two patches, your v5 would
> just contain this one patch.
> 
> -Doug


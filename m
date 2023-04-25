Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98696ED94B
	for <lists+linux-spi@lfdr.de>; Tue, 25 Apr 2023 02:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjDYAWx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Apr 2023 20:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjDYAWw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Apr 2023 20:22:52 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBDCB55AA
        for <linux-spi@vger.kernel.org>; Mon, 24 Apr 2023 17:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
        Content-Type; bh=jCUHgEdAh5ND2XrFJK/nUyjDb1xgdON8csCxLaV/31k=;
        b=iygKEjGskik/gP3iRmeTxO/QNvRbBX/gzJTfyULpJYR36+LrssmQeAsT5sd/hR
        KZ3c/vM8aollm11NbqealbzXpvNxUPXIZHZI1ADW1r8mrdse8HbYdr3VXDG7pWv2
        uhhoFZKwb1wkSOTXRU1mhetWuZnzvCPlkIaRvTU421MQw=
Received: from [172.21.25.67] (unknown [218.201.129.19])
        by zwqz-smtp-mta-g1-0 (Coremail) with SMTP id _____wC33LA3HUdk6KIsAA--.9857S2;
        Tue, 25 Apr 2023 08:22:15 +0800 (CST)
Message-ID: <7cadd411-77a5-17d6-a145-54b01b0d0eee@163.com>
Date:   Tue, 25 Apr 2023 08:22:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drivers: spi: sunxi: Enable irq after the initialization
 is done
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-sunxi@lists.linux.dev, linux-spi@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Evgeny Boger <boger@wirenboard.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
References: <20230423023056.27929-1-qianfanguijin@163.com>
 <2fe1f98b-9126-4245-bce9-d8fbb3da9ba8@sirena.org.uk>
Content-Language: en-US
From:   qianfan <qianfanguijin@163.com>
In-Reply-To: <2fe1f98b-9126-4245-bce9-d8fbb3da9ba8@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wC33LA3HUdk6KIsAA--.9857S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF4fKryxZw4rWryfuryUKFg_yoW8Wr1xpr
        WUJan3KrW8X345tFn2grs0v3W5Gr4Fya47Cr4vk3yfA390gryqqF1rt3W2krZ5urWfW342
        qFyvqrsY9ayqqaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UE-ewUUUUU=
X-Originating-IP: [218.201.129.19]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/1tbiXBhc7VXl6X5lyQAAs+
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



在 2023/4/24 19:46, Mark Brown 写道:
> On Sun, Apr 23, 2023 at 10:30:56AM +0800, qianfanguijin@163.com wrote:
>
>> The kernel error messages is as follows:
>>
>> [    1.362449] sun6i-spi 1c06000.spi: Failed to request RX DMA channel
>> [    1.369654] 8<--- cut here ---
>> [    1.372716] Unable to handle kernel paging request at virtual address fffffffc
>> [    1.379928] pgd = (ptrval)
>> [    1.382632] [fffffffc] *pgd=6bef6861, *pte=00000000, *ppte=00000000
>> [    1.388907] Internal error: Oops: 37 [#1] SMP ARM
>> ...
>> [    1.784024] [<c0159c54>] (swake_up_locked.part.0) from [<c0159d9c>] (complete+0x30/0x40)
> Please think hard before including complete backtraces in upstream
> reports, they are very large and contain almost no useful information
> relative to their size so often obscure the relevant content in your
> message. If part of the backtrace is usefully illustrative (it often is
> for search engines if nothing else) then it's usually better to pull out
> the relevant sections.
Thanks and I will drop the backtrace messages.
>
>>   	ret = devm_request_irq(&pdev->dev, irq, sun4i_spi_handler,
>> -			       0, "sun4i-spi", sspi);
>> +			       IRQF_NO_AUTOEN, "sun4i-spi", sspi);
>>   	if (ret) {
>>   		dev_err(&pdev->dev, "Cannot request IRQ\n");
>>   		goto err_free_master;
>> @@ -506,6 +506,8 @@ static int sun4i_spi_probe(struct platform_device *pdev)
>>   		goto err_pm_disable;
>>   	}
>>   
>> +	enable_irq(irq);
>> +
> The usual approach would be to move the requesting of the interrupt
> later.  Why do this instead?
Nothing special, this way does not change the goto logic.


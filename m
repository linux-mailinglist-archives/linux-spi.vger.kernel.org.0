Return-Path: <linux-spi+bounces-10196-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F04C9B8E37E
	for <lists+linux-spi@lfdr.de>; Sun, 21 Sep 2025 20:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948A717B638
	for <lists+linux-spi@lfdr.de>; Sun, 21 Sep 2025 18:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF051266574;
	Sun, 21 Sep 2025 18:52:25 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630661C84A0;
	Sun, 21 Sep 2025 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758480745; cv=none; b=MQx8UCXiFZvT5m4iXTv4Z80c57XfmzaHLSeWwRBzcQtLHUBKVw0iytNZkm2ON72PL4d3YGQPpy02hhRbzJoHtwVryuT3XgI2t/HX/UnJLJIuTLHG0StTnvvrT3K+j0uNaK633EozbfLv1Zxl6cBF88K195FUe8PR7yq3smKqPdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758480745; c=relaxed/simple;
	bh=aGtuEHxtXePmXb9Bz/sjo4Ha/4K0ioBr7XAQzZ75TU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tleTIIN2UgVNB/hIy4AyzKmoZZvnfvzoPNYnSwvkiBOcMWzqptJt8nqMSpc8ik43+mNEKfXcxepc351OtzqneGwA9mgTjjailFcd0e4O9vPflZTUUtB0vTy1ogmThLNIoMPdBcnTDgKdkmDzP0YDCGejRRHlw6auKHaC5JaXiUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.106] (unknown [114.241.87.235])
	by APP-01 (Coremail) with SMTP id qwCowAA3kaM3SdBo3kkjBA--.9911S2;
	Mon, 22 Sep 2025 02:51:35 +0800 (CST)
Message-ID: <411ade91-3fb5-40a3-baca-e6b03c5783ae@iscas.ac.cn>
Date: Mon, 22 Sep 2025 02:51:35 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] spi: spacemit: introduce SpacemiT K1 SPI
 controller driver
To: Alex Elder <elder@riscstar.com>, broonie@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dlan@gentoo.org, ziyao@disroot.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250919155914.935608-1-elder@riscstar.com>
 <20250919155914.935608-3-elder@riscstar.com>
 <a7070f3f-8857-4834-9e9e-02068637075c@iscas.ac.cn>
 <3c9aaa62-f685-47f7-a21c-00f51550f185@riscstar.com>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <3c9aaa62-f685-47f7-a21c-00f51550f185@riscstar.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAA3kaM3SdBo3kkjBA--.9911S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWxZFW5Kr4xKry8CFy7GFg_yoW8WFyUpF
	95WFWYkFW5tFn3Xr17tF1UWa45Aw1rKa4DAFy8Xas0yr45uw1vgFW5XrWv93srJr4kJF1U
	Jw1UXr47Z3sxJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvlb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
	xwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07jfb18UUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/


On 9/20/25 23:59, Alex Elder wrote:
> On 9/19/25 10:52 PM, Vivian Wang wrote:
>>
>> [...]
>>
>> +static void k1_spi_read_word(struct k1_spi_driver_data *drv_data)
>> +{
>> +    struct k1_spi_io *rx = &drv_data->rx;
>> +    u32 bytes = drv_data->bytes;
>> +    u32 val;
>> +
>> +    val = readl(drv_data->base + SSP_DATAR);
>> +    rx->resid -= bytes;
>> +
>> +    if (!rx->buf)
>> +        return;    /* Null reader: discard the data */
>> +
>> +    if (bytes == 1)
>> +        *(u8 *)rx->buf = val;
>> +    else if (bytes == 1)
>>
>> Typo? else if (bytes == 2)
>
> Wow.  Yes that is an error that I'll correct.
>
>>> +        *(u16 *)rx->buf = val;
>>> +    else
>>> +        *(u32 *)rx->buf = val;
>>
>> Maybe
>>
>>     else if (bytes == 4)
>>         *(u32 *)rx->buf = val;
>>     else
>>         WARN_ON_ONCE(1);
>
> The value of bytes will be 1, 2, or 4, which we can tell
> by inspection.  At one time I had a switch statement with
> a default, but I decided to leave out the default, which
> won't happen.
>
>> Just to make the pattern consistent? Same for k1_spi_write_word.
>
> Consistent with what? 
>
I was just thinking it would be clearer if the code states clearly:

    1 -> u8
    2 -> u16
    4 -> u32
    anything else -> shouldn't happen

As is, it wasn't obvious to me that we're just handling 4 as u32. Maybe
we're just capping it at u32, and 8 is also handled.

Well, maybe I'm just not familiar with SPI stuff, and word size above 4
doesn't make sense anyway.

It could also be a comment

    else /* 4 */

Just a suggestion, no strong preference from me.

Vivian "dramforever" Wang



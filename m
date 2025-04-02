Return-Path: <linux-spi+bounces-7397-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FE5A792A1
	for <lists+linux-spi@lfdr.de>; Wed,  2 Apr 2025 18:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96FBE18927B6
	for <lists+linux-spi@lfdr.de>; Wed,  2 Apr 2025 16:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67CE166F29;
	Wed,  2 Apr 2025 16:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BhZVGlGc"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262AB38DE9
	for <linux-spi@vger.kernel.org>; Wed,  2 Apr 2025 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743609859; cv=none; b=LprVJ+xP6qHWP6vMjHLdhdjOJpRt74FTBti7sQ04Y3H4ZRtMFPPE6l84u8/DB4Jxk+dq/1yR1/KWroFZyvLAZQxWwiVJZSDhs7WaSGBvwPdr1X1tyX9NzC/tZSNUgjfFDTu+VBhAZS7AzL7HCxDHxdnd0nJw8rTq2B3tuMg18ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743609859; c=relaxed/simple;
	bh=UGfpQLQ61ImaisNx5dYToKG60nCfbCY6OgnEczIf8oE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a7Ex30mIJS4YYHoCBi9O52QOPFtbePqQ+nbFD41ZUI42rgQFyMz5dWzbUISKGWqCnqvZH/2dzw1wgcilhM1Ta6NfpAL8NidVqyrVHsdS+0AIzpoyNxWiaXe3GDmnZFL1Mfi3i3jKvleVlSQmk7vJ/flcbFXPxe546GK/J1kQVl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BhZVGlGc; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3f8d2f8d890so3970752b6e.0
        for <linux-spi@vger.kernel.org>; Wed, 02 Apr 2025 09:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1743609857; x=1744214657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YRcCr0UxfopUNgxK+5pqGpdPNVgXj21wPiyLC3kd8PM=;
        b=BhZVGlGciZ6SNg6I9GoCS/useJXzrHULImforcz9i07Jw1a0RWuZuZHuDRUxxmMq1J
         SAwKXOl6pCWi0iYHmwx+nutXWKXYZofZUO0aeLpaMk3+QBcoVIhW5VqcB83IDxCkpYpx
         3bopSvND1q3y1tbK8oxufje0fC/PW7n9bVBO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743609857; x=1744214657;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRcCr0UxfopUNgxK+5pqGpdPNVgXj21wPiyLC3kd8PM=;
        b=RXyAzbCEXmDN5kw8SOlu64JgtkizephZU0NxvKOCAQkyrgWAt4QIii99aNweIqF4ly
         aXkeqbvha9oCWQ4HBmamP6tKSvVsXLOnre0t9ahZZxxOe7pt0M/Jyd7HaJrUKuF4UJZn
         xq6ZVtx0xnj3ollzkj6oVuRuJqpEHHOIJ2t/LuTn3kTVN8qSfSfp4CGvGbtBWSQRsFck
         7fLRsiGa2MpS/+Cw6clVeCZ4j2m5dWg5W6ySi5u2lsBIOFRZIjYSvfjW5NWO5guwz0sm
         ATuJiFSV0V8NVd2iRKwhwz71HrqVuQbVt9RsVYiRh7Zzmj94yvY5gaEVBF4sR7mXmmex
         CVrA==
X-Forwarded-Encrypted: i=1; AJvYcCWrR3eiYZDwxwGlg5uRNAkiE0TA9HurXyggLcgzqgp4+M7BW9fX2NhZQ1VFqrUYikQQ+hFibbzGBeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDHit2ep5+W0NO65sqQcGyobkyeNRLtHlRsPkCe409B9gATOFM
	jGeynn/KJrAviDlzMyquhV/bmnfUf2AaWaEBhK5sBQyC/JyVHjyQEmfy69VP7Q==
X-Gm-Gg: ASbGncuYO+eireC8c+C9BhxipJLlLC7MAvTW26YOiWuCilFCUL0TjKA6wdR7dsAs4cc
	tCV7KwprrQ641IGwtckAuJA7yJhV1ARdcL+8EaQSJC52PPWPH8SlzL91nz3SfhJpnqmyCuwCpAx
	tvq5CJPkE9ZtBCd8VA/d/dYUmRiPwCNRaC3uDNtKJwO/rPfo9jsyLSPHTLJt7AG25OI8Nt6G36O
	JRA83csg1okmrPZHWxDIiA7/gKWbfAPjI96n3yYzg3ASEsnfaygmHT8q4tpt47iexK9JSZiy4Yu
	SFr34yyTGSPw/AEuVpdxmnTtxk2b54yWUNTrzUryBb3+FGpD0PXknW4UkUc49wpQpAiG0zzuZkM
	UbT2CEbUR
X-Google-Smtp-Source: AGHT+IHPcEIEeitdzKDC8eD3T4OZh19nJpylEp0BpW6lGH0e8ZiOIghhnDLC5eL8MJ+Po1Uy950RiQ==
X-Received: by 2002:a05:6808:1524:b0:3f9:43dd:a054 with SMTP id 5614622812f47-3ff0f5f4c6dmr11055882b6e.34.1743609857169;
        Wed, 02 Apr 2025 09:04:17 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ff0529650esm2399237b6e.48.2025.04.02.09.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 09:04:15 -0700 (PDT)
Message-ID: <92d95675-5d4a-4bc1-b2a2-8f2f1668a640@broadcom.com>
Date: Wed, 2 Apr 2025 09:04:14 -0700
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: bcm2835: Restore native CS probing when
 pinctrl-bcm2835 is absent
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
References: <20250401233603.2938955-1-florian.fainelli@broadcom.com>
 <CAMRc=MeiALzO3XAmH9BLjxrB3EA1br1tpzHd5Qucw2NCVQ2q7g@mail.gmail.com>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <CAMRc=MeiALzO3XAmH9BLjxrB3EA1br1tpzHd5Qucw2NCVQ2q7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/2/25 04:44, Bartosz Golaszewski wrote:
> On Wed, Apr 2, 2025 at 1:37 AM Florian Fainelli
> <florian.fainelli@broadcom.com> wrote:
>>
>> The lookup table forces the use of the "pinctrl-bcm2835" GPIO chip
>> provider and essentially assumes that there is going to be such a
>> provider, and if not, we will fail to set-up the SPI device.
>>
> 
> Yeah, the consumer driver itself is an unfortunate place to define the
> provider data. This could potentially be moved to gpiolib-of.c quirks.
> 
>> While this is true on Raspberry Pi based systems (2835/36/37, 2711,
>> 2712), this is not true on 7712/77122 Broadcom STB systems which use the
>> SPI driver, but not the GPIO driver.
>>
>> There used to be an early check:
>>
>>         chip = gpiochip_find("pinctrl-bcm2835", chip_match_name);
>>         if (!chip)
>>                 return 0;
>>
>> which would accomplish that nicely, bring something similar back by
>> checking for the compatible strings matched by the pinctrl-bcm2835.c
>> driver, if there is no Device Tree node matching those compatible
>> strings, then we won't find any GPIO provider registered by the
>> "pinctrl-bcm2835" driver.
>>
>> Fixes: 21f252cd29f0 ("spi: bcm2835: reduce the abuse of the GPIO API")
>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>> ---
>>   drivers/spi/spi-bcm2835.c | 15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
>> index a5d621b94d5e..5926e004d9a6 100644
>> --- a/drivers/spi/spi-bcm2835.c
>> +++ b/drivers/spi/spi-bcm2835.c
>> @@ -1226,7 +1226,12 @@ static int bcm2835_spi_setup(struct spi_device *spi)
>>          struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
>>          struct bcm2835_spidev *target = spi_get_ctldata(spi);
>>          struct gpiod_lookup_table *lookup __free(kfree) = NULL;
>> -       int ret;
>> +       const char *pinctrl_compats[] = {
>> +               "brcm,bcm2835-gpio",
>> +               "brcm,bcm2711-gpio",
>> +               "brcm,bcm7211-gpio",
>> +       };
>> +       int ret, i;
>>          u32 cs;
>>
>>          if (!target) {
>> @@ -1291,6 +1296,14 @@ static int bcm2835_spi_setup(struct spi_device *spi)
>>                  goto err_cleanup;
>>          }
>>
>> +       for (i = 0; i < ARRAY_SIZE(pinctrl_compats); i++) {
>> +               if (of_find_compatible_node(NULL, NULL, pinctrl_compats[i]))
>> +                       break;
>> +       }
>> +
>> +       if (i == ARRAY_SIZE(pinctrl_compats))
>> +               return 0;
>> +
>>          /*
>>           * TODO: The code below is a slightly better alternative to the utter
>>           * abuse of the GPIO API that I found here before. It creates a
>> --
>> 2.34.1
>>
>>
> 
> The fix is good for now but I'd still try to move this out of the
> driver at some point.
> 
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Thanks, I will see what I can do on that front, but if you don't hear 
from me in the next few weeks, don't hesitate to ask again :)
-- 
Florian


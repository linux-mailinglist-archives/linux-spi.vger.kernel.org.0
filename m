Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E053F2AC812
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 23:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbgKIWKY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 17:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbgKIWKX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 17:10:23 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCB0C0613CF;
        Mon,  9 Nov 2020 14:10:22 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id q22so2304492qkq.6;
        Mon, 09 Nov 2020 14:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H0PQ6nyLYrfffzbRL92Wcmyqh/B5owqtAHhzB8+J5mM=;
        b=un3OsxyTQew89BMnf5RxUUNkXvjQYFjMyu9i99n7lkmO2jC+R88urYmD/z7geCeVB4
         LGQrOyhf3zQcDcCnJRPlW/CSiUI/ESp00a3OOGZN0IjMX1RNWdxO/CnxmfRPfoHARPg2
         MKQ6q7NqZ5XAeRsgLXzK413k8Ru0QWs8p8ZRja+IvQz7TMe1FSipb0ZHZqt54uMJ25H1
         pJfrnAmIsB/6hBqJkDU11Th2Qsxzjwh4CAZaPC+6dD54pUN1EqI1y98dNlWUtHIj3h/4
         Splsf3IXqlcizsoo+REF5NJSW85edH0/M3bA/qHP7mfxijxAtDoowdEJipI1hi0Nb75n
         Ng/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=H0PQ6nyLYrfffzbRL92Wcmyqh/B5owqtAHhzB8+J5mM=;
        b=A/7+Ye/D6+v5K9L5GE35RuYGFPWVGhVkv2bV2ekez/PIM1uW5nb5AO/tWft+skRosi
         XSaf7EzDuLJJLn9IpUHr3yc4eX3fI9rNh7JckJrBWo3S6KW6z9LbvUsUqoHE2HJ/Wjbu
         ca0fGojfTvuD4U4fci1UNKdiNbKzxUR/DiGVXF6sDzPabQzpOBOEOUNnd2LgH+v2f89w
         26vwZ1TNJ2Imi9DAG90TIWf5oPE/4uma7S4TKy5u/jA8QsCuqP5iTXFiZYydowf9m3pM
         5xK6H5hUChLfYU3qMhE0n3y5wYdQf4mP7ALiKyeC4Xpo4pZjt9T0MiNo4j0ynn9zPGyS
         fkDg==
X-Gm-Message-State: AOAM531hDv58nn/W9OgXa2BulbJm2QnIQTFsEAWzI511/0fqq7ekQFlU
        MwEAy2FPJyjzLPZhyH/QA2c=
X-Google-Smtp-Source: ABdhPJyrw67HyLeeROH8ErKI8NEgL0YMxtjGYRNFy5TuUE5m/WkUtUwyhFHei5Fji+8zhX1Cn0ivgQ==
X-Received: by 2002:a05:620a:b13:: with SMTP id t19mr15341378qkg.3.1604959821374;
        Mon, 09 Nov 2020 14:10:21 -0800 (PST)
Received: from [192.168.1.201] (pool-108-51-35-162.washdc.fios.verizon.net. [108.51.35.162])
        by smtp.googlemail.com with ESMTPSA id o4sm6593550qti.97.2020.11.09.14.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 14:10:20 -0800 (PST)
Subject: Re: [PATCH 15/32] dt-bindings: Define Kendryte K210 sysctl registers
To:     Rob Herring <robh@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-16-damien.lemoal@wdc.com>
 <20201109215913.GA1828781@bogus>
From:   Sean Anderson <seanga2@gmail.com>
Autocrypt: addr=seanga2@gmail.com; prefer-encrypt=mutual; keydata=
 mQENBFe74PkBCACoLC5Zq2gwrDcCkr+EPGsT14bsxrW07GiYzQhLCgwnPdEpgU95pXltbFhw
 46GfyffABWxHKO2x+3L1S6ZxC5AiKbYXo7lpnTBYjamPWYouz+VJEVjUx9aaSEByBah5kX6a
 lKFZWNbXLAJh+dE1HFaMi3TQXXaInaREc+aO1F7fCa2zNE75ja+6ah8L4TPRFZ2HKQzve0/Y
 GXtoRw97qmnm3U36vKWT/m2AiLF619F4T1mHvlfjyd9hrVwjH5h/2rFyroXVXBZHGA9Aj8eN
 F2si35dWSZlIwXkNu9bXp0/pIu6FD0bI+BEkD5S7aH1G1iAcMFi5Qq2RNa041DfQSDDHABEB
 AAG0K1NlYW4gR2FsbGFnaGVyIEFuZGVyc29uIDxzZWFuZ2EyQGdtYWlsLmNvbT6JAVcEEwEK
 AEECGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4ACGQEWIQSQYR1bzo1I0gPoYCg+6I/stKEQ
 bgUCXT+S2AUJB2TlXwAKCRA+6I/stKEQbhNOB/9ooea0hU9Sgh7PBloU6CgaC5mlqPLB7NTp
 +JkB+nh3Fqhk+qLZwzEynnuDLl6ESpVHIc0Ym1lyF4gT3DsrlGT1h0Gzw7vUwd1+ZfN0CuIx
 Rn861U/dAUjvbtN5kMBqOI4/5ea+0r7MACcIVnKF/wMXBD8eypHsorT2sJTzwZ6DRCNP70C5
 N1ahpqqNmXe0uLdP0pu55JCqhrGw2SinkRMdWyhSxT56uNwIVHGhLTqH7Q4t1N6G1EH626qa
 SvIJsWlNpll6Y3AYLDw2/Spw/hqieS2PQ/Ky3rPZnvJt7/aSNYsKoFGX0yjkH67Uq8Lx0k1L
 w8jpXnbEPQN3A2ZJCbeM
Message-ID: <9e0bf865-99ff-3ca4-c693-34fb3d155c80@gmail.com>
Date:   Mon, 9 Nov 2020 17:10:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201109215913.GA1828781@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 11/9/20 4:59 PM, Rob Herring wrote:
> On Sat, Nov 07, 2020 at 05:14:03PM +0900, Damien Le Moal wrote:
>> Introduce the dt-bindings file include/dt-bindings/mfd/k210_sysctl.h to
>> define the offset of all registers of the K210 system controller.
> 
> We generally don't have defines for registers in DT.

At least K210_SYSCTL_SOFT_RESET is necessary for the syscon-reboot driver.

--Sean

> 
>>
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>> ---
>>  include/dt-bindings/mfd/k210-sysctl.h | 41 +++++++++++++++++++++++++++
>>  1 file changed, 41 insertions(+)
>>  create mode 100644 include/dt-bindings/mfd/k210-sysctl.h
>>
>> diff --git a/include/dt-bindings/mfd/k210-sysctl.h b/include/dt-bindings/mfd/k210-sysctl.h
>> new file mode 100644
>> index 000000000000..5cc386d3c9ca
>> --- /dev/null
>> +++ b/include/dt-bindings/mfd/k210-sysctl.h
>> @@ -0,0 +1,41 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/*
>> + * Copyright (C) 2020 Sean Anderson <seanga2@gmail.com>
>> + * Copyright (c) 2020 Western Digital Corporation or its affiliates.
>> + */
>> +#ifndef MFD_K210_SYSCTL_H
>> +#define MFD_K210_SYSCTL_H
>> +
>> +/*
>> + * Kendryte K210 SoC system controller registers offsets.
>> + * Taken from Kendryte SDK (kendryte-standalone-sdk).
>> + */
>> +#define K210_SYSCTL_GIT_ID	0x00 /* Git short commit id */
>> +#define K210_SYSCTL_UART_BAUD	0x04 /* Default UARTHS baud rate */
>> +#define K210_SYSCTL_PLL0	0x08 /* PLL0 controller */
>> +#define K210_SYSCTL_PLL1	0x0C /* PLL1 controller */
>> +#define K210_SYSCTL_PLL2	0x10 /* PLL2 controller */
>> +#define K210_SYSCTL_PLL_LOCK	0x18 /* PLL lock tester */
>> +#define K210_SYSCTL_ROM_ERROR	0x1C /* AXI ROM detector */
>> +#define K210_SYSCTL_SEL0	0x20 /* Clock select controller 0 */
>> +#define K210_SYSCTL_SEL1	0x24 /* Clock select controller 1 */
>> +#define K210_SYSCTL_EN_CENT	0x28 /* Central clock enable */
>> +#define K210_SYSCTL_EN_PERI	0x2C /* Peripheral clock enable */
>> +#define K210_SYSCTL_SOFT_RESET	0x30 /* Soft reset ctrl */
>> +#define K210_SYSCTL_PERI_RESET	0x34 /* Peripheral reset controller */
>> +#define K210_SYSCTL_THR0	0x38 /* Clock threshold controller 0 */
>> +#define K210_SYSCTL_THR1	0x3C /* Clock threshold controller 1 */
>> +#define K210_SYSCTL_THR2	0x40 /* Clock threshold controller 2 */
>> +#define K210_SYSCTL_THR3	0x44 /* Clock threshold controller 3 */
>> +#define K210_SYSCTL_THR4	0x48 /* Clock threshold controller 4 */
>> +#define K210_SYSCTL_THR5	0x4C /* Clock threshold controller 5 */
>> +#define K210_SYSCTL_THR6	0x50 /* Clock threshold controller 6 */
>> +#define K210_SYSCTL_MISC	0x54 /* Miscellaneous controller */
>> +#define K210_SYSCTL_PERI	0x58 /* Peripheral controller */
>> +#define K210_SYSCTL_SPI_SLEEP	0x5C /* SPI sleep controller */
>> +#define K210_SYSCTL_RESET_STAT	0x60 /* Reset source status */
>> +#define K210_SYSCTL_DMA_SEL0	0x64 /* DMA handshake selector 0 */
>> +#define K210_SYSCTL_DMA_SEL1	0x68 /* DMA handshake selector 1 */
>> +#define K210_SYSCTL_POWER_SEL	0x6C /* IO Power Mode Select controller */
>> +
>> +#endif /* MFD_K210_SYSCTL_H */
>> -- 
>> 2.28.0
>>


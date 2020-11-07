Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75DE2AA578
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 14:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgKGNi7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 08:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbgKGNi7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 08:38:59 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4BDC0613CF;
        Sat,  7 Nov 2020 05:38:59 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id n63so2832988qte.4;
        Sat, 07 Nov 2020 05:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mN57aF3uFwRKik5ZN1WZ9zgD6+iSPvQKkG2jBob0/z0=;
        b=L6tkULQ8G3ScoNOjbnTPIfkea8pDu9nEYT1Kc0JSpO/Ed9ioWMrlKrjdAwGpxsecMK
         mAQW80EpW6fU69D0iWnhUcesxXkgpfjvT4KfoIlsqb2W0XN24YMuAgRVfZUJMru3tqhR
         KX94LACPelo2ZX43b+A/AkapJ+rovZTsuDxz+zXsKzy+1i/bbXiTkMhOuiuhT9KyKTbT
         JBfytyG0zkaGupBpq81koZYCW6hNbmwf7shja3uUeCpQD7dft6WKVKanovpmmBRGXqvs
         AJi/NJLwXhItUj/icGDCffOcocLxgwrCnnRi+pdaC6uaT5ndfzVQ9SZdSMX8/8abE5mW
         hq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mN57aF3uFwRKik5ZN1WZ9zgD6+iSPvQKkG2jBob0/z0=;
        b=ozrGKlyVhtEy7kPu1CX9FUhAEa5iacXOuHn+A2bbbvuJuuEoBxlFqrnMIC38o+dWK6
         EUTSgs5dehAI4m6bxxpxtAvpBxC9ZFOP7zbh9dfWVpk8Xb5ViMAOgOLMfDEk61tN09II
         0PQfo6ExqjgB57Bx9J0ehSQRMXvCq4yuHiPd0IuDN+VOXZttkcT2MZZRhypz/8GQCm72
         PS/Va/MUhOnLtbRzDgAOvvqQqi9sedGNdfrIcrfpbSK6Y41bTscmHeHP/7hVjzzdNGUd
         AxyveiJAgYmOHIGcJjTXuyYvfSFnPkvRW/VYMv+8CVwMbhKcd+2qpLUqo+bkqzikHkSH
         VyBg==
X-Gm-Message-State: AOAM531ppK5keqOWiyE7N1Prr2zxMQQ0d26H7yU2Zl5dS3iMACyoNKOW
        qKonPUY/YFMpKH7ZB9M3Q5g=
X-Google-Smtp-Source: ABdhPJyIp/972JuRNtCAX5kxeFqzif/DydCJUgMtgNi+VPFMt5+yf/OzzVRlPd5tDeGRlxNvkxENJQ==
X-Received: by 2002:ac8:6b06:: with SMTP id w6mr5912684qts.6.1604756338588;
        Sat, 07 Nov 2020 05:38:58 -0800 (PST)
Received: from [192.168.1.201] (pool-108-51-35-162.washdc.fios.verizon.net. [108.51.35.162])
        by smtp.googlemail.com with ESMTPSA id o19sm2566333qko.3.2020.11.07.05.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2020 05:38:58 -0800 (PST)
Subject: Re: [PATCH 17/32] dt-bindings: Define Kendryte K210 reset signals
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-18-damien.lemoal@wdc.com>
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
Message-ID: <c1d4e336-2f18-1c06-bfe8-feac9838532e@gmail.com>
Date:   Sat, 7 Nov 2020 08:38:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201107081420.60325-18-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 11/7/20 3:14 AM, Damien Le Moal wrote:
> Introduce the dt-bindings file include/dt-bindings/reset/k210_sysctl.h
> to define IDs for all 30 reset signals available on the Kendryte K210
> RISC-V SoC.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  include/dt-bindings/reset/k210-rst.h | 42 ++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 include/dt-bindings/reset/k210-rst.h
> 
> diff --git a/include/dt-bindings/reset/k210-rst.h b/include/dt-bindings/reset/k210-rst.h
> new file mode 100644
> index 000000000000..883c1aed50e8
> --- /dev/null
> +++ b/include/dt-bindings/reset/k210-rst.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2019 Sean Anderson <seanga2@gmail.com>
> + * Copyright (c) 2020 Western Digital Corporation or its affiliates.
> + */
> +#ifndef RESET_K210_SYSCTL_H
> +#define RESET_K210_SYSCTL_H
> +
> +/*
> + * Kendryte K210 SoC system controller K210_SYSCTL_SOFT_RESET register bits.
> + * Taken from Kendryte SDK (kendryte-standalone-sdk).
> + */
> +#define K210_RST_ROM	0
> +#define K210_RST_DMA	1
> +#define K210_RST_AI	2
> +#define K210_RST_DVP	3
> +#define K210_RST_FFT	4
> +#define K210_RST_GPIO	5
> +#define K210_RST_SPI0	6
> +#define K210_RST_SPI1	7
> +#define K210_RST_SPI2	8
> +#define K210_RST_SPI3	9
> +#define K210_RST_I2S0	10
> +#define K210_RST_I2S1	11
> +#define K210_RST_I2S2	12
> +#define K210_RST_I2C0	13
> +#define K210_RST_I2C1	14
> +#define K210_RST_I2C2	15
> +#define K210_RST_UART1	16
> +#define K210_RST_UART2	17
> +#define K210_RST_UART3	18
> +#define K210_RST_AES	19
> +#define K210_RST_FPIOA	20
> +#define K210_RST_TIMER0	21
> +#define K210_RST_TIMER1	22
> +#define K210_RST_TIMER2	23
> +#define K210_RST_WDT0	24
> +#define K210_RST_WDT1	25
> +#define K210_RST_SHA	26
> +#define K210_RST_RTC	29
> +
> +#endif /* RESET_K210_SYSCTL_H */
> 

Reviewed-by: Sean Anderson <seanga2@gmail.com>

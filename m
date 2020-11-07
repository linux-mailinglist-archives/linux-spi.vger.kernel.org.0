Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259392AA567
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 14:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgKGNeC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 08:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgKGNeC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 08:34:02 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E911C0613CF;
        Sat,  7 Nov 2020 05:34:02 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id k9so3762330qki.6;
        Sat, 07 Nov 2020 05:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cgygmZxcrPCaXUcxy5sWPsLyE59i3yYRAYjJcbg36cg=;
        b=P4ZZvfCj5FfPAh6P+CzmqyCBwg6kbvlcDf/0KQYIUFmcCoH96dUrKTT9dgPaa8nXr+
         QZuqlPuK6WemrdAczvusuEXIsqEROhVM2y10wIvvXxt1Rp+l1qjM/ASmi2AvNlByOXsW
         X1KY945fhjFilMlibsrAaEPpVwf4P3p4fQOR8yBeM6J2+oNZxdiuqrctY87LpW+8H98I
         wdoh5hu1AmpOIG0jv91TVqL01JvePdyuSoC1MI0LWKtsWN33orcp41VG0LpmCOibjAKF
         laErLeWQQ3UNyVHA5bEteRFTTWpm0CKnAoY3cZ+iHfvtYBz7pA0rKtGuTIc7YARaT2uT
         HpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cgygmZxcrPCaXUcxy5sWPsLyE59i3yYRAYjJcbg36cg=;
        b=U0J17RU7G5k6kvL+GhFGKq2h3RzuJma4cm7vH0mf1IXs275c3ConlruGx2c9FOgm1F
         fSLpZiOd/6KY5aTMbA4uB6x6KKgts++lSNT1tdyhLt/iM2svh715nMc9t1IGHL4s/NSg
         r5fsuouCw3yvMGH4zZX24xgQwf3YoYAm69SRFHXwZMU8snWZHpUBAyBojqiTM+j9qSDn
         L0NC8iVpxCjFKPhVFiKMZgHO+/7Fq1gxa2q84ds7t0bTLTgeb+cO32F36LIsKMWOlXfO
         bVQCAgo673J6zBfqXwGaWQZP52COc/bBKqAR8yqbBhGn+9a31iF64d+fur42CiQaMcdS
         dArQ==
X-Gm-Message-State: AOAM5305wFDOX4dM/ymYNQrs2JCTGWMCgNrt2ioUAxbqN9p5fax31yT5
        4omSXZdagQczd+BVOjgDDXY=
X-Google-Smtp-Source: ABdhPJwWwStW9USc+7zEAiO3Ay8nV6LTJWVF1ojxBwaVaHGmQZV7m9sY6fFc75YFBHI4sY/TBgF16w==
X-Received: by 2002:a05:620a:1276:: with SMTP id b22mr552113qkl.256.1604756041288;
        Sat, 07 Nov 2020 05:34:01 -0800 (PST)
Received: from [192.168.1.201] (pool-108-51-35-162.washdc.fios.verizon.net. [108.51.35.162])
        by smtp.googlemail.com with ESMTPSA id k11sm2480644qtu.45.2020.11.07.05.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2020 05:34:00 -0800 (PST)
Subject: Re: [PATCH 14/32] dt-bindings: Define all Kendryte K210 clock IDs
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
 <20201107081420.60325-15-damien.lemoal@wdc.com>
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
Message-ID: <af85a79d-547f-b948-440c-756456576706@gmail.com>
Date:   Sat, 7 Nov 2020 08:33:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201107081420.60325-15-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 11/7/20 3:14 AM, Damien Le Moal wrote:
> Define unique arbitrary IDs for all 44 clocks available on the Kendryte
> K210 RISC-V SoC in the header file include/dt-bindings/clock/k210-clk.h.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  include/dt-bindings/clock/k210-clk.h | 61 +++++++++++++++++++++++-----
>  1 file changed, 50 insertions(+), 11 deletions(-)
> 
> diff --git a/include/dt-bindings/clock/k210-clk.h b/include/dt-bindings/clock/k210-clk.h
> index 5a2fd64d1a49..8d7ab2f0737c 100644
> --- a/include/dt-bindings/clock/k210-clk.h
> +++ b/include/dt-bindings/clock/k210-clk.h
> @@ -3,18 +3,57 @@
>   * Copyright (C) 2019-20 Sean Anderson <seanga2@gmail.com>
>   * Copyright (c) 2020 Western Digital Corporation or its affiliates.
>   */
> -#ifndef K210_CLK_H
> -#define K210_CLK_H
> +#ifndef CLOCK_K210_CLK_H
> +#define CLOCK_K210_CLK_H
>  
>  /*
> - * Arbitrary identifiers for clocks.
> - * The structure is: in0 -> pll0 -> aclk -> cpu
> - *
> - * Since we use the hardware defaults for now, set all these to the same clock.
> + * Kendryte K210 SoC clock identifiers (arbitrary values).
>   */
> -#define K210_CLK_PLL0   0
> -#define K210_CLK_PLL1   0
> -#define K210_CLK_ACLK   0
> -#define K210_CLK_CPU    0
> +#define K210_CLK_IN0	0
> +#define K210_CLK_PLL0	1
> +#define K210_CLK_PLL1	2
> +#define K210_CLK_PLL2	3
> +#define K210_CLK_ACLK	4
> +#define K210_CLK_CPU	5
> +#define K210_CLK_CLINT	6
> +#define K210_CLK_DMA	7
> +#define K210_CLK_FFT	8
> +#define K210_CLK_SRAM0	9
> +#define K210_CLK_SRAM1	10
> +#define K210_CLK_ROM	11
> +#define K210_CLK_DVP	12
> +#define K210_CLK_APB0	13
> +#define K210_CLK_APB1	14
> +#define K210_CLK_APB2	15
> +#define K210_CLK_AI	16
> +#define K210_CLK_I2S0	17
> +#define K210_CLK_I2S1	18
> +#define K210_CLK_I2S2	19
> +#define K210_CLK_I2S0_M	20
> +#define K210_CLK_I2S1_M	21
> +#define K210_CLK_I2S2_M	22
> +#define K210_CLK_WDT0	23
> +#define K210_CLK_WDT1	24
> +#define K210_CLK_SPI0	25
> +#define K210_CLK_SPI1	26
> +#define K210_CLK_SPI2	27
> +#define K210_CLK_I2C0	28
> +#define K210_CLK_I2C1	29
> +#define K210_CLK_I2C2	30
> +#define K210_CLK_SPI3	31
> +#define K210_CLK_TIMER0	32
> +#define K210_CLK_TIMER1	33
> +#define K210_CLK_TIMER2	34
> +#define K210_CLK_GPIO	35
> +#define K210_CLK_UART1	36
> +#define K210_CLK_UART2	37
> +#define K210_CLK_UART3	38
> +#define K210_CLK_FPIOA	39
> +#define K210_CLK_SHA	40
> +#define K210_CLK_AES	41
> +#define K210_CLK_OTP	42
> +#define K210_CLK_RTC	43
>  
> -#endif /* K210_CLK_H */
> +#define K210_NUM_CLKS	44
> +
> +#endif /* CLOCK_K210_CLK_H */
> 

Reviewed-by: Sean Anderson <seanga2@gmail.com>

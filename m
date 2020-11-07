Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436002AA56A
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 14:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgKGNeU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 08:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgKGNeT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 08:34:19 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD330C0613CF;
        Sat,  7 Nov 2020 05:34:19 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id w5so1810262qvn.12;
        Sat, 07 Nov 2020 05:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=44ZrDKfH3x7ZWkU/9cqJtBpMieXFvYfttGTFzMae91Y=;
        b=OmorHa1pXiHiyQxGplOwQtnzxGiWgKgTCwHvH5vfY0F7IuYfik5JlUEyg4Zp+NGMBM
         sk68SwanQsEpg2n2OXw2114orITDj2nJ2JCf/LmRs6BydxxIuTFZCveOYG5Z39N96sL/
         at+bD+9lSBUQtl7/Czl6HTbh5X6T4LmvG7TCj+91U6m7PV4Lf7iNS6jzil/HPxJtHE9d
         UrpR/IuJPXZ4MowAP2QuFhpSnmIi2s76g355owIAd1pQ9pDdSDUL6c4DXBZYs7BC7ybI
         5X3cweZXxpwy3Xt/22LZJoboEsGnoDoVZ8gZEiSyyb8X86YcSqFK/cGqgr6WcXugPyDL
         khkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=44ZrDKfH3x7ZWkU/9cqJtBpMieXFvYfttGTFzMae91Y=;
        b=J3VqQ7bwn4F6T+3+K4zfonSrbXf+AfCY71nv6BkXiRH9Nvd9nSZ470l9A75QHUq3mF
         g7hNgrV80AKqQuJeeuo4BIxfsAfwdu9XMvXeeBfVw6J0iSD23lyt2H612c6+hKbqdjCe
         cGgn7kSOfg/dKyiH2CHrSOxULDzgSWfomDQSeU9R1P7B/qhpAEKHruzy+DslyKPQ/sHu
         tND/jf7m8xQS+WLre6/slAPN+yk0s1QH5zrB3jqBfAoA+BHcN+or6h6WbLv3zoXLmp6N
         NvjRLuDSSEsSc7cD5+wHXU2qMZuv9Ed3bCs8Og/JJ8u6EI8pdRG7tegDLPVnNeTITc7B
         8JEA==
X-Gm-Message-State: AOAM53194VPHXo8YiGRgBzFpIezTb+eaOcA5KNE1Nn+kOgnbU8j/ZjcD
        EQZwHTW9w3LbFm3s/cyC9ls=
X-Google-Smtp-Source: ABdhPJx4/Iu1kjdK7aNO5xPmFgJDKkeSY6ycB+bhid2xfRsbEvur41S7FP9EbPhN2X1JGHjYDjv9EQ==
X-Received: by 2002:a0c:fa50:: with SMTP id k16mr6129700qvo.41.1604756059104;
        Sat, 07 Nov 2020 05:34:19 -0800 (PST)
Received: from [192.168.1.201] (pool-108-51-35-162.washdc.fios.verizon.net. [108.51.35.162])
        by smtp.googlemail.com with ESMTPSA id z2sm2588780qkg.76.2020.11.07.05.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2020 05:34:18 -0800 (PST)
Subject: Re: [PATCH 15/32] dt-bindings: Define Kendryte K210 sysctl registers
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
 <20201107081420.60325-16-damien.lemoal@wdc.com>
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
Message-ID: <7d8a869c-df9e-7a26-4049-8de543dabe33@gmail.com>
Date:   Sat, 7 Nov 2020 08:34:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201107081420.60325-16-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 11/7/20 3:14 AM, Damien Le Moal wrote:
> Introduce the dt-bindings file include/dt-bindings/mfd/k210_sysctl.h to
> define the offset of all registers of the K210 system controller.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  include/dt-bindings/mfd/k210-sysctl.h | 41 +++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 include/dt-bindings/mfd/k210-sysctl.h
> 
> diff --git a/include/dt-bindings/mfd/k210-sysctl.h b/include/dt-bindings/mfd/k210-sysctl.h
> new file mode 100644
> index 000000000000..5cc386d3c9ca
> --- /dev/null
> +++ b/include/dt-bindings/mfd/k210-sysctl.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2020 Sean Anderson <seanga2@gmail.com>
> + * Copyright (c) 2020 Western Digital Corporation or its affiliates.
> + */
> +#ifndef MFD_K210_SYSCTL_H
> +#define MFD_K210_SYSCTL_H
> +
> +/*
> + * Kendryte K210 SoC system controller registers offsets.
> + * Taken from Kendryte SDK (kendryte-standalone-sdk).
> + */
> +#define K210_SYSCTL_GIT_ID	0x00 /* Git short commit id */
> +#define K210_SYSCTL_UART_BAUD	0x04 /* Default UARTHS baud rate */
> +#define K210_SYSCTL_PLL0	0x08 /* PLL0 controller */
> +#define K210_SYSCTL_PLL1	0x0C /* PLL1 controller */
> +#define K210_SYSCTL_PLL2	0x10 /* PLL2 controller */
> +#define K210_SYSCTL_PLL_LOCK	0x18 /* PLL lock tester */
> +#define K210_SYSCTL_ROM_ERROR	0x1C /* AXI ROM detector */
> +#define K210_SYSCTL_SEL0	0x20 /* Clock select controller 0 */
> +#define K210_SYSCTL_SEL1	0x24 /* Clock select controller 1 */
> +#define K210_SYSCTL_EN_CENT	0x28 /* Central clock enable */
> +#define K210_SYSCTL_EN_PERI	0x2C /* Peripheral clock enable */
> +#define K210_SYSCTL_SOFT_RESET	0x30 /* Soft reset ctrl */
> +#define K210_SYSCTL_PERI_RESET	0x34 /* Peripheral reset controller */
> +#define K210_SYSCTL_THR0	0x38 /* Clock threshold controller 0 */
> +#define K210_SYSCTL_THR1	0x3C /* Clock threshold controller 1 */
> +#define K210_SYSCTL_THR2	0x40 /* Clock threshold controller 2 */
> +#define K210_SYSCTL_THR3	0x44 /* Clock threshold controller 3 */
> +#define K210_SYSCTL_THR4	0x48 /* Clock threshold controller 4 */
> +#define K210_SYSCTL_THR5	0x4C /* Clock threshold controller 5 */
> +#define K210_SYSCTL_THR6	0x50 /* Clock threshold controller 6 */
> +#define K210_SYSCTL_MISC	0x54 /* Miscellaneous controller */
> +#define K210_SYSCTL_PERI	0x58 /* Peripheral controller */
> +#define K210_SYSCTL_SPI_SLEEP	0x5C /* SPI sleep controller */
> +#define K210_SYSCTL_RESET_STAT	0x60 /* Reset source status */
> +#define K210_SYSCTL_DMA_SEL0	0x64 /* DMA handshake selector 0 */
> +#define K210_SYSCTL_DMA_SEL1	0x68 /* DMA handshake selector 1 */
> +#define K210_SYSCTL_POWER_SEL	0x6C /* IO Power Mode Select controller */
> +
> +#endif /* MFD_K210_SYSCTL_H */
> 

Reviewed-by: Sean Anderson <seanga2@gmail.com>

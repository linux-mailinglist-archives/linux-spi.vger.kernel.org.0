Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD45B2AA5B2
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 15:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgKGOFi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 09:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgKGOFh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 09:05:37 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7404C0613CF;
        Sat,  7 Nov 2020 06:05:37 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id g17so2872505qts.5;
        Sat, 07 Nov 2020 06:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=McXJiuNmRUheJhVyGIyG9agTCG5L6Hc8mLIxyaW+pVE=;
        b=YUP/px9gEY4c8O+NQMRkZ4cZtimjnECOSCIbFU6c1LnrsxcsEeQxudlczO5JWc5wjv
         vi/MqP8ODvvaGDLJsm1cHNklngPMWdwPO/QN7Evls2Fp0oiM9Xa1KoX6nHml4mJnvDGV
         Gq3M61JoIGFffjP3pM+wv15stx42ozauZJj917Wi6C6gG760bOEn/Vjb8eD1uPZocbPB
         JYdBpErBOs+ZCZyi14ZJdEySEAwOc8bNanNe4eUfC2i9MCDDMceDYMxVn0x/LYCd1zJY
         mQMErwg9jZpf6NzcBeFOliNf2DJ/k++5V+TqRaI4lklRS0Psw4MSx/Mm6mYW7vbUkpLK
         0R8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=McXJiuNmRUheJhVyGIyG9agTCG5L6Hc8mLIxyaW+pVE=;
        b=TqFtaGGI9RhP/dqtWDhtBybdGQjXz45Z8HVmcnu0BBw/aiREZgb3ZBxPNv3aSxJCFE
         hYxwIYvdc9fBczz3PNV4mgW8PTsB4FPDachX+Zz+cHnrSBuKLyDtGMpcJh18V/ThjZdB
         vKwOaEykh6i6tXs71zXeVM1yylG2y+CT9g2TvAr1dh96cKbzVLxxvJVBTypBoKCmQZqx
         3NRcz7vqfDdwiYlJiGw7m8/IC0rL+HozjKUCefDQgY/d1QHrXbEt19yKfDbXsY9fprb3
         Gy9Hq/7ZgAkN6eOefSPb/6mayJHdVdFN2oy3u4Nt0YbZv58v84OhEVWtJ207GOb7lLFO
         xkCw==
X-Gm-Message-State: AOAM533hvf9ujThCMPuSB7RmDkU3e7iWag4IbcSn+WRUIQEMMTTsh66f
        eBlBlKEQeJBBHqxdR4jkzDg=
X-Google-Smtp-Source: ABdhPJw5cPadKcMUxFjLnpLviksgG6dYE2tSnVCVynuORVSPyIO6ZyqXoUq2dMzp3h8O/fOwe4V20Q==
X-Received: by 2002:ac8:6b92:: with SMTP id z18mr5873972qts.30.1604757937017;
        Sat, 07 Nov 2020 06:05:37 -0800 (PST)
Received: from [192.168.1.201] (pool-108-51-35-162.washdc.fios.verizon.net. [108.51.35.162])
        by smtp.googlemail.com with ESMTPSA id g9sm2424379qti.86.2020.11.07.06.05.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2020 06:05:36 -0800 (PST)
Subject: Re: [PATCH 23/32] dt-binding: Document kendryte,k210-clk bindings
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
 <20201107081420.60325-24-damien.lemoal@wdc.com>
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
Message-ID: <14940525-40a7-b4fb-0837-853e1236e023@gmail.com>
Date:   Sat, 7 Nov 2020 09:05:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201107081420.60325-24-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 11/7/20 3:14 AM, Damien Le Moal wrote:
> Document the device tree bindings of the Kendryte K210 SoC clock driver
> in Documentation/devicetree/bindings/clock/kendryte,k210-clk.yaml.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  .../bindings/clock/kendryte,k210-clk.yaml     | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/kendryte,k210-clk.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/kendryte,k210-clk.yaml b/Documentation/devicetree/bindings/clock/kendryte,k210-clk.yaml
> new file mode 100644
> index 000000000000..02f5f8a86bc8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/kendryte,k210-clk.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/kendryte,k210-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Kendryte K210 Clock Device Tree Bindings
> +
> +maintainers:
> +  - Damien Le Moal <damien.lemoal@wdc.com>
> +
> +description: |
> +  Kendryte K210 clock controller driver which support the system controller
> +  subsystem supplied clocks for the various controllers and peripherals within
> +  the SoC.
> +
> +  See also:
> +  - dt-bindings/clock/k210-clk.h
> +
> +properties:
> +  compatible:
> +    const: kendryte,k210-clk
> +
> +  clocks:
> +    maxItems: 1
> +    description: System fixed rate oscillator clock
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - '#clock-cells'
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/k210-clk.h>
> +
> +    clocks {
> +      in0: oscillator {
> +        compatible = "fixed-clock";
> +        #clock-cells = <0>;
> +        clock-frequency = <26000000>;
> +      };
> +    };
> +
> +    soc {
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      /* ... */
> +
> +      sysctl: system-controller@50440000 {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        compatible = "kendryte,k210-sysctl",
> +                     "syscon", "simple-mfd";
> +        reg = <0x50440000 0x1000>;
> +        /* ... */
> +        sysclk: clock-controller {
> +          #clock-cells = <1>;
> +          compatible = "kendryte,k210-clk";
> +          clocks = <&in0>;
> +        };
> +        /* ... */
> +      };
> +    };
> +
> 

Reviewed-by: Sean Anderson <seanga2@gmail.com>

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400D62AA5BB
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 15:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgKGOHI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 09:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgKGOHI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 09:07:08 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F355CC0613CF;
        Sat,  7 Nov 2020 06:07:07 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id i17so1837666qvp.11;
        Sat, 07 Nov 2020 06:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zKB3lPGWxBL2tP2yoSCPfZH1/fL4oEaD+x4JT1cAitc=;
        b=GvbE4rS6hdLnccBvenC6mkNNZyeG9nPJPltPAGuQiVCBNDeAoTxt6nnVHK/NRq6+f2
         2Zi422zgUgcHnk8gchYtUyY4qdfyKB76d0jbmCMTiAIksEreGl4iJbne2D+NQk5RNW0r
         7MZxLiHYSyYowe/QEApVF6qxwm43arfPX/Ici/jEWfrRjIrADSgqyRgq77WUojUdSziT
         FzFyYII5XBKrpSi9TlulQPPJJp97mxSGhIuH3nWrwvKvvzQzAETyTy0Sll3T/1kFB0eo
         dTrCSJEiJchZsmPkCOcNNAeFegu51eSuYxOc+plhvysGgfLsG4jumomc818tszgAi6/z
         a3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zKB3lPGWxBL2tP2yoSCPfZH1/fL4oEaD+x4JT1cAitc=;
        b=CJ05r9fx2m2PNMY2eotujvLnGryh3Y+2WwhSXIERhSKHQfOnh4sKnqb4HLafJeqBYa
         GjJw0NdQSfHq3dl66Hln9yOQTwb4Wd16p7k58yRhxN93oCSEp4NKZe+fQSo/jMO9ZHxb
         XZkaqrd56XeO4QSZVfoeLc2AZmpDqBfL8cAy0pRA2ewSpxZdYpKI+7mXMy54LN6/p6J2
         51ZERChMrcl57LGrdoxOVx+lvprnKZ4PVrjD4Dhy7733eUjs4RW1pFlrq5T9Ujv/nmWI
         jKC2qLK3YLKahJZYEapITgBNYRr5HtddO3E4R5Wx8kDszoZQp5cEbBTnJD7r+tSro6d2
         zLyA==
X-Gm-Message-State: AOAM531mths1vIJgWrmhdMIvWqMfDaNErtWnVn+s5bsnJU9wp9jNdbsh
        oV6ggM9QJu4plqb5Nd36biY=
X-Google-Smtp-Source: ABdhPJx4ic66oyZsOa3eGQaRgTAbe1052WlMHm2rDsfiwbC/4I2NWKXpxlJXNQQtpT9yE9uEzU4Xpw==
X-Received: by 2002:a05:6214:174f:: with SMTP id dc15mr6062408qvb.26.1604758027246;
        Sat, 07 Nov 2020 06:07:07 -0800 (PST)
Received: from [192.168.1.201] (pool-108-51-35-162.washdc.fios.verizon.net. [108.51.35.162])
        by smtp.googlemail.com with ESMTPSA id 8sm2669070qkb.98.2020.11.07.06.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2020 06:07:06 -0800 (PST)
Subject: Re: [PATCH 25/32] dt-bindings: Document kendryte,k210-rst bindings
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
 <20201107081420.60325-26-damien.lemoal@wdc.com>
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
Message-ID: <b37c9b72-dc96-6ae9-a94e-457a96a1809c@gmail.com>
Date:   Sat, 7 Nov 2020 09:07:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201107081420.60325-26-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 11/7/20 3:14 AM, Damien Le Moal wrote:
> Document the device tree bindings for the Kendryte K210 SoC reset
> controller driver in
> Documentation/devicetree/bindings/reset/kendryte,k210-rst.yaml.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  .../bindings/reset/kendryte,k210-rst.yaml     | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/kendryte,k210-rst.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reset/kendryte,k210-rst.yaml b/Documentation/devicetree/bindings/reset/kendryte,k210-rst.yaml
> new file mode 100644
> index 000000000000..bdd0bf37bdfb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/kendryte,k210-rst.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/kendryte,k210-rst.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Kendryte K210 Reset Controller Device Tree Bindings
> +
> +maintainers:
> +  - Damien Le Moal <damien.lemoal@wdc.com>
> +
> +description: |
> +  Kendryte K210 reset controller driver which support the system controller
> +  subsystem supplied reset registers for the various peripherals within
> +  the SoC.
> +
> +  See also:
> +  - dt-bindings/reset/k210-rst.h
> +
> +properties:
> +  compatible:
> +    allOf:
> +      - items:
> +        - const: kendryte,k210-rst
> +        - const: syscon-reset
> +
> +  regmap:
> +    maxItems: 1
> +    description: phandle of the system controller (sysctl) node
> +
> +  offset:
> +    maxItems: 1
> +    description: peripheral reset register offset in the system controller
> +      controller register map
> +
> +  mask:
> +    maxItems: 1
> +    description: bit-mask indicating valid reset bits in the reset register
> +
> +  assert-high:
> +    maxItems: 1
> +    description: bit value to write when asserting a reset
> +
> +  '#reset-cells':
> +    const: 1
> +
> +required:
> +  - '#reset-cells'
> +  - compatible
> +  - regmap
> +  - offset
> +  - mask
> +  - assert-high
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/mfd/k210-sysctl.h>
> +    #include <dt-bindings/reset/k210-rst.h>
> +
> +    sysctl: system-controller@50440000 {
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      compatible = "kendryte,k210-sysctl",
> +                   "syscon", "simple-mfd";
> +      reg = <0x50440000 0x1000>;
> +      /* ... */
> +      sysrst: reset-controller {
> +        compatible = "kendryte,k210-rst",
> +                      "syscon-reset";
> +        #reset-cells = <1>;
> +        regmap = <&sysctl>;
> +        offset = <K210_SYSCTL_PERI_RESET>;
> +        mask = <0x27FFFFFF>;
> +        assert-high = <1>;
> +      };
> +    };
> 

Reviewed-by: Sean Anderson <seanga2@gmail.com>

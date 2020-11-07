Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B1B2AA5B9
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 15:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgKGOGz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 09:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgKGOGz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 09:06:55 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6F2C0613CF;
        Sat,  7 Nov 2020 06:06:53 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id e5so143999qvs.1;
        Sat, 07 Nov 2020 06:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y91JaQF/1kETwdGUyyWD+92BX5/w6nl9g0qOOaKrv4o=;
        b=DPtMBh5USsAkdJ4UT0WA8B7dgWYV3Eb0+NQ83SkAv18daezc9BGw1kjFy0gYppbjOw
         mkFAEDjgsE3Zn+dc/YRxdDlSR8WbbbnUxFYV0uEN7Euvat23gLBBV3K/EZzjARXqCMeW
         9M4NUPDSK/U++GdfprZVEsON23XD05DQzqCLNIZmwKJLXYZwCgKAnf3UKsvhu5gWHFt5
         wXAJsnRvHnyosA7urqf77G7wPHJxh3RsizFNUJIimUpb0Xfs2WXvburmVLF7mKCd/pWB
         ycRSMX/mcDVzE9236k00UQ5Yzy+y5aJIUFptBidCndPLWnJRF3rXer+mwWqxUB0B7Sdq
         Ol0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y91JaQF/1kETwdGUyyWD+92BX5/w6nl9g0qOOaKrv4o=;
        b=jTq9MO347eyYB/5kQVjFWmhSA8IB4IG4Mzg/7pDAexTDwGLkyu/jXGuoOSbJe1V7du
         vI2kYkcVzuxwxiERT1BG63kYnQmp/ksnPN3K5ctH/v8+ZgV4XlhYVp/3SMTe2jr308Y+
         EQwNKzZWHbWRO40pLrtsIHnp6tnSVzq6pz5WGNes8QjDM27T7YedMtGr+EyQtj7gemYS
         hCd5gCS2tFvWqXkuxStXXgVgjZqU7uCGNnQBvm+/wSb+G4Ad8D0G7eCSjbnKKdY6d70W
         oVlMom6soaye+kDXVcrmbEwk2B/mArvAWN61cZdR5YgEGLM/8HZL2kOiKcWPtkyBk8VG
         sAow==
X-Gm-Message-State: AOAM531wPiBw928TLrWxqOQu2SKoLnx8ADU7nDYPymfn2WANTqHJ5le1
        /PLBWIa0PQ1IE9oIocTDsww=
X-Google-Smtp-Source: ABdhPJy/8LlBNEyFw668t0iz4qhwviq1iivffqIkYwBoBD1i0JdYLjzPcsMhxiBb07qf/7gcsvmVZw==
X-Received: by 2002:a0c:d6cb:: with SMTP id l11mr6191774qvi.9.1604758012724;
        Sat, 07 Nov 2020 06:06:52 -0800 (PST)
Received: from [192.168.1.201] (pool-108-51-35-162.washdc.fios.verizon.net. [108.51.35.162])
        by smtp.googlemail.com with ESMTPSA id t184sm2559968qka.19.2020.11.07.06.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2020 06:06:52 -0800 (PST)
Subject: Re: [PATCH 24/32] dt-bindings: Document kendryte,k210-fpioa bindings
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
 <20201107081420.60325-25-damien.lemoal@wdc.com>
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
Message-ID: <62d01a24-4395-ce58-dea9-2241180c17ce@gmail.com>
Date:   Sat, 7 Nov 2020 09:06:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201107081420.60325-25-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 11/7/20 3:14 AM, Damien Le Moal wrote:
> Document the device tree bindings for the Kendryte K210 SoC Fully
> Programmable IO Array (FPIOA) pinctrl driver in
> Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  .../bindings/pinctrl/kendryte,k210-fpioa.yaml | 106 ++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml b/Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml
> new file mode 100644
> index 000000000000..8730add88ee0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml
> @@ -0,0 +1,106 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/kendryte,k210-fpioa.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Kendryte K210 FPIOA (Fully Programmable IO Array) Device Tree Bindings
> +
> +maintainers:
> +  - Damien Le Moal <damien.lemoal@wdc.com>
> +
> +description:
> +  The Kendryte K210 SoC Fully Programmable IO Array controller allows assiging
> +  any of 256 possible functions to any of 48 IO pins. Pin function configuration
> +  is performed on a per-pin basis.
> +
> +properties:
> +  compatible:
> +    const: kendryte,k210-fpioa
> +
> +  reg:
> +    description: FPIOA controller register space base address and size
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 2
> +    items:
> +      - description: Controller reference clock source
> +      - description: APB interface clock source
> +
> +  clock-names:
> +    minItems: 2
> +    maxItems: 2
> +    items:
> +      - const: ref
> +      - const: pclk
> +
> +  resets:
> +    maxItems: 1
> +
> +  kendryte,sysctl:
> +    minItems: 1
> +    maxItems: 1
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: |
> +      phandle to the system controller node
> +
> +  kendryte,power-offset:
> +    minItems: 1
> +    maxItems: 1
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Offset of the power domain control register of the system controller.
> +      The value should be the macro K210_SYSCTL_POWER_SEL defined in
> +      dt-bindings/mfd/k210-sysctl.h.
> +
> +patternProperties:
> +  '^.*$':
> +    if:
> +      type: object
> +    then:
> +      patternProperties:
> +        "^pinmux$":
> +          $ref: /schemas/pinctrl/pincfg-node.yaml
> +          description:
> +            An array of IO pins alternate functions. The values for each
> +            IO pin is a combination of an IO pin number (0 to 47) with the
> +            desired function for the IO pin. Functions are defined as macros in
> +            dt-bindings/pinctrl/k210-pinctrl.h. The K210_FPIOA(IO pin, function)
> +            is provided to facilitate the combination of IO pin numbers and
> +            functions.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets
> +  - kendryte,sysctl
> +  - kendryte,power-offset
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/pinctrl/k210-pinctrl.h>
> +    #include <dt-bindings/mfd/k210-sysctl.h>
> +    #include <dt-bindings/clock/k210-sysctl.h>
> +    #include <dt-bindings/reset/k210-sysctl.h>
> +
> +    fpioa: pinmux@502B0000 {
> +      compatible = "kendryte,k210-fpioa";
> +      reg = <0x502B0000 0x100>;
> +      clocks = <&sysclk K210_CLK_FPIOA>;
> +      resets = <&sysrst K210_RST_FPIOA>;
> +      kendryte,sysctl = <&sysctl>;
> +      kendryte,power-offset = <K210_SYSCTL_POWER_SEL>;
> +      pinctrl-0 = <&fpioa_jtag>;
> +      pinctrl-names = "default";
> +
> +      fpioa_jtag: jtag {
> +        pinmux = <K210_FPIOA(0, K210_PCF_JTAG_TCLK)>,
> +                 <K210_FPIOA(1, K210_PCF_JTAG_TDI)>,
> +                 <K210_FPIOA(2, K210_PCF_JTAG_TMS)>,
> +                 <K210_FPIOA(3, K210_PCF_JTAG_TDO)>;
> +      };
> +    };
> 

Reviewed-by: Sean Anderson <seanga2@gmail.com>

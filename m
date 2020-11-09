Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDD02AC02F
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 16:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbgKIPp4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 10:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729174AbgKIPpz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 10:45:55 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39A9C0613CF;
        Mon,  9 Nov 2020 07:45:55 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id d28so3196806qka.11;
        Mon, 09 Nov 2020 07:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t6Yf+sMEnysuGEtJE0jXIIPWFzhinCXEIJNIE/9Krlo=;
        b=nTRhYkXQPj6oCvt1hed4gVi7ed4AknoSL14YilIkiHoS+Wf9C+yczRy5PyOx+mFioK
         I4rXsr/TbC7Qx75VFlui34JHSK7J1OhBvjQJ1VZ42ha81oUTIjHb+OL1nGQpyATOTLuN
         oe+kHPjU3Mbv8Z6002FDOyypRqcCZVDLSv3nN9ETKSb4k/v1KQbTRwMLmVWj/cuPKoY+
         YJQBGE5sxRm2RKgT/I0deO2IPVnzw1lChvYCN44gfVfEgx/TCn7MY6Ofggpmm+GNszIh
         4FIAE6smy5yCip2R4FqbD6aMiFLFUaCoXVB5MAwU17UzxKYhEMfIVVxIvIANYk/kJRuf
         /Gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=t6Yf+sMEnysuGEtJE0jXIIPWFzhinCXEIJNIE/9Krlo=;
        b=LTzt4Sj+mfPAGExkTnR3j+PIfrM3pMAZdBuvLrJX6HMR4PGu/mkjpvQynav8qdhUPh
         5kNvesylVgB2+WSo/3MYA7DJ4+5BBfIIVHoeA8FfvbIAdEftF7sO+H0N5tCZYy900e2U
         Pea9TvCF3LubgWxR5MbIbSg+VxyDQW7HLewi2X4myWZgJo2uSIjoXMnQsthL+UlH0jUd
         YX/4GypmFxXwSfJg8ekEim5puU0+nDBi3UvxExJ4Q15Jghe61HNKaeMyN+Sy1b7a+wCL
         TtqMqzxHSJonCovkUBC0MAOhM63qG14tYaSgKOy3Le9+Bc0MiKRjG0EsOQ0keKZBNZtk
         iocA==
X-Gm-Message-State: AOAM531jkHofiWcDUb22GEXrwrUGTEO5JiJD+HMDf0Z0KbsQNBnDj36Q
        yUPN0eFuEFwPrZ+xd8HnGuk=
X-Google-Smtp-Source: ABdhPJxzTXnRRctFaCp0/SBDiD/D/14kREbi+rLR78C2+JEyF9IlirjH6mVXxOTjvltL7NJOyY92RA==
X-Received: by 2002:a37:d08:: with SMTP id 8mr6717554qkn.306.1604936754965;
        Mon, 09 Nov 2020 07:45:54 -0800 (PST)
Received: from [192.168.1.201] (pool-108-51-35-162.washdc.fios.verizon.net. [108.51.35.162])
        by smtp.googlemail.com with ESMTPSA id z1sm5854162qtz.46.2020.11.09.07.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 07:45:54 -0800 (PST)
Subject: Re: [PATCH 24/32] dt-bindings: Document kendryte,k210-fpioa bindings
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
 <20201107081420.60325-25-damien.lemoal@wdc.com>
 <20201109153625.GB1330401@bogus>
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
Message-ID: <04b266c7-bba9-d847-a526-f64f76c11a50@gmail.com>
Date:   Mon, 9 Nov 2020 10:45:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201109153625.GB1330401@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 11/9/20 10:36 AM, Rob Herring wrote:
> On Sat, Nov 07, 2020 at 05:14:12PM +0900, Damien Le Moal wrote:
>> Document the device tree bindings for the Kendryte K210 SoC Fully
>> Programmable IO Array (FPIOA) pinctrl driver in
>> Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml
>>
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>> ---
>>  .../bindings/pinctrl/kendryte,k210-fpioa.yaml | 106 ++++++++++++++++++
>>  1 file changed, 106 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml b/Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml
>> new file mode 100644
>> index 000000000000..8730add88ee0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml
>> @@ -0,0 +1,106 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pinctrl/kendryte,k210-fpioa.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Kendryte K210 FPIOA (Fully Programmable IO Array) Device Tree Bindings
>> +
>> +maintainers:
>> +  - Damien Le Moal <damien.lemoal@wdc.com>
>> +
>> +description:
>> +  The Kendryte K210 SoC Fully Programmable IO Array controller allows assiging
>> +  any of 256 possible functions to any of 48 IO pins. Pin function configuration
>> +  is performed on a per-pin basis.
>> +
>> +properties:
>> +  compatible:
>> +    const: kendryte,k210-fpioa
>> +
>> +  reg:
>> +    description: FPIOA controller register space base address and size
>> +
>> +  clocks:
>> +    minItems: 2
>> +    maxItems: 2
> 
> Can drop these. Implied by 'items' length.
> 
>> +    items:
>> +      - description: Controller reference clock source
>> +      - description: APB interface clock source
>> +
>> +  clock-names:
>> +    minItems: 2
>> +    maxItems: 2
>> +    items:
>> +      - const: ref
>> +      - const: pclk
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  kendryte,sysctl:
>> +    minItems: 1
>> +    maxItems: 1
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description: |
>> +      phandle to the system controller node
>> +
>> +  kendryte,power-offset:
>> +    minItems: 1
>> +    maxItems: 1
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Offset of the power domain control register of the system controller.
> 
> Sounds like you should be using power-domains binding.

This is for pin power domains. E.g. pins 0-5 can be set to 1V8 or 3V3 logic levels.

--Sean

> 
>> +      The value should be the macro K210_SYSCTL_POWER_SEL defined in
>> +      dt-bindings/mfd/k210-sysctl.h.
>> +
>> +patternProperties:
>> +  '^.*$':
>> +    if:
>> +      type: object
>> +    then:
> 
> This is a hack for existing bindings. Use '-pins$' for the node names.
> 
>> +      patternProperties:
>> +        "^pinmux$":
> 
> Not really a pattern.
> 
>> +          $ref: /schemas/pinctrl/pincfg-node.yaml
> 
> This is at the wrong level. Goes up 1 level.
> 
>> +          description:
>> +            An array of IO pins alternate functions. The values for each
>> +            IO pin is a combination of an IO pin number (0 to 47) with the
>> +            desired function for the IO pin. Functions are defined as macros in
>> +            dt-bindings/pinctrl/k210-pinctrl.h. The K210_FPIOA(IO pin, function)
>> +            is provided to facilitate the combination of IO pin numbers and
>> +            functions.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - resets
>> +  - kendryte,sysctl
>> +  - kendryte,power-offset
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/pinctrl/k210-pinctrl.h>
>> +    #include <dt-bindings/mfd/k210-sysctl.h>
>> +    #include <dt-bindings/clock/k210-sysctl.h>
>> +    #include <dt-bindings/reset/k210-sysctl.h>
>> +
>> +    fpioa: pinmux@502B0000 {
>> +      compatible = "kendryte,k210-fpioa";
>> +      reg = <0x502B0000 0x100>;
>> +      clocks = <&sysclk K210_CLK_FPIOA>;
>> +      resets = <&sysrst K210_RST_FPIOA>;
>> +      kendryte,sysctl = <&sysctl>;
>> +      kendryte,power-offset = <K210_SYSCTL_POWER_SEL>;
>> +      pinctrl-0 = <&fpioa_jtag>;
>> +      pinctrl-names = "default";
>> +
>> +      fpioa_jtag: jtag {
>> +        pinmux = <K210_FPIOA(0, K210_PCF_JTAG_TCLK)>,
>> +                 <K210_FPIOA(1, K210_PCF_JTAG_TDI)>,
>> +                 <K210_FPIOA(2, K210_PCF_JTAG_TMS)>,
>> +                 <K210_FPIOA(3, K210_PCF_JTAG_TDO)>;
>> +      };
>> +    };
>> -- 
>> 2.28.0
>>


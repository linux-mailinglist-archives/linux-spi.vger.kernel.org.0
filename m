Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE7B2AA5B0
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 15:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgKGOFH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 09:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgKGOFH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 09:05:07 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C162C0613CF;
        Sat,  7 Nov 2020 06:05:07 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id u4so1077537qkk.10;
        Sat, 07 Nov 2020 06:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CnitLoeMqyrA8E81YF2krwIxxHfJVb8lU/Wo+vPHi74=;
        b=qiToNamLXeSFmnaeLgat/1P0z2PJ1Kvlr4cDM10kLizi1Jm2L9ckOtf5tyy6128fge
         Tgq2uoCIgkj/ZPFLfu0vA4AZKcas4I/PU/nSytjDXnarZJYJ181x2472PreD48SJXXkm
         eMt3kMA/Wf27Pzow08AnWNs+cdneT6PWOHhsSACGtYTYDRDlNgmcO2aRZnjWLWjAvUzh
         eJPFjBQFOJP9pqC74YhNjkVXfhsYZ4pGREHyNNMaR6hDh7AphLfEiiDIiLOuoFc/ZIR2
         AmjbClzMUrCN54sjSERnW52vesYSmbvfZGKq//Vwo73ryEGGtM/m4nVhC+XXSGHzoCfJ
         YzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CnitLoeMqyrA8E81YF2krwIxxHfJVb8lU/Wo+vPHi74=;
        b=NxHhz/UdufVpX1T9cRt2C6CdBFA5ZLtGDXWGAjLAXA/MsjXmrr34GJQ5LQcyD8RHDF
         sVarKXnoiEONPZwztSAgZaSmTzh7MPhkZRJqYqTlYnyjEHfoIyYf6q61y0vq95K6/tw3
         g/FzgyAWc4IZv76AC0vcyJswLMRkDO5JHoQzaagR7Khhog6aULClDF0TRfcRc6LVMCbr
         Wcv4h4Gr3J0WxBzbD7opCqNP4Y2kP8KovXkvq1xcezkD8OlwHho4zn4TXU+UVoYB3cdh
         SwxDb0WtSL5pqk03X+ppyqvf5BjYJnSfha8hXgrc80PnCm4IohOZ+osnYb+s0bgiQkAT
         JK+g==
X-Gm-Message-State: AOAM532KYiEETcGFIyQbe7uJrawZ505F8Evx/Yb6xca1ltQkHwORy1R5
        z2NbQicT8J4KttZtTUyGadk=
X-Google-Smtp-Source: ABdhPJx/D0D439YZskPQ/Fb4kPHVFAE7Fs0zHkU1kTMKvkOs8RZgqIXlPyC4d5Nq5lEJV5LBxQ1ULw==
X-Received: by 2002:a37:78c:: with SMTP id 134mr6297005qkh.359.1604757906475;
        Sat, 07 Nov 2020 06:05:06 -0800 (PST)
Received: from [192.168.1.201] (pool-108-51-35-162.washdc.fios.verizon.net. [108.51.35.162])
        by smtp.googlemail.com with ESMTPSA id z20sm2522633qtb.31.2020.11.07.06.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2020 06:05:05 -0800 (PST)
Subject: Re: [PATCH 22/32] dt-binding: Document kendryte,k210-sysctl bindings
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
 <20201107081420.60325-23-damien.lemoal@wdc.com>
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
Message-ID: <a994bd33-22cb-d689-8f41-b8b3643be698@gmail.com>
Date:   Sat, 7 Nov 2020 09:05:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201107081420.60325-23-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 11/7/20 3:14 AM, Damien Le Moal wrote:
> Document the device tree bindings of the Kendryte K210 SoC system
> controller driver in
> Documentation/devicetree/bindings/mfd/kendryte,k210-sysctl.yaml.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  .../bindings/mfd/kendryte,k210-sysctl.yaml    | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/kendryte,k210-sysctl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/kendryte,k210-sysctl.yaml b/Documentation/devicetree/bindings/mfd/kendryte,k210-sysctl.yaml
> new file mode 100644
> index 000000000000..8c002d2078f4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/kendryte,k210-sysctl.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/kendryte,k210-sysctl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Kendryte K210 System Controller Device Tree Bindings
> +
> +maintainers:
> +  - Damien Le Moal <damien.lemoal@wdc.com>
> +
> +description: |
> +  Kendryte K210 system controller driver which provides a register map for
> +  clocks and peripherals within the SoC.
> +
> +  See also:
> +  - dt-bindings/mfd/kendryte,k210-sysctl.h
> +
> +properties:
> +  compatible:
> +    allOf:
> +      - items:
> +        - const: kendryte,k210-sysctl
> +        - const: syscon
> +        - const: simple-mfd
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 1
> +    items:
> +      - description: APB interface clock source
> +
> +  clock-names:
> +    minItems: 1
> +    items:
> +      - const: pclk
> +
> +  reg:
> +    items:
> +      - description: system controller register space base address and size
> +
> +  reg-io-width:
> +    const: 4
> +
> +required:
> +  - compatible
> +  - clocks
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/mfd/k210-sysctl.h>
> +
> +    sysctl: system-controller@50440000 {
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      compatible = "kendryte,k210-sysctl",
> +                   "syscon", "simple-mfd";
> +      reg = <0x50440000 0x1000>;
> +      reg-io-width = <4>;
> +      /* ... */
> +    };
> +
> 

Reviewed-by: Sean Anderson <seanga2@gmail.com>

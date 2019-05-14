Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0694D1D097
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2019 22:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfENU1y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 May 2019 16:27:54 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33569 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfENU1y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 May 2019 16:27:54 -0400
Received: by mail-lf1-f68.google.com with SMTP id x132so235870lfd.0
        for <linux-spi@vger.kernel.org>; Tue, 14 May 2019 13:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cg+0pIxncJfvTs4tSoXl4GsGWbTnN63dbKG4EXKdY5I=;
        b=uXDDy/8gSW0jEorXj4eEKaiOvkegZ9DkXL+itl4xCKsGvVnDxiqb9TOYJ7uZwxQQ6f
         Z5zwbihzNlRL5hNx0YodjSJ1b0ibJ1+pIOHph2tL5/Jw0hYNo0axkDGfyiAlW8tpFsf+
         Qiqpqp2Wq5e/kcKkbYo4NdSGqxA4Ajt8jDRBg1dlGf235oqdtzr9M52JXGW613NuIk6b
         lKvC63Gx6Scwn48rpDrpKQXCfc4Rv2+M/BQyi1KlwGKNNEXPgSC7s+vKIhLey+YZDOXi
         6c8QKUx6VHUS5BiVOs8NNBzxwigbKmDaRpAdHoMUpvqpzaNSH+7hBGLJb6z0J/Z0hq0v
         ul0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Cg+0pIxncJfvTs4tSoXl4GsGWbTnN63dbKG4EXKdY5I=;
        b=SJWt2MtyfAwMEZM6dXE9wEkUxvsHEHYFABMMdNM72AQ1Ow9Ku3qUL/TXACW+mmK1t9
         nfNkkuPafUScfSiHWTNQN1X5tWkj4eEHkLWOZhMr+Z1hazss6Glys5zhis5WVwRcbdDF
         hdC8hsB1ml5Mvc6DKnYgOnL6N2z/9QAsaQj8uIWEDIBnyDgtjL8YxBub3wVcaYQydlP6
         BECaUy+KlqIYllz2h2q7FQ+kjqxcCib3oVhSsgY5NWGuZ73HmBNFDBijFlSNZCJh1Cjo
         Av6fj430VNyL6KOv4IPqE/YPCAIQj7cWly68eW1eblL2p3044LGbiaE9TOj2tnWvCyFY
         f0Mw==
X-Gm-Message-State: APjAAAXNn+mjbRtFBmzOJeD2fXVYvcH44NihTZ20Ze1s8Ofs9g7nPn9o
        SZUJwnbLozdrnlOHk+OYvyPWvg==
X-Google-Smtp-Source: APXvYqzPxsM8974bIW7yAai/77T/30BrUMlizPu9DEpJloaDJRxl1lG+PYCPEmvieuPciMNeWkUmjw==
X-Received: by 2002:a05:6512:206:: with SMTP id a6mr18870241lfo.18.1557865672326;
        Tue, 14 May 2019 13:27:52 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.86.127])
        by smtp.gmail.com with ESMTPSA id x29sm3942315lfg.58.2019.05.14.13.27.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 13:27:51 -0700 (PDT)
Subject: Re: [PATCH v12 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF MFD bindings
To:     masonccyang@mxic.com.tw, Geert Uytterhoeven <geert@linux-m68k.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>, zhengxunli@mxic.com.tw
References: <1556092536-17095-1-git-send-email-masonccyang@mxic.com.tw>
 <1556092536-17095-4-git-send-email-masonccyang@mxic.com.tw>
 <20190424212356.GA27103@bogus>
 <65853dc2-6f3c-1494-7e72-54877797cdd2@gmail.com>
 <20190507125730.GD29524@dell>
 <OF08A5650B.8AE8977C-ON482583F4.000E5B1E-482583F4.000F7215@mxic.com.tw>
 <d229b19e-351c-c576-b5c4-716d10dad1a0@gmail.com> <20190508061119.GB7627@dell>
 <OFE86674B9.06D723A0-ON482583F5.000AD50C-482583F5.000BA075@mxic.com.tw>
 <a05cff8f-7df2-1938-c0e7-f9366bece607@cogentembedded.com>
 <OFB19BCE91.6EBBAA77-ON482583F6.000234E2-482583F6.00061290@mxic.com.tw>
 <CAMuHMdUP8KU3Dbv6cwOvrY0hWOcm1xqVcsi20+GvazYMDLGGZg@mail.gmail.com>
 <OFD932ABFC.E3FFCEB8-ON482583F9.003412B1-482583F9.0034D5CA@mxic.com.tw>
 <b51d1cb7-b3b5-208f-ab4c-145ecb57805d@cogentembedded.com>
 <OFAD9AA573.86373900-ON482583FA.0034781A-482583FA.0035B40C@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <44bc8f0a-cbdc-db4a-9a46-b8bae5cc37a2@cogentembedded.com>
Date:   Tue, 14 May 2019 23:27:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <OFAD9AA573.86373900-ON482583FA.0034781A-482583FA.0035B40C@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 05/14/2019 12:46 PM, masonccyang@mxic.com.tw wrote:

>>>> There's precedence for such constructs being an MFD: please see
>>>> drivers/mfd/at91-usart.c, which registers a single MFD cell for 
> either
>>>> serial or SPI.
>>
>>    Thanks fir your example, Geert! :-)

   s/fir/for/, not the firtree season anymore. :-)

>>> okay, many thanks for your information.
>>>
>>> How about to patch RPF-IF dts to:
>>> -------------------------------------------------------------->
>>>
>>> Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
>>> ---------------------------------------------------------
>>>
>>>   RPC-IF supports both SPI NOR and HyperFlash (CFI-compliant flash)
>>>
>>>   Required properties:
>>>   - compatible: should be an SoC-specific compatible value, followed 
> by
>>>                   "renesas,rcar-gen3-rpc" as a fallback.
>>>                   supported SoC-specific values are:
>>>                   "renesas,r8a77995-rpc"  (R-Car D3)
>>>   - reg: should contain three register areas:
>>>           first for the base address of RPC-IF registers,
>>
>>    I'd drop "the base address" here.
> 
> okay.
> 
>>>           second for the direct mapping read mode and
>>>           third for the write buffer area.
>>>   - reg-names: should contain "regs", "dirmap" and "wbuf"
>>>   - clocks: should contain 1 entries for the module's clock
>>>   - clock-names: should contain "rpc"
>>
>>    I suspect we'd need the RPC/RPCD2 clocks mentioned as well (not sure 
> yet)...
> 
> Need it ?

   You seem to call clk_get_rate() on the module clock, I doubt that's
correct topologically...

> RPCD2 is derived from RPC and it's value is half of RPC,
> i.e., RPC = 160MHz, RPCD2 = 80 MHz

   I know.

>>    And how about "power-domains", "resets" (seen in the example below),
>> also what about #address-cells & #size-cells?
>>
>>>
>>>   Example:
>>
>>    Could you please indent with 1 or 2 tabs where you used 8 or 16 
> spaces?
>>
>>>   - SPI mode:
>>>
>>>           rpc: rpc-if@ee200000 {
>>
>>    The node names should be generic, based on the device class. And in 
> this
>> case I'd like to use "spi@ee200000" as otherwise dtc keeps bitching like 
> below:
> 
> okay, patch to
> 
> rpc_if: spi@<...>

   That, or just keep the node label.

>> arch/arm64/boot/dts/renesas/r8a77980.dtsi:1344.21-1359.5: Warning 
> (spi_bus_bridge):
>> /soc/rpc@ee200000: node name for SPI buses should be 'spi'
>>   also defined at 
> arch/arm64/boot/dts/renesas/r8a77980-condor.dts:283.6-343.3
>> arch/arm64/boot/dts/renesas/r8a77980-condor.dtb: Warning (spi_bus_reg):
>> Failed prerequisite 'spi_bus_bridge'
>>
>>
>>>   - HF mode:
>>>           rpc: rpc-if@ee200000 {
>>
>>    Again, spi@<...>.
> 
> what about rpc_if: hf@<...>

   Can't change the node name, as it's declared in the .dtsi files, not *.dts
ones. And "spi" works for the HF case as well -- no complaints from dtc. :-)

>>>                   compatible = "renesas,r8a77995-rpc", 
> "renesas,rcar-gen3-rpc";
>>>                   reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 
> 0x4000000>,
>>>                         <0 0xee208000 0 0x100>;
>>>                   reg-names = "regs", "dirmap", "wbuf";
>>>                   clocks = <&cpg CPG_MOD 917>;
>>>                   clock-names = "rpc";
>>>                   power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
>>>                   resets = <&cpg 917>;
>>>                   #address-cells = <1>;
>>>                   #size-cells = <1>;
>>>
>>>                   flash@0 {
>>>                           compatible = "cfi-flash";
>>
>>    The working HF implementation has "cypress,hyperflash" before 
> "cfi-flash".
>>
>>>                           reg = <0 0x4000000>;
>>>                   };
>>>           };
>>>
>>> --------------------------------------------------------------<
>>>
>>> Is it OK ?
>>
>>    Yeah, seems good (assuming you fix the issues above).
> 
> Patch new DTS to
> ===============================================================> 
> 
> +Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
> +---------------------------------------------------------
> +
> +RPC-IF supports both SPI NOR and HyperFlash (CFI-compliant flash)
> +
> +Required properties:
> +- compatible: should be an SoC-specific compatible value, followed by
> +                                "renesas,rcar-gen3-rpc" as a fallback.
> +                                supported SoC-specific values are:
> +                                "renesas,r8a77995-rpc"          (R-Car 
> D3)
> +- reg: should contain three register areas:
> +                first for RPC-IF registers,
> +                second for the direct mapping read mode and
> +                third for the write buffer area.
> +- reg-names: should contain "regs", "dirmap" and "wbuf"
> +- clocks: should contain 1 entries for the module's clock
> +- clock-names: should contain "rpc"
> +- #address-cells: should be 1
> +- #size-cells: should be 0

   Still nothing about the "oower-domains" and "resets" props... :-(

> +
> +Example:
> +- SPI mode:
> +
> +                rpc_if: spi@ee200000 {
> +                                compatible = "renesas,r8a77995-rpc", 
> "renesas,rcar-gen3-rpc";
> +                                reg = <0 0xee200000 0 0x200>, <0 
> 0x08000000 0 0x4000000>,
> +                                      <0 0xee208000 0 0x100>;
> +                                reg-names = "regs", "dirmap", "wbuf";
> +                                clocks = <&cpg CPG_MOD 917>;
> +                                clock-names = "rpc";
> +                                power-domains = <&sysc 
> R8A77995_PD_ALWAYS_ON>;
> +                                resets = <&cpg 917>;
> +                                #address-cells = <1>;
> +                                #size-cells = <0>;
[...]
> =======================================================================<
> 
> OK ?

   Yes, with the remaining issue fixed.
 
> thanks & best regards,
> Mason

[...]

MBR, Sergei

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9163A1BD94
	for <lists+linux-spi@lfdr.de>; Mon, 13 May 2019 21:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfEMTIg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 May 2019 15:08:36 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34365 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbfEMTIf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 May 2019 15:08:35 -0400
Received: by mail-lj1-f194.google.com with SMTP id j24so11230334ljg.1
        for <linux-spi@vger.kernel.org>; Mon, 13 May 2019 12:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AcW/lh7CeNInQyC6auP2jdaJFlOhXKYi2ZP/KtFkZts=;
        b=WgMdtH5TRVKo3TPLzJI93onG5BpSAnfaMf0aWiZwByifMYtjsDgXoeyX+hv6C9hYNL
         QSeouWFZbff2rQbcsaKUaMEacdCxzeU4q2Oz3kuoZ/a7JA8URO9vJUj4CaloZREYiNS8
         0m1LeVGowMpWWseT2q0njY1TpJ9d2hIOWTnd8vQhJ/blMSAslMaah30a3u0Pg4LdUrwd
         HUVWQwp/3kcN8euIwuQnmPMxYkv7hHpHs+JrxQQ41lKSfpG5Kmjm0pitgNeTa3LwKgut
         OlFeQ6fawcNkf96eBVqjuQ/MGbm9KZRCuo2gzpNkqmP+oKwBkyBoPVYPYnVvELLwByFP
         plzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=AcW/lh7CeNInQyC6auP2jdaJFlOhXKYi2ZP/KtFkZts=;
        b=AF52VfKNHziDr6DwwZ26mfEog1v7GU3hjZ0I2b6gsYBjVZ3AlX/Bkvzoxz4rdzUgdu
         QV/vEYC2c44hiIoztw5zTDEjp96HlNaQvcBHqhKcvRn//aKYwhTuT418RGyz8hmh+8Sa
         r6MlCrRqnb/UsYP71tSK7BUn0jYU/w100w0S3iyWEhFImZQ3A+vliZiGLpVdnA4gznBF
         GZS9Ou6jBu8/O8UESpaFsjQK6EtgyTj75G8m+bPMhc7QB6NxbL3P/fASUX2Bm40v6n90
         boaUd+LWpIPz7XOt4WjkiviGn88iS3JQShRiX6xgCeATvYH0OWPZjn9EedAFpHNzASng
         tSfg==
X-Gm-Message-State: APjAAAXTaB+NXbq3L78fxi6tn8gPtvYCzLxdADP2rUCW0nUI6NDoH1+Q
        kNIovQspmTZY6QgZyqiMirBL1Q==
X-Google-Smtp-Source: APXvYqw9xW4fnm/BWpWFEYxohh6YEbXyKRx3kergymsyW8MgYKEWS2CmimBwq21dYeFL6lBOGKypsA==
X-Received: by 2002:a2e:9cd5:: with SMTP id g21mr9557098ljj.39.1557774512999;
        Mon, 13 May 2019 12:08:32 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.81.227])
        by smtp.gmail.com with ESMTPSA id s24sm3321380ljs.30.2019.05.13.12.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 12:08:31 -0700 (PDT)
Subject: Re: [PATCH v12 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF MFD bindings
To:     masonccyang@mxic.com.tw, Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Lee Jones <lee.jones@linaro.org>,
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
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <b51d1cb7-b3b5-208f-ab4c-145ecb57805d@cogentembedded.com>
Date:   Mon, 13 May 2019 22:08:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <OFD932ABFC.E3FFCEB8-ON482583F9.003412B1-482583F9.0034D5CA@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello!

On 05/13/2019 12:37 PM, masonccyang@mxic.com.tw wrote:

>> > > [...]
>> > > >> > >> > On 4/24/19 11:23 PM, Rob Herring wrote:
>> > > >> > >> > > On Wed, Apr 24, 2019 at 03:55:36PM +0800, Mason Yang wrote:
>> > > >> > >> > >> Document the bindings used by the Renesas R-Car
>> Gen3 RPC-IF MFD.
>> > > >> > >> > >>
>> > > >> > >> > >> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>> > > >> > >> > >> ---
>> > > >> > >> > >>  .../devicetree/bindings/mfd/mfd-renesas-rpc.txt  
>> | 40 ++++++
>> > > >> > >> ++++++++++++++++
>> > > >> > >> > >>  1 file changed, 40 insertions(+)
>> > > >> > >> > >>  create mode 100644 Documentation/devicetree/
>> bindings/mfd/mfd-
>> > > >> > >> renesas-rpc.txt
>> > > >> > >> > >>
>> > > >> > >> > >> diff --git a/Documentation/devicetree/bindings/mfd/
>> mfd-renesas-
>> > > >> > >> rpc.txt b/Documentation/devicetree/bindings/mfd/mfd-
>> renesas-rpc.txt
>> > > >> > >> > >> new file mode 100644
>> > > >> > >> > >> index 0000000..668b822
>> > > >> > >> > >> --- /dev/null
>> > > >> > >> > >> +++ b/Documentation/devicetree/bindings/mfd/mfd-
>> renesas-rpc.txt
>> > > >> > >> > >> @@ -0,0 +1,40 @@
>> > > >> > >> > >> +Renesas R-Car Gen3 RPC-IF MFD Device Tree Bindings
>> > > >> > >> > >> +--------------------------------------------------
>> > > >> > >> > >
>> > > >> > >> > > Looks like a SPI flash controller from the example. What
>> > > makes it an
>> > > >> > >> > > MFD?
>> > > >> > >> >
>> > > >> > >> > It supports both SPI NOR and HyperFlash (CFI-compliantflash with
>> > > >> > >> > different bus interface).
>> > > >> > >>
>> > > >> > >> Looks like you're registering one OR the other.
>> > > >> > >>
>> > > >> > >> Why don't you just do this from DT?
>> > > >> > >>
>> > > >> > >> No reason for this to be an MFD IMHO.
>> > > >> > >
>> > > >> > >
>> > > >> > > okay, I will patch it back to SPI mode only.
>> > > >> >
>> > > >> > I don't think that's what Lee meant . The controller supports _both_
>> > > >> > modes , hence it would have the same compatible string. You
>> just need to
>> > > >> > extract the mode of operation from the DT.
>> > > >>
>> > > >> HiSilicon attempted to upstream something similar, only their
>> > > >> controller provided NAND and NOR functionality.  They used different
>> > > >> compatible strings to differentiate between the varying
>> > > >> technologies.
>> > > >>
>> > > >> They too tried to use MFD as a means to select between them (which was
>> > > >> also NACKed).  Not sure what they ended up doing, but the original
>> > > >> submission and (half of) the conversation can be found at [0].  Some
>> > > >> more of the thread continues at [1].
>> > > >>
>> > > >> Hope that helps.
>> > > >>
>> > > >> [0] https://groups.google.com/forum/#!topic/fa.linux.kernel/F6i9o8sfOIw
>> > > >> [1] https://marc.info/?l=devicetree&m=147669165104431&w=2
>> > > >
>> > > >
>> > > > Hi Marek,
>> > > >
>> > > > By Jones's comments:
>> > > >
>> --------------------------------------------------------------------------
>> > > >> From: Shunquan Lin <linshunquan1@hisilicon.com>
>> > > >>
>> > > >> This patch adds driver support for HiSilicon Flash Memory
>> > > >> Controller(FMC). HiSilicon FMC is a multi-functions device which
>> > > >> supports SPI Nor flash controller, SPI nand Flash controller and
>> > > >> parallel nand flash controller.
>> > > >
>> > > > MFDs are for devices which span multiple subsystems.
>> > >
>> > >    And we do! One of the subdrivers will live under drivers/
>> spi/, the other
>> > > under drivers/mtd/...
>> > >
>> >
>> > From my point of view, I think Jones mean to MFD's subsystems are
>> working simultaneously
>> > at the run-time, one period of time is working for sub-device-1
>> and later period of time
>> > is working for sub-device-2 and so on.
>> >
>> > But for RPC-IF, SPI or HF mode is decided at boot time by pins
>> configure and later in kernel
>> > by dtb, RPC-IF can't switch SPI and HF mode at the run time.
>>
>> > So far, Jones seems don't agree RPC-IF to MFD and then RPC MFD
>> will not applied
>> > to mfd tree by him !
>>
>> There's precedence for such constructs being an MFD: please see
>> drivers/mfd/at91-usart.c, which registers a single MFD cell for either
>> serial or SPI.

   Thanks fir your example, Geert! :-)

> okay, many thanks for your information.
> 
> How about to patch RPF-IF dts to:
> -------------------------------------------------------------->
> 
> Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
> ---------------------------------------------------------
>  
>   RPC-IF supports both SPI NOR and HyperFlash (CFI-compliant flash)
>  
>   Required properties:
>   - compatible: should be an SoC-specific compatible value, followed by
>                   "renesas,rcar-gen3-rpc" as a fallback.
>                   supported SoC-specific values are:
>                   "renesas,r8a77995-rpc"  (R-Car D3)
>   - reg: should contain three register areas:
>           first for the base address of RPC-IF registers,

   I'd drop "the base address" here.

>           second for the direct mapping read mode and
>           third for the write buffer area.
>   - reg-names: should contain "regs", "dirmap" and "wbuf"
>   - clocks: should contain 1 entries for the module's clock
>   - clock-names: should contain "rpc"

   I suspect we'd need the RPC/RPCD2 clocks mentioned as well (not sure yet)...
   And how about "power-domains", "resets" (seen in the example below),
also what about #address-cells & #size-cells?

>  
>   Example:

   Could you please indent with 1 or 2 tabs where you used 8 or 16 spaces?

>   - SPI mode:
>  
>           rpc: rpc-if@ee200000 {

   The node names should be generic, based on the device class. And in this
case I'd like to use "spi@ee200000" as otherwise dtc keeps bitching like below:

arch/arm64/boot/dts/renesas/r8a77980.dtsi:1344.21-1359.5: Warning (spi_bus_bridge):
/soc/rpc@ee200000: node name for SPI buses should be 'spi'
  also defined at arch/arm64/boot/dts/renesas/r8a77980-condor.dts:283.6-343.3
arch/arm64/boot/dts/renesas/r8a77980-condor.dtb: Warning (spi_bus_reg):
Failed prerequisite 'spi_bus_bridge'


>   - HF mode:
>           rpc: rpc-if@ee200000 {

   Again, spi@<...>.

>                   compatible = "renesas,r8a77995-rpc", "renesas,rcar-gen3-rpc";
>                   reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 0x4000000>,
>                         <0 0xee208000 0 0x100>;
>                   reg-names = "regs", "dirmap", "wbuf";
>                   clocks = <&cpg CPG_MOD 917>;
>                   clock-names = "rpc";
>                   power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
>                   resets = <&cpg 917>;
>                   #address-cells = <1>;
>                   #size-cells = <1>;
>  
>                   flash@0 {
>                           compatible = "cfi-flash";

   The working HF implementation has "cypress,hyperflash" before "cfi-flash".

>                           reg = <0 0x4000000>;
>                   };
>           };
> 
> --------------------------------------------------------------<
> 
> Is it OK ?

   Yeah, seems good (assuming you fix the issues above).

[...]
> thanks & best regards,
> Mason

MBR, Sergei

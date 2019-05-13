Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D00D1B8DB
	for <lists+linux-spi@lfdr.de>; Mon, 13 May 2019 16:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbfEMOnY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 May 2019 10:43:24 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:39457 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729893AbfEMOnY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 May 2019 10:43:24 -0400
Received: by mail-vs1-f65.google.com with SMTP id m1so1003717vsr.6;
        Mon, 13 May 2019 07:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ClzU7jZAryaIXzR+/qv1yEuyi15Ak7Jc5yYHkm+jUlE=;
        b=UHSBnBwRKi2PsFkZS/Y1M9KW5l+UG/SNvzsM00vj10nq1Ur8+7/V1Ead9gAxfLWbW+
         tAL2s0kU2TRouxv2tuXytbyyGrcg9s1iyh/8OrDSRzpEJY58MH/fEdn4HnhSvT7JxoMn
         /3yb2yQ1KeWeqhLR8wf+C3SYwMB0BTDCAMksnfnninUpvJp4onyxWrb1apce6wvAmsgl
         o/RBEa8ZxVfQLhNMJ0LPgMmtagsYhnUVzjRZzjNEMHwjYUqRFWmESVC2caKr54t2WDjN
         ZaZjHe7aUhYNficbc7yxbHb0oYgguBCuXHwIyfO+Rhh2gBSQCb9NCMM7dAXMHN23VAIU
         2cJQ==
X-Gm-Message-State: APjAAAWrcC/Lee2T4klztruJtBjWFIE0toUaWi30BtobsuODaZhXcmUY
        L5pducjb035/MF8CR1Gyv5GBXPpZE4Hb9RjLMs0=
X-Google-Smtp-Source: APXvYqx6lgUfn+cBlcwFavQQI3d2TF3Qqkzwe2QJhqICSPH/EAbTfEMSktmNgiu1Yfxi3tdjXLT5ZhTyKRREk2FELMc=
X-Received: by 2002:a67:f303:: with SMTP id p3mr2137246vsf.166.1557758602639;
 Mon, 13 May 2019 07:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <1556092536-17095-1-git-send-email-masonccyang@mxic.com.tw>
 <1556092536-17095-4-git-send-email-masonccyang@mxic.com.tw>
 <20190424212356.GA27103@bogus> <65853dc2-6f3c-1494-7e72-54877797cdd2@gmail.com>
 <20190507125730.GD29524@dell> <OF08A5650B.8AE8977C-ON482583F4.000E5B1E-482583F4.000F7215@mxic.com.tw>
 <d229b19e-351c-c576-b5c4-716d10dad1a0@gmail.com> <20190508061119.GB7627@dell>
 <OFE86674B9.06D723A0-ON482583F5.000AD50C-482583F5.000BA075@mxic.com.tw>
 <a05cff8f-7df2-1938-c0e7-f9366bece607@cogentembedded.com> <OFB19BCE91.6EBBAA77-ON482583F6.000234E2-482583F6.00061290@mxic.com.tw>
 <CAMuHMdUP8KU3Dbv6cwOvrY0hWOcm1xqVcsi20+GvazYMDLGGZg@mail.gmail.com> <OFD932ABFC.E3FFCEB8-ON482583F9.003412B1-482583F9.0034D5CA@mxic.com.tw>
In-Reply-To: <OFD932ABFC.E3FFCEB8-ON482583F9.003412B1-482583F9.0034D5CA@mxic.com.tw>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 May 2019 16:43:09 +0200
Message-ID: <CAMuHMdWsZPevpYg0HfbgaXPD89RFdOOEPawvvZDt3Kp4=PeLRQ@mail.gmail.com>
Subject: Re: [PATCH v12 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF MFD bindings
To:     Mason Yang <masonccyang@mxic.com.tw>
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
        Rob Herring <robh@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        zhengxunli@mxic.com.tw
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mason,

Note that if you send multipart/text+html emails, they will be dropped silently
by most Linux mailing lists.
Hence I'm quoting your last email fully, to give other people a chance
reading it (and commenting).

On Mon, May 13, 2019 at 11:37 AM <masonccyang@mxic.com.tw> wrote:
> > > > [...]
> > > > >> > >> > On 4/24/19 11:23 PM, Rob Herring wrote:
> > > > >> > >> > > On Wed, Apr 24, 2019 at 03:55:36PM +0800, Mason Yang wrote:
> > > > >> > >> > >> Document the bindings used by the Renesas R-Car
> > Gen3 RPC-IF MFD.
> > > > >> > >> > >>
> > > > >> > >> > >> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> > > > >> > >> > >> ---
> > > > >> > >> > >>  .../devicetree/bindings/mfd/mfd-renesas-rpc.txt
> > | 40 ++++++
> > > > >> > >> ++++++++++++++++
> > > > >> > >> > >>  1 file changed, 40 insertions(+)
> > > > >> > >> > >>  create mode 100644 Documentation/devicetree/
> > bindings/mfd/mfd-
> > > > >> > >> renesas-rpc.txt
> > > > >> > >> > >>
> > > > >> > >> > >> diff --git a/Documentation/devicetree/bindings/mfd/
> > mfd-renesas-
> > > > >> > >> rpc.txt b/Documentation/devicetree/bindings/mfd/mfd-
> > renesas-rpc.txt
> > > > >> > >> > >> new file mode 100644
> > > > >> > >> > >> index 0000000..668b822
> > > > >> > >> > >> --- /dev/null
> > > > >> > >> > >> +++ b/Documentation/devicetree/bindings/mfd/mfd-
> > renesas-rpc.txt
> > > > >> > >> > >> @@ -0,0 +1,40 @@
> > > > >> > >> > >> +Renesas R-Car Gen3 RPC-IF MFD Device Tree Bindings
> > > > >> > >> > >> +--------------------------------------------------
> > > > >> > >> > >
> > > > >> > >> > > Looks like a SPI flash controller from the example. What
> > > > makes it an
> > > > >> > >> > > MFD?
> > > > >> > >> >
> > > > >> > >> > It supports both SPI NOR and HyperFlash (CFI-compliantflash with
> > > > >> > >> > different bus interface).
> > > > >> > >>
> > > > >> > >> Looks like you're registering one OR the other.
> > > > >> > >>
> > > > >> > >> Why don't you just do this from DT?
> > > > >> > >>
> > > > >> > >> No reason for this to be an MFD IMHO.
> > > > >> > >
> > > > >> > >
> > > > >> > > okay, I will patch it back to SPI mode only.
> > > > >> >
> > > > >> > I don't think that's what Lee meant . The controller supports _both_
> > > > >> > modes , hence it would have the same compatible string. You
> > just need to
> > > > >> > extract the mode of operation from the DT.
> > > > >>
> > > > >> HiSilicon attempted to upstream something similar, only their
> > > > >> controller provided NAND and NOR functionality.  They used different
> > > > >> compatible strings to differentiate between the varying
> > > > >> technologies.
> > > > >>
> > > > >> They too tried to use MFD as a means to select between them (which was
> > > > >> also NACKed).  Not sure what they ended up doing, but the original
> > > > >> submission and (half of) the conversation can be found at [0].  Some
> > > > >> more of the thread continues at [1].
> > > > >>
> > > > >> Hope that helps.
> > > > >>
> > > > >> [0] https://groups.google.com/forum/#!topic/fa.linux.kernel/F6i9o8sfOIw
> > > > >> [1] https://marc.info/?l=devicetree&m=147669165104431&w=2
> > > > >
> > > > >
> > > > > Hi Marek,
> > > > >
> > > > > By Jones's comments:
> > > > >
> > --------------------------------------------------------------------------
> > > > >> From: Shunquan Lin <linshunquan1@hisilicon.com>
> > > > >>
> > > > >> This patch adds driver support for HiSilicon Flash Memory
> > > > >> Controller(FMC). HiSilicon FMC is a multi-functions device which
> > > > >> supports SPI Nor flash controller, SPI nand Flash controller and
> > > > >> parallel nand flash controller.
> > > > >
> > > > > MFDs are for devices which span multiple subsystems.
> > > >
> > > >    And we do! One of the subdrivers will live under drivers/
> > spi/, the other
> > > > under drivers/mtd/...
> > > >
> > >
> > > From my point of view, I think Jones mean to MFD's subsystems are
> > working simultaneously
> > > at the run-time, one period of time is working for sub-device-1
> > and later period of time
> > > is working for sub-device-2 and so on.
> > >
> > > But for RPC-IF, SPI or HF mode is decided at boot time by pins
> > configure and later in kernel
> > > by dtb, RPC-IF can't switch SPI and HF mode at the run time.
> >
> > > So far, Jones seems don't agree RPC-IF to MFD and then RPC MFD
> > will not applied
> > > to mfd tree by him !
> >
> > There's precedence for such constructs being an MFD: please see
> > drivers/mfd/at91-usart.c, which registers a single MFD cell for either
> > serial or SPI.
>
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
>           second for the direct mapping read mode and
>           third for the write buffer area.
>   - reg-names: should contain "regs", "dirmap" and "wbuf"
>   - clocks: should contain 1 entries for the module's clock
>   - clock-names: should contain "rpc"
>
>   Example:
>   - SPI mode:
>
>           rpc: rpc-if@ee200000 {
>                   compatible = "renesas,r8a77995-rpc", "renesas,rcar-gen3-rpc";
>                   reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 0x4000000>,
>                         <0 0xee208000 0 0x100>;
>                   reg-names = "regs", "dirmap", "wbuf";
>                   clocks = <&cpg CPG_MOD 917>;
>                   clock-names = "rpc";
>                   power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
>                   resets = <&cpg 917>;
>                   #address-cells = <1>;
>                   #size-cells = <0>;
>
>                   flash@0 {
>                           compatible = "jedec,spi-nor";
>                           reg = <0>;
>                           spi-max-frequency = <40000000>;
>                           spi-tx-bus-width = <1>;
>                           spi-rx-bus-width = <1>;
>                   };
>           };
>
>   - HF mode:
>           rpc: rpc-if@ee200000 {
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
>                           reg = <0 0x4000000>;
>                   };
>           };
>
> --------------------------------------------------------------<
>
> Is it OK ?

I'll defer to the MTD experts.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5041B0ED
	for <lists+linux-spi@lfdr.de>; Mon, 13 May 2019 09:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfEMHLe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Mon, 13 May 2019 03:11:34 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36200 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbfEMHLd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 May 2019 03:11:33 -0400
Received: by mail-vs1-f66.google.com with SMTP id c76so7358097vsd.3;
        Mon, 13 May 2019 00:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AwLnfNDWLBJHzIjiUSN0rlrxnWBlC6Tvjo4enXu1mhg=;
        b=Egg7OwyxiZAhSSAOSbKVmc/SO5wdRM76/aQcvV1MdkP5n+zmM4uULUGS0k1vsllcVr
         dfYF5kU28zxa9slh0/orKuPuzRaL+l4e1H2SjDQRB1yP622RjdtdNq47e+6mdeiARbBR
         sFMs39d4c+gk0mgIyq3f9M07ec7apZMgEi+XrUbODCR03cT3VIeiNcP/zamnVmpo/5Xw
         ILDXHv38owiMCxOkDdGR2e0jvwJoAy+CvsXOn9h9QtFdfwu1ZxekcVG3PjwM0VILzhCs
         QPxVawQdo11AG/rVuN+oa7Lb1485MjqB7HD7D4AxVzpe+cCkk0r0tCMxQg1gWn+eD4W/
         iWfQ==
X-Gm-Message-State: APjAAAXZxWtUOgsugJ5+3qV1dC5J+nBtaKMlivG2AeneO1kQkW7aUMli
        nk+2QoKKB2AO5h4EOnunjRhvBqAwI0prIU76FVA=
X-Google-Smtp-Source: APXvYqzanTyYBb7c5ZEsyF0TeIoVR+0s3dXHYolBKBYY7ZsmE8E+iJt4sQJSjNZ8KUmEOmvsdnDYYZrEq2u+9BrrhNU=
X-Received: by 2002:a67:f303:: with SMTP id p3mr1137935vsf.166.1557731491713;
 Mon, 13 May 2019 00:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <1556092536-17095-1-git-send-email-masonccyang@mxic.com.tw>
 <1556092536-17095-4-git-send-email-masonccyang@mxic.com.tw>
 <20190424212356.GA27103@bogus> <65853dc2-6f3c-1494-7e72-54877797cdd2@gmail.com>
 <20190507125730.GD29524@dell> <OF08A5650B.8AE8977C-ON482583F4.000E5B1E-482583F4.000F7215@mxic.com.tw>
 <d229b19e-351c-c576-b5c4-716d10dad1a0@gmail.com> <20190508061119.GB7627@dell>
 <OFE86674B9.06D723A0-ON482583F5.000AD50C-482583F5.000BA075@mxic.com.tw>
 <a05cff8f-7df2-1938-c0e7-f9366bece607@cogentembedded.com> <OFB19BCE91.6EBBAA77-ON482583F6.000234E2-482583F6.00061290@mxic.com.tw>
In-Reply-To: <OFB19BCE91.6EBBAA77-ON482583F6.000234E2-482583F6.00061290@mxic.com.tw>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 May 2019 09:11:19 +0200
Message-ID: <CAMuHMdUP8KU3Dbv6cwOvrY0hWOcm1xqVcsi20+GvazYMDLGGZg@mail.gmail.com>
Subject: Re: [PATCH v12 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF MFD bindings
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Lee Jones <lee.jones@linaro.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>, zhengxunli@mxic.com.tw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mason,

On Fri, May 10, 2019 at 3:09 AM <masonccyang@mxic.com.tw> wrote:
> > "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>
> > 2019/05/10 上午 03:24
> > mark.rutland@arm.com, "Rob Herring" <robh@kernel.org>, zhengxunli@mxic.com.tw
> > On 05/09/2019 05:06 AM, masonccyang@mxic.com.tw wrote:
> >
> > [...]
> > >> > >> > On 4/24/19 11:23 PM, Rob Herring wrote:
> > >> > >> > > On Wed, Apr 24, 2019 at 03:55:36PM +0800, Mason Yang wrote:
> > >> > >> > >> Document the bindings used by the Renesas R-Car Gen3 RPC-IF MFD.
> > >> > >> > >>
> > >> > >> > >> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> > >> > >> > >> ---
> > >> > >> > >>  .../devicetree/bindings/mfd/mfd-renesas-rpc.txt    | 40 ++++++
> > >> > >> ++++++++++++++++
> > >> > >> > >>  1 file changed, 40 insertions(+)
> > >> > >> > >>  create mode 100644 Documentation/devicetree/bindings/mfd/mfd-
> > >> > >> renesas-rpc.txt
> > >> > >> > >>
> > >> > >> > >> diff --git a/Documentation/devicetree/bindings/mfd/mfd-renesas-
> > >> > >> rpc.txt b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> > >> > >> > >> new file mode 100644
> > >> > >> > >> index 0000000..668b822
> > >> > >> > >> --- /dev/null
> > >> > >> > >> +++ b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> > >> > >> > >> @@ -0,0 +1,40 @@
> > >> > >> > >> +Renesas R-Car Gen3 RPC-IF MFD Device Tree Bindings
> > >> > >> > >> +--------------------------------------------------
> > >> > >> > >
> > >> > >> > > Looks like a SPI flash controller from the example. What
> > makes it an
> > >> > >> > > MFD?
> > >> > >> >
> > >> > >> > It supports both SPI NOR and HyperFlash (CFI-compliant flash with
> > >> > >> > different bus interface).
> > >> > >>
> > >> > >> Looks like you're registering one OR the other.
> > >> > >>
> > >> > >> Why don't you just do this from DT?
> > >> > >>
> > >> > >> No reason for this to be an MFD IMHO.
> > >> > >
> > >> > >
> > >> > > okay, I will patch it back to SPI mode only.
> > >> >
> > >> > I don't think that's what Lee meant . The controller supports _both_
> > >> > modes , hence it would have the same compatible string. You just need to
> > >> > extract the mode of operation from the DT.
> > >>
> > >> HiSilicon attempted to upstream something similar, only their
> > >> controller provided NAND and NOR functionality.  They used different
> > >> compatible strings to differentiate between the varying
> > >> technologies.
> > >>
> > >> They too tried to use MFD as a means to select between them (which was
> > >> also NACKed).  Not sure what they ended up doing, but the original
> > >> submission and (half of) the conversation can be found at [0].  Some
> > >> more of the thread continues at [1].
> > >>
> > >> Hope that helps.
> > >>
> > >> [0] https://groups.google.com/forum/#!topic/fa.linux.kernel/F6i9o8sfOIw
> > >> [1] https://marc.info/?l=devicetree&m=147669165104431&w=2
> > >
> > >
> > > Hi Marek,
> > >
> > > By Jones's comments:
> > > --------------------------------------------------------------------------
> > >> From: Shunquan Lin <linshunquan1@hisilicon.com>
> > >>
> > >> This patch adds driver support for HiSilicon Flash Memory
> > >> Controller(FMC). HiSilicon FMC is a multi-functions device which
> > >> supports SPI Nor flash controller, SPI nand Flash controller and
> > >> parallel nand flash controller.
> > >
> > > MFDs are for devices which span multiple subsystems.
> >
> >    And we do! One of the subdrivers will live under drivers/spi/, the other
> > under drivers/mtd/...
> >
>
> From my point of view, I think Jones mean to MFD's subsystems are working simultaneously
> at the run-time, one period of time is working for sub-device-1 and later period of time
> is working for sub-device-2 and so on.
>
> But for RPC-IF, SPI or HF mode is decided at boot time by pins configure and later in kernel
> by dtb, RPC-IF can't switch SPI and HF mode at the run time.

> So far, Jones seems don't agree RPC-IF to MFD and then RPC MFD will not applied
> to mfd tree by him !

There's precedence for such constructs being an MFD: please see
drivers/mfd/at91-usart.c, which registers a single MFD cell for either
serial or SPI.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

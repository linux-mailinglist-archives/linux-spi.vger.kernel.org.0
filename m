Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B765215AC6
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jul 2020 17:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbgGFPdE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jul 2020 11:33:04 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34877 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729307AbgGFPdE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Jul 2020 11:33:04 -0400
Received: by mail-oi1-f194.google.com with SMTP id k4so32309774oik.2;
        Mon, 06 Jul 2020 08:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z8U0WbtD7YYbhflGPUz8Z1TbfGsbY1TA8GO2xlWQBVk=;
        b=f3Y/STFHkZW2E67m5Us055orKNEt67RpoDrCht8jZR+P3CK6n7cvMty/xt2YbKQWcE
         olVYehsfFsdy2BUxbU7cCVgM4n+1JkTxPEzLZE+29GgX4kBKk3Xqxv34v9fwq7VMt/Ym
         Xllzw9L4WPkrCmy3j7+e3cceSbXClvWQJWR1mwM2TK39hRnnnxvOzd0W0XxVMdhWgwBU
         sKEIun34FsO1Lvp+6FU0q6VvELWX4nCJpLGkZgc1+76WiG7gmqj5u/Yj/XVAJzZDm6gC
         4VuWi9DB+E6AOrTKhScArctaBrUHc3ZhXAj5ABLtsSKEy+aMxG8bcAbez5xviK+uZvgI
         73wQ==
X-Gm-Message-State: AOAM531QCiY8NE16Bu2tt9vq/ACbb12/Jj+oZjYSqDGABX+/IXfAU5Tb
        K/xqKQFyWhjq+88Ot8yYub2YhmDxBSZqjci46CE=
X-Google-Smtp-Source: ABdhPJxqsVIdoIx7YyiL4cE+REpRjEhCzWl+LWRTxxQHIUZOK+rtUBpXclRghl5nrdwjzg8JklDUzk+bzJKGwQPNXmo=
X-Received: by 2002:aca:5c41:: with SMTP id q62mr3762637oib.148.1594049583089;
 Mon, 06 Jul 2020 08:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <202007040833.xIqR5rAw%lkp@intel.com> <20200706092247.20740-1-adrian.fiergolski@fastree3d.com>
 <20200706092247.20740-2-adrian.fiergolski@fastree3d.com> <CAMuHMdW_aTKtrUnGqf3DB=fr0ZxTsjoEjMmwSpPqhwjs-Tz7ig@mail.gmail.com>
 <d80b1b85-ee23-3244-9bb0-876986f6ff17@fastree3d.com>
In-Reply-To: <d80b1b85-ee23-3244-9bb0-876986f6ff17@fastree3d.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Jul 2020 17:32:51 +0200
Message-ID: <CAMuHMdUV_2DbbUqp+0=XARyLCwPya1RqFCrr6VoTJjVAZiKJzg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: Add documentation for SPI daisy chain driver.
To:     Adrian Fiergolski <adrian.fiergolski@fastree3d.com>
Cc:     Lukas Wunner <lukas@wunner.de>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Adrian,

On Mon, Jul 6, 2020 at 5:19 PM Adrian Fiergolski
<adrian.fiergolski@fastree3d.com> wrote:
> On 06.07.2020 17:10, Geert Uytterhoeven wrote:
> > On Mon, Jul 6, 2020 at 11:23 AM Adrian Fiergolski
> > <adrian.fiergolski@fastree3d.com> wrote:
> >> Add documentation for SPI daisy chain driver.
> >>
> >> Signed-off-by: Adrian Fiergolski <adrian.fiergolski@fastree3d.com>
> > Thanks for your patch!
> >
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/spi/spi-daisy_chain.txt
> >> @@ -0,0 +1,56 @@
> >> +spi-daisy_chain : The driver handling SPI daisy chains.
> >> +-----------------------------------------------------------
> >> +
> >> +Required properties:
> >> +- compatible           : Should be "spi,daisy_chain"
> >> +- reg                  : Chip select assigned to the chain
> >> +
> >> +  For the SPI devices on a common SPI chain - nodes of daisy_chain):
> >> +- spi-daisy-chain-len  : Length (in bytes) of the SPI transfer,
> >> +                        when the SPI device is part of a device chain.
> >> +- spi-daisy-chain-noop : Byte string of no-operation command which should
> >> +                        be send when device is not addressed during the
> >> +                        given SPI transfer
> > The above two properties are device-specific, and the same for all
> > devices of the same type, thus leading to duplication.
> > Hence I think this should not be specified in DT, but instead handled
> > by the driver.  I.e. for Linux, you would retrieve this from struct
> > spi_device, as filled in by the slave driver.
> The problem is that then this patch would not be compatible out of the
> box with all SPI devices (as it's now) and would require rewrite (adding
> this extra information in the spi_driver struct) of all SPI drivers
> which support daisy chain.

That's correct.
However, that information would need to be added to each driver only once.
With your proposal, it has to be added to all affected nodes of all DTSes
of all users.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

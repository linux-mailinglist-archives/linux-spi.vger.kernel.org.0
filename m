Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32B9E17246C
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2020 18:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbgB0RDM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Feb 2020 12:03:12 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38882 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbgB0RDM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Feb 2020 12:03:12 -0500
Received: by mail-oi1-f195.google.com with SMTP id 2so2863553oiz.5;
        Thu, 27 Feb 2020 09:03:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3SLSeusjyF7xuR70ZDE6DWBdGicv7IAt+yuIdcwz2t8=;
        b=NJEaogyn7Bj1o2mGanFo/0Rc3K6M/2Ce+zsOOxLPv/ALAvgUCUNcFxl3c73V41uK2R
         7UCTp6U8bNDrLbRL8Zs8AsEsJeAvOscBl83hlatuKmxgzFtKio5KnKERZijeEpHxngJL
         GMkNKMuL9+hDJBd8wnZjh31jQeMDasoveFzhUGItgLLRKjZeJkCPIlFVYO3OvnxF3Rna
         sEIyVLSeSk6f7wJ/r3z/PZZqchMDVuqUyaXfDjDwzecZL94rqdmIQostDw9PDvqdKEmL
         bRNLN7zLVlLwm3RulfiD2TqJtu/ftpRJrEJalF7+vqJ3gOH8dX4EolnC9hjnEwkFOL9P
         w7Ow==
X-Gm-Message-State: APjAAAULQI3wpkT5jWDuWv4TA968XeI2624LR3BT1HVZuWsjvc8dAAdS
        1AtPRI/XeYZV+Pw6DZemTwm6FenlzkaLgqHkFik=
X-Google-Smtp-Source: APXvYqzRjEtzoIaCCugVuFD4BsmBmzfqIzgRC0i4fNsaXIhsSXoYehtum4tWBRTUqYj7/Lp5oUYRtCM/IezBtVMEXfY=
X-Received: by 2002:aca:48cd:: with SMTP id v196mr11129oia.102.1582822991282;
 Thu, 27 Feb 2020 09:03:11 -0800 (PST)
MIME-Version: 1.0
References: <20200226093703.19765-1-p.yadav@ti.com> <20200226093703.19765-2-p.yadav@ti.com>
 <20200227171147.32cc6fcf@collabora.com> <20200227162842.GE4062@sirena.org.uk>
 <CAMuHMdWMCDzQm0tjpybJZyHy4imbC9NqRXP5d4C0xgxQx-Pf8g@mail.gmail.com> <20200227164425.GF4062@sirena.org.uk>
In-Reply-To: <20200227164425.GF4062@sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 27 Feb 2020 18:03:00 +0100
Message-ID: <CAMuHMdV_1RfGFgDjJYzAnGd_x57zSwjZd8si=UTPp8ksgdwYGA@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] dt-bindings: spi: allow expressing DTR capability
To:     Mark Brown <broonie@kernel.org>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        Sekhar Nori <nsekhar@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Pratyush Yadav <p.yadav@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

On Thu, Feb 27, 2020 at 5:44 PM Mark Brown <broonie@kernel.org> wrote:
> On Thu, Feb 27, 2020 at 05:40:31PM +0100, Geert Uytterhoeven wrote:
> > On Thu, Feb 27, 2020 at 5:28 PM Mark Brown <broonie@kernel.org> wrote:
> > > It's what we do for other properties, and if this is anything like the
> > > other things adding extra wiring you can't assume that the ability to
> > > use the feature for TX implies RX.
>
> > Double Transfer Rate uses the same wire.
>
> But is it still on either the TX or RX signals?

E.g. good old Spansion S25FL512S supports single/dual/quad DDR, but
apparently only for read, not write.
Other FLASHes may support both directions. I guess.

> > But as you sample at both the rising and the falling edges of the clock, this
> > makes the cpha setting meaningless for such transfers, I think ;-)
>
> Might affect what the first bit is possibly?

Quoting the manual for the above part:

4.1.2
Double Data Rate (DDR)
Mode 0 and Mode 3 are also supported for DDR commands. In DDR
commands, the instruction bits are
always latched on the rising edge of clock, the same as in SDR
commands. However, the address and input
data that follow the instruction are latched on both the rising and
falling edges of SCK. The first address bit is
latched on the first rising edge of SCK following the falling edge at
the end of the last instruction bit. The first
bit of output data is driven on the falling edge at the end of the
last access latency (dummy) cycle.
SCK cycles are measured (counted) in the same way as in SDR commands,
from one falling edge of SCK to
the next falling edge of SCK. In mode 0 the beginning of the first SCK
cycle in a command is measured from
the falling edge of CS# to the first falling edge of SCK because SCK
is already low at the beginning of a
command.

> > However, as the future may bring us QDR, perhaps this should not be a
> > boolean flag, but an integer value?
> > Cfr. spi-tx-bus-width vs. the original spi-tx-dual/spi-tx-quad proposal.
>
> > What would be a good name (as we only need one)? spi-data-phases?
>
> Sounds reasonable, apart from the increasingly vague connection with
> something that's recognizably SPI :P

Yeah, especially Octal and Hyper modes are far from serial ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

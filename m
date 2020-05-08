Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3351CB86F
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 21:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgEHTjS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 15:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726767AbgEHTjR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 May 2020 15:39:17 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0383C05BD0A
        for <linux-spi@vger.kernel.org>; Fri,  8 May 2020 12:39:15 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a21so2886641ljj.11
        for <linux-spi@vger.kernel.org>; Fri, 08 May 2020 12:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gjrGLJHLzoxchg9f/7+BzZ/emAWiNvtOkRqlM0vdoIg=;
        b=aGj4Wnxz1/aQyFPMr7NUm4zXJhJ8h7VAryh5DVU6ZQt6AVBxS9tmKQlupGJ5KeXejP
         KSz+L58WUX50UeLf1ShwLZkVfus9ZX0lgD06QjMNC3/zKkfIiXkiwYge15T1/gUc27aO
         SkBLyUASa8xg9hfhlhGe48TZ8pL8eEM/DPhjceFCm41s4igWICxrTAtxmj/XVBmMuxC4
         E0I1gaydT5OWK5CYVJmqK9YvykFVgSYts/bi6SSXxHBh3rqtCTLdTb3PJAIbT3TVcvcg
         VNqziYQkuxX1HykgiPzPe2jl2OWQ4sEXFDROXuEuqS3AeWyiXcSOnUPjvLntH8TtjK2v
         OUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gjrGLJHLzoxchg9f/7+BzZ/emAWiNvtOkRqlM0vdoIg=;
        b=CIGyW28LOkNMHzt90VT9wmBv4J9v2NFyGSqRUJXrADRB3MIMCSAp47BRjeXZJotVp8
         U4ZX+aix2qBc1AB3i5GavIvRD0vLpcj+TwXfTmGCQDYdoqvOL/SjHGBJXJaxpMl7PhOU
         jF49PTY4wNa6D7jZz0ndrNjZqf+nqlKIRF3u19uh6vs8kvIsBN03j0lP9bpmCWH/lnAO
         s7O8KStY2FAKzbF9Pjg2DOVwGrG0/CsAzoantW/G3pWUys4oZWeOpAqNK6QtgQn5yIsH
         rpIBiAJCxXXl78w3rnVcM9iUdPBh8lJs/ZB0hTqM8ZvwKHYAOsXE0/dl5WqZ+R45DMY7
         YGZA==
X-Gm-Message-State: AOAM53166EE6f+yK3JcB4D0BwIHRnvCu9rH8i9xrRonsGaq5ksD3pFtl
        zRFZVPV8pRCziXiKVcrsKoujUf9pNyNLIE+r289BCw==
X-Google-Smtp-Source: ABdhPJzVNt0K7k0tLrvgknOBlVHyrZtBVYfRv9CoX9LYJ+b2t/u4YporDzh0yTsMzYpoIig38TiOGb/ERqa5Fzvduw8=
X-Received: by 2002:a2e:8087:: with SMTP id i7mr2546861ljg.99.1588966753962;
 Fri, 08 May 2020 12:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru> <20200508132943.9826-12-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200508132943.9826-12-Sergey.Semin@baikalelectronics.ru>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 May 2020 21:39:02 +0200
Message-ID: <CACRpkdY=wkgnYPcqSzyzNpS6ckJZs-9kXfTfdwa1E+POzOBQGA@mail.gmail.com>
Subject: Re: [PATCH 11/17] spi: dw: Fix native CS being unset
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        "wuxu.wu" <wuxu.wu@huawei.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 8, 2020 at 3:31 PM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:

> Commit 6e0a32d6f376 ("spi: dw: Fix default polarity of native
> chipselect") attempted to fix the problem when GPIO active-high
> chip-select is utilized to communicate with some SPI slave. It fixed
> the problem, but broke the normal native CS support. At the same time
> the reversion commit ada9e3fcc175 ("spi: dw: Correct handling of native
> chipselect") didn't solve the problem either, since it just inverted
> the set_cs() polarity perception without taking into account that
> CS-high might be applicable. Here is what is done to finally fix the
> problem.

I'm not sure this is the whole story.

I think Charles' fix made it work, and then commit
3e5ec1db8bfee845d9f8560d1c64aeaccd586398
"spi: Fix SPI_CS_HIGH setting when using native and GPIO CS"
fixed it broken again.

This commit will make sure only set SPI_CS_HIGH on a
spi_device if it is using a GPIO as CS. Before this change,
the core would set that on everything, and expect the
.set_cs() callback to cope.

I think we fixed that and that fix should have been undone
when applying commit 3e5ec1db8bfe.

So possibly Fixes: should be set only to this commit, so
that the fix is not backported to kernels without it.

> DW SPI controller demands any native CS being set in order to proceed
> with data transfer. So in order to activate the SPI communications we
> must set any bit in the Slave Select DW SPI controller register no
> matter whether the platform requests the GPIO- or native CS.

Ah-ha! Maybe we should even add a comment explaining that.
And that is why SPI_MASTER_GPIO_SS is set.

I suppose my naive understanding was:
"bit set to 1" = CS asserted (driven low)
"bit set to 0" = CS de-asserted  (driven high)
So that is not how this register works at all.

> This commit fixes the problem for all described cases. So no matter
> whether an SPI slave needs GPIO- or native-based CS with active-high
> or low signal the corresponding bit will be set in SER.

Makes sense.

>         struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
>         struct chip_data *chip = spi_get_ctldata(spi);
> +       bool cs_high = !!(spi->mode & SPI_CS_HIGH);
>
>         /* Chip select logic is inverted from spi_set_cs() */
>         if (chip && chip->cs_control)
>                 chip->cs_control(!enable);
>
> -       if (!enable)
> +       if (cs_high == enable)
>                 dw_writel(dws, DW_SPI_SER, BIT(spi->chip_select));

This is the correct fix now but I an afraid not correct before
commit 3e5ec1db8bfe.

What I can't help but asking is: can the native chip select even
handle active high chip select if not backed by a GPIO?
Which register would set that polarity?

Yours,
Linus Walleij

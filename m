Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0E91B1408
	for <lists+linux-spi@lfdr.de>; Mon, 20 Apr 2020 20:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgDTSKj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Apr 2020 14:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbgDTSKj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Apr 2020 14:10:39 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F09C061A0C;
        Mon, 20 Apr 2020 11:10:39 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id l3so5216018edq.13;
        Mon, 20 Apr 2020 11:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OsEsVqFYdMSb7DvTNoLz36ojWhYP2bDeJgp2Rpv0Krk=;
        b=CF9oVWum7P6oGqf/+o/Kfq8ccqpl/kqXKpD5Ov3s0d6NsvfIEGAmcv8qfwxjZn0zVg
         ynvyXJBYZxaE6qa+9ImjKr17D04XIQPPy4Yhi0GtZvMcehBwVgh+am27oicRuZZBy69Y
         0UE2jBqxbyKVjh3oWwFNvRqjhQiKr57pzRmKNO0fRLYyr1LtdquWn2zwQmk8e/fSC77+
         DzC+16bcYwTLYolDPEl7ov14N67ELp26piJ8A+kX6zrkQsOK4pZJ4AzYDK0l+vPUoZ9R
         vBNELc1LN+uOG3lJ4pojJI9EQbhO4dPXVorQBY3l7vszpjDGMIh9CeoZLnM5l5pUSdNU
         Af9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OsEsVqFYdMSb7DvTNoLz36ojWhYP2bDeJgp2Rpv0Krk=;
        b=n8q3eGWDsdxfa1oV7caEywVrmSGEoTzXroxa442+neiF8KVBOCOifLwLkDqB80mw0W
         pkz7ZspJim46/gEoYE9fhz06e8wKLheG7QGVjRBkYABgaMaHGgc+dhms+itJ50ePiupk
         XDW7cGwISEQHu7UDjzqS2zQlQpawrR5Y7ZSGM3BzksaOF7XZ20hT05W07Pdxm0nF6aKZ
         Z2vyxodsHb6DwZZv9l017CtKfJhdRwIGJrHeeV2KfPEJBCX4dhcloBebnhB3jyb+8C4X
         oKOLJ334LdI3SIelBPeTDPPzgcq5N++nTjvlJzg9/1rZ0zC+L7hCzT0eSPXL8ww1MBDC
         Y1mg==
X-Gm-Message-State: AGi0PuZnpm7Oi9KAepyRh8Ddsvb6+1XxOZvuFnWxCqJmH6TReymGFKlW
        gz2UQ0BJ1JjsM+TxXng0ydE2VpuEet/WyWvt1HA=
X-Google-Smtp-Source: APiQypKh8INZWiu0vYAwkyTSSdFKBGinZbwNyt+jZO5Euhz9Y9RwZQSR5ngPH+538R2KWSEW23JML9DVlLKeSSsbzMs=
X-Received: by 2002:a50:9ea1:: with SMTP id a30mr16192872edf.318.1587406237905;
 Mon, 20 Apr 2020 11:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200318001603.9650-1-olteanv@gmail.com> <20200318001603.9650-13-olteanv@gmail.com>
 <CAMuHMdUDYWNOOrAXrq1Lf5_GD84Z1rr4Co5buZS-GnJvGyN5yA@mail.gmail.com>
In-Reply-To: <CAMuHMdUDYWNOOrAXrq1Lf5_GD84Z1rr4Co5buZS-GnJvGyN5yA@mail.gmail.com>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Mon, 20 Apr 2020 21:10:27 +0300
Message-ID: <CA+h21hpHeL08Gb36m1RNrE6agebZu7ygz9jFekOH7zGc9uLcSQ@mail.gmail.com>
Subject: Re: [PATCH v5 12/12] arm64: dts: ls1028a-rdb: Add a spidev node for
 the mikroBUS
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Esben Haabendal <eha@deif.com>,
        Angelo Dureghello <angelo@sysam.it>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wei Chen <weic@nvidia.com>, Mohamed Hosny <mhosny@nvidia.com>,
        Michael Walle <michael@walle.cc>, peng.ma@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Geert,

On Mon, 20 Apr 2020 at 21:07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Vladimir,
>
> On Wed, Mar 18, 2020 at 1:17 AM Vladimir Oltean <olteanv@gmail.com> wrote:
> > From: Vladimir Oltean <vladimir.oltean@nxp.com>
> >
> > For debugging, it is useful to have access to the DSPI controller
> > signals. On the reference design board, these are exported to either the
> > mikroBUS1 or mikroBUS2 connector (according to the CPLD register
> > BRDCFG3[SPI3]).
> >
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>
> Thanks for your patch!
>
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> > @@ -83,6 +83,20 @@
> >         };
> >  };
> >
> > +&dspi2 {
> > +       bus-num = <2>;
> > +       status = "okay";
> > +
> > +       /* mikroBUS1 */
> > +       spidev@0 {
>
> Please use generic node names, e.g. "dac@0".
>

It's not a DAC. It's really an unpopulated pin header. I would have
really liked to have access to that as a char device with the default
board DTS, via spidev. That being said, there are warnings to not use
the "spidev" compatible in device trees. So if what I want is not
possible, I'd rather drop the patch altogether.

> > +               compatible = "rohm,dh2228fv";
> > +               spi-max-frequency = <20000000>;
> > +               fsl,spi-cs-sck-delay = <100>;
> > +               fsl,spi-sck-cs-delay = <100>;
> > +               reg = <0>;
> > +       };
> > +};
> > +
> >  &esdhc {
> >         sd-uhs-sdr104;
> >         sd-uhs-sdr50;
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

Thanks,
-Vladimir

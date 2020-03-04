Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 107C81790A7
	for <lists+linux-spi@lfdr.de>; Wed,  4 Mar 2020 13:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388029AbgCDMuy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Mar 2020 07:50:54 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33463 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387776AbgCDMux (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Mar 2020 07:50:53 -0500
Received: by mail-oi1-f193.google.com with SMTP id q81so1975981oig.0;
        Wed, 04 Mar 2020 04:50:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p7FRqJyhTEmACxJGCDQAplfiTQ67K8Njaui3NWndKCk=;
        b=AXhO9OlY0lVdID/ecpqIIVtrBJfdkmicPE/BTRJuf0v7qQX2m0V4pXMlTNiRDL+NNK
         LXHAv2aOfA9rum/wy9l7C/XhiMkIvnmruFIJTOfx9lJijPjU9TtVIr3VN+Bru3lunpDR
         zTvbV7lV41JoMu1KDDoAjqjmjBWCoq35yfjuOeEgTsL+E2+pKZqRlSSxY89nNOrOJFGP
         foS4i8ggUDa2Uyh205kKeWGgt/peVO/UAOxE2PsVT6zS9PG3t40TnO+JDkEmD99I9FGb
         A3Ujst9m8loyNR7LN73Pueniwn+3Z55BdvlX9Rw2SXVJkSzPmELW3j46VA05BmSG8s84
         0SGA==
X-Gm-Message-State: ANhLgQ1qi75F/o3QoB9MrkZUF/qHg/i4OtnBiNIsBnsvMGTA9CpPJ+Do
        oHOPU2vXnMj0GImMu9XI/fJ41YWEdhCUJtQEoy+Zv+kX
X-Google-Smtp-Source: ADFU+vtS15MEGVq3XbpQbW8c0fcWWTHigWSJb+9KT3nHpA8xJ67V9+ALPr8+cGI2pKL0qKyotbflbp2ioN9nMIjOtNo=
X-Received: by 2002:aca:ed04:: with SMTP id l4mr1648104oih.54.1583326253059;
 Wed, 04 Mar 2020 04:50:53 -0800 (PST)
MIME-Version: 1.0
References: <20200303094522.23180-1-geert+renesas@glider.be>
 <20200303094522.23180-2-geert+renesas@glider.be> <CAL_JsqL+9Tcqm_bsorRwqvWZyJXAZmJhXb=EmJ+nZ44kCFp6Kg@mail.gmail.com>
In-Reply-To: <CAL_JsqL+9Tcqm_bsorRwqvWZyJXAZmJhXb=EmJ+nZ44kCFp6Kg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Mar 2020 13:50:41 +0100
Message-ID: <CAMuHMdUBTVZGNtdc0dhUz5d+P2_Fr89MvBCz8=9oQK1EOi7s2w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] spi: dt-bindings: spi-controller: Fix
 #address-cells for slave mode
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

On Tue, Mar 3, 2020 at 10:05 PM Rob Herring <robh+dt@kernel.org> wrote:
> On Tue, Mar 3, 2020 at 3:45 AM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > Currently, the DT bindings for an SPI controller specify that
> > "#address-cells" must be fixed to one.  However, that applies to an SPI
> > controller in master mode only.  When running in SPI slave mode,
> > "#address-cells" should be zero.
> >
> > Fix this making the value of "#address-cells" dependent on the presence
> > of "spi-slave".
> >
> > Fixes: 0a1b929356830257 ("spi: Add YAML schemas for the generic SPI options")
> > Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > v2:
> >   - Use "enum: [0, 1]" instead of min/max limit,
> >   - use "- spi-slave" instead of "[ spi-slave ]".
> >
> > As of dtc commit 403cc79f06a135ae ("checks: Update SPI bus check for
> > 'spi-slave'") and Linux commit c2e7075ca8303631 ("scripts/dtc: Update to
> > upstream version v1.4.7-57-gf267e674d145"), dtc knows about SPI slave.
> >
> > However, when using "#address-cells = <0>" with W=1:
> >
> >     Warning (avoid_unnecessary_addr_size): /soc/spi@e6e10000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>
> What was the point in having #address-cells in the first place for
> slaves?

I don't know, commit a8830cb19cfea04e ("spi: Document DT bindings for
SPI controllers in slave mode") doesn't require any #address-cells for
slave mode.

Perhaps because node_addr_cells() in dtc defaults to 2?
Or because of_bus_n_addr_cells() walks up the parent chain and thus
defaults to the first found parent value?

> Seems like we should make it mutually exclusive with 'spi-slave'.

Sounds like a good idea. How to express that in yaml?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

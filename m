Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2711597AA
	for <lists+linux-spi@lfdr.de>; Tue, 11 Feb 2020 19:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731150AbgBKSFO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Feb 2020 13:05:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:35796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731149AbgBKSFO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 Feb 2020 13:05:14 -0500
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91814208C3;
        Tue, 11 Feb 2020 18:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581444313;
        bh=6PE1cQDVRluOgEBrX4BbGhN0yYnAPz0zqhe0TovaI5o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l1Sa6LV29Nk2K2rAs5pOGEdWBrK7blZ394zkXkcKtGeTSea4pto6xOb1UC68LvoCb
         rQcQkopTRHIkdvHboYFj7gcwFDBRV0Ay8v9AXIo6AahAcEAMIjHAGoo+hvdXaboJ8K
         /FUJ5aUHuqo8wnpZQT4pyg7N6GzSzhJ0h0lMCm4M=
Received: by mail-qk1-f175.google.com with SMTP id z19so7940554qkj.5;
        Tue, 11 Feb 2020 10:05:13 -0800 (PST)
X-Gm-Message-State: APjAAAUerb4PgCnHvqiurxiUKNCN4ViBEFdeAoWL/EKVCNB4guzu5ron
        cES1qOx3XUZE2lpGa2Jvg21D8B/6Vx5vCs37pw==
X-Google-Smtp-Source: APXvYqzAAdsaAknJAJ5NQJ1yPYP+6XiEu2QBieclv1o0pXq2SzMkQhREIj0fKiHyiUC2B4XLKseSBuDPfByqgqJIuII=
X-Received: by 2002:a37:85c4:: with SMTP id h187mr7476483qkd.223.1581444312635;
 Tue, 11 Feb 2020 10:05:12 -0800 (PST)
MIME-Version: 1.0
References: <20200202125950.1825013-1-aford173@gmail.com> <20200202125950.1825013-4-aford173@gmail.com>
 <20200206184030.GA11381@bogus> <CAHCN7x+uCwyJ60ZG_0m5SgNmqUAyEwxqXVTL7nQzJLXxXrh+Tw@mail.gmail.com>
In-Reply-To: <CAHCN7x+uCwyJ60ZG_0m5SgNmqUAyEwxqXVTL7nQzJLXxXrh+Tw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 11 Feb 2020 12:05:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLJweVLgYhoU-3cmg1aFwRNtAehx2-Euy-cwUsRy2jsgw@mail.gmail.com>
Message-ID: <CAL_JsqLJweVLgYhoU-3cmg1aFwRNtAehx2-Euy-cwUsRy2jsgw@mail.gmail.com>
Subject: Re: [PATCH V2 4/5] dt-bindings: spi: spi-nxp-fspi: Add support for
 imx8mm, imx8qxp
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Feb 11, 2020 at 4:49 AM Adam Ford <aford173@gmail.com> wrote:
>
> On Thu, Feb 6, 2020 at 2:46 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Sun, Feb 02, 2020 at 06:59:49AM -0600, Adam Ford wrote:
> > > Add support for nxp,imx8qxp-fspi and nxp,imx8mm-fspi do the bindings
> >
> > s/do/to/
>
> Oops.  Thanks for catching that.
>
> >
> > > document.
> > >
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > ---
> > > V2: No change
> > >
> > > diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> > > index 2cd67eb727d4..7ac60d9fe357 100644
> > > --- a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> > > +++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> > > @@ -2,6 +2,9 @@
> > >
> > >  Required properties:
> > >    - compatible : Should be "nxp,lx2160a-fspi"
> > > +                         "nxp,imx8qxp-fspi"
> > > +                         "nxp,imx8mm-fspi"
> >
> > All 3 are different and no compatibility?
>
> This was all based on a series from NXP's repo where they have some
> data tables all associated to the various compatible entries, and they
> created a place holder for quirks.  Based on an older NXP repo, it
> seems like there might be some quirks associated to the different
> families, but the newer repo where I got this patch series didn't
> implement them, however, it's possible the quirks may enhance
> functionality later. If that's true, I think this is the best solution
> for future enhancements without having to change the compatibility
> names down the road.  Maybe someone from NXP can comment?  I am just
> trying to help push things upstream so we can support QSPI flash.  I
> would prefer to keep them separate for now, because we might have
> these improvements later. However, I'll do what you request.  Do you
> want me to drop the additional compatible flags and just use the
> original, or create a new one that's a bit more generic?

Neither.

If you already know that they have differences, then as-is is fine.

If they are believed to be 'the same', then you do:

compatible = "nxp,imx8qxp-fspi", "nxp,imx8mm-fspi";

assuming i.MX8MM was the first version.

This allows a MX8QXP to work without OS changes if the driver already
supports the previous chip. And if any quirks are found, then the OS
can handle them without a DT change.

Rob

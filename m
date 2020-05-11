Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC58F1CD10F
	for <lists+linux-spi@lfdr.de>; Mon, 11 May 2020 06:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgEKEwv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 May 2020 00:52:51 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:55687 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725884AbgEKEwu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 May 2020 00:52:50 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 5AFCA3FA;
        Mon, 11 May 2020 00:52:49 -0400 (EDT)
Received: from imap26 ([10.202.2.76])
  by compute3.internal (MEProxy); Mon, 11 May 2020 00:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=tHIWHGwD2awLQ7YfvHIbcGG38ivg
        dphn08I12CZ2Xx4=; b=QCTj+BVkhFwvH/TOjPuWMhgNEpOGamwHoEcavOmIuSIW
        VPQCGmRBC5zrYOHgXfRxcH7T33qczjumF32ChqB7WqueeG7i86pNit8OspWAhgla
        lQoTj01/mnZLMkxD2xeJBZMRk3AQPLtcJScVuc9BxWzxyHBooRqSBp1kHE+3MhWl
        6Gh4y81FVOHt/UfyOC9d/7NZ73zFDiMul2U8AZgceVQXhYEQkVrOKA1sFc96ViZK
        P/vjcvVmBimEFphNpz8SXx5RwAuOvipiQMZJqU9yM9MNQv0sp84hGO77cAEh2xeP
        v+3aMOA0fOtHVcSSZfKIm5/bfYjzlHqZjeys4Uld+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=tHIWHG
        wD2awLQ7YfvHIbcGG38ivgdphn08I12CZ2Xx4=; b=gFP7sW5ExcrIVbqJ+saGLi
        i99R+Z3Q5Ik33sL3sQpDH+F5vCwrHfC945pQeaA/E0u6Vsfl4bvfd6PwrK2ntx2H
        iSTzHu0fHoD9Uhpt+MjRtr7LXjb8lbME/661m2WKkNFGmI1UDW9QucZHAUAiNjOR
        KScxVJzDTI4eg1F1VqjzyWlkwd2IL1ZPIX62nCS8RyL3XU4LX8E+c3KhxOtxmByX
        /RTfvGanwj5+XvxtH/D0n5S7f9o4fFpGtgTSXkKFw6DPPD3uPe0bHgOkUe4disWz
        z7nJdxzGZqOKigGt6/g0JWJTF9a+qHOe2eStSLtafbo9KAUJA35zAZUFEZDl3Tpg
        ==
X-ME-Sender: <xms:INq4XhHZYc17U9LVumxao8pYJxhjT3UkutMvDJWgUVUtVMrHtf8puQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrkeelgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpeetlhhishht
    rghirhcuoegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrth
    htvghrnhepueffkeevheejledtueevieekleekjefhjeehudfhtdfgtdfgjeejkedvveej
    veeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:INq4XtOYh1BjK-l9aCyqQ3N8CAmTdf-2sj69GAnnPTBJC5QTNA8TOg>
    <xmx:INq4Xrc2oJyv7MLmmA5mEaYGv8hEtzSnDLBuMU8h5kzjbPMiJJDHqw>
    <xmx:INq4XivgtEnnbOfpUcLdjQ-kdG4AX2gtuM9uH7UCQUvvu98hb50nng>
    <xmx:Idq4Xn-si6AyLlkZU2ihXLcHNdiHyr0DRv_TSgEGL63mmPBIJSbPfA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2766E14200A2; Mon, 11 May 2020 00:52:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-413-g750b809-fmstable-20200507v1
Mime-Version: 1.0
Message-Id: <7d6d1494-31a7-4780-85f3-8bbc2f32bcd6@www.fastmail.com>
In-Reply-To: <CAMuHMdV7qGSbw44O+ykSz3W6h6oxj-ir+9qRbeazKb+p7Z=2Mg@mail.gmail.com>
References: <20200506014135.2941967-1-alistair@alistair23.me>
 <CAMuHMdV7qGSbw44O+ykSz3W6h6oxj-ir+9qRbeazKb+p7Z=2Mg@mail.gmail.com>
Date:   Sun, 10 May 2020 21:52:27 -0700
From:   Alistair <alistair@alistair23.me>
To:     "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc:     "Mark Brown" <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Chen-Yu Tsai" <wens@csie.org>,
        "Alistair Francis" <alistair23@gmail.com>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] spi: sun6i: Add support for GPIO chip select lines
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, May 6, 2020, at 1:27 AM, Geert Uytterhoeven wrote:
> Hi Alistair,
> 
> On Wed, May 6, 2020 at 3:41 AM Alistair Francis <alistair@alistair23.me> wrote:
> > Add a setup function that can be used to support using generic GPIO
> > lines for the chip select.
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > ---
> > drivers/spi/spi-sun6i.c | 27 +++++++++++++++++++++++++++
> > 1 file changed, 27 insertions(+)
> >
> > diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> > index ec7967be9e2f..fd4e19434942 100644
> > --- a/drivers/spi/spi-sun6i.c
> > +++ b/drivers/spi/spi-sun6i.c
> > @@ -10,6 +10,7 @@
> > #include <linux/clk.h>
> > #include <linux/delay.h>
> > #include <linux/device.h>
> > +#include <linux/gpio.h>
> > #include <linux/interrupt.h>
> > #include <linux/io.h>
> > #include <linux/module.h>
> > @@ -171,6 +172,31 @@ static inline void sun6i_spi_fill_fifo(struct sun6i_spi *sspi, int len)
> > }
> > }
> >
> > +static int sun6i_spi_setup(struct spi_device *spi)
> > +{
> > + int ret;
> > +
> > + /* sanity check for native cs */
> > + if (spi->mode & SPI_NO_CS)
> > + return 0;
> > + if (gpio_is_valid(spi->cs_gpio)) {
> > + /* with gpio-cs set the GPIO to the correct level
> > + * and as output (in case the dt has the gpio not configured
> > + * as output but native cs)
> > + */
> > + ret = gpio_direction_output(spi->cs_gpio,
> > + (spi->mode & SPI_CS_HIGH) ? 0 : 1);
> > + if (ret)
> > + dev_err(&spi->dev,
> > + "could not set gpio %i as output: %i\n",
> > + spi->cs_gpio, ret);
> > +
> > + return ret;
> > + }
> > +
> > + return 0;
> > +}
> > +
> > static void sun6i_spi_set_cs(struct spi_device *spi, bool enable)
> > {
> > struct sun6i_spi *sspi = spi_master_get_devdata(spi->master);
> > @@ -470,6 +496,7 @@ static int sun6i_spi_probe(struct platform_device *pdev)
> >
> > master->max_speed_hz = 100 * 1000 * 1000;
> > master->min_speed_hz = 3 * 1000;
> > + master->setup = sun6i_spi_setup;
> > master->set_cs = sun6i_spi_set_cs;
> > master->transfer_one = sun6i_spi_transfer_one;
> > master->num_chipselect = 4;
> 
> Can't you just set
> 
>  master->use_gpio_descriptors = true;
> 
> instead and be done with it?
> Then drivers/spi/spi.c:spi_get_gpio_descs() will configure the GPIO line
> as output for you.

Yep, it looks like that works. Sending a v2.

Alistair

> 
> Gr{oetje,eeting}s,
> 
>  Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>  -- Linus Torvalds
> 

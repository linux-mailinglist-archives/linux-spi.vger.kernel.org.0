Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724891CCC2B
	for <lists+linux-spi@lfdr.de>; Sun, 10 May 2020 18:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgEJQPk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 10 May 2020 12:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726446AbgEJQPk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 10 May 2020 12:15:40 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA4BC061A0C;
        Sun, 10 May 2020 09:15:40 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id o8so3815739ybc.11;
        Sun, 10 May 2020 09:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jP2OppdWYHG9ae8C528jnvGRJr3i8WffS/Btmm79ef4=;
        b=UJVMboicOJwIStVUYHd58OCXInFzut0XWyCZVxttgKZS7QWuKI0cEuXq7+Otzj1xrF
         RI28MvZ4wnyR66Y5SdApVlL5bynlIkreJTc81Fv1wpZwmFmaec0E+v0Nt05DpO6RKKvK
         PdYhAi45YwJkA+fGV8ZfQWIMJq3AOC49pZVKWc/vh2zpYchQH1QOZG08kzCYoSdLaDNl
         Iy5qNC73aV9h0lKQZiXNfJqTkb3VzLJfW+z0tNwNd4Nzx7lnupcarj2UpL9jr/FmlFrc
         5puOqeRv4QCSYTBmng7kukOsXQjCcAtguVqoRY4ta+ETqJtjZInii+dm5nGDCW69Lc8s
         wtpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jP2OppdWYHG9ae8C528jnvGRJr3i8WffS/Btmm79ef4=;
        b=bxrxvGJ5VYH2Qsd5uJ+PX2b3medmj21UquiPwjLTqCE3dyX3KcbE3Cgk/ufKcU9eA6
         7WHWQYG+e/qhy+CMG4jEyxs9Jwqy99z+kNPVhEhlT3ZSczo82JwyBzVwOVinFPufvv5p
         qI/CSdH8r3ZDIo/ArTDveHejGzstXF5viVrQ6ZIZk6TCuEhI6O5o0stiJytOihigGBZF
         BlPrl5L5C3jIargoqIpcs9E+4stn1Ng/mWAPZBuPM9wckkPcPJHi3nYg//cDPfelF8Pr
         q2Q8lghw82olDJtd84Ihh34l1Nm/mvgNemSS2n38MFpfQUpxAh6zL22i2uF/zgpWD3+2
         DuoA==
X-Gm-Message-State: AGi0PuZ9lduYUDnuijWbl5EJBo9iAHc7F0dqmew4IY7rBkloufDQCO6q
        BGWPw9sE1oHgkYZXEPGkypVJLoG3g/74O/3Au3E=
X-Google-Smtp-Source: APiQypKywA8Hib3xDA/OXgsS2tECxAn+F0IIkb1c1aowKuxjItssElORtZsiGLY5OvroP4pQlIXgPV/MwEp4L+XvpK4=
X-Received: by 2002:a25:c402:: with SMTP id u2mr18775323ybf.231.1589127339046;
 Sun, 10 May 2020 09:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200508083729.5560-1-chris.ruehl@gtsys.com.hk>
 <20200508083729.5560-2-chris.ruehl@gtsys.com.hk> <CANBLGcwA+=OB-_nOYUijWrDBSkLYhR7_PNG1ewO7LZ-zRVGoxg@mail.gmail.com>
 <3890ba80-f9f7-7f22-5cb5-5b78bbf042e7@gtsys.com.hk>
In-Reply-To: <3890ba80-f9f7-7f22-5cb5-5b78bbf042e7@gtsys.com.hk>
From:   Emil Renner Berthing <emil.renner.berthing@gmail.com>
Date:   Sun, 10 May 2020 18:15:27 +0200
Message-ID: <CANBLGcxmAyPhnUB0hKdxcg7dQCfQLaHYY1Uxc6-GOmmF6rvK8Q@mail.gmail.com>
Subject: Re: [PATCH v0 1/1] spi: spi-rockchip: add support for spi slave_mode
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Jack Lo <jack.lo@gtsys.com.hk>, Heiko Stuebner <heiko@sntech.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Chris,

On Sat, 9 May 2020 at 02:10, Chris Ruehl <chris.ruehl@gtsys.com.hk> wrote:
>
> Hi Emil,
>
> thanks for the review and your comments
>
> On 8/5/2020 9:13 pm, Emil Renner Berthing wrote:
> > Hi Chris,
> >
> > On Fri, 8 May 2020 at 10:47, Chris Ruehl <chris.ruehl@gtsys.com.hk> wrote:
> >> This patch aim to add spi slave mode support to the rockchip driver.
> >> Fix the wrong usage of num_cs set fix to ROCKCHIP_SPI_MAX_CS_NUM,
> >> instead use max_native_cs flag to set the limit of native chip-select.
> >> Enable use_gpio_descriptors to have cs_gpiod for gpio based chip-selects.
> >>
> >> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> >> ---
> >>   drivers/spi/spi-rockchip.c | 46 +++++++++++++++++++++++++++++++++-----
> >>   1 file changed, 41 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> >> index 70ef63e0b6b8..9c1ff52c0f85 100644
> >> --- a/drivers/spi/spi-rockchip.c
> >> +++ b/drivers/spi/spi-rockchip.c
> >> @@ -183,6 +183,9 @@ struct rockchip_spi {
> >>          u8 rsd;
> >>
> >>          bool cs_asserted[ROCKCHIP_SPI_MAX_CS_NUM];
> >> +
> >> +       bool slave_mode;
> >> +       bool slave_abort;
> >>   };
> >>
> >>   static inline void spi_enable_chip(struct rockchip_spi *rs, bool enable)
> >> @@ -359,7 +362,7 @@ static void rockchip_spi_dma_rxcb(void *data)
> >>          struct rockchip_spi *rs = spi_master_get_devdata(master);
> >>          int state = atomic_fetch_andnot(RXDMA, &rs->state);
> >>
> >> -       if (state & TXDMA)
> >> +       if (state & TXDMA && !rs->slave_abort)
> >>                  return;
> >>
> >>          spi_enable_chip(rs, false);
> >> @@ -372,7 +375,7 @@ static void rockchip_spi_dma_txcb(void *data)
> >>          struct rockchip_spi *rs = spi_master_get_devdata(master);
> >>          int state = atomic_fetch_andnot(TXDMA, &rs->state);
> >>
> >> -       if (state & RXDMA)
> >> +       if (state & RXDMA && !rs->slave_abort)
> >>                  return;
> >>
> >>          /* Wait until the FIFO data completely. */
> >> @@ -466,6 +469,10 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
> >>          u32 cr1;
> >>          u32 dmacr = 0;
> >>
> >> +       if (rs->slavemode)
> >> +               cr0 |= CR0_OPM_SLAVE << CR0_OPM_OFFSET;
> >> +       rs->slave_abort = false;
> >> +
> >>          cr0 |= rs->rsd << CR0_RSD_OFFSET;
> >>          cr0 |= (spi->mode & 0x3U) << CR0_SCPH_OFFSET;
> >>          if (spi->mode & SPI_LSB_FIRST)
> >> @@ -535,6 +542,16 @@ static size_t rockchip_spi_max_transfer_size(struct spi_device *spi)
> >>          return ROCKCHIP_SPI_MAX_TRANLEN;
> >>   }
> >>
> >> +static int rockchip_spi_slave_abort(struct spi_master *master)
> >> +{
> >> +       struct rockchip_spi *rs = spi_master_get_devdata(master);
> >> +
> >> +       rs->slave_abort = true;
> >> +       complete(master);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >>   static int rockchip_spi_transfer_one(
> >>                  struct spi_master *master,
> >>                  struct spi_device *spi,
> >> @@ -589,14 +606,25 @@ static int rockchip_spi_probe(struct platform_device *pdev)
> >>          struct spi_master *master;
> >>          struct resource *mem;
> >>          u32 rsd_nsecs;
> >> +       bool slave_mode;
> >> +       u32 num_cs = 1;
> >> +
> >> +       slave_mode = of_property_read_bool(np, "spi-slave");
> >> +
> >> +       if (slave_mode)
> >> +               master = spi_alloc_slave(&pdev->dev,
> >> +                               sizeof(struct rockchip_spi));
> >> +       else
> >> +               master = spi_alloc_master(&pdev->dev,
> >> +                               sizeof(struct rockchip_spi));
> >>
> >> -       master = spi_alloc_master(&pdev->dev, sizeof(struct rockchip_spi));
> >>          if (!master)
> >>                  return -ENOMEM;
> >>
> >>          platform_set_drvdata(pdev, master);
> >>
> >>          rs = spi_master_get_devdata(master);
> >> +       rs->slave_mode = slave_mode;
> > This entry doesn't seem to be read from any of your code, and even it
> > it was, the same information is available in master->slave, so I don't
> > see why you need it in the rockchip_spi struct.
> I haven't see the slave flag in the spi_controller struct, I will store the
> information
> there.
> >
> > Also spi_master is just #defined to spi_controller in spi.h, so maybe
> > consider changing all 'struct spi_master *master' to 'struct
> > spi_controller *ctrl' now that the driver supports both modes.
> Can do,  but I think that is better to have a separate patch for it,
> make it easier for review.

Yes, you should probably do something like

patch 1/3: change struct spi_master *master to struct spi_controller *ctrl
patch 2/3: add slave slave mode
patch 3/3: use num-cs property for ctrl->num_chipselect

> >
> >>          /* Get basic io resource and map it */
> >>          mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> @@ -676,7 +704,16 @@ static int rockchip_spi_probe(struct platform_device *pdev)
> >>          master->auto_runtime_pm = true;
> >>          master->bus_num = pdev->id;
> >>          master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP | SPI_LSB_FIRST;
> >> -       master->num_chipselect = ROCKCHIP_SPI_MAX_CS_NUM;
> >> +       if (slave_mode) {
> >> +               master->mode_bits |= SPI_NO_CS;
> >> +               master->slave_abort = rockchip_spi_slave_abort;
> >> +       } else {
> >> +               of_property_read_u32(np, "num-cs", &num_cs);
> >> +               master->num_chipselect = num_cs;
> > If you do something like this you won't need the temporary num_cs variable:
> >
> > if (of_property_read_u32(np, "num-cs", &master->num_chipselect))
> >      master->num_chipselect = 1;
> Like it , can see clearly the fallback to a default if num-cs isn't set in the
> dts.
> >
> > Also it seems like you're changing the default from
> > ROCKCHIP_SPI_MAX_CS_NUM to 1 if there is no num-cs property. Did you
> > check that all boards either have the num-cs property defined or only
> > needs num_chipselect = 1?
> Only spi0 of the rockchip has a 2nd native chip select, all others a single only
> therefore I find it less evil to use 1 vs. ROCKCHIP_SPI_MAX_CS_NUM
>
> >> +               master->use_gpio_descriptors = true;
> >> +               master->max_native_cs = ROCKCHIP_SPI_MAX_CS_NUM;
> >> +               master->flags = SPI_MASTER_GPIO_SS;
> >> +       }
> >>          master->dev.of_node = pdev->dev.of_node;
> >>          master->bits_per_word_mask = SPI_BPW_MASK(16) | SPI_BPW_MASK(8) | SPI_BPW_MASK(4);
> >>          master->min_speed_hz = rs->freq / BAUDR_SCKDV_MAX;
> >> @@ -686,7 +723,6 @@ static int rockchip_spi_probe(struct platform_device *pdev)
> >>          master->transfer_one = rockchip_spi_transfer_one;
> >>          master->max_transfer_size = rockchip_spi_max_transfer_size;
> >>          master->handle_err = rockchip_spi_handle_err;
> >> -       master->flags = SPI_MASTER_GPIO_SS;
> >>
> >>          master->dma_tx = dma_request_chan(rs->dev, "tx");
> >>          if (IS_ERR(master->dma_tx)) {
> >> --
> >> 2.20.1
> >>
> >>
> >> _______________________________________________
> >> Linux-rockchip mailing list
> >> Linux-rockchip@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>
> --
> GTSYS Limited RFID Technology
> 9/F, Unit E, R07, Kwai Shing Industrial Building Phase 2,
> 42-46 Tai Lin Pai Road, Kwai Chung, N.T., Hong Kong
> Tel (852) 9079 9521
>
> Disclaimer: https://www.gtsys.com.hk/email/classified.html
>

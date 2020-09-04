Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C83725D932
	for <lists+linux-spi@lfdr.de>; Fri,  4 Sep 2020 15:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730282AbgIDNCw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Sep 2020 09:02:52 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:59041 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730018AbgIDNCv (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 4 Sep 2020 09:02:51 -0400
IronPort-SDR: LPv6p8VBFjjcYmntUG0UAnpzcSHEGq4/UIIvdKKqNHArY5TBgsO4ETEWjW6no+TchXzZwbbEk3
 YEFZx7XP0b5/C9lesgHYWh6X/Tl3phEGa4HQOoZoOu16AJWgvPNP5d8zpxC3odLZ/L47GzCV03
 dDL4bAA6vmGeDg8eeRkksQVguhJfu+gh+uNWyb9RQEreZG+uRLL0EpSWCWU04u4dRHIyr5R6o0
 l1QUrAykCeRnt0AfK4dJqqxzIXDo0Q+AlYiKXW7XO0ZWIJNV1D8XdeUFS22lzlZz7aJsqVKwMR
 X74=
X-IronPort-AV: E=Sophos;i="5.76,389,1592863200"; 
   d="scan'208";a="13736372"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 04 Sep 2020 15:02:48 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 04 Sep 2020 15:02:48 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 04 Sep 2020 15:02:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1599224568; x=1630760568;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sxPcx61j+oNNPmi+1j+653tuMkYTgM/PcPrvPEAVVis=;
  b=cQGvEXlk8ZJ37Cnhu5CrGx0xuwN4DZt5YVHAmyXnnb8Jzfk19MhqlpfR
   Zoy+Fc4xDPGh5VMu31PkLUg0slb4qnrETnKNqJvLfQRT6e9SUobIe0OgR
   q3TJVJ2419D9YVypiHKGvQROGUgnkPUfnpjwQgDCU2QQ/70U2cqItS1ic
   GpjMYmZthmuzmgapE75efqPWQ/SiAymhuXigqIBkWa8rq7SQvs9QAkGX1
   ydOGSgwiafx16rESkwfQfuS81QT2aujDsQMKjWsHCETS7BrhgPaCpzbim
   OgEBAzVGE2LOx87X92DsQiCREiv5FwHs/6Z0Q4VdQs6CP6VoUC2y2SeDk
   Q==;
IronPort-SDR: ghZlZR/81gsikeGmjRjXFgzkK32ULfrL8wtbfdzoLHSPLn5nfALJyP31rtj+vz46dVhf9l4r8A
 XGXYe4TTNmWiOsXevFtrxOdOn+SGRnqFB5kMVNCvPWxslE8J2je7MkV9rqjjUebz5PSDmSdIld
 zj1O2OnbqqcEWZHb+MPFAAcBQLis7eG3h5UmIVW00vz+Tx2VEGm6hIyLzf2sIufRnr2C6pUsif
 jNz6rCgUq1vhtGKZt0KS4VAuXW3/vbKuCtt0VNbFdZNll9zGpbb2t/AqE3IHZbBolKf1437RBy
 6NM=
X-IronPort-AV: E=Sophos;i="5.76,389,1592863200"; 
   d="scan'208";a="13736371"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 04 Sep 2020 15:02:48 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id A4509280065;
        Fri,  4 Sep 2020 15:02:48 +0200 (CEST)
Message-ID: <e1431dd2653dbffdfec39a2e7167db07836e30ac.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: [PATCH] spi-imx: remove num-cs support, set
 num_chipselect to 4
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 04 Sep 2020 15:02:46 +0200
In-Reply-To: <CAOMZO5DGHoG_8X+fbrGCHR4g=sGdEaF7bYrHbC_2T=aUnfTs8g@mail.gmail.com>
References: <20200903144028.20416-1-matthias.schiffer@ew.tq-group.com>
         <CAOMZO5DGHoG_8X+fbrGCHR4g=sGdEaF7bYrHbC_2T=aUnfTs8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 2020-09-04 at 09:35 -0300, Fabio Estevam wrote:
> Hi Matthias,
> 
> On Thu, Sep 3, 2020 at 11:40 AM Matthias Schiffer
> <matthias.schiffer@ew.tq-group.com> wrote:
> > 
> > The num-cs property is not considered useful, and no in-tree Device
> > Trees define it for spi-imx.
> > 
> > The default value to be used when no cs-gpios are defined is set to
> > 4 to
> > give access to all native CS pins of modern i.MX SoCs (i.MX6 and
> > newer).
> > 
> > In older SoCs, the number of CS pins varies (for example the i.MX27
> > has 3
> > CS pins on CSPI1 and CSPI2, and only a single CS on CSPI3).
> > Attempting
> > to use the nonexisting CS pin would be an easy to notice DT
> > misconfiguration; making the driver catch this doesn't seem
> > worthwhile.
> > 
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com
> > >
> > ---
> >  drivers/spi/spi-imx.c | 13 +------------
> >  1 file changed, 1 insertion(+), 12 deletions(-)
> > 
> > diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> > index 197f60632072..aece8482739b 100644
> > --- a/drivers/spi/spi-imx.c
> > +++ b/drivers/spi/spi-imx.c
> > @@ -1581,7 +1581,6 @@ static int spi_imx_probe(struct
> > platform_device *pdev)
> >         const struct spi_imx_devtype_data *devtype_data = of_id ?
> > of_id->data :
> >                 (struct spi_imx_devtype_data *)pdev->id_entry-
> > >driver_data;
> >         bool slave_mode;
> > -       u32 val;
> > 
> >         slave_mode = devtype_data->has_slavemode &&
> >                         of_property_read_bool(np, "spi-slave");
> > @@ -1605,6 +1604,7 @@ static int spi_imx_probe(struct
> > platform_device *pdev)
> >         master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
> >         master->bus_num = np ? -1 : pdev->id;
> >         master->use_gpio_descriptors = true;
> > +       master->num_chipselect = 4;
> 
> On an imx6q-sabresd, which only has one SPI chip-select via GPIO,
> this
> makes the SPI core to understand that it has 4 chip selects.
> 
> From spi_get_gpio_descs() in drivers/spi/spi.c:
> 
> ctlr->num_chipselect = max_t(int, nb, ctlr->num_chipselect);
> 
> It is 4 now after your patch, it was 3 after 8cdcd8aeee28 ("spi:
> imx/fsl-lpspi: Convert to GPIO descriptors") and 1 before such
> commit.
> 
> Couldn't we just remove master->num_chipselect from the spi-imx.c
> driver?

This would make num_chipselect default to 1 again (set by
__spi_alloc_controller()), breaking every i.MX board that uses more
than 1 native CS.

I'm aware that using cs-gpios instead of native CS is probably a good
idea in any case, as the native CS of this SPI controller is kinda
flaky (and at a glance it looks like all in-tree DTs do this; not sure
about board files that don't use DTs?), but I'm not convinced that
breaking native CS support completely is desirable either.


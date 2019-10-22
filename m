Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09946E0655
	for <lists+linux-spi@lfdr.de>; Tue, 22 Oct 2019 16:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfJVO0r (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Oct 2019 10:26:47 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45745 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfJVO0r (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Oct 2019 10:26:47 -0400
Received: by mail-oi1-f195.google.com with SMTP id o205so14302250oib.12
        for <linux-spi@vger.kernel.org>; Tue, 22 Oct 2019 07:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qiAt8L5OT3hXdkzH1lX9kQo6mopwtjKLecR9EfE5xgg=;
        b=MpdvXUMdfT/V772BtXPLVkhd9CKJHlRZ20jF1/xIBbE4IPR004TNJxOTuHa9giJCdz
         aiG9647INNqAKsjCI27O6js5vP4biCXwFRGGN2L2om0Kiu/MHFk7WOAZvIPLgkss6qyf
         +S99U/GtumDy0lR9UHwqNdYE1Z9skSJIygDr+sqKMtglxS7apLwgNaVMN8KKiNjJU8kH
         09hW5NthYjXn4Nd96RXkMA8Y7RB/QpW2keVo1SMtc+Nu9r/yOHsSozwwEAVXMLCVQlCo
         Kk30ljPoupdcd7tkGmcGyny3QzZI++M8gIllx3jVE/G6GxQIKxHGfxAYtXwOJKwXB8JG
         zUDA==
X-Gm-Message-State: APjAAAUeT0/Do6154PgQvA9kif3QtLXRzNoozxtzdKCbQPO2KW8kWAqK
        kXeucSFtb1spbt+AN8Dhlml8lDRvdWe54SvoOpE=
X-Google-Smtp-Source: APXvYqzC0UHABmNjAOHpWJknjyJygUOk2PgBYwyqnUOO4Y9u6/oqtVrWMnD0vDxaT/7dNCBcRdwVhtlVTAAtXIFIUYE=
X-Received: by 2002:a54:4e89:: with SMTP id c9mr3071439oiy.148.1571754404335;
 Tue, 22 Oct 2019 07:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191022090007.15147-1-alvaro.gamez@hazent.com>
 <20191022102007.GA5554@sirena.co.uk> <20191022102859.GA1928@salem.gmr.ssr.upm.es>
 <CAMuHMdWavg_50DrKnSa5K9j4oxN5gn0RWGhS2yr42x6okHvLoQ@mail.gmail.com> <20191022140135.GA16222@salem.gmr.ssr.upm.es>
In-Reply-To: <20191022140135.GA16222@salem.gmr.ssr.upm.es>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 22 Oct 2019 16:26:32 +0200
Message-ID: <CAMuHMdVua2XLOYJAO=JWf=e_7qnHsta6ojSeOTzJ8-iFVqCsyQ@mail.gmail.com>
Subject: Re: [PATCH] spi: xilinx: Add DT support for selecting transfer word width
To:     Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Alvaro,

On Tue, Oct 22, 2019 at 4:01 PM Alvaro Gamez Machado
<alvaro.gamez@hazent.com> wrote:
> On Tue, Oct 22, 2019 at 03:03:18PM +0200, Geert Uytterhoeven wrote:
> > On Tue, Oct 22, 2019 at 12:38 PM Alvaro Gamez Machado
> > <alvaro.gamez@hazent.com> wrote:
> > > On Tue, Oct 22, 2019 at 11:20:07AM +0100, Mark Brown wrote:
> > > > On Tue, Oct 22, 2019 at 11:00:07AM +0200, Alvaro Gamez Machado wrote:
> > > >
> > > > >             of_property_read_u32(pdev->dev.of_node, "xlnx,num-ss-bits",
> > > > >                                       &num_cs);
> > > > > +           ret = of_property_read_u32(pdev->dev.of_node,
> > > > > +                                      "xlnx,num-transfer-bits",
> > > > > +                                      &bits_per_word);
> > > > > +           if (ret)
> > > > > +                   bits_per_word = 8;
> > > >
> > > > Any new DT property needs documentation adding but in any case this
> > >
> > > Oh, ok. If this patch is of any interest, then I should provide changes to
> > > the appropriate file under Documentation/, is that right?
> > >
> > > I was preparing and testing a second patch to add "spi-bits-per-word"
> > > property to children of the SPI driver, similar to the spi-max-frequency
> > > property and others alike, to fully support AXI Quad SPI core with different
> > > word widths. This also modifies the DT, so I guess it'd be better to send a
> > > single patch that comprises all these changes alongside the DT
> > > documentation. Would that be correct procedure?
> >
> > Is this "spi-bits-per-word" a property of the SPI slave device?
> > If yes, it may be better to hardcode it in the SPI slave device driver,
> > as it is fixed for that type of SPI slave.
> >
> > If not, perhaps I'm misunderstanding the purpose.
>
> Ok, this is a bit confusing and my patch didn't really explain a lot. I'll
> try to explain myself and not make a lot of mistakes.
>
> Most, if not all SPI slaves, have a fixed word width, which is typically 8
> bits, but there exist some devices for which this value is 16, 32 or who
> knows what.
>
> On the other hand, master SPI devices may have the possibility to use word
> widths of 8, 16, 32 or whatever, and some of them may be able to switch its
> word width on demand.

OK.

> The specific case of AXI Quad SPI core is that you choose this value upon
> instantiation and you cannot modify it via software. This means that you
> could instantiate an 8 bit IP core to talk to a 32 wordwidth slave, and
> you'd get no useful communication, that's the harwdare designer
> responsibility: both devices must match in its wordwidth.
>
> More over, it seems that linux needs to know this information to build the
> messages it needs to send to the SPI master.

You also have to configure this in spi_controller.bits_per_word_mask.
Typical values are:
    - SPI_BPW_RANGE_MASK(8, 32),
    - SPI_BPW_MASK(8) | SPI_BPW_MASK(16) | SPI_BPW_MASK(32),
    - SPI_BPW_MASK(8).

So you have to use SPI_BPW_MASK(8)[*] resp. SPI_BPW_MASK(32).

[*] This could actually be relaxed to 8/16/24/32, as the last three can be
    emulated using 8.

> For something this simple, I believe the best approach is a DT property, as
> I've proposed in my not-very-clearly-explained patch. So, this means a DT
> property for the SPI master, although a different compatible string could be
> used as you suggested. See below for my comments on this idea.

OK.

> Any way, afer this, assuming we have a way of setting this master driver
> with the correct wordwidth, and given that there may be SPI masters that are
> able to switch it on demand, it seems feasible to connect two or more slaves
> with different wordwidth to the same SPI master.

Sure, but only if the master supports all bits_per_word values needed
by the slaves.

> It's true that this value could be hardcoded in each slave device driver
> code, but currently the SPI infrastructure sets this value to 8 by

Slave drivers for slaves using a different value should fill in a different
value.

> default. What's wrong with this? The problem lies on userspace drivers.
>
> For SPI slaves that do not have an in kernel code, we can add a compatible
> string to spidev_dt_ids, which will provide a /dev/spidevX.Y node which can
> be used from userspace, from the set of properties that we write on the DT.
>
> Using this spidev node one would expect to be able to set this slave in
> particular to a different datawidth using SPI user interface, with ioctl
> SPI_IOC_WR_BITS_PER_WORD, basically the same as what we'd do in the kernel.
>
> What happens, however, is that on boot a wordwidth of 8 is assigned by
> default, and so there occurs this discrepancy between what the master is
> capable of and what the slave requires. The patch I sent before makes the
> master know it can work with something different to 8, in my case that's 32.
> But when trying to initialize /dev/spidev devices, the following happens:
>
> xilinx_spi 44a10000.spi: can't setup spi1.0, status -22
> spi_master spi1: spi_device register error /amba_pl/spi@44a10000/spidev@0
> spi_master spi1: Failed to create SPI device for /amba_pl/spi@44a10000/spidev@0
>
> So now there's no way for me to open /dev/spidev1.0 and change its
> bits-per-word parameter, because /dev/spidev1.0 does not exist and it's
> trying to link an 8 bit wordwidth slave with a 32 bit wordwidth master.

OK, so that's a bug in the SPI core, or in spidev.

> So, in fact here below is the full patch that will serve my purpose of
>
> a) Configuring my up-to-now unconfigurable SPI master driver to support
>    16 or 32 wordwidth.

OK.

> b) Allow its slaves to be visible from userspace without the need of a
>    kernel driver
>
> diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
> index 92ea22fedb33..46bb103ef30e 100644
> --- a/drivers/spi/spi-xilinx.c
> +++ b/drivers/spi/spi-xilinx.c
> @@ -380,7 +380,7 @@ static int xilinx_spi_probe(struct platform_device *pdev)
>         struct xilinx_spi *xspi;
>         struct xspi_platform_data *pdata;
>         struct resource *res;
> -       int ret, num_cs = 0, bits_per_word = 8;
> +       int ret, num_cs = 0, bits_per_word;
>         struct spi_master *master;
>         u32 tmp;
>         u8 i;
> @@ -392,6 +392,11 @@ static int xilinx_spi_probe(struct platform_device *pdev)
>         } else {
>                 of_property_read_u32(pdev->dev.of_node, "xlnx,num-ss-bits",
>                                           &num_cs);
> +               ret = of_property_read_u32(pdev->dev.of_node,
> +                                          "xlnx,num-transfer-bits",
> +                                          &bits_per_word);
> +               if (ret)
> +                       bits_per_word = 8;
>         }
>
>         if (!num_cs) {

Looks good to me.

> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index f9502dbbb5c1..06424b7b0d73 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1792,6 +1792,10 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>         }
>         spi->max_speed_hz = value;
>
> +       /* Bits per word */
> +       if (!of_property_read_u32(nc, "spi-bits-per-word", &value))
> +               spi->bits_per_word = value;
> +
>         return 0;
>  }

Probably this should be fixed in spidev instead, to use a value that
conforms to spi_controller.bits_per_word_mask.
That would remove the need for specifying this in DT.
Once the spidev is instantiated, userspace can still change it using
SPI_IOC_WR_BITS_PER_WORD.

> > > > shouldn't be set in DT, it should be set by the client driver - it's
> > > > going to be a fixed property of the device, not something that varies
> > > > per system.
> > >
> > > But this is in fact something that changes per system. When instantiating an
> > > AXI Quad SPI core in a HDL design that's exactly one of the options you can
> > > provide. In fact, in the board I'm working with right now, I'm instantiating
> > > two SPI cores, one of them with 8 bits per word but the other one requires
> > > 32 bits per word, as the devices it's going to talk to have this
> > > requirement.
> >
> > So you're instantiating two variants of the same "xlnx,axi-quad-spi-1.00.a"
> > controller, with different options?
> > While you could add an "xlnx,foo" DT property for that, an alternative could
> > be to introduce a new compatible value.
> > It all depends on how many options there are when instantiating such a
> > controller.
> >
>
> Regardless of which SPI slave will be connected to the SPI master, there's
> the need to indicate in the DT how is this master configured. Now, you could
> definitely add another compatible value, but then I'd need to introduce a
> compatible value for 8 bits, another one for 16 and a last one for 32. I
> don't think this is easier nor powerful enough, and I think the use of the
> DT property matches very well with other drivers I've read, such as
> axi-ethernet and others (most of them from the Xilinx IP core set), but I
> surely can be in the wrong about this, I'm pretty noob on kernel code as you
> can see.

Yes, using a DT property for this is fine.  It just needs to be documented
in Documentation/devicetree/bindings/spi/spi-xilinx.txt (or its yaml
counterpart).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

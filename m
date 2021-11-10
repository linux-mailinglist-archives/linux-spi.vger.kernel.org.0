Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B2144C4FA
	for <lists+linux-spi@lfdr.de>; Wed, 10 Nov 2021 17:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhKJQZt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Nov 2021 11:25:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:38754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229602AbhKJQZt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 10 Nov 2021 11:25:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B2E061211;
        Wed, 10 Nov 2021 16:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636561381;
        bh=TkUZrNxT9Xg0EqgNv4SUEM8IWit4UdrF9FRly520EDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WWLEUIig1SFGC9I8XrT00ImDviJ49+q9dUiUFXr2NFnR8nJGm7aK3thjaVOmHyIiY
         i1pIONCBtBeL2T0OGfMw3SnmG6ruhClkdDdMKHgzSoPxB1Jos/quK5748woWSM2gwb
         6w7bkqnEIGCq7T/MABMviBwBqlQ0KIGcGnMxCsnVdm5BVqIOnavOpB7zG1sMVVNaMY
         eNJhYZS5Pjq50fCb+rUUq8bqyXjNMnZMQT5D/oZubDLNrJV9uJNF86OEPl1F3v0o03
         ZjxE08wrDvWyrOCBRpq1hg2DBhuZgoqAYB2QRBVPyGY0SLkyb+ws0l08asTy0ZpS1Z
         TwnO435p5bV6Q==
Date:   Wed, 10 Nov 2021 16:22:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lh Kuo =?utf-8?B?6YOt5Yqb6LGq?= <lh.Kuo@sunplus.com>
Cc:     "LH.Kuo" <lhjeff911@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dvorkin@tibbo.com" <dvorkin@tibbo.com>,
        "qinjian@cqplus1.com" <qinjian@cqplus1.com>,
        Wells Lu =?utf-8?B?5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: Re: [PATCH v2 1/2] SPI: Add SPI driver for Sunplus SP7021
Message-ID: <YYvx4LtKiSPBIgCN@sirena.org.uk>
References: <1635747525-31243-1-git-send-email-lh.kuo@sunplus.com>
 <1636448488-14158-1-git-send-email-lh.kuo@sunplus.com>
 <1636448488-14158-2-git-send-email-lh.kuo@sunplus.com>
 <YYqMLPB6VX9k5LUK@sirena.org.uk>
 <f98b5548cf564093af1d10ba1239507d@sphcmbx02.sunplus.com.tw>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9yiih3DAiIZ/qpj8"
Content-Disposition: inline
In-Reply-To: <f98b5548cf564093af1d10ba1239507d@sphcmbx02.sunplus.com.tw>
X-Cookie: You have junk mail.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--9yiih3DAiIZ/qpj8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 10, 2021 at 02:42:01AM +0000, Lh Kuo =E9=83=AD=E5=8A=9B=E8=B1=
=AA wrote:

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

> > This is *still* open coding a GPIO chip select, to repeat what I said l=
ast time
> > this is not OK - use the core facilities to avoid introducing bugs like=
 double
> > application of SPI_CS_HIGH you have here.

> I try to find some function can replay this part.
> EX:
>   Spi.c -> spi_set_cs but it is not EXPORT_SYMBOL_GPL and it looks not fi=
t in the driver
>=20
>   Spi-gpio.c -> spi_gpio_chipselect it looks not fit in the driver.
>=20
> Sorry maybe i misunderstood this issue
>=20
>   Or the problem is 	gpiod_set_value_cansleep  can't be used in here ?
>=20
> Which function can I use for GPIO_CS?

The same way other controllers do: by setting use_gpio_descriptors in
the controller.  The core will then request the GPIOs for the driver
using the standard binding, this requires no further work on the part of
the driver.

> > > +// spi slave irq handler
> > > +static irqreturn_t sp7021_spi_sla_irq(int _irq, void *_dev) {
> > > +	struct sp7021_spi_ctlr *pspim =3D (struct sp7021_spi_ctlr *)_dev;

> > If you need this cast something is very wrong, do you need it?

> So the vold* should be struct * spi_controller ??

No, interrupt handlers need to take an int and a void *.  There should
be no cast.

> > > +	if (RW_phase =3D=3D SP7021_SLA_WRITE) {

> > This looks like a switch statement, though given how little code is sha=
red it's
> > not clear why this is all in one function.

> It is easy to check the flow and setting for me

It's contributing to making the code hard for other people to follow.

> > > +		if (_t->tx_dma =3D=3D pspim->tx_dma_phy_base)
> > > +			memcpy(pspim->tx_dma_vir_base, _t->tx_buf, _t->len);

> > Why are we copying data into a DMA transfer buffer, doesn't this defeat=
 the
> > point of DMA?  I'd expect to DMA data directly.  I'd also expect some
> > synchronisation operations to ensure that everything has a consistent v=
iew of
> > the memory.

> It only happens when tx_dma =3D pspim->tx_dma_phy_base
> And if it can't get dma-addr or wrong case. I will set tx_dma =3D pspim->=
tx_dma_phy_base.

What does that mean at a higher level - what is tx_dma here?  Why does
not being able to get an address to DMA mean that we need to memcpy()
things?  I can't see any reason for the memcpy() at all.

> > > +// spi master irq handler
> > > +static irqreturn_t sp7021_spi_mas_irq_dma(int _irq, void *_dev) {
> > > +	struct sp7021_spi_ctlr *pspim =3D (struct sp7021_spi_ctlr *)_dev;

> > > +	spin_lock_irq(&pspim->lock);

> > Why are we using spin_lock_irq() when we're already in an interrupt han=
dler?

> Yes it is in interrupt handler

Yes, I know it's an interrupt handler - to repeat my question why are we
we using spin_lock_irq() in that case?

> > > +	return IRQ_HANDLED;
> > > +}

> > This unconditionally reports IRQ_HANDLED even if we didn't actually see=
 any
> > interrupt status flagged, this will break shared interrupts and reduce =
the ability
> > of the interrupt core to handle errors.

> Sorry I'm confuse. What should i do in this issue

Report IRQ_NONE if there was no interrupts reported by the hardware.

> > This is still copying all data for no apparent reason as highlighted la=
st time.

> It is difference case. It is in master mode and and can only be transmitt=
ed through FIFO

> And It is transmitting for one message and I need collect the all tx data=
 first.

For what reason do you need to collect all the tx data?  It really is
not at all apparent from the code and seems especially unusual in the
PIO case.

> > Is the device full duplex or half duplex?  The code immediately above t=
his
> > treats both transmit and recieve buffers as optional.  If the device do=
es
> > actually need to be full duplex then the driver should flag it as such.

> You mean set the flsg of should be struct * spi_controller in probe funct=
ion

> Ctlr-flags =3D SPI_CONTROLLER_FULL_DUPLEX  right ?

Yes.

> > > +// called when child device is registering on the bus static int
> > > +sp7021_spi_dev_setup(struct spi_device *_s) {
> > > +	struct sp7021_spi_ctlr *pspim =3D
> > spi_controller_get_devdata(_s->controller);
> > > +	int ret;
> > > +
> > > +	ret =3D pm_runtime_get_sync(pspim->dev);
> > > +		if (ret < 0)
> > > +			return 0;
> > > +
> > > +	pm_runtime_get_sync(pspim->dev);;
> > > +
> > > +	return 0;
> > > +
> > > +}

> > This function does nothing except bounce the power on the device, this =
is
> > obviously not useful and should be removed.

> You mean set the auto_runtime_pm of should be struct * spi_controller in =
probe function
> And remove pm_runtime_get_sync(pspim->dev);

> pm_runtime_get_sync(pspim->dev);

> even the pm_runtime in the probe should be remove . right ?

You should only take a runtime reference for the period that it's
actually needed.  Taking one in probe and then not dropping it before
the end of probe would defeat the point of having runtime PM.

> > > +static size_t sp7021_spi_max_length(struct spi_device *spi) {
> > > +	return SP7021_SPI_MSG_SIZE;
> > > +}

> > Is there any actual limit in the hardware?  This looks very much like i=
t's a
> > completely artificial limit in the driver for no obvious reason.

>   The limit of the hardware is only 255 bytes . But more user need more t=
han the limit.
> So I try to extend by software that is one reason use one message transfe=
r and use CS-GPIO

As ever *please* use the core features rather than open coding - if you
specify a maximum transfer size the core already supports using a
software controllable chip select to handle messages with transfers of
arbatrary lengths.  There is no need for the driver to do anything here
other than providing a length, but that needs to be per transfer and not
per message.

In general if you're doing something that doesn't interact directly with
the hardware it shouldn't be in the driver, it's a pure software thing
which will also apply to any other similar hardware and should therefore
be done in the core. =20

> > > +	pm_runtime_get_sync(pspim->dev);

> > To repeat the feedback from last time do not open code runtime PM, use =
the
> > core support.

> Only set set the auto_runtime_pm of should be struct * spi_controller in =
probe function  right ?

Yes.

> > > +	list_for_each_entry(xfer, &m->transfers, transfer_list) {
> > > +		if (!first_xfer)
> > > +			first_xfer =3D xfer;
> > > +		total_len +=3D  xfer->len;

> > To further repeat my prior feedback I can't see any reason why this dri=
ver
> > doesn't just use transfer_one().

> The FIFO only 16bytes for one action. I need push tx_data and pull rx_dat=
a as soon as possible.
> Use one message I can collect the data first and start transmitting=20
> It is more efficient than transfer_one at real case.

That doesn't mean it's a good idea to just duplicate the core code, that
means that you should look into improving the performance of the core
code so any optimisation benefits everyone and the driver doesn't end
up with some combination of bugs, missing features and reduced
performance in the open coded version.  Having small FIFOs isn't at all
unusual so it seems unlikely that there's any need for anything here to
be device specific, and any benefits from copying all the data into a
linear buffer have got to be application specific, indeed it'll clearly
make things worse in some common cases.  For example with something like
flash where we have frequent use of large transfers for data payloads
the data is already mostly in large buffers the overhead of copying
those buffers is going to be very noticable compared to any saving,
especially given that there's only two transfers.  On the other end of
things when something like regmap is already linearising small writes
into single transfers then the copy is just pure overhead.

There's definitely scope for improving things here, the main one being
to pull advancing to the next transfer into spi_finalize_current_transfer()
which would benefit DMA as well, that don't introduce these overheads
and don't involve all this code duplication.

--9yiih3DAiIZ/qpj8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGL8d8ACgkQJNaLcl1U
h9ApYQf9FzEypJPaLmkcT70D1lkGZNXFHmFjgggLNGdIq8jrjf2nPQRYazZObGJu
YFcu3z5PFHYcZIzFu/nh9bnrc4weP7G0ppZuQZ+14CcnpoxKRgaDe0q4LzZOXxXr
8YjL42Ye7IVwj12/2Z7qU9tkldlaAeZYNYmd+GvTKMonztvIpJIUtvMEIMf2qRkW
BdkrsDf4YbbYdqdaO6vRzEcMryhvY+jLcdQVctUaySnCt5Uu7y4RHQp0ptfWumTW
sn8ZkeEA9mmGVEmBUPru6X9ukO8rdaPfMsZ1BvWtvJKiy9DlxvMVvxdcG0/YFRN1
V0ieA19eIji/nJtvtz7JzAX7IvPykw==
=Vrme
-----END PGP SIGNATURE-----

--9yiih3DAiIZ/qpj8--

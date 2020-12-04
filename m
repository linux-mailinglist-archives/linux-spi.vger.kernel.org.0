Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0932CF462
	for <lists+linux-spi@lfdr.de>; Fri,  4 Dec 2020 19:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgLDSxJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Dec 2020 13:53:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:51228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgLDSxI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 4 Dec 2020 13:53:08 -0500
Date:   Fri, 4 Dec 2020 18:52:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607107947;
        bh=FKobiGwv/Vz9ya9A/LUGe7+OJ9lr7WNxazXGbvRffMk=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=M9ATD/Ychqh4F1JCdDnqas8MlT0T2vDcB1M9ICdA9Kc9i4lY9iaV7hTn2tL2Wlcuh
         +lrOP3rFso5F9D5vNWL+zIKtIMvA34qu4Tz6QZG/+77t07H7Uv8FLG3S/ULmTCSGY/
         g5650Bhf4EtPBGj7XWHjYlnotFQSUhXp7kZbRsmKUyYsZqc+JSS0ms7wLyfScRijBb
         PmWYLnxoGrBpx++/0LLFNmV1+y9/e4m89SJ6q/W7iNWM7SnkLtAwxGUhuowQtFFkxq
         X+kdy5A6amtE6IpdOKWMyzd+icjt6gTqBgEY5OtwjOILiNyT+/+86pFhfW46Sz9GWJ
         yAl6CPxsGlHrw==
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 3/7] spi: qspi-tegra: Add support for Tegra210 QSPI
 controller
Message-ID: <20201204185223.GF4558@sirena.org.uk>
References: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
 <1606857168-5839-4-git-send-email-skomatineni@nvidia.com>
 <20201202172721.GL5560@sirena.org.uk>
 <2257bc33-80ef-a6d8-8542-480defa32937@nvidia.com>
 <be8291fc-8e69-b577-d8f4-20aeca0b45cc@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/aVve/J9H4Wl5yVO"
Content-Disposition: inline
In-Reply-To: <be8291fc-8e69-b577-d8f4-20aeca0b45cc@nvidia.com>
X-Cookie: Not a flying toy.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--/aVve/J9H4Wl5yVO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 03, 2020 at 04:22:54PM -0800, Sowjanya Komatineni wrote:
> On 12/2/20 11:17 AM, Sowjanya Komatineni wrote:

> > > It seems weird that this device needs us to do a memcpy() to do DMA,
> > > most devices are able to DMA directly from the buffers provided by the
> > > SPI API (and let the SPI core sync things).=A0 What is going on here?

> > For transfers of size more than max DMA transfer limit, data transfer
> > happens in multiple iterations with each iteration transferring up to
> > max DMA transfer limit.

> > So using separate dma buffers and on every iteration copying them to SPI
> > core provided tx/rx buffers.

I don't understand this - there's no restriction on where DMA transfers
can be done from within a DMA mapped region, the driver can do multiple
transfers from different chunks of the source buffer without having to
copy anything.  That's a very common scenario.

> Also unpack mode needs to manually put the bytes together from read data =
to
> SPI core rx buffer.

Could you be more explicit here, I don't know what "unpack mode" is?

> > > This is worrying, the client device might be confused if /CS is doing
> > > things outside of the standard handling.

> > Do you mean to honor spi_transfer cs_change flag?

At least, yes - more generally just if there's any feature to with chip
select then the driver will need to open code it.  The driver should at
least be double checking that what it's doing matches what it was told
to do, though just letting this be handled by the generic code if
there's no limitation on the hardware tends to be easier all round.

> > Tegra QSPI is master and is used only with QSPI flash devices. Looking
> > at SPI NOR driver, I see QSPI Flash commands are executed with one flash
> > command per spi_message and I dont see cs_change flag usage w.r.t QSPI
> > flash. So, using SW based CS control for QSPI.

> > Please correct me if I miss something to understand here.

Someone might build a system that does something different, they may see
a spare SPI controller and decide they can use it for something else or
there may be some future change with the flash code which does something
different.

> > > > +=A0=A0=A0 tegra_qspi_writel(tqspi, tqspi->def_command2_reg, QSPI_C=
OMMAND2);

> > > The setup for one device shouldn't be able to affect the operation of
> > > another, already running, device so either these need to be configured
> > > as part of the controller probe or these configurations need to be
> > > deferred until we're actually doing a transfer.

> > We will only have 1 device on QSPI as we only support single chip selec=
t.

It's quite common for people to do things like add additional devices
with GPIO chip selects.

> > > > +=A0=A0=A0 /*
> > > > +=A0=A0=A0=A0 * Tegra QSPI hardware support dummy bytes transfer ba=
sed on the
> > > > +=A0=A0=A0=A0 * programmed dummy clock cyles in QSPI register.
> > > > +=A0=A0=A0=A0 * So, get the total dummy bytes from the dummy bytes =
transfer in
> > > > +=A0=A0=A0=A0 * spi_messages and convert to dummy clock cyles.
> > > > +=A0=A0=A0=A0 */
> > > > +=A0=A0=A0 list_for_each_entry(xfer, &msg->transfers, transfer_list=
) {
> > > > +=A0=A0=A0=A0=A0=A0=A0 if (ntransfers =3D=3D DUMMY_BYTES_XFER &&
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 !(list_is_last(&xfer->transfer_l=
ist, &msg->transfers)))
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dummy_cycles =3D xfer->len * 8 /=
 xfer->tx_nbits;
> > > > +=A0=A0=A0=A0=A0=A0=A0 ntransfers++;
> > > > +=A0=A0=A0 }

> > > This seems weird, there's some hard coded assumption about particular
> > > patterns that the client device is going to send.=A0 What's going on =
here?
> > > I don't really understand what this is trying to do.

> > QSPI flash needs dummy cycles for data read operation which is actually
> > the initial read latency and no. of dummy cycles required are vendor
> > specific.

> > SPI NOR driver gets required dummy cycles based on mode clock cycles and
> > wait state clock cycles.

> > During read operations, spi_nor_spimem_read_data() converts dummy cycles
> > to number of dummy bytes.

> > Tegra QSPI controller supports dummy clock cycles register and when
> > programmed QSPI controller sends dummy bytes rather than SW handling
> > extra cycles for transferring dummy bytes.

> > Above equation converts this dummy bytes back to dummy clock cycles to
> > program into QSPI register and avoid manual SW transfer of dummy bytes.

This is not a good idea, attempting to reverse engineer the message and
guess at the contents isn't going to be robust and if it's useful it
will if nothing else lead to a bunch of duplicated code in drivers as
every device that has this feature will need to reimplment it.  Instead
we should extend the framework so there's explicit support for
specifying transfers that are padding bytes, then there's no guesswork
that can go wrong and no duplicated code between drivers.  A flag in the
transfer struct might work?

--/aVve/J9H4Wl5yVO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/KhWYACgkQJNaLcl1U
h9D5rAf/UXH5pXjHwsAegxtnMvM+8cgWCzvs2PM6GsIOb6SgfLOliNoXC64Zia28
+/7YK1aRuk53w1rIx1I+b2yUG5WSXSAKwIPtz4QUYdzN4VJvIBC4fxCCjR8f4RIR
RrPpLD9bMMmuVhM84aIF3xjQmNz3z5/qS8+BXwhtIrTP7SMnDAfU62adJmONMPp3
72T2xGpME00bIZ5NczxHE0Wo3jc42H/KstjifMAjBSW5u0dYjaIsV4IFSShA2SY3
YhhSv+j6v6ock1AZ9AFUV4brvhciKpLs2GpfM8bXOVnAun2BJsy0AxmFOuoZeIP9
vI5zle2CVDMsXzFySUwaY3OWc00Ptg==
=HKIs
-----END PGP SIGNATURE-----

--/aVve/J9H4Wl5yVO--

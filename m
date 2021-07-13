Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08833C6ECF
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jul 2021 12:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbhGMKs5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Jul 2021 06:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235669AbhGMKs4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Jul 2021 06:48:56 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1300C0613DD;
        Tue, 13 Jul 2021 03:46:06 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 73D271F42144
Received: by earth.universe (Postfix, from userid 1000)
        id 0CAA73C0C97; Tue, 13 Jul 2021 12:46:00 +0200 (CEST)
Date:   Tue, 13 Jul 2021 12:46:00 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Ian Ray <ian.ray@ge.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv6 3/3] misc: gehc-achc: new driver
Message-ID: <20210713104600.gbhixaf7r4cukg6i@earth.universe>
References: <20210712150242.146545-1-sebastian.reichel@collabora.com>
 <20210712150242.146545-4-sebastian.reichel@collabora.com>
 <YOx/3YaIg24Tx+OQ@kroah.com>
 <20210712232016.feixz7mqingdc7ck@earth.universe>
 <YO0nn5iX2835Zta9@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qno7zh7oiefmaw2w"
Content-Disposition: inline
In-Reply-To: <YO0nn5iX2835Zta9@kroah.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--qno7zh7oiefmaw2w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 13, 2021 at 07:41:51AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jul 13, 2021 at 01:20:16AM +0200, Sebastian Reichel wrote:
> > On Mon, Jul 12, 2021 at 07:46:05PM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Jul 12, 2021 at 05:02:42PM +0200, Sebastian Reichel wrote:
> > > > General Electric Healthcare's PPD has a secondary processor from
> > > > NXP's Kinetis K20 series. That device has two SPI chip selects:
> > > >=20
> > > > The main interface's behaviour depends on the loaded firmware
> > > > and is currently unused.
> > > >=20
> > > > The secondary interface can be used to update the firmware using
> > > > EzPort protocol. This is implemented by this driver using the
> > > > kernel's firmware API. It's not done during probe time, since
> > > > the device has non-volatile memory and flashing lasts almost 3
> > > > minutes.
> > >=20
> > > In thinking about this some more, why does it matter?  Spin up a
> > > workqueue when probing and do the firmware loading then. That way you
> > > do not end up creating yet another custom user/kernel api just to do
> > > something as trivial as loading the firmware for a device.
> > >=20
> > > And I think the firmware loader even handles async loading, or at lea=
st
> > > it used to, maybe not anymore, it's a complex api, I recommend reading
> > > the docs...
> >=20
> > Flashing the firmware during boot instead of on-demand is not
> > a good idea for two reasons:
> >=20
> > 1. This will wear the flash memory of the microcontroller for no
> >    good reason.
>=20
> Why would you boot with this hardware and not want the firmware
> loaded?

As written in the commit message this code is updateing the firmware
in non-volatile memory, so the previously flashed FW will be used
until a new one is flashed.

The datasheet for the memory being programmed states, that it has a
guaranteed programming endurance of 10.000 times. So programming it
at every boot instead of manually when a new FW should be flashed
(i.e. once every few years) shortens the device life time considerably.

> > 2. Even if the flashing happens in the background, the microcontroller
> >    will not be usable while it is being programmed. Thus the system
> >    boot takes 3 minutes instead of 30 seconds.
>=20
> Why would the system boot depend on the firmware being loaded?
>=20
> You have to wait sometime, might as well get the first 30 seconds of
> waiting out of the way while the rest of the system boots :)

The microcontroller collects sensor data for the system and is
essential for the overall functionality of the medical device.
While the firmware flashing is on-going the device cannot be
used normally, since the microcontroller will not process and
forward the data.

> > Note, that this is not the first device with this kind of problem.
> > I've seen this before for e.g. atmel touchscreen [0] basically does
> > the same via (undocumented) mxt_update_fw_store().
> >=20
> > [0] drivers/input/touchscreen/atmel_mxt_ts.c
>=20
> Yes, but everyone else uses the normal firmware api method of doing
> this, don't take one odd driver as being the "rule" :)

Most FW updates happen to volatile memory (=3D firmware data is lost
on power loss) and must be programmed at boot time. So I'm not
looking for the average FW update driver, but for the odd driver
also updating FW in non-volatile memory. Those often have the
same limitations as the Kinetis K20 has:

 * limited amount of programming cycles available
 * slow programming speed

> > > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > > ---
> > > >  .../ABI/testing/sysfs-driver-ge-achc          |  14 +
> > > >  drivers/misc/Kconfig                          |  11 +
> > > >  drivers/misc/Makefile                         |   2 +
> > > >  drivers/misc/gehc-achc.c                      | 136 +++++
> > > >  drivers/misc/nxp-ezport.c                     | 468 ++++++++++++++=
++++
> > > >  drivers/misc/nxp-ezport.h                     |   9 +
> > >=20
> > > Why is there two different modules here for the same piece of hardwar=
e?
> >=20
> > It's only one module, but I put all the generic ezport code into its
> > own file for easy code reuse. I can put it all into gehc-achc and
> > thus reduce the chance of code reuse if somebody else needs to do
> > ezport flashing. Since both files are built into the same module
> > the size savings of merging both files are minimal.
>=20
> Sorry, you are right, I read the code and Makefile wrong.
>=20
> But, from an organizing point of view, having 2 random files in that
> directory that are not named alike being built together into one module
> is not obvious at all.
>=20
> For now, keep it to one file.  If future users come along that need this
> method, split the code then, no need to do extra work at this point in
> time for unknown uses.

Ok, I will put it all into gehc-achc. I doubt somebody will find
ezport code in there in the future, but that's not my problem :)

> > > > +static ssize_t update_firmware_store(struct device *dev, struct de=
vice_attribute *attr,
> > > > +				     const char *buf, size_t count)
> > > > +{
> > > > +	struct achc_data *achc =3D dev_get_drvdata(dev);
> > > > +	int ret;
> > > > +
> > > > +	if (count !=3D 1 || buf[0] !=3D '1')
> > > > +		return -EINVAL;
> > >=20
> > > There a core kernel call to see if the data written to a sysfs file is
> > > "true/false" I would recommend, if you stick with this, to use that
> > > instead.
> >=20
> > I have problems understanding that sentence, it seems to be missing
> > a word.
> >=20
> > As far as I can tell -EINVAL is usually used when the user supplied
> > data is not formatted correctly for sysfs store routines, e.g. lot's
> > of them are returning -EINVAL like this:
> >=20
> > rc =3D kstrtoul(buf, 0, &value);
> > if (rc)
> >     return rc;
> >=20
> > Did I miss something?
>=20
> I was trying to say "use kstrtoul()" instead of trying to hand-roll much
> the same thing.  Sorry for not being specific.

Ok.

Thanks,

-- Sebastian

--qno7zh7oiefmaw2w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmDtbuMACgkQ2O7X88g7
+poqWw/+IB5KtEo/2G135slJHpDCk9r6VmQOPFKSHUM7n4mXxsGvw7FlWHa4RZ3z
FTXAO2T1+bL2WM8QRg+TdwUw6ggc4VJ7VzMR/Zzzm57qf37dPj4Sz81yAmcHmLDx
3poLm+3a8rQPWTgSHTJA4YdOBGtDeOT0+FSTy7/TvVf3o5ImTflrAU0bknMLCYwq
Rkhh/Yb0cQVx6c8MJ/avC6HzbH6PH/6mJ/+aAsDZnaVIrXwJvPABOA00uq4pGX5a
+d4Nx3NyCKWedZ7bhHOeO/8zCqu6RkasFspAlMmetiFkRhYB3uqdQm5zlQa4j7XK
FkISMkkWBZ/MUHWB05qi9/0eyJxUR2XkktSdy1mTrTeNabCevnGOFNQloXK1+7nP
enoUUSpS7TW7lE7rqTVXffvjo1b+jbPM/srw+Jd06zbeYL8mG9afRY6UyQ1QCbya
qbB5ZW5GKFzGG/WLLyTOW4+QczrvI1m4WwCV1S/pkvaANWqPE+ZF4JumKN0mTY5t
Gix+X4+wx9sO/JUatLMAq72F4vxis19lnmh2qePkbatcQrZndmiu2lZ8p2tven7L
FxGhOQQ04ulgfiPE7AIu1UT4ZuFN7iH/yI7/SgqdABC/dOWSXK1rP30fQwRm6/UO
IkcOdikhpuSukXquUeEdShlSHQsco1nq7BuW0PhOAQTK5qEo8HA=
=mXfJ
-----END PGP SIGNATURE-----

--qno7zh7oiefmaw2w--

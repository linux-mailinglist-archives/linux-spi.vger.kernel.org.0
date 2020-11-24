Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C622C26AD
	for <lists+linux-spi@lfdr.de>; Tue, 24 Nov 2020 14:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387661AbgKXNBV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Nov 2020 08:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387642AbgKXNBV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Nov 2020 08:01:21 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5535C0617A6
        for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2020 05:01:20 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1khXwV-0005u3-A1; Tue, 24 Nov 2020 14:01:11 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1khXwT-0006Yl-OX; Tue, 24 Nov 2020 14:01:09 +0100
Date:   Tue, 24 Nov 2020 14:01:07 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 2/3] spi: Use bus_type functions for probe, remove and
 shutdown
Message-ID: <20201124130107.2yvgk7kheep5gd6z@pengutronix.de>
References: <20201119161604.2633521-1-u.kleine-koenig@pengutronix.de>
 <20201119161604.2633521-2-u.kleine-koenig@pengutronix.de>
 <CGME20201124120324eucas1p189ec6eed6d6477e27a194f9d75d7b43a@eucas1p1.samsung.com>
 <9b86504f-c5f4-4c85-9bef-3d1ee4cbaf9c@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eyicznphi2ywjrds"
Content-Disposition: inline
In-Reply-To: <9b86504f-c5f4-4c85-9bef-3d1ee4cbaf9c@samsung.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--eyicznphi2ywjrds
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Marek,

On Tue, Nov 24, 2020 at 01:03:25PM +0100, Marek Szyprowski wrote:
> On 19.11.2020 17:16, Uwe Kleine-K=F6nig wrote:
> > The eventual goal is to get rid of the callbacks in struct
> > device_driver. Other than not using driver callbacks there should be no
> > side effect of this patch.
> >
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>=20
> This patch landed recently in linux-next as commit 9db34ee64ce4 ("spi:=20
> Use bus_type functions for probe, remove and shutdown").
>=20
> It causes a regression on some of my test boards:
>=20
> Unable to handle kernel NULL pointer dereference at virtual address=20
> 0000000000000018
> Mem abort info:
>  =A0 ESR =3D 0x96000004
>  =A0 EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>  =A0 SET =3D 0, FnV =3D 0
>  =A0 EA =3D 0, S1PTW =3D 0
> Data abort info:
>  =A0 ISV =3D 0, ISS =3D 0x00000004
>  =A0 CM =3D 0, WnR =3D 0
> user pgtable: 4k pages, 48-bit VAs, pgdp=3D00000000318ed000
> [0000000000000018] pgd=3D0000000000000000, p4d=3D0000000000000000
> Internal error: Oops: 96000004 [#1] PREEMPT SMP
> Modules linked in: cpufreq_powersave cpufreq_conservative brcmfmac=20
> brcmutil cfg80211 crct10dif_ce s3fwrn5_i2c s3fwrn5 nci nfc s5p_mfc=20
> s5p_jpeg hci_uart btqca btbc
> buf2_dma_contig videobuf2_memops videobuf2_v4l2 bluetooth=20
> videobuf2_common videodev panfrost gpu_sched ecdh_generic mc ecc rfkill=
=20
> ip_tables x_tables ipv6
> CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted=20
> 5.10.0-rc5-next-20201124+ #9771
> Hardware name: Samsung TM2E board (DT)
> pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=3D--)
> pc : spi_shutdown+0x10/0x38
> lr : device_shutdown+0x10c/0x350
> sp : ffff80001311bc70
> ...
> Call trace:
>  =A0spi_shutdown+0x10/0x38
>  =A0kernel_restart_prepare+0x34/0x40
>  =A0kernel_restart+0x14/0x88
>  =A0__do_sys_reboot+0x148/0x248
>  =A0__arm64_sys_reboot+0x1c/0x28
>  =A0el0_svc_common.constprop.3+0x74/0x198
>  =A0do_el0_svc+0x20/0x98
>  =A0el0_sync_handler+0x140/0x1a8
>  =A0el0_sync+0x140/0x180
> Code: f9403402 d1008041 f100005f 9a9f1021 (f9400c21)
> ---[ end trace 266c07205a2d632e ]---
> Kernel panic - not syncing: Oops: Fatal exception
> Kernel Offset: disabled
> CPU features: 0x0240022,65006087
> Memory Limit: none
> ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---
>=20
> > ---
> >   drivers/spi/spi.c | 33 ++++++++++++++++-----------------
> >   1 file changed, 16 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> > index 5becf6c2c409..e8c0a000ee19 100644
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -374,16 +374,7 @@ static int spi_uevent(struct device *dev, struct k=
obj_uevent_env *env)
> >   	return add_uevent_var(env, "MODALIAS=3D%s%s", SPI_MODULE_PREFIX, spi=
->modalias);
> >   }
> >  =20
> > -struct bus_type spi_bus_type =3D {
> > -	.name		=3D "spi",
> > -	.dev_groups	=3D spi_dev_groups,
> > -	.match		=3D spi_match_device,
> > -	.uevent		=3D spi_uevent,
> > -};
> > -EXPORT_SYMBOL_GPL(spi_bus_type);
> > -
> > -
> > -static int spi_drv_probe(struct device *dev)
> > +static int spi_probe(struct device *dev)
> >   {
> >   	const struct spi_driver		*sdrv =3D to_spi_driver(dev->driver);
> >   	struct spi_device		*spi =3D to_spi_device(dev);
> > @@ -414,7 +405,7 @@ static int spi_drv_probe(struct device *dev)
> >   	return ret;
> >   }
> >  =20
> > -static int spi_drv_remove(struct device *dev)
> > +static int spi_remove(struct device *dev)
> >   {
> >   	const struct spi_driver		*sdrv =3D to_spi_driver(dev->driver);
> >   	int ret =3D 0;
> > @@ -426,13 +417,25 @@ static int spi_drv_remove(struct device *dev)
> >   	return ret;
> >   }
> >  =20
> > -static void spi_drv_shutdown(struct device *dev)
> > +static void spi_shutdown(struct device *dev)
> >   {
> >   	const struct spi_driver		*sdrv =3D to_spi_driver(dev->driver);
> >  =20
> > -	sdrv->shutdown(to_spi_device(dev));
> > +	if (sdrv->shutdown)
> > +		sdrv->shutdown(to_spi_device(dev));
> >   }
>=20
> In the above function dev->driver might be NULL, so its use in=20
> to_spi_driver() and sdrv->shutdown leads to NULL pointer dereference. I=
=20
> didn't check the details, but a simple check for NULL dev->driver and=20
> return is enough to fix this issue. I can send such fix if you want.

Ah, I see. shutdown is called for unbound devices, too. Assuming that
Mark prefers a fix on top instead of an updated patch: Yes, please send
a fix. Otherwise I can do this, too, as I introduced the problem.

Best regards and thanks,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--eyicznphi2ywjrds
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+9BBEACgkQwfwUeK3K
7AkUFAf/ZbDu/Bi4tVHfAfDODPomtYgK6blE3EvY5GMT80YIlsyRxUQVRkpCTyJz
M2HrYnBO5alxW6+qCM6/2hqpOBJfywR0ag06E7e5fN/21GF7yw8frY5jApzAGeRN
VkHcbToYz6ESuv2+nMQ1mRs9xwY2dkHq+5IqsovDZAOG5obUSMwcSAiAD8Bs/WVl
NVfjFFnfOlR6HiUs+dGyPAaRBmvwHzGAYcFOK5FXxIDtn9wzmDCOq3xSdhk7Clx1
rVbYsaRfyet1PVkWIPCrQEJ6zMqzuY5MRKzdnBJ01456hzXMQWHABQ1CfpEGsBh3
EApqQEK7sa2UNp91XhmmYJ4O+59pVg==
=UZdV
-----END PGP SIGNATURE-----

--eyicznphi2ywjrds--

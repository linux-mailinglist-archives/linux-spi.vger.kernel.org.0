Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C635426BB5
	for <lists+linux-spi@lfdr.de>; Fri,  8 Oct 2021 15:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbhJHNd7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Oct 2021 09:33:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230324AbhJHNd5 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 8 Oct 2021 09:33:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3D5360F22;
        Fri,  8 Oct 2021 13:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633699921;
        bh=EIhqiR4YzFiknY+LLsgAK5R1Byzz+I36aGY4k1z9a3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i+/FB0Y0GaA1CmLW3/cgh7hIi/S03sOA3+DyreeFHZb8MJDvQTp2V1bHLlhla3Rc7
         PfOc15mIZ0MzdXfPGllR6eiGh0inA7BJd8VggbqgEnTdVc0QxR/2be+IDhrBGg3vxW
         Qevb7VerhsNGQKt1PJjiV+HOuREaxxNIaUvH7VVH6wdSoAlycicvkCGcJt2knoSFxs
         YMgxItN37nUJbQowDxILfeP5MmY/qhkbZ7rRy2JLoqgH90L+yBLv9V7n64MuauUgpm
         lLS65ONnCYHNhFL2jefqaXG/PI+8Dm/xKCegJ9lXnG/iiqZz+c5w5gmGJTas4IvUPy
         nsewTVnpMggSg==
Date:   Fri, 8 Oct 2021 14:31:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-spi@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@intel.com>
Subject: Re: Deadlock in spi_add_device() -- device core problem
Message-ID: <YWBITX2Wbfx/QHCE@sirena.org.uk>
References: <20211007160524.qhjtcwtto2ftsmhe@pengutronix.de>
 <YV8eIoxIxQLC5x5N@kroah.com>
 <20211007165214.r5h7x3evdqbwxmma@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zHHfI13WIAeQoK+b"
Content-Disposition: inline
In-Reply-To: <20211007165214.r5h7x3evdqbwxmma@pengutronix.de>
X-Cookie: When your memory goes, forget it!
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--zHHfI13WIAeQoK+b
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 07, 2021 at 06:52:14PM +0200, Uwe Kleine-K=F6nig wrote:
> On Thu, Oct 07, 2021 at 06:19:46PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Oct 07, 2021 at 06:05:24PM +0200, Uwe Kleine-K=F6nig wrote:

> > Drivers for a bus bind to the bus, they should not be creating new
> > devices for that same bus, as that does not seem correct.

> That's not the culprit here. We have a spi-device (spi-mux) that is a
> bus device on the SoC's bus and a bus master for it's own bus. And
> spi_add_device for the spi-mux device triggers the probe function for
> the spi-mux driver which creates a new bus controller which triggers
> spi_add_device() for the devices on the inner bus.

I think we need to be arranging for spi_add_lock to be per bus
rather than global - putting it into the controller ought to do
the trick.  We are only concerned about collisions on the same
bus, we don't care about other buses, so we don't need a global
lock and if the lock is per controller then we should't have any
issue adding a new bus in the middle of adding a device on
another bus.  Does the below totally untested patch work for you?

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index aea037c65985..412a10586233 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -478,12 +478,6 @@ static LIST_HEAD(spi_controller_list);
  */
 static DEFINE_MUTEX(board_lock);
=20
-/*
- * Prevents addition of devices with same chip select and
- * addition of devices below an unregistering controller.
- */
-static DEFINE_MUTEX(spi_add_lock);
-
 /**
  * spi_alloc_device - Allocate a new SPI device
  * @ctlr: Controller to which device is connected
@@ -636,9 +630,9 @@ int spi_add_device(struct spi_device *spi)
 	 * chipselect **BEFORE** we call setup(), else we'll trash
 	 * its configuration.  Lock against concurrent add() calls.
 	 */
-	mutex_lock(&spi_add_lock);
+	mutex_lock(&ctlr->add_lock);
 	status =3D __spi_add_device(spi);
-	mutex_unlock(&spi_add_lock);
+	mutex_unlock(&ctlr->add_lock);
 	return status;
 }
 EXPORT_SYMBOL_GPL(spi_add_device);
@@ -658,7 +652,7 @@ static int spi_add_device_locked(struct spi_device *spi)
 	/* Set the bus ID string */
 	spi_dev_set_name(spi);
=20
-	WARN_ON(!mutex_is_locked(&spi_add_lock));
+	WARN_ON(!mutex_is_locked(&ctlr->add_lock));
 	return __spi_add_device(spi);
 }
=20
@@ -2830,6 +2824,7 @@ int spi_register_controller(struct spi_controller *ct=
lr)
 	spin_lock_init(&ctlr->bus_lock_spinlock);
 	mutex_init(&ctlr->bus_lock_mutex);
 	mutex_init(&ctlr->io_mutex);
+	mutex_init(&ctlr->add_lock);
 	ctlr->bus_lock_flag =3D 0;
 	init_completion(&ctlr->xfer_completion);
 	if (!ctlr->max_dma_len)
@@ -2966,7 +2961,7 @@ void spi_unregister_controller(struct spi_controller =
*ctlr)
=20
 	/* Prevent addition of new devices, unregister existing ones */
 	if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
-		mutex_lock(&spi_add_lock);
+		mutex_lock(&ctlr->add_lock);
=20
 	device_for_each_child(&ctlr->dev, NULL, __unregister);
=20
@@ -2997,7 +2992,7 @@ void spi_unregister_controller(struct spi_controller =
*ctlr)
 	mutex_unlock(&board_lock);
=20
 	if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
-		mutex_unlock(&spi_add_lock);
+		mutex_unlock(&ctlr->add_lock);
 }
 EXPORT_SYMBOL_GPL(spi_unregister_controller);
=20
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 8371bca13729..6b0b686f6f90 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -531,6 +531,9 @@ struct spi_controller {
 	/* I/O mutex */
 	struct mutex		io_mutex;
=20
+	/* Used to avoid adding the same CS twice */
+	struct mutex		add_lock;
+
 	/* lock and mutex for SPI bus locking */
 	spinlock_t		bus_lock_spinlock;
 	struct mutex		bus_lock_mutex;

--zHHfI13WIAeQoK+b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFgSEwACgkQJNaLcl1U
h9CnGwf+OEC11qpc2dYS1q7OHivXoH77VoGf3Mc0njM9vOzCCCwtlCWKu8yJQtIe
606gqOh57U04n2s2xG8qZJJ6vVNxUjCFKJR7JQg/jXMtKCr7klPWZe6yD8LAvllJ
qSxsbRiivVsctkcNka+mwD0i8dTV3fnZgbbNtx6tRqihLSAwGguLuSNQeTn+xGW1
M3WY+GQSoWwGvDJM4F8WpqZnIy9CCdKzZEXFrsRIcCP1mC33NlWNcldx+IQCadvW
WGt/229qgaehmv38hg+XeT9YUuBI3ul51+B98GmonL/tZWMQm8TGEiiIJY7ZJPdI
ulD70T+E4FJdHpcymObJbrSoigik8w==
=648h
-----END PGP SIGNATURE-----

--zHHfI13WIAeQoK+b--

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C83D42575D
	for <lists+linux-spi@lfdr.de>; Thu,  7 Oct 2021 18:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbhJGQHV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Oct 2021 12:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbhJGQHV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Oct 2021 12:07:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E18C061570
        for <linux-spi@vger.kernel.org>; Thu,  7 Oct 2021 09:05:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mYVtd-0001M5-C9; Thu, 07 Oct 2021 18:05:25 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mYVtc-0006IE-Bj; Thu, 07 Oct 2021 18:05:24 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mYVtc-0007Vs-An; Thu, 07 Oct 2021 18:05:24 +0200
Date:   Thu, 7 Oct 2021 18:05:24 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-spi@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@intel.com>
Subject: Deadlock in spi_add_device() -- device core problem
Message-ID: <20211007160524.qhjtcwtto2ftsmhe@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wmdllupxtv6jffp5"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--wmdllupxtv6jffp5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On an ARM board with an spi-mux I observe a deadlock during boot. This
happens because spi_add_device() (in drivers/spi/spi.c) for the spi-mux
device calls device_add() while holding &spi_add_lock. The spi-mux
driver's probe routine than creates another controller and for the
devices on that bus spi_add_device() is called again, trying to grab
&spi_add_lock again.

The easy workaround would be to replace &spi_add_lock with a
per-controller lock, but I have the expectation that it should be
possible to not hold a lock while calling device_add().

The difficulty (and the reason that this lock exists) is that it should
be prevented that more than one device is added for a any chipselect.
My first guess was, this check isn't necessary, because the devices are
called $busname.$chipselect and a second device on the same bus with the
same chipselect would fail when device_add() tries to create the
duplicate name. However for devices instanciated by ACPI the naming is
different (see spi_dev_set_name(), and commit b6fb8d3a1f15). Also there
is a comment "We need to make sure there's no other device with this
chipselect **BEFORE** we call setup(), else we'll trash its
configuration." A problem there might be that spi_setup() might toggle
the chipselect line (which is a problem if the chipselect polarity
isn't the same for the two devices, or the earlier device is currently
busy). Anything else?

There is also a check:

	if (IS_ENABLED(CONFIG_SPI_DYNAMIC) &&
	    !device_is_registered(&ctlr->dev)) {
		return -NODEV;
	}

which catches the race that the controller (which is also the device's
parent) is about to go while we try to add a new device to it. Is this a
real problem? (The spi_unregister_controller() function unregisters all
children which might race with adding a new child without locking. This
check was implemented by Lukas Wunner (on Cc:) in commit ddf75be47ca7.)
Doesn't all children of a given device are unregistered automatically by
the device core somehow when said device is unregistered? (I checked,
but didn't find anything.)

Does this all sound about right? Greg, do you have a recommendation how
to properly fix this problem?

Best regards
Uwe

PS: For now the workaround is to have the spi-mux driver as a module.
This way device_add() for the spi-mux device doesn't bind the driver and
the function returns (but triggers a module load which then can bind the
spi-mux device and create the new controller without a locking issue).

For the record, the relevant device-tree snippet looks as follows:

/ {
	...
        spimux: mux-controller {
                compatible =3D "gpio-mux";
                pinctrl-names =3D "default";
                pinctrl-0 =3D <&pinctrl_spimux>;
                #mux-control-cells =3D <0>;
                mux-gpios =3D <&gpio3 19 GPIO_ACTIVE_HIGH>;
        };
};

&ecspi2 {
        pinctrl-names =3D "default";
        pinctrl-0 =3D <&pinctrl_ecspi2>;
        status =3D "okay";
        #address-cells =3D <1>;
        #size-cells =3D <0>;

        spi@0 {
                compatible =3D "spi-mux";
                reg =3D <0>;
                #address-cells =3D <1>;
                #size-cells =3D <0>;
                spi-max-frequency =3D <100000000>;
                mux-controls =3D <&spimux>;

                adc@0 {
                        compatible =3D "ti,ads7953";
                        reg =3D <0>;
                        spi-max-frequency =3D <10000000>;
                };

                adc@1 {
                        compatible =3D "ti,ads7953";
                        reg =3D <1>;
                        spi-max-frequency =3D <10000000>;
                };
        };
};


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wmdllupxtv6jffp5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFfGsAACgkQwfwUeK3K
7Akfkgf+M5FY71vsc138Sj0jU9oIUq1bbKoT+7e+UBXWCU3eDzwWg4rZCDRVA3Kd
vvaIOnxO6LBxLkmy9f42aCL8jpQ5jBpKsVH6DcX+n2AsKwkt88rLBcZCr1nn34R+
2kTrtzET5wgAC1DB2Q0CNoEa0fDnmPhrwUubeZjxUmB7RMvUrJugpIfd1Q0itC3J
Yc4zwoqjAPctimK/rsV9DIzAsmLF2YSCs7LOCG7BlLdotSrGf9ZiCNhVkpvsWP2U
NbQJt5YGMFdNmK1dYsT6LpAz5oTqIQlmFe2GLFOf+oIB1dDt89UfxX3wNOrxzwQ1
VWwhJPL+jjR6n2x1WONjc6Dl6bjJxg==
=1+Ec
-----END PGP SIGNATURE-----

--wmdllupxtv6jffp5--

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D8A5175E3
	for <lists+linux-spi@lfdr.de>; Mon,  2 May 2022 19:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386683AbiEBRgt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 May 2022 13:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241242AbiEBRgt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 May 2022 13:36:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B466268
        for <linux-spi@vger.kernel.org>; Mon,  2 May 2022 10:33:20 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nlZv5-0000xd-A2; Mon, 02 May 2022 19:33:11 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 83821735C6;
        Mon,  2 May 2022 17:33:05 +0000 (UTC)
Date:   Mon, 2 May 2022 19:33:01 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     linux-spi@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Marek Vasut <marex@denx.de>, kernel@pengutronix.de,
        linux-imx@nxp.com, Mark Brown <broonie@kernel.org>,
        David Jander <david@protonic.nl>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 7/9] spi: spi-imx: replace struct spi_imx_data::bitbang by
 pointer to struct spi_controller
Message-ID: <20220502173301.ghgxu2wfg346zqrc@pengutronix.de>
References: <20220502165210.1956397-1-mkl@pengutronix.de>
 <20220502165210.1956397-8-mkl@pengutronix.de>
 <87a6bzyhky.fsf@tarshish>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="asfy25ipqjjqmugg"
Content-Disposition: inline
In-Reply-To: <87a6bzyhky.fsf@tarshish>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--asfy25ipqjjqmugg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02.05.2022 20:14:28, Baruch Siach wrote:
> Hi Marc,
>=20
> On Mon, May 02 2022, Marc Kleine-Budde wrote:
>=20
> > There's no need to embed the struct spi_bitbang into our private
> > data (struct spi_imx_data), the spi core is flexible enough, so that
> > we only need a pointer to the allocated struct spi_controller.
> >
> > This is also a preparation patch to add PIO based polling support to
> > the driver.
> >
> > Co-developed-by: David Jander <david@protonic.nl>
> > Signed-off-by: David Jander <david@protonic.nl>
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> [...]
>=20
> > @@ -1641,17 +1642,17 @@ static int spi_imx_probe(struct platform_device=
 *pdev)
> >  	else
> >  		controller->num_chipselect =3D 3;
> > =20
> > -	spi_imx->bitbang.setup_transfer =3D spi_imx_setupxfer;
> > -	spi_imx->bitbang.txrx_bufs =3D spi_imx_transfer;
> > -	spi_imx->bitbang.master->setup =3D spi_imx_setup;
> > -	spi_imx->bitbang.master->cleanup =3D spi_imx_cleanup;
> > -	spi_imx->bitbang.master->prepare_message =3D spi_imx_prepare_message;
> > -	spi_imx->bitbang.master->unprepare_message =3D spi_imx_unprepare_mess=
age;
> > -	spi_imx->bitbang.master->slave_abort =3D spi_imx_slave_abort;
> > -	spi_imx->bitbang.master->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_H=
IGH | SPI_NO_CS;
> > +	spi_imx->controller->transfer_one =3D spi_imx_transfer_one;
> > +	spi_imx->controller->setup =3D spi_imx_setup;
> > +	spi_imx->controller->cleanup =3D spi_imx_cleanup;
> > +	spi_imx->controller->prepare_message =3D spi_imx_prepare_message;
> > +	spi_imx->controller->unprepare_message =3D spi_imx_unprepare_message;
> > +	spi_imx->controller->slave_abort =3D spi_imx_slave_abort;
> > +	spi_imx->controller->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH =
| SPI_NO_CS;
> > +
> >  	if (is_imx35_cspi(spi_imx) || is_imx51_ecspi(spi_imx) ||
> >  	    is_imx53_ecspi(spi_imx))
> > -		spi_imx->bitbang.master->mode_bits |=3D SPI_LOOP | SPI_READY;
> > +		spi_imx->controller->mode_bits |=3D SPI_LOOP | SPI_READY;
> > =20
> >  	if (is_imx51_ecspi(spi_imx) &&
> >  	    device_property_read_u32(&pdev->dev, "cs-gpios", NULL))
>=20
> This hunk conflicts with commit 79422ed9bd7f ("spi: spi-imx: add support
> for SPI_RX_CPHA_FLIP") in Mark's for-5.19 branch. That commit also adds
> another reference to bitbang.master.

Will rebase to broonie/spi.git for-5.19.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--asfy25ipqjjqmugg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmJwFcsACgkQrX5LkNig
010KLAf/VGwccg5/njKxVYmQr3hJSxLjPrHHAf3cOrd6neIr3HLC7Sc/B8OuWYru
VdtkiK2lN1I3Kv214ShiMlxfd0/c4BfoYjf+ZoYpkaZPA5nr89HkkoDUO5tiPL5M
30gGq0/xkeVgBVjuWJko8Xvrf4ZT6aOB4eLW6FtfJLmwkE/Dr5f6IEGkf9YhwOuc
CMDm8r85SQi4K2d4blNW04lt4kNewsLdCiXFSpy01os2syEzXSgWXvV3a5eSc8wB
Ywz2v65mOHqL/azEXAwn45cUQEuGyZj5JbA3AO2KdE/jROCgeVLxDIijv1Kt6Ihi
HUkUaeYIbqI5HUTFnpJkfWUH6Jz84g==
=NNeq
-----END PGP SIGNATURE-----

--asfy25ipqjjqmugg--

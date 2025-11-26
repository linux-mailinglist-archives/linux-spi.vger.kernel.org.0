Return-Path: <linux-spi+bounces-11599-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47FEC89DE4
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 13:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95ADC3A9A6F
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 12:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42BA328B5F;
	Wed, 26 Nov 2025 12:52:31 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29F72DCBF2
	for <linux-spi@vger.kernel.org>; Wed, 26 Nov 2025 12:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764161551; cv=none; b=LBhJFtXLI7UUVN9es+jBaajTiusEfCd3u3PH66xcp/qaaesaDwCEHgYHoPCqmEPVn8bh0ctQPbN0RT3RKIjR/0CNX6M3eCDeqg2Gsk9Ab1zfFj1475Kz5GIL60lHqn15GWlr60nsHRW/XyhGdnlOM8uKqKmpf7OObJfDPUqyd6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764161551; c=relaxed/simple;
	bh=R9k/WD2lTWB6v2rz39aMkMg3rNDHipdAX0wWoWUMT0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=katN2t2K6iVpKQtez22JEmk+oEwtlXUqe/G+H45IX3l9F10Q+d4e9rhQhG+amL37fGvGcSV/Sh6kEMrHCePYN2TnV3SvtELt33ArwgL2sJ0q58TIzR5dBZRk0rG+hrxLvv6BhZZ516e+kveSYuT2Ez7mjrPRk+U1dToMrQKZe7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOF0P-0003KP-5V; Wed, 26 Nov 2025 13:52:21 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOF0O-002bsV-2Q;
	Wed, 26 Nov 2025 13:52:20 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6B7F14A8C49;
	Wed, 26 Nov 2025 12:52:20 +0000 (UTC)
Date: Wed, 26 Nov 2025 13:52:20 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Carlos Song <carlos.song@nxp.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>, Frank Li <frank.li@nxp.com>, 
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, 
	"festevam@gmail.com" <festevam@gmail.com>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RE: [EXT] Re: [PATCH 5/6] spi: imx: support dynamic burst length
 for ECSPI DMA mode
Message-ID: <20251126-glistening-rampant-dragon-4ec9d3-mkl@pengutronix.de>
References: <20251125100618.2159770-1-carlos.song@nxp.com>
 <20251125100618.2159770-6-carlos.song@nxp.com>
 <20251126-loyal-lobster-of-virtuosity-0aa824-mkl@pengutronix.de>
 <VI2PR04MB111470B46C3B7B6AF66B69D07E8DEA@VI2PR04MB11147.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o5sidt4qwxpc2qbb"
Content-Disposition: inline
In-Reply-To: <VI2PR04MB111470B46C3B7B6AF66B69D07E8DEA@VI2PR04MB11147.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--o5sidt4qwxpc2qbb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: RE: [EXT] Re: [PATCH 5/6] spi: imx: support dynamic burst length
 for ECSPI DMA mode
MIME-Version: 1.0

On 26.11.2025 12:29:35, Carlos Song wrote:
> > On 25.11.2025 18:06:17, Carlos Song wrote:
> > >  static int spi_imx_pio_transfer(struct spi_device *spi,
> > >  				struct spi_transfer *transfer)
> > >  {
> > > @@ -1780,9 +2112,14 @@ static int spi_imx_transfer_one(struct
> > spi_controller *controller,
> > >  	 * transfer, the SPI transfer has already been mapped, so we
> > >  	 * have to do the DMA transfer here.
> > >  	 */
> > > -	if (spi_imx->usedma)
> > > -		return spi_imx_dma_transfer(spi_imx, transfer);
> > > -
> > > +	if (spi_imx->usedma) {
> > > +		ret =3D spi_imx_dma_transfer(spi_imx, transfer);
> > > +		if (transfer->error & SPI_TRANS_FAIL_NO_START) {
> > > +			spi_imx->usedma =3D false;
> > > +			return spi_imx_pio_transfer(spi, transfer);
> > > +		}
> > > +		return ret;
> > > +	}
> >
> > Why do you do this? AFAICS the framework already does this for you see:
> > spi_transfer_one_message().
> >
> Hi,
>
> In frame work:
> 				if ((xfer->tx_sg_mapped || xfer->rx_sg_mapped) &&
> 				    (xfer->error & SPI_TRANS_FAIL_NO_START)) {
> 					__spi_unmap_msg(ctlr, msg);
> 					ctlr->fallback =3D true;
> 					xfer->error &=3D ~SPI_TRANS_FAIL_NO_START;
> 					goto fallback_pio;
> 				}
>
> It only will help do this for "framework finished DMA map case". But DMA =
dynamic burst feature is mapped in driver.
> So this condition never meet: (xfer->tx_sg_mapped || xfer->rx_sg_mapped) =
I think..

=2E..and you remove "controller->can_dma" this deserves some comments in
the commit message. That you fool the framework, that you cannot do DMA,
and do all the mapping on your own.

If you can make it work with DMA_SLAVE_BUSWIDTH_1_BYTES then you can use
controller->prepare_message and controller->unprepare_message to do the
byte swapping. These functions are called before and after the DMA sync.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--o5sidt4qwxpc2qbb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkm+AEACgkQDHRl3/mQ
kZz2aAf+NfQMom5cSlCV1sp4geNMQsYmqG4QERaSHYNr/okdJJwdai4uuxAdpfA6
R1bnr+JPDx2fFHsixxpkJkWtiLo0RE4uNAARa63gWSVKHLFRjN2hXYmHR1uoDyy5
cYVMTcIdNn2DvheQ6eVfzN3LZI67RyiYL3sfwnjuHwsORJhghMpj14hqoR2dJeCB
kdDMm71JUrfDfEa4VHMCRFokKLi3A1KBKlImfvTq60UREvHsG+Z2aGxCxyjEldhj
zEC1Lw6eCED/bZf+VroSpoDGjvpbMQbRMviVPfqxOy8obbxiwjxezBwqCzswi0X/
2cuNSWCvVtynRv4wdL6WdK7JDO+csg==
=w9CB
-----END PGP SIGNATURE-----

--o5sidt4qwxpc2qbb--


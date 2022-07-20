Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFCA57B5DD
	for <lists+linux-spi@lfdr.de>; Wed, 20 Jul 2022 13:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiGTLsh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Jul 2022 07:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiGTLsh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Jul 2022 07:48:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C1171706
        for <linux-spi@vger.kernel.org>; Wed, 20 Jul 2022 04:48:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C837B81EE2
        for <linux-spi@vger.kernel.org>; Wed, 20 Jul 2022 11:48:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD8DC341C7;
        Wed, 20 Jul 2022 11:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658317713;
        bh=wqCiYjEXOUaJZ/nWcp+srmzpGPVkNH/8l8lR7DRCTqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tbBn2ffzZjsNw3CHkM5mGkw4ti2sDzgUwkj8y++vMWWf5wSHv/VDYwFrjsf2qw0Uq
         MyyWvQgS5KIo/iCJdqB99/Bq3x2J+3Sy6qQc7Ut/G61lgYHImXZN87W7sQX8dLcflQ
         4AsADfc9G9wCLVoUXb5zwJc4T3HN2INWvFIARx5m3NPDAs6aNIvh+3snBTh91pQ8qv
         Sef8JfAm73JPJxe04Ee7GSz2YIXZCgGFsv9mzWJQs2G6a60zyAf1TX/mb52UkYN/n9
         Ibr9qCMndhanZZljMHPYzEP05ghhUM+i6H1iWuPcPRCXTp47ZtYLFDgAlnGM9n+WHz
         tGjr01cnE3DnQ==
Date:   Wed, 20 Jul 2022 12:48:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-spi@vger.kernel.org,
        kernel@pengutronix.de, Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jens Lindahl <jensctl@gmail.com>
Subject: Re: [PATCH] spi: bcm2835: bcm2835_spi_handle_err(): fix NULL pointer
 deref for non DMA transfers
Message-ID: <YtfrjPoqeSPWDYgH@sirena.org.uk>
References: <20220719072234.2782764-1-mkl@pengutronix.de>
 <20220719074701.GA26268@wunner.de>
 <20220719075515.x2usfgiolzx4xkt5@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cyo/wMjNfje6A7mm"
Content-Disposition: inline
In-Reply-To: <20220719075515.x2usfgiolzx4xkt5@pengutronix.de>
X-Cookie: I exist, therefore I am paid.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--cyo/wMjNfje6A7mm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 19, 2022 at 09:55:15AM +0200, Marc Kleine-Budde wrote:

> The difference is (Jens Lindahl):
>=20
> +	if (bs->tx_dma_active) {
> +		dmaengine_terminate_sync(ctlr->dma_tx);
> +		bs->tx_dma_active =3D false;
> +	}
>=20
> vs. (me):
>=20
> +	if (ctlr->dma_tx) {
> +		dmaengine_terminate_sync(ctlr->dma_tx);
> +		bs->tx_dma_active =3D false;
> +	}
>=20
> Which one is preferred?

Probably checking dma_tx is a bit more robust, though it shouldn't
matter really.

--cyo/wMjNfje6A7mm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLX64sACgkQJNaLcl1U
h9Cnggf+PiiguM0flSpu77XVei8gOEf+RavzxBCrbEK7ZuNHveBWUbYjkp5/fA00
SJddPXzYgYi6zWC6qGlHI/F2HTB5GTm/DEsRxRCfy8Jd3fXNldxEcLJ6wmi7g117
nbMPOXf4Qf6OiVF5seRvXNbYwg7awlxF1vBnGqJWDPO/WzJUNALnAlBM8xbCRswJ
vabesulK5FGxg8gEWKsnNOWntR49wwoNZwySnAnim1b8/MzkKuhVTttxjnBUTXmx
VMjzuLWwrFhsLOc7trEvzKKFW71RSYFgqNuFZXw8zpyBbY7zcZvNPoOvwoDDDFWx
cg7wT+JIA666cZHv8S3pFXwSPBicUA==
=FJ7N
-----END PGP SIGNATURE-----

--cyo/wMjNfje6A7mm--

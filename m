Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74EDF249D4D
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 14:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgHSMEP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Aug 2020 08:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbgHSMEI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 19 Aug 2020 08:04:08 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C82EC205CB;
        Wed, 19 Aug 2020 12:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597838648;
        bh=llznCmAlAsG7lUfJSLQrqdeCqZCRGQh2/qbmrfm9NNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dxFXoxA6dS+hsFBdDrtJ0AEPzQEYkf+3pBADRmxUlhwxosWSAzOq4UM5SWn+bKSWk
         Ku0LjQUGu+64MVesseT9eNUGLUogr+QGTPu6OqQVC7iaNVvXbBKTBmG9UUYA1tAigK
         TGdR2aKOxo6ZQFmf0M6y+AvVN/wH1ieWOonJeAeo=
Date:   Wed, 19 Aug 2020 13:03:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: imx: Remove unneeded probe message
Message-ID: <20200819120336.GA13577@sirena.org.uk>
References: <20200818223519.8737-1-festevam@gmail.com>
 <20200818223519.8737-2-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <20200818223519.8737-2-festevam@gmail.com>
X-Cookie: Peter's hungry, time to eat lunch.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2020 at 07:35:19PM -0300, Fabio Estevam wrote:
> There is no point in printing a plain "probed" message on successful prob=
e.
>=20
> Just remove it and make the kernel log a bit less noisier.

This doesn't apply against current code, please check and resend.

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl89FRcACgkQJNaLcl1U
h9BFIAf6AvLM3fEzOQXcE2MtSgjVDTuG00PDCJ5tdfnzG3jk0LCGPyIYSOC4E/nN
7ZU8zToja3XOsVTeFUtGAoJxwHJsdajJZRNliMF1cVb1vpNMvcfspuXsLw6tJHAH
miuGQI6nZNsgg/fh7ObwWT/30TEEs41CmkuMw5XA9yXQWr4ZYHMWQsR87lVEBFNO
4wPAI5sBjzY0C8ROmDKgSwyQnYmnrTc7D8a0I+VHUksCgTln9B1CYrbaWK3oN54i
Q5bNHgODbC5kL6Xp+Yfqsr+PDBrvV2QIMe1hi+11GutlUOKG6D5f8Io13yGHJCXu
wSujMIXA/mzFZLfTy8hK/Lym+3miTQ==
=Ht1p
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--

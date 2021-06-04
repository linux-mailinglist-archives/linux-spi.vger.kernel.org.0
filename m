Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7ED39BC29
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jun 2021 17:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhFDPr3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Jun 2021 11:47:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229809AbhFDPr3 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 4 Jun 2021 11:47:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DD8561405;
        Fri,  4 Jun 2021 15:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622821542;
        bh=/BQwUagx9a5ZyivH2uGWPzZC1Noajep7RNrh0F+YQJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JCM1d1f9RFPRfoAMZRTMSCOmFkoYrHo/UE8J+cXqcUEeURkZ61pQnnqZviLsAJS9E
         ve5wlMQeStdePeV74TS+HFRRDAw/7PliG/no4jkXZdpqMyDJY4+s3LZha78eBa28o0
         CdE2LynVvpXlHfA5LgDI9UsZLn/hRuzJvTcNOsuCkRZeHi8nVh1sjRj6wbLoqrtMnZ
         HiSR7Rxv5Dl1HDZGSJIaurIVpmiaphWL/GH9YxfVjfJwwDy5W30YdZaYt4p8WHh3xT
         U2LQNHU/KmLZVA/GJ3fWVuSfRrxMBY6fGKTrTgd8xjWSUogBe24JpLLzSSWSfP3/u0
         rSqr25pVU2ngA==
Date:   Fri, 4 Jun 2021 16:45:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v1] spi: add of_device_uevent_modalias support
Message-ID: <20210604154530.GE4045@sirena.org.uk>
References: <20210525091003.18228-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wTWi5aaYRw9ix9vO"
Content-Disposition: inline
In-Reply-To: <20210525091003.18228-1-m.felsch@pengutronix.de>
X-Cookie: There is a fly on your nose.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 25, 2021 at 11:10:03AM +0200, Marco Felsch wrote:
> Add OF support as already done for ACPI to take driver
> MODULE_DEVICE_TABLE(of, ..) into account.
>=20
> For example with this change a spi nor device MODALIAS changes from:
>=20
> MODALIAS=3Dspi:spi-nor
>=20
> to
>=20
> MODALIAS=3Dof:Nspi-flashT(null)Cjedec,spi-nor

Will this break existing userspace?

--wTWi5aaYRw9ix9vO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmC6SpoACgkQJNaLcl1U
h9CZMgf/eSlXNYzVP/z/QjJRmOHNj6Hbaspol9znlzYy28SOYVOeec657fQjPQCr
rgMXmIw97Bf1jKNSnNC1ABl8UEdewzyN+TgnP6BNGw1awIDUuQ+aiei/WkmwIN0m
ClmYEOgLdtNvAN57a5pZt9CpuxGWF4r3qhDXw81pFaWxP9hKaXJYgh+fxQAsx2pE
6ume9uQ95s21U8ug/82imJUfbvNYr7piLfovzggQDU2O2auOY90+/EmP9yUYpkZk
mQm6gcjbkp0CKiY6cvZhTAm9s0RstDPn6VNEpqWSycL5P253BQOey8GyDswRqOKx
t08YByn1VLGlg2y2xSJoBFfTghn9Wg==
=2ri+
-----END PGP SIGNATURE-----

--wTWi5aaYRw9ix9vO--

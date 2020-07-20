Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A69226248
	for <lists+linux-spi@lfdr.de>; Mon, 20 Jul 2020 16:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgGTOhJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Jul 2020 10:37:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgGTOhI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 20 Jul 2020 10:37:08 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0A7922482;
        Mon, 20 Jul 2020 14:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595255828;
        bh=D0KFNAjP2SiT70ZP0dwkqvRXTRBrn0imU8/trOhkoGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PFC/Qy/RnQlCdjFiaSMVCI9FyQWhyd9wC7R6o2c/0UEOGLkKBX2B78+6oTKrI/pVQ
         1Rj6c36FREPm9mHEPYtJuq6ohSXnbOjuhoKAtaCsqHWS9nOf7njmpxkPwMctKmmkqM
         OR7dK5pLCcM0AOdvtYZbvzMujkkzhl/i5ofM08wE=
Date:   Mon, 20 Jul 2020 15:36:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Colton Lewis <colton.w.lewis@protonmail.com>
Cc:     linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: correct kernel-doc inconsistency
Message-ID: <20200720143655.GA5949@sirena.org.uk>
References: <20200719195630.148075-1-colton.w.lewis@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <20200719195630.148075-1-colton.w.lewis@protonmail.com>
X-Cookie: In the next world, you're on your own.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 19, 2020 at 07:56:40PM +0000, Colton Lewis wrote:
> Silence documentation build warnings by correcting kernel-doc comment
> for spi_transfer struct.

This doesn't apply against current code, please check and resend.

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8VrAcACgkQJNaLcl1U
h9Do0gf/fM2+AgFvGyVM5Q3sm0pZze/V8pgdTzuEVftwDYJsPSjDctTlDfsIv0j4
fnzkYIwPtlxGrQgQ9JlMNwYUkhDUS2QchaUxiPOsxl8iQBWEJP+uC36NKxE+VaXq
h40WQhLifkV1ds5FkcKoW6+uF2LwPDSnPqT6S9NHGjWYk/ecy6KjsccRHnln6Sdm
FZZ0vn0LuygiZvWup04ciD7jTo7hYF2cPhLTXvsLRETSH4Ne4euYfziZn6AxDoRw
2PCcZmp7163O0Ol0BQ+FDo6y+beRXz0YyLiIPz+PJ/gx6mb2otvUrnde4MBmuRk3
TGUVruvgimzwoldF4DKtyLkktdrXGw==
=B9U7
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--

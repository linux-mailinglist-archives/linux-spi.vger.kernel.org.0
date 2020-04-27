Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF641BA2FA
	for <lists+linux-spi@lfdr.de>; Mon, 27 Apr 2020 13:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgD0LyU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Apr 2020 07:54:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgD0LyT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 27 Apr 2020 07:54:19 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 058D720644;
        Mon, 27 Apr 2020 11:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587988459;
        bh=nZ3mD9ws68gkD063hDmlcYv/n61XV3lal2k6Vx5PZk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mZtWC51jN5UBzwJsN47+KsV2QojadwCDn8NKR8M9kFVY0RAehRGAoLxTfSFaBheQL
         L3tHoQyKA3GWQOUDDc7sMCOH0uuFPoQTfm5Y3C6v2k20u3c6e7zLChAhNIFWLl1VS7
         g622ihc/MIA2Q1EiV4hfyNeJnl26cR3Hxj9Yl+24=
Date:   Mon, 27 Apr 2020 12:54:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     Nehal-bakulchandra.Shah@amd.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: spi-amd: Add AMD SPI controller driver support
Message-ID: <20200427115416.GA4383@sirena.org.uk>
References: <1587844788-33997-1-git-send-email-sanju.mehta@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <1587844788-33997-1-git-send-email-sanju.mehta@amd.com>
X-Cookie: If your bread is stale, make toast.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2020 at 02:59:48PM -0500, Sanjay R Mehta wrote:
> This driver supports SPI Controller for AMD SOCs.This driver
> supports SPI operations using FIFO mode of transfer.
>=20
> ChangeLog v1->v2:
> 	- Fix up to handle multiple receive transfer case.
> 	- move chip_select in transfer_message, flag device as
> 	  half-duplex and some cosmetic changes.

As covered in submitting-patches.rst this should go after the --- so it
doesn't appear in git.  Otherwise this looks good though, thanks!

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6mx+cACgkQJNaLcl1U
h9DCSQf+K699hIJlaQHPEbRacevvfybEhe6YAWmB+PKZgF7K4ukUZ4clcMlCx6d0
duwrN/CilJv+Yl2jbvoNq1GaVH3qf2UIPysXPVWwEgWn/mEtfIp/PLR0NRz909Cz
+zThV+uuC6vLHKOGqKZdn2i2ySbTYF/X2QLDBCAV56kXEp+JG3nHJN6gITp2DJX4
+ypx8s5hLN/+HcTYrVgDqSk0YcBpzJY7W/23eWPl9+n/ALGwWiblN2wJzbJyoZ0x
8gS30I44BYCbTm288j7vDQux+aJZGUn5S0Hlp7ZoBV6l4Gz2nOl0nX0LV4FGpruX
sBap5hf4mhN0ZPywI+jCihC0uLgaIw==
=zNSI
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--

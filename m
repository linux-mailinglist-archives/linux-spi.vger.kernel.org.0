Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6922627324A
	for <lists+linux-spi@lfdr.de>; Mon, 21 Sep 2020 20:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgIUS5b (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Sep 2020 14:57:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgIUS5b (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 21 Sep 2020 14:57:31 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D86B20888;
        Mon, 21 Sep 2020 18:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600714650;
        bh=Fpuvc99D3ojSQz0Ih1e/dJpmDNQ5V5OWcXq0uMfacF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kseT8TpGG26uG5yPWiqpdhbWGZ1/0PmnqYpqJAybACB1zN6tLEHjPIFlErnY3MSqG
         7DzjQa4BW/y9K5FN75m/60QfvuSeIjopB9brlTSFETy4TSa2JM9dQC0cvrJE5Sx9Ci
         4vw5PXGLPq+ORUp5nHYa/cvyCmaMta4/CKrJtz84=
Date:   Mon, 21 Sep 2020 19:56:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "spi: omap2-mcspi: Switch to readl_poll_timeout()"
Message-ID: <20200921185638.GH4792@sirena.org.uk>
References: <20200910122624.8769-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LiQwW4YX+w4axhAx"
Content-Disposition: inline
In-Reply-To: <20200910122624.8769-1-a-govindraju@ti.com>
X-Cookie: Love thy neighbor, tune thy piano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--LiQwW4YX+w4axhAx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2020 at 05:56:24PM +0530, Aswath Govindraju wrote:
> This reverts commit 13d515c796adc49a49b0cd2212ccd7f43a37fc5a.
>=20
> The amount of time spent polling for the MCSPI_CHSTAT bits to be set on
> AM335x-icev2 platform is less than 1us (about 0.6us) in most cases, with

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--LiQwW4YX+w4axhAx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9o92UACgkQJNaLcl1U
h9AZYAf/fV6TOg8U++qh08UDGcRasmk50C1XO2QANRr0TYNKvCZ5WOOpyh69y9Wn
EBrHSEAdvihbb5w8plSKMVpmZDrm5/ttmRSPwfA5OlKQqoz8oqkLZPlXifbr/+DQ
/iAMttuRGj7eXI1WJoUcpyPFrtrRUbBcJPQHSdhHuToH0aq3SvCMcOA7+JHec9Gf
Tb/MUKPnq6jl84c5qdojU/FpdKiznAVPPlDBZHnD07laSOxDuz40tVFBEZvHkumN
8MXSGz6b7mL1I0Z2b+keDDa1jVzZLqnAuRutm2WV6877ykKF2FCa0Zo5sc3znh7k
qOOqu/SKm+Cdge2ddo+KtEe0b71DVQ==
=pequ
-----END PGP SIGNATURE-----

--LiQwW4YX+w4axhAx--

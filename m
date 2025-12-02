Return-Path: <linux-spi+bounces-11722-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7669FC9C332
	for <lists+linux-spi@lfdr.de>; Tue, 02 Dec 2025 17:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 737FF4E417F
	for <lists+linux-spi@lfdr.de>; Tue,  2 Dec 2025 16:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00ED283FC5;
	Tue,  2 Dec 2025 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTeaHskc"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6003270557;
	Tue,  2 Dec 2025 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764692910; cv=none; b=PLYqTcoxGK4850qLhRNp1V/d35n/oiNldGUuFLXn6+UONHLtvNrEY40/DwKTc5gCtefi7NEz1Ya9tI6E88appZbTRu+HWKiRs5JdRvWXT/21yst4qIFsTXGsKjbEZxVoKF0Lp8vVtSxnYBMNBtjusL6y/SEIJ//sFrtpy7bIbvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764692910; c=relaxed/simple;
	bh=bMdsKnyhcJs9VfP6ltjW1PuLp0n8+YA6JBJWKjztIQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktpky5KOx3jaG3Gff9eswqWVk5YhMhX2McgRYYq9xZXOeTLYXBquRRIicRmzzUPF0traOM9WPbezU/GynmPZ7XFGxQFcg8TqijMUoZLc3/uJiGgfG3NIKaMgNVNMtTcnBc8tHbYLaTOUODsY1D843Qa9+I0NfJfi0p7aQGpeko8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTeaHskc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF294C4CEF1;
	Tue,  2 Dec 2025 16:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764692910;
	bh=bMdsKnyhcJs9VfP6ltjW1PuLp0n8+YA6JBJWKjztIQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YTeaHskcMr7V4e4oRUflCmsQK79rRG0s4+sy/HW0MYk+5wuws6jJk/nX1K4ZNUal8
	 sX2gRP/K6zrkRdU3qW0AdVk2NCCGwePDaOfXFmQbzNozXcVJ1C6e/cIE3NvDwyn2Fk
	 PRFF7H7wg/8QGBIi2vWIb2ndLyujNNrfRWyFdpn0l61LgVsTEcabQyE7cX8lS2GaEN
	 48Gp+JnsKznxNE0pXVF5j+mYwDOcOoBLCIeZvD5y9pTEE2Dhg2jAnDmNAv7R46lW8T
	 yq73BGj+Naw8v1nyx+EgMFZvdlEuUZV7taJNh5y8ySmV/P7zW2RxXj2MTge1dMZq9m
	 4lWSxj3PEdzCw==
Date: Tue, 2 Dec 2025 16:28:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, a-dutta@ti.com,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH] spi: cadence-quadspi: Fix cqspi_probe() error handling
 for runtime pm
Message-ID: <5f288d65-4209-41cd-8f1a-3690f38da7ef@sirena.org.uk>
References: <20251119152545.2591651-1-s-vadapalli@ti.com>
 <20251201072844.GA6785@francesco-nb>
 <20251201074320.GA8737@francesco-nb>
 <dfbbd5ce209fac9a556c200748d8c521d0d4f450.camel@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aG5bUVWmZOfsZcU4"
Content-Disposition: inline
In-Reply-To: <dfbbd5ce209fac9a556c200748d8c521d0d4f450.camel@ti.com>
X-Cookie: Beware the new TTY code!


--aG5bUVWmZOfsZcU4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 01, 2025 at 06:08:07PM +0530, Siddharth Vadapalli wrote:
> On Mon, 2025-12-01 at 08:43 +0100, Francesco Dolcini wrote:
> > On Mon, Dec 01, 2025 at 08:28:44AM +0100, Francesco Dolcini wrote:

> > > > The error is due to the second invocation of 'clk_disable_unprepare=
()' on
> > > > 'cqspi->clk' in the error handling within 'cqspi_probe()', with the=
 first
> > > > invocation being within 'cqspi_runtime_suspend()'.

> > > [    8.648915] cadence-qspi fc40000.spi: No flash device declared
> > > [    8.675671] cadence-qspi fc40000.spi: failed to setup flash parame=
ters -19

> Could you please check if the driver's suspend callback has executed befo=
re
> the above? The patch intended to fix the very issue being reported.
> Therefore, the commit corresponding to the current patch might still
> trigger the issue. Ideally, reverting the commit for the current patch and
> the commit under Fixes (f1eb4e792bb1 ("spi: spi-cadence-quadspi: Enable pm
> runtime earlier to avoid imbalance"))
> should prevent the issue.

Given the above log we've failed at cqspi_setup_flash() so we shouldn't
have got as far as the code you changed for handling direct mode - I
think the actual issue is likely Anurag's earlier change f1eb4e792bb1
(spi: spi-cadence-quadspi: Enable pm runtime earlier to avoid imbalance)
that you mention, it means we've done a pm_runtime_get_noresume()
previously.  That shouldn't have done a clock enable due to the
noresume, but the get() being there will confuse pm_runtime_disable()
and cause it to invoke the suspend callback as Francesco identified.
This will have been failing previously if controller registration
failed, but it's now happening in more situations.

This is all very annoying since runtime PM can be configured off so we
can't rely on it's callbacks actually happening.  I *think* something
like the below ought to DTRT (I'd expect it should avoid the reported
error at least):

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-qu=
adspi.c
index af6d050da1c8..0833b6f666d0 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1985,7 +1985,6 @@ static int cqspi_probe(struct platform_device *pdev)
 		pm_runtime_enable(dev);
 		pm_runtime_set_autosuspend_delay(dev, CQSPI_AUTOSUSPEND_TIMEOUT);
 		pm_runtime_use_autosuspend(dev);
-		pm_runtime_get_noresume(dev);
 	}
=20
 	ret =3D cqspi_setup_flash(cqspi);
@@ -2012,6 +2011,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	}
=20
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
+		pm_runtime_get_noresume(dev);
 		pm_runtime_mark_last_busy(dev);
 		pm_runtime_put_autosuspend(dev);
 	}

Unfortunately none of my testing appears to show the issue.

--aG5bUVWmZOfsZcU4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkvE6kACgkQJNaLcl1U
h9BD0wf/SeW9/3pIxTUbxozYkm7XeHw06XMSrVru1LRh53CJqmPp/CK3yLWHXDZD
tBkYtKDcyYERihgoqLGUdk3HfETJDoRsnlScHMXeXIiB9ARKkv4CJZ9vS2BE7qYo
LB6QvkLLyZ4HYM80g3Ty/S/xMoAZwaLK2k5ZQ8eJvf6XP4oDdl2YY9gzeGjydY3U
bAeF8w1wUsTeaPMLn5wusn6q8hq+taSyjFChkt7HTMImDl8OePN3hURwpi65xX8S
GIF5nKlxvnHAwifLa6WKXJ+CoRTTs+ZcZ/nL7Yu9RtRciW3vj9hVn1wv7l54GPUL
SRgRfILunELe5SLkPZGeJ5GL1gFqjw==
=K6gR
-----END PGP SIGNATURE-----

--aG5bUVWmZOfsZcU4--


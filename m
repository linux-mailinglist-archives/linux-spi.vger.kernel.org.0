Return-Path: <linux-spi+bounces-11776-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B67D0CA5B89
	for <lists+linux-spi@lfdr.de>; Fri, 05 Dec 2025 01:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A7A03094B70
	for <lists+linux-spi@lfdr.de>; Fri,  5 Dec 2025 00:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21696EEC0;
	Fri,  5 Dec 2025 00:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOKE/KYO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72E938D;
	Fri,  5 Dec 2025 00:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764892995; cv=none; b=VE93//dxxj3KJieLTJqYLFg0c4NlOTLwaCpjGwYqHo8miD4DmD1e6ANG190Rfcwo6tZycVt98vDY9ZL+ccQGWDFUSW8N3dHxa6t/68GeHjeOIl3i09QMlt9D9B6rV/PY8rQE9fvZPRO8se3+l5dS8yH81AUBGvspwh1EclpzJl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764892995; c=relaxed/simple;
	bh=7xZOHa1uWVWWOcDXuhi8IIxst4cg/SaFIAADJg3TPhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZbn4ZDDoonDgtoFHVoeqGfdfaO7/u/g144Su9Jl3ZE4uiVv7IzxCom8TU40Z8zAOYxGzlh56csbXTej75g+viFfjBPteXQLmZvgUm/1aQKIUhFXLQeGOCc5EvyT84maaVyuIYrDcs53xQzTXrxEO+4qphUumyZz/hiVR5dJclY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOKE/KYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04D6C4CEFB;
	Fri,  5 Dec 2025 00:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764892994;
	bh=7xZOHa1uWVWWOcDXuhi8IIxst4cg/SaFIAADJg3TPhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NOKE/KYOFUT+94lImOY5oBlErREiSRUQ8WyoF3aHoqx4nrqstDJlJI9K+vONquYk6
	 wBSNzkYeOHo8ni0gtE6HmRSwrHRDSDLK9BZhbadhseVpXSBVky2SWBdtQVDM7bumfp
	 WnQztlM+V3eamV61N2KrNHgAF4MccT0p2jHo6U4Ho4lC/ituor/90hfDeVYMpTwU9A
	 kFsR/lIA0TgnBdJ+6ByXgkeNEh9ObjTjYq/Wqqp7I7+htO21cEUARE4e2qRsPW35Up
	 W1Ix/I6GduXIWl+YJUXA9m5ulw55ucxYEhjMEVJndJhXQ5ZQ4Zksrwty3pxXmuTlQX
	 6e5zD6Y+dKW8g==
Date: Fri, 5 Dec 2025 00:03:10 +0000
From: Mark Brown <broonie@kernel.org>
To: Nishanth Menon <nm@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Anurag Dutta <a-dutta@ti.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] spi: cadence-quadspi: Parse DT for flashes with the
 rest of the DT parsing
Message-ID: <1f8b3c12-acf9-4828-818d-3526c7675e14@sirena.org.uk>
References: <20251204-spi-cadence-qspi-runtime-pm-imbalance-v2-1-10af9115d531@kernel.org>
 <20251204200027.p4osjcj67bcmsvck@skipper>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IlY1Ynf3ryy/wQKH"
Content-Disposition: inline
In-Reply-To: <20251204200027.p4osjcj67bcmsvck@skipper>
X-Cookie: volcano, n.:


--IlY1Ynf3ryy/wQKH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 04, 2025 at 02:00:27PM -0600, Nishanth Menon wrote:
> On 19:13-20251204, Mark Brown wrote:

> > The recent refactoring of where runtime PM is enabled done in commit
> > f1eb4e792bb1 ("spi: spi-cadence-quadspi: Enable pm runtime earlier to
> > avoid imbalance") made the fact that when we do a pm_runtime_disable()

> https://gist.github.com/nmenon/5ca89b617113e9dbb31d4630586af945#file-gist=
file1-txt-L1004
> next-20251204 + this patch -> The issue still exists at least on my
> platform.

Right, so from the log this is the one I think I mentioned earlier that
the error path isn't being triggered by cqspi_setup_flash() but by
something else which doesn't log anything:

[    1.489445] 2840000.serial: ttyS4 at MMIO 0x2840000 (irq =3D 210, base_b=
aud =3D 3000000) is a 8250
[    1.498635] ------------[ cut here ]------------
[    1.503239] clk:104:0 already disabled
[    1.507019] WARNING: drivers/clk/clk.c:1188 at clk_core_disable+0x80/0xa=
0, CPU#0: kworker/u8:2/55

so I'd not expect this to help in that case, it's specifically avoiding
the issue Francesco reported where it's the DT parse.  Can you put some
debug statements in or something to confirm what triggers the error
handling?  Sorry, I'd not remembered that we'd got other triggers when I
sent this.

Also, I wonder if the below completely untested change will help with
that issue?  I'm a bit nervous that this might mess up some power domain
handling.

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-qu=
adspi.c
index bdbeef05cd72..ff7beacbc085 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1884,11 +1884,6 @@ static int cqspi_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return -ENXIO;
=20
-	ret =3D pm_runtime_set_active(dev);
-	if (ret)
-		return ret;
-
-
 	ret =3D clk_prepare_enable(cqspi->clk);
 	if (ret) {
 		dev_err(dev, "Cannot enable QSPI clock.\n");
@@ -1987,13 +1982,6 @@ static int cqspi_probe(struct platform_device *pdev)
 	cqspi->current_cs =3D -1;
 	cqspi->sclk =3D 0;
=20
-	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
-		pm_runtime_enable(dev);
-		pm_runtime_set_autosuspend_delay(dev, CQSPI_AUTOSUSPEND_TIMEOUT);
-		pm_runtime_use_autosuspend(dev);
-		pm_runtime_get_noresume(dev);
-	}
-
 	host->num_chipselect =3D cqspi->num_chipselect;
=20
 	if (ddata && (ddata->quirks & CQSPI_SUPPORT_DEVICE_RESET))
@@ -2005,10 +1993,21 @@ static int cqspi_probe(struct platform_device *pdev)
 			goto probe_setup_failed;
 	}
=20
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
+		ret =3D pm_runtime_set_active(dev);
+		if (ret)
+			goto err_probe_setup_failed;
+
+		pm_runtime_enable(dev);
+		pm_runtime_set_autosuspend_delay(dev, CQSPI_AUTOSUSPEND_TIMEOUT);
+		pm_runtime_use_autosuspend(dev);
+		pm_runtime_get_noresume(dev);
+	}
+
 	ret =3D spi_register_controller(host);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register SPI ctlr %d\n", ret);
-		goto probe_setup_failed;
+		goto probe_pm_failed;
 	}
=20
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
@@ -2017,9 +2016,10 @@ static int cqspi_probe(struct platform_device *pdev)
 	}
=20
 	return 0;
-probe_setup_failed:
+probe_pm_failed:
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
 		pm_runtime_disable(dev);
+probe_setup_failed:
 	cqspi_controller_enable(cqspi, 0);
 probe_reset_failed:
 	if (cqspi->is_jh7110)

--IlY1Ynf3ryy/wQKH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkyIT0ACgkQJNaLcl1U
h9DCvQf+KnFt00B9LHSqG3EblHOQi2QzU6vvui7LXoSAC9ndDAVgQeJgHYoMVE6X
lTnBC2ZRlvOWTVO36xxRgUukehA3wQQYyy4f25W07+pn9WI4Fxrk6plVLl0vUnyJ
leQtMnTM73zhpedS+FTfBVCLXV69fXM3xK0MVAngAj2aUerYz4vd6c5PKf5vebyC
2VC2kA4s2l/kp+ilRnSznNAWz8Wxv5X3U1aySIw07PGa7N4DR1HM76nzssoSlIqV
Y8NDsqEQRJ2Y8oLSEULb8cdLPULoi7hGEzj3pP9mkIB+d4yqMUFX+PHkTz3Eh6vZ
p1tmMkBQW/lxXz+yuGnNvgAS09yyvQ==
=WuF4
-----END PGP SIGNATURE-----

--IlY1Ynf3ryy/wQKH--


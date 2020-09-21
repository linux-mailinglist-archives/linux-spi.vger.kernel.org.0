Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8318E273254
	for <lists+linux-spi@lfdr.de>; Mon, 21 Sep 2020 21:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbgIUTBT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Sep 2020 15:01:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbgIUTBS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 21 Sep 2020 15:01:18 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 002172086A;
        Mon, 21 Sep 2020 19:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600714878;
        bh=deQYkPS0iXLFmKUTBwE68qM37Y3TxhR4uGafiXwSPOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DYBKqeCEQ+PT7FGjYNQk4XsV9/a0MPchAdZS8ZsF/KfFYeTMGCgXZ0URASLNfQDP1
         D8luC82UtbTAOpbyluLVp7PNrc9MEGOkFZKX9sXu/M+HLIczQ03Ul2075I1nv2lNqu
         KvW7O8M5ps+xDB0h4vLONyt/+3XtypNplQd6AVEo=
Date:   Mon, 21 Sep 2020 20:00:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "spi: omap2-mcspi: Switch to readl_poll_timeout()"
Message-ID: <20200921190025.GI4792@sirena.org.uk>
References: <20200910122624.8769-1-a-govindraju@ti.com>
 <20200921185638.GH4792@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VaKJWhUROU/xPxjb"
Content-Disposition: inline
In-Reply-To: <20200921185638.GH4792@sirena.org.uk>
X-Cookie: Love thy neighbor, tune thy piano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--VaKJWhUROU/xPxjb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2020 at 07:56:38PM +0100, Mark Brown wrote:
> On Thu, Sep 10, 2020 at 05:56:24PM +0530, Aswath Govindraju wrote:
> > This reverts commit 13d515c796adc49a49b0cd2212ccd7f43a37fc5a.
> >=20
> > The amount of time spent polling for the MCSPI_CHSTAT bits to be set on
> > AM335x-icev2 platform is less than 1us (about 0.6us) in most cases, with
>=20
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

Oh, and also:

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--VaKJWhUROU/xPxjb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9o+EkACgkQJNaLcl1U
h9BkJAf+M/tafx3tPXNVe/XWRpgw5xppnPA35pudyXqx0Ho9DMriH7DY9aPKrV8r
qpCqPziXf600FNK/tSG/EaVQOY+aiBEjASkhA19Im6zhDlbgAjejsc+BrUcu495+
K2wxRJkLnChZc7a6k67k6afWHLA2ybcMBfJWTHgaOsfyANZgbDEZ4f/5iNP6Q4a5
e/7bREh9uBJKgzzE+wXwDKUXTNWUCknnQLAEhX7lFi4vYL5qzNV6eaLy3RIN+vLj
XPXPxKoiwa+jUuv7yRpNQjVzptsXVCzmKn0cU7xL8MtC5opdrSxWtL19Lh5fd8c3
0k8WCrswnedyeYNBVcMqapbxFr6mbQ==
=0spJ
-----END PGP SIGNATURE-----

--VaKJWhUROU/xPxjb--

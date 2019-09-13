Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3E44B1BD0
	for <lists+linux-spi@lfdr.de>; Fri, 13 Sep 2019 12:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387819AbfIMK4o (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Sep 2019 06:56:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51840 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387424AbfIMK4n (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 13 Sep 2019 06:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YOYXEjBESmLCsUGcNj3I50WW8DukBigrP4NNCY1YSGw=; b=cv5BwDRfX2gC2N0mHv+CSQWC8
        2S5E1yzmW63l8j5+23s/ZabEeiDKXg1reefEOf/Qnxjlp8PmJneKsoH9eL86/r5BB7v7wLiVeTddD
        9kJ0xtXBI7Zp2+ZgEbkv8paMOqfzNwDWJzVh/D5WDKk+d5tHF1JHdExIvvAoRcq0yU+QQ=;
Received: from 195-23-252-136.net.novis.pt ([195.23.252.136] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i8jFq-0003l6-6U; Fri, 13 Sep 2019 10:56:42 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 8EC7DD01270; Fri, 13 Sep 2019 11:56:41 +0100 (BST)
Date:   Fri, 13 Sep 2019 11:56:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     linux-spi@vger.kernel.org, ard.biesheuvel@linaro.org,
        jaswinder.singh@linaro.org
Subject: Re: [PATCH] spi: spi-synquacer: fix set_cs handling
Message-ID: <20190913105641.GR2036@sirena.org.uk>
References: <20190903092118.4818-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gkQsIeIyLzf1kMz9"
Content-Disposition: inline
In-Reply-To: <20190903092118.4818-1-masahisa.kojima@linaro.org>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--gkQsIeIyLzf1kMz9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 03, 2019 at 06:21:18PM +0900, Masahisa Kojima wrote:

As documented in submitting-patches.rst please send patches to the=20
maintainers for the code you would like to change.  The normal kernel
workflow is that people apply patches from their inboxes, if they aren't
copied they are likely to not see the patch at all and it is much more
difficult to apply patches.

> DMSTOP register must be updated when the slave is
> selected/desected.
> RXFIFO needs to be cleaned to safely deselect the device.

Why are we changing the chip select state on a device that is
actively transferring data?  This feels like we are masking some
other bug here.

--gkQsIeIyLzf1kMz9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl17degACgkQJNaLcl1U
h9BziQf8DcVdJ+8ttGPhS2irJ0kMkI+PlPYAk1nd8I22SSKiOKMk1Xkp3qW69ayz
LQJb3pYwqfLJeYHHPjQqFKnlRI9lBFE+KJVKWLRybCpzWCcTxakW+HyYoaG/VYQ3
PyFJJeihabscTJhsL1LJPMStDoMZ/rINTpbjW/8wnjWge57Le/km+vaIFFp5ybDy
hSNH+WLCJ56f8kpMz/43A+4QfyogeGXPObYpn6UQvmwNFX84OVGv3Nt8hPYkqJXj
mZ2+prkLAYBKC9UKragcw/pc8oheYN0c5yxG+ZOQH8iy+XnhxXtSUYdUeSyY0yKt
T2cctDzbehiztqcZkGYxz2Tt07eBsQ==
=6J0F
-----END PGP SIGNATURE-----

--gkQsIeIyLzf1kMz9--

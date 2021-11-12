Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11A044EC82
	for <lists+linux-spi@lfdr.de>; Fri, 12 Nov 2021 19:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbhKLSUj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Nov 2021 13:20:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:53938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235265AbhKLSUj (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 12 Nov 2021 13:20:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6528260F41;
        Fri, 12 Nov 2021 18:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636741068;
        bh=MDRYkTIa+OsXDBQGmlQUZAcG4lkASJfrWxpxjW0ebe0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o++CeXK6lR+2w5APKJ2Zos6qg+iUpamU92e4IaRzNrngbUFWgS/NR9hWgM5DH0+81
         irPCmGGpd+m9WGpg2+7LkF3oKBC7D3W9VyxI8rh7oQLrfS49cR44bN2T3IgVhAUSZX
         5Onub7XXWIbiTjYOCHQP0HEpvo786PcfEy4B0DDyIyYdgoFvrHup7c71JeOK9LVeIX
         eDLpBQwYQM6nS7db3j74ql5QsaZUljXGmaAs08nKGvzJqUXVgYsk7JTIhP4/V2myy5
         0luQyT7nDwPknTrcBbBHZBTzHJqKqznBUjadVuEWhrJKkBBLUiR8yZJ2sSmPcCAwvY
         ZQkKQAgAQ9vxA==
Date:   Fri, 12 Nov 2021 18:17:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     linux-spi@vger.kernel.org
Subject: Re: [PATCH 1/1] spi: lpspi: release requested DMA channels
Message-ID: <YY6vyLt6lhUp8xXW@sirena.org.uk>
References: <20211109103134.184216-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PqO5UuyQuufaVqM3"
Content-Disposition: inline
In-Reply-To: <20211109103134.184216-1-alexander.stein@ew.tq-group.com>
X-Cookie: Ring around the collar.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--PqO5UuyQuufaVqM3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 09, 2021 at 11:31:34AM +0100, Alexander Stein wrote:
> The requested DMA channels are never released. Do this in .remove as well
> as in .probe. spi_register_controller() can return -EPROBE_DEFER if
> cs-gpios are not probed yet.

This doesn't apply against current code, please check and resend.

--PqO5UuyQuufaVqM3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGOr8cACgkQJNaLcl1U
h9CEWAgAgY/GfU8BXFYGIRsRJvI1cWat2E8FDdx6w4hGOXZu1PkCE/clQw49sl8s
TtkBnnWdHaqEdTMjxGuYfuBjeCJ+wRX04gs4rrlyFX3kUYQ7/Aw6f/kUAn7UkFJX
Fd4529ooHiVRGzoyP3qWfGIgM9fnA/j34lptaIkUmzun0eA4pQQkmHfGb7QPfS3k
sRS71vw6B/OsKm4pDHqE+Y70xSYP0wxVzNb9m/3Jg8Uc/jV4OVKGmUKbKZ5YaN97
Mh74Ggiymg0INA68ejMHTrqZZHuSinNv6gE0Z9oWpDfuF9pSpGQxJQIh2nLD3DEc
oAQPEIK/FZq0tcc1VpkSKhqqcF+g2Q==
=Ur35
-----END PGP SIGNATURE-----

--PqO5UuyQuufaVqM3--

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E082F3F6839
	for <lists+linux-spi@lfdr.de>; Tue, 24 Aug 2021 19:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242190AbhHXRli (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Aug 2021 13:41:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242670AbhHXRjm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 24 Aug 2021 13:39:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB6AF610FD;
        Tue, 24 Aug 2021 17:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629825555;
        bh=4KgpOFk8+xW0LI5R4I/UNoqugzdwXJKeGalMmTpyq5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hk2AgL7J8LCBDFU49/BzpJK0kywOJ6Y9R5Cm6d8XbcPHqgO6RIZO1yLPbqsCD1MKr
         Dp+mxg7tQ4dXqZJ8hQrtZQhuRA1LMK/Ze5e45YM5bIPBRUsfuk/XcIhJfdA+9hN5Fp
         K0x+hwE9gTt2cyqlgltTiislhBURdDbFPQR/d+GMhhHx/TErtii2DGvERE74ngv8VW
         BOab3HBA6wwAf/v0Cn16yJ3bHZf2L5PHC+owRFRbUL/lGof5RUUCdtu1up80QTg6Sf
         ABhKhN0HrBkDaYMu0GWaizIHHNXrrc4sHpFceQXt9XCsO4NOZolB+s0kU1ntFk2bWv
         F/mJ7RsVXq4nA==
Date:   Tue, 24 Aug 2021 18:18:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 8/9] spi: amd: Refactor to overcome 70 bytes per CS
 limitation
Message-ID: <20210824171848.GA21804@sirena.org.uk>
References: <20210824104041.708945-1-tanureal@opensource.cirrus.com>
 <20210824104041.708945-9-tanureal@opensource.cirrus.com>
 <20210824171619.GK4393@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20210824171619.GK4393@sirena.org.uk>
X-Cookie: You will contract a rare disease.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 24, 2021 at 06:16:19PM +0100, Mark Brown wrote:

> It also looks like the code is adding support for a new revision of the
> hardware which isn't mentioned anywhere in the commit message at all and
> really should be, it should most likely be a separate commit.

Sorry, I managed to move on to the next message while writing the reply
without noticing - this is actually a separate commit so that bit is
fine (modulo the confusion with the version field).

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmElKfcACgkQJNaLcl1U
h9C11wf+N2I2mvjPYHNdQAEZzaRKX1sV1kW1dzcr2KzTBCUqOmRMlYC2rxJ+ccBZ
V2OGg9GS1QVDrS5Vx3qpPmE9z3sd2qyhQloZeerDQ9t35On6pEw1Wl3sL6oGpfiW
ISaVIvv8jr0nsGe68kXo4g8exnuV5qg5mzKwDhYPRfX70XGr3WRYw3Kh4PRYlJYg
MQqgZdSX1u1r/2BrQcvK34NkvBbPO8OxyDkTEM2MroNT7RR3UF/B57uoSQtnSYEU
sjF1pLR8kx/vsKzudcElVlFHxoOHiFENKl1+kbKMmaRbBmbXNxsdnAv472xNLSHr
A+JIL06WWh9t3lSo24yowxc+e5Xbvg==
=ssj+
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--

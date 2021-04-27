Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68EDD36C4F5
	for <lists+linux-spi@lfdr.de>; Tue, 27 Apr 2021 13:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbhD0LVN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Apr 2021 07:21:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235765AbhD0LVM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 27 Apr 2021 07:21:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C62A9613C3;
        Tue, 27 Apr 2021 11:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619522429;
        bh=oFO99Ma6ue6jo0ubeeAIjvB1etKGrqDlPrDpJNUNuhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FU7AV6jtkF7vRya3QSzK3EA05pQeXp2yl0psBqRuQnKGKgF96J9Gvggas8zVrRhik
         y0OsENspfXd0Yw9LQ/BFoMAISAEbofteOgHrnRHJPVbPmpyjfISbFNBylgwkxM68qg
         oj3nftCYJViYEIlykjbL59o95yrd//0hTkHI1HiVLFYz9qp9mvmA6NaNxY266S+cTM
         SruU+8VXK4xH37m18/uk8HRbW6IGpx9IZSOcZ9plcBf45QE633WSxe2SPlrerGdFOD
         KDTleKi66tVqWaxUT6YRz7C2n1ev93qSVnjrX7JhoOR1QXj+PeRHGP04sk6P4qLZpp
         u/yA51ugM81BA==
Date:   Tue, 27 Apr 2021 12:19:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: imx: remove CLK calculation and divider in slave
 mode
Message-ID: <20210427111958.GF4605@sirena.org.uk>
References: <20210427085211.299756-1-xiaoning.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wtjvnLv0o8UUzur2"
Content-Disposition: inline
In-Reply-To: <20210427085211.299756-1-xiaoning.wang@nxp.com>
X-Cookie: Don't feed the bats tonight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--wtjvnLv0o8UUzur2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 27, 2021 at 04:52:11PM +0800, Clark Wang wrote:

> ---
> Please remove the patch(4df2f5e1372e spi: imx: add a check for speed_hz before
> calculating the clock) first and then apply this patch.
> Sorry about this. Thank you!
> ---

Please resumbit with a revert (with appropriate changelog) either sent
in a series with this or just squashed into this patch.

--wtjvnLv0o8UUzur2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCH810ACgkQJNaLcl1U
h9Bctwf9FfiP6/95eGi5fpeCaB24EpTeXRnKgGjX9TTTqqFfcdqIRJlc5x50dC1K
no9XvVE94E2s7S6VMAzwACsPH1EGq7bE2JKAnuM/m3VcmTXZboqHrKMbBIVtzOAv
zVe+K2ouzV/PWOkxQKg9ffLAMBLgS0Ph2s8mAhzv/IDzJ8d9AOYJyA6QY0l1orar
x0nbPH+Nw+ffGAbUic8xehsDW9jE/cgeLOx4hUODStIzCByBqe2B/C7UKbMmAtvA
AvBuYR9He9bX7uKhzGsKR9McnXqBan1l9CDetdI/CxDT8DSq/v588SHIWFppw6FF
TgXaeABnzUp/fPVOumkYy3TICD290g==
=cUFC
-----END PGP SIGNATURE-----

--wtjvnLv0o8UUzur2--

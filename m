Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68D53B8240
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jun 2021 14:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbhF3Mht (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Jun 2021 08:37:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234618AbhF3Mho (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 30 Jun 2021 08:37:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B2DA61622;
        Wed, 30 Jun 2021 12:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625056516;
        bh=Ou0dDCgoY93+XH7Ohp1U845vXDZIJyhjcdMYSiuQTkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C56YgfjRwydgzFN0x7mgvW0G4MUTRG/h21qRv1gFf57Z8fePi1NOU9hsbSNqfe6bp
         n6BvGMRjpFR82y/1STdAjD46sczRg2gRbQa6cCQuKe3aOq3ts+rqJ/iRYQd7q76fA7
         FGH/oJrHYVKUEg6KzCgtmRUt4QxmHlAuZ4R13OsrAx8BQ1TPAOm61Zn3agDgmK6AgJ
         KdcmNOeQ3T7uDV1L+sGDe1f4pky5Cjk/0OLPRT0hiVZ6CbqemMmS0WehZzjYH5RnlF
         hOVVLd04fomkCA1tC1GqhNWcfcAWvneCbd8lVmMj6nq1Mh8ejpXwIQMlF7aK2jXwYm
         qkT0wLLwMY/vg==
Date:   Wed, 30 Jun 2021 13:34:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alain Volmat <alain.volmat@foss.st.com>
Cc:     amelie.delaunay@foss.st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabrice.gasnier@foss.st.com
Subject: Re: [PATCH 3/6] Revert "spi: stm32: properly handle 0 byte transfer"
Message-ID: <20210630123447.GD5106@sirena.org.uk>
References: <1625042723-661-1-git-send-email-alain.volmat@foss.st.com>
 <1625042723-661-4-git-send-email-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Content-Disposition: inline
In-Reply-To: <1625042723-661-4-git-send-email-alain.volmat@foss.st.com>
X-Cookie: Use at own risk.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 30, 2021 at 10:45:20AM +0200, Alain Volmat wrote:
> This reverts commit 2269f5a8b1a7b38651d62676b98182828f29d11a.
> 0 byte transfer handling is now done within the core in code added
> by commit b306320322c9 ("spi: Skip zero-length transfers in spi_transfer_one_message()")

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDcZOcACgkQJNaLcl1U
h9B/ogf/Vst1y720ItQmoJtAnynVuU00lwrfCgpr2gA02reYHLKL2xL3r0VmqKBe
SCuYcM9dUn+xbGcvjgWs2vufZmXKUu7WLkSHl6F01GZWMV2oHflU9XsY7zcbYZIO
hRV7/ZN/Q1s/jwqwnI+pd4EbJ+lpdW6GRrJVgxj4TzUgEqwv0X2LPtZDDKqbSpHH
vtdwsYl/4JFmz/OfvHT046uAdbNeJft/Cwzn4ZZA83QxGuHbnVAOzSC1YQKiwuxR
Zsp5Ppr2NHJqD4em8bY7PKfZpocM0MGTknqrF9ZEs9It/vUnjF6JRDkJmze7R79d
nIdR40lj7E6pdA4xrv3U+mkfRkBY6g==
=8ayZ
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--

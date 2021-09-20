Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D188441146D
	for <lists+linux-spi@lfdr.de>; Mon, 20 Sep 2021 14:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238031AbhITMat (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Sep 2021 08:30:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238218AbhITMaq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 20 Sep 2021 08:30:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3134860F58;
        Mon, 20 Sep 2021 12:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632140959;
        bh=ObHHjmqefZdehr9608wgJPUdpSprqKXrlBTDgkQ0lFA=;
        h=Date:From:To:Cc:Subject:From;
        b=m5Vv39YegcE7ASDxn33u4mLdfpSt74DhMNuh8W5bEFLJWj6Thf0eZhRlpsV50BNrN
         7+IDGF+ANYyNjgQtjZmQ54n4hHORuYGFC5e4R1SqB6mKwaKGvW4mGnM1jfxiCeo2vm
         B/evKl5N6Z/7KcscCwQNanzt15hhg4hRc5A3pe3Ov5XCaRDulM5jgx+8kd+JqDv4Oj
         KrhiJfxxNrhEgnyUXBXBpwg3m7u3B8MtIfxeCQuVqPVb8tvnK7tx7WZMn1xXtWGMGS
         LHkYPrll53byN0rvYU9c4ZIwhTBZiyxElVZarJ5pfKVInnPCGQAdUAFWNryA5Y32Xy
         4TNJouyoSqhwg==
Date:   Mon, 20 Sep 2021 13:28:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ville Baillie <villeb@bytesnap.co.uk>
Cc:     linux-spi@vger.kernel.org, Dan Sneddon <dan.sneddon@microchip.com>
Subject: Re: [PATCH v2] spi: atmel: Fix PDC transfer setup bug
Message-ID: <20210920122836.GA13727@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
X-Cookie: Loose bits sink chips.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 16, 2021 at 02:16:46PM +0000, Ville Baillie wrote:
> Commit 5fa5e6dec762 ("spi: atmel: Switch to transfer_one transfer
> method") refactored the code and changed a conditional causing
> atmel_spi_dma_map_xfer to never be called in PDC mode. This causes the
> driver to silently fail.
>=20
> This patch changes the conditional to match the behaviour of the
> previous commit before the refactor.

This doesn't apply against current code, please check and resend.

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFIfnMACgkQJNaLcl1U
h9BB0Af+KvGDtKGHY4b+3drLmFV5i9cpXRPX3w6fLWUNNkMh/gLR93L8i6kkdwny
0wfzt5TvGsK4YIL+3kKBAHp+Xc72MLrOeUq4XGWZNf1ngQyZzLjZb7qajS2aF6EJ
wFGZtmU27vVdfLY8HFDg2O2B8+ctZZldtOegm6L+QHlTDWZ/nwZ9aitoAgqZURMA
aDCJhArWrZPNQPucjAFFaej5Cjxhc4GIyfOUiBpA4dbe8LMKbK3OLJ2MpGIyt0cT
TDqvlbuoeGuyqvAXXyGYBFGux/s1ztrvo32L0akCS3+MC9by6PI3mfXzNvJKXpee
dXiDPDzJYLoWf+sSLJ2NvERnaoPr1A==
=4Wap
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--

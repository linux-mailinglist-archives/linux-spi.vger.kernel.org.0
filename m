Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDB01F9A89
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 16:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbgFOOmT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 10:42:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729243AbgFOOmS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Jun 2020 10:42:18 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 758DF20679;
        Mon, 15 Jun 2020 14:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592232138;
        bh=JSuKebwopgBzXJZMdP+B6aJpBrtYlBU47wHbA6tc3zQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cW7Vv9SEtrKZaR+F7ReFzEMsS5UwxlohQkgWgW8aWRwel+bQ0WCaxisEgYsrFgFsV
         yAlqcoEYmMItHnFYFMSk4Xt1f7GDj0rscvt+twAf9dFSR5IRPo8StyjjNcCP5TtULj
         wvxdNLE1Gzz/OpeqKU/oismbVYdGK8P/+yTpzNTc=
Date:   Mon, 15 Jun 2020 15:42:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Qing Zhang <zhangqing@loongson.cn>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: uapi: spidev: Use TABs for alignment
Message-ID: <20200615144215.GA19492@sirena.org.uk>
References: <20200613073755.15906-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20200613073755.15906-1-geert+renesas@glider.be>
X-Cookie: Duckies are fun!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 13, 2020 at 09:37:54AM +0200, Geert Uytterhoeven wrote:
> The UAPI <linux/spi/spidev.h> uses TABs for alignment.
> Convert the recently introduced spaces to TABs to restore consistency.
>=20
> Fixes: f30e8cbdf8ee1a43 ("spi: tools: Add macro definitions to fix build =
errors")

That commit doesn't exist?  I think you mean 7bb64402a092136.

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7niMYACgkQJNaLcl1U
h9CTjwf/RLOof0hAkK+LVvvhaccz+mQVozivfX9Ir/uldiwEFC/jLxGuB7tqW7z/
m9uHFOZsos7qDAUBQ50TxpMwypIV2cb2bshHxibRcYZyrszHtfkKCeTEv0cq7271
tWDY9Gnfc2m/rJlALe20O1O1Zxx4aPo1VsXuKTblWRhGEm7d+pbVvTGi65kwLpsK
j550Qi63KU+0KXldxysP/iwKGw2OPBxMCPlG3HzjUici4wzB34XMh8FphzgDhQzG
emOCw6zYO7QzOb0h7GDUamMI5e5a+acTGyBNBYcY9uxY9xdtDaAHdjtP1dMPKqsZ
hMhxDCc/HA/XJFBl0yRnH7Iq4GuAQw==
=MP3a
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--

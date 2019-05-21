Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E41A259C2
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2019 23:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfEUVPv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 May 2019 17:15:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53954 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbfEUVPv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 May 2019 17:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bFiSTaT4Q2eSspIIAHqbLl4xHrhY1SulOd0XMMPdQZU=; b=W61N9hJVbVfk3mtqrw/yTJxGy
        YGHlgispoUAXZLDDXJptKco7gnR0larMM4fzZ7yGaCvwu4AG0KgmdAMqPM4j8KbMKCszLROv260Fl
        Ys/rRapYAaoCqZvUCyWKifrXMlauPCybBuJD6VEWXcmaNNDK1LjwjCulNlbZwk85ZzVm0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hTC6u-0002Fx-N8; Tue, 21 May 2019 21:15:48 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 339121126D13; Tue, 21 May 2019 22:15:48 +0100 (BST)
Date:   Tue, 21 May 2019 22:15:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-meson-spifc: update with SPDX Licence identifier
Message-ID: <20190521211548.GE1580@sirena.org.uk>
References: <20190520140452.30167-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GxcwvYAGnODwn7V8"
Content-Disposition: inline
In-Reply-To: <20190520140452.30167-1-narmstrong@baylibre.com>
X-Cookie: Klatu barada nikto.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--GxcwvYAGnODwn7V8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 20, 2019 at 04:04:52PM +0200, Neil Armstrong wrote:
> index 616566e793c6..20413def4cfb 100644
> --- a/drivers/spi/spi-meson-spifc.c
> +++ b/drivers/spi/spi-meson-spifc.c
> @@ -1,14 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Driver for Amlogic Meson SPI flash controller (SPIFC)
>   *

Please make the entire comment a C++ comment so things look neater and
more intentional.

--GxcwvYAGnODwn7V8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzkaoMACgkQJNaLcl1U
h9BHUAf9GB3ropLIXJhU8dEhK1T6AsQ2s+d1xMhXjSzVIZRgTMg/hYap+PnSYoEP
4ZBpi/9WeXKntdAxw7zRiFnoq9rYtGagtTJR0ja010dVBz2erwlPoYWSUUHeKRKx
4OKncRLCGY5KUtk48ywFrUdUkvJQeKGfR9PAvy0QgdSUs6lofeHJctCbbmNfWKhy
QbJQY7mcz261N6xlEpto4++2w9I+njwJjbajPoFSkB9M18FDPga0wk8t//GWPX3D
HzaurmQoSdPY+z9PaXOcsr4b3RUnLNwXdURHPXua83txGVR4GEikgbN3jFhWbjdm
6vmDIfWwXQGI83JVypiThIgS7LV1JQ==
=AoI8
-----END PGP SIGNATURE-----

--GxcwvYAGnODwn7V8--

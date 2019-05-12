Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAA3F1AD56
	for <lists+linux-spi@lfdr.de>; Sun, 12 May 2019 19:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfELRFv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 12 May 2019 13:05:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49650 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbfELRFu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 12 May 2019 13:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=u2q75OsSvN0gs9+vI+HKmu1j+P1UgVapAAD+9M7rxxI=; b=RuxoE3LAX9keebSda6rl0E4YX
        sdxnYM8dMd4Ld7j/AwvO/B+7D1m64BAgXVoOolJHM/VlPKUO6H0ZBzN61/Mke/pSijUeyaJHLkeOK
        IL8uhxAbGX1K/eFMLrbtvOGWovUjthTKAsJHoZFS1Bge0Ral8dhc1EGCs6utORIACiX0A=;
Received: from [81.145.206.43] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hPruu-00044c-8K; Sun, 12 May 2019 17:05:40 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id F412C440036; Sun, 12 May 2019 08:52:23 +0100 (BST)
Date:   Sun, 12 May 2019 16:52:23 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: Applied "dt-bindings: mfd: atmel-usart: add DMA bindings for
 USART in SPI mode" to the spi tree
Message-ID: <20190512075223.GF21483@sirena.org.uk>
References: <20190505180646.1442-2-radu_nicolae.pirea@upb.ro>
 <20190508090857.B7CB344003F@finisterre.sirena.org.uk>
 <20190508105105.GN3995@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xkXJwpr35CY/Lc3I"
Content-Disposition: inline
In-Reply-To: <20190508105105.GN3995@dell>
X-Cookie: HOST SYSTEM RESPONDING, PROBABLY UP...
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--xkXJwpr35CY/Lc3I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 08, 2019 at 11:51:05AM +0100, Lee Jones wrote:
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > ---
> >  .../devicetree/bindings/mfd/atmel-usart.txt   | 20 ++++++++++++++-----

> Interesting!

For some reason the bindings for the SPI function got put in the MFD
directory, dunno why.

--xkXJwpr35CY/Lc3I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzX0LcACgkQJNaLcl1U
h9DQCwf/WFhMZtcust0DuMCXriQ8faNSLBTBaf77XBUl0FDL66Uge3k6OO/5RP3h
8hEh7TTviJw3VCcryu1ee9kRNUVdBqdiSHEzb18Q2gDfGmmGrJWGzj59B/47NUjz
e5enUWORH2PLwGFNmZ81Ay2w2DUvN1UPDHKcCWX1/fbJBxBkzRYiCLjZAOMh9QE6
QEKjmRIJmVnvgNYeSoz5DNo+++PUKxZYX2IN0JN9oX7LtPdjN9UL4HegW+3xflrB
IVi2Am4CNMwDCNlMDHrkdClRKmEmAlDRU3kWxlUDLezIKbA3LAiFhQ9nuXyC+Q7e
Ncn36/FFn/CtfjbD1EWLwGhBGQGoGw==
=A/JO
-----END PGP SIGNATURE-----

--xkXJwpr35CY/Lc3I--

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1B9A7E676
	for <lists+linux-spi@lfdr.de>; Fri,  2 Aug 2019 01:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731964AbfHAXkQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Aug 2019 19:40:16 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39226 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732215AbfHAXkP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Aug 2019 19:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OB+reDjjhSJ8Mv9eo14ve7duHodLML77yXu5K5sSQTs=; b=Cgm+VM4A+nmcrlWVS5NePPfhm
        WFP68aA2llpkf7/sbevDbpu9aRKA9qjapR3uAnlPxrAnjMLj1J4X06c9dGjlzci4veUUbSnqTaiFj
        2WVEfmWHTNUfXev1haZks7TRthCYN/4nxZ0EDBMM3nKV5yJB4ZyVk14AX49JBk4qrgfDI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1htKg8-0005ph-Qf; Thu, 01 Aug 2019 23:40:12 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 869A32742E3A; Fri,  2 Aug 2019 00:40:11 +0100 (BST)
Date:   Fri, 2 Aug 2019 00:40:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: atmel: add tracing to custom .transfer_one_message
 callback
Message-ID: <20190801234011.GF5488@sirena.org.uk>
References: <20190801204710.27309-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="E7i4zwmWs5DOuDSH"
Content-Disposition: inline
In-Reply-To: <20190801204710.27309-1-uwe@kleine-koenig.org>
X-Cookie: Love thy neighbor, tune thy piano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--E7i4zwmWs5DOuDSH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01, 2019 at 10:47:10PM +0200, Uwe Kleine-K=F6nig wrote:
> Driver specific implementations for .transfer_one_message need to call
> the tracing stuff themself. This is necessary to make spi tracing
> actually useful.

Have you tested this for modular builds?  IIRC it breaks unfortunately.

--E7i4zwmWs5DOuDSH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1DeFoACgkQJNaLcl1U
h9AqfAf/XxfAZXQ7psDgSqk4XnWxmL+gCwDkoVg7uAxpgA+ZwE79uNMbQ6vDO1AR
ReV0lzJb8NsqVx8AfPrAlk8N/Ure2FKtyagFEbkc4uVOE9xjUzwbFvqkEVSYcNjd
mUe+dIuzdZmzONJfByk4lIcUbaYJG28atCAG5KbXB1Rw2ltasCC/aMrdXZbvR24Q
oSzJwt2tAHlIX75ershU/WfMuioJ7ml2gmJbkLaWzXdYo/vLZPbRkVhG3gftEow3
mtuQbZiHikx0X/9O1Wvw1dNhegyjQMnGx+T/BRqSbazZ7CPn2gOs73SIZGqs5zC7
QPvjZi+iFri4mbNihBBkLj2wbApbZg==
=lPp/
-----END PGP SIGNATURE-----

--E7i4zwmWs5DOuDSH--

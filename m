Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1C47F580
	for <lists+linux-spi@lfdr.de>; Fri,  2 Aug 2019 12:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfHBKwD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Aug 2019 06:52:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38542 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfHBKwD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Aug 2019 06:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uYVzg1Coc9oRO7L8zwdtvpedX89L6V2caqJDMffxcJo=; b=gzLEdFeNuwN1KzUCt86zL4c19
        0TYj9qNJ7ePJ9LPRCqLfRjSiZAH1JgxgbIZqHcFRkkab04kyQMNKjTLIa38X66AP6D4pj44Yn7uhZ
        1cEMx15C4ZuuU2Z7XDusx8vken5VY/hgvISMer7EFEoqMAaT7PrwVV3naEABkEr+HPKzU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1htVAH-0007OF-0N; Fri, 02 Aug 2019 10:52:01 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 5F8812742DA7; Fri,  2 Aug 2019 11:51:59 +0100 (BST)
Date:   Fri, 2 Aug 2019 11:51:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: atmel: add tracing to custom .transfer_one_message
 callback
Message-ID: <20190802105159.GA5387@sirena.org.uk>
References: <20190801204710.27309-1-uwe@kleine-koenig.org>
 <20190801234011.GF5488@sirena.org.uk>
 <20190802062018.GC11858@taurus.defre.kleine-koenig.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <20190802062018.GC11858@taurus.defre.kleine-koenig.org>
X-Cookie: She blinded me with science!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 02, 2019 at 08:20:18AM +0200, Uwe Kleine-K=F6nig wrote:
> On Fri, Aug 02, 2019 at 12:40:11AM +0100, Mark Brown wrote:
> > On Thu, Aug 01, 2019 at 10:47:10PM +0200, Uwe Kleine-K=F6nig wrote:

> > Have you tested this for modular builds?  IIRC it breaks unfortunately.

> Works for me. Is this just a suspicion or do you have a breaking
> .config? If the latter, the spi-mxs driver probably has the same
> problem. When I sent the analogous patch for mxs this was indeed a
> problem, but this was fixed in
> ca1438dcb34c7fcad63b6ce14ea63a870b92a69b.

It was a problem I remember happening in the past.

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1EFcgACgkQJNaLcl1U
h9CYxwf/b1QWrviKYvHDsqcibTSNnsqI/XVVHIZFPWtyMWLu6RiG2FQmEsCwOT82
xsCf9PfsI/4/3va+oSYLNaltq8oLmbhW518FO2G2ddVV7LG/eP7VkFPOIZAL2Bnl
qM0TSHjXnsoLCMEH8gX4XjAQgTelasZgGOiBQWa+Sht+AIN7bK13rUWZIwia3D8u
2kGd+8R6tlMU6JTWOab2vescNtYyyCc/GLUAkdW5bGC8ZN2xmfIk6MgE4WcpUHRD
c/cbPpVeHunILhRTYLO+Dk0LFm/kIyw+OY7XlFl8fLEbN07tPNyeZ1kMLj6QI7ap
7m2We9Vu3Ah9hHRJLOezrkOZX5yD0g==
=CTkW
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--

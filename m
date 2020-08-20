Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E2C24C45C
	for <lists+linux-spi@lfdr.de>; Thu, 20 Aug 2020 19:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgHTRTi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Aug 2020 13:19:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729359AbgHTRTh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 20 Aug 2020 13:19:37 -0400
Received: from localhost (cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net [82.37.168.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87E38206B5;
        Thu, 20 Aug 2020 17:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597943976;
        bh=DXObe3yllUjgowlYXeYGYXXG6O44syV5/SCwu1zMnR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RZv+DNRRK2jOkMVZE8xtcia8ygssFpKxLyBUZLr1tLkhYId/rPyEdAFQz0BwA81GO
         wqdPLlpuK1U9aMlBgoCZ6JKfzXzylEDI6YUN4JMZUMix/XUHYgF6lWgnoBUtiFkU5K
         AC23qNm7qWY6hq6+gle2JKpwCog4YVyetiWWGs3w=
Date:   Thu, 20 Aug 2020 18:19:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, joel@jms.id.au,
        bradleyb@fuzziesquirrel.com, robh+dt@kernel.org, arnd@arndb.de
Subject: Re: [PATCH 5/7] spi: fsi: Implement restricted size for certain
 controllers
Message-ID: <20200820171903.GI5854@sirena.org.uk>
References: <20200820170228.42053-1-eajames@linux.ibm.com>
 <20200820170228.42053-6-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="itqfrb9Qq3wY07cp"
Content-Disposition: inline
In-Reply-To: <20200820170228.42053-6-eajames@linux.ibm.com>
X-Cookie: Dead? No excuse for laying off work.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--itqfrb9Qq3wY07cp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 20, 2020 at 12:02:26PM -0500, Eddie James wrote:
> Some of the FSI-attached SPI controllers cannot use the loop command in
> programming the sequencer due to security requirements. Add a boolean
> devicetree property that describes this condition and restrict the
> size for these controllers. Also, add more transfers directly in the
> sequence up to the length of the sequence register.

If there is one difference between implementations of the controller
there are likely to be more - why have a property here rather than use
compatible strings for the different hardware variants?  Compatible
strings mean that as more differences are discovered existing DTs
continue to work.

--itqfrb9Qq3wY07cp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8+sIYACgkQJNaLcl1U
h9CaYAgAgwerWqlI1BrlSYQTl94DDZ5osIs6bNoENTGD08ZgpFKKcktclTRPnvbE
+DHLD2cKelydFh3t2BYStjGRPKH+4Rp0r7Isc7+aXvhHUHbf/JWcop3LCL90LZ8W
f54xEu7PoMPJGenGOPWMKYpyt1kwC5Vqys+ygqSrnGQtoJN2grxbEgn/GpJL2/eQ
FaMZ4oJzLRvV2F3e6LJoPwUa2WMAdJi2QpmHZQhyxkq58q3uI10oLY2Da4MSxRad
ZRI3AcKKbqXfyYcnx6hQDGF0jhMc1CSlC2O/3TsEF0PE4EjYyL36o5VMoMDOGT1c
IdUm8rDXR68hXgk0DdWnTk9ieQU57w==
=NofV
-----END PGP SIGNATURE-----

--itqfrb9Qq3wY07cp--

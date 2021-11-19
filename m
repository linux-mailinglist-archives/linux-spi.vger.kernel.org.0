Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28847456F4D
	for <lists+linux-spi@lfdr.de>; Fri, 19 Nov 2021 14:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbhKSNJd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Nov 2021 08:09:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:47136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234542AbhKSNJd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 19 Nov 2021 08:09:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02AEB61A38;
        Fri, 19 Nov 2021 13:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637327191;
        bh=VH1vfNNbOjINaFz/r+kl03In+zpRGb/Yee4RQaf89bE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ieL3d8V7q8RySK8AlZiceaoG3q3SbZEimpU2xiT6iCW0wgK45DGDDQdur6T0xK+mE
         HO+0BlmZQXmXAfRBVg+EGej4RctMbjv9xHASdrDqrq0wB1/o1U/r5P+xdRHzL9tRCh
         JmgqlYs5kFYeslXBwFhOB/m3XSqYJ/XVf3SbPbRxjQcj2AvJ+0uHB8NrdLXxh3ilsg
         EuwxSlUV82niF4hwbDVvVB5r1IbDdDEogxG7XdFYecpaoXELdGyuLFL394eqLyCSG4
         i2uWxkbOlzR6JcoxCeC4ZajMYkObtJpVRr6XFfT0IewoHgJxyPOlqbnLZ2CVlZohck
         vCE2QkEAF7PSw==
Date:   Fri, 19 Nov 2021 13:06:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lh Kuo =?utf-8?B?6YOt5Yqb6LGq?= <lh.Kuo@sunplus.com>
Cc:     "LH.Kuo" <lhjeff911@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dvorkin@tibbo.com" <dvorkin@tibbo.com>,
        "qinjian@cqplus1.com" <qinjian@cqplus1.com>,
        Wells Lu =?utf-8?B?5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: Re: [PATCH v2 1/2] SPI: Add SPI driver for Sunplus SP7021
Message-ID: <YZehVn9WTqbznMrV@sirena.org.uk>
References: <1636448488-14158-1-git-send-email-lh.kuo@sunplus.com>
 <1636448488-14158-2-git-send-email-lh.kuo@sunplus.com>
 <YYqMLPB6VX9k5LUK@sirena.org.uk>
 <f98b5548cf564093af1d10ba1239507d@sphcmbx02.sunplus.com.tw>
 <YYvx4LtKiSPBIgCN@sirena.org.uk>
 <70a9c10ef34e46c2a51f134829abdd08@sphcmbx02.sunplus.com.tw>
 <YY0dk26NqoOi2QEH@sirena.org.uk>
 <083dc70e20964ec8b74f71f6817be55e@sphcmbx02.sunplus.com.tw>
 <YZZXTokMn6+p7C3H@sirena.org.uk>
 <e98c0bc4dc99415099197688a8dd3ef5@sphcmbx02.sunplus.com.tw>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PTHkGAXZ/U+oJFgq"
Content-Disposition: inline
In-Reply-To: <e98c0bc4dc99415099197688a8dd3ef5@sphcmbx02.sunplus.com.tw>
X-Cookie: fortune: not found
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--PTHkGAXZ/U+oJFgq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 19, 2021 at 01:51:15AM +0000, Lh Kuo =E9=83=AD=E5=8A=9B=E8=B1=
=AA wrote:

>    The driver made a lot of changes. Which function do you want to check =
first, or can i make a new patch ? And we can review on this basis.

It will be easiest to send a new patch.  The bits you included
here looked fine at first glance.

--PTHkGAXZ/U+oJFgq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGXoVIACgkQJNaLcl1U
h9AeIAf/WGvVna7zhCF/f7uqUEpyQFGYONEw+hyn+uze1kJByv69NpXFOd+U4lGZ
0Y6iSTu5nHlBtDdB7A+w6KXQLR+ff4oJM1eYOhT+tJ9ViFcR5AGXo6w9iU03aaCP
cH5pS054w45hdHNXxN7jetRgsVVazRU2llh4RtZWlNun1x7MmcxMUipenv1MYbGA
jLn3MYQ1j0lbjWh+w9CdCYw1JYXGvK5sjd3VfFwdTADXOsyfKy0/T/1JgUYto7qT
8gM6uvUKcnXo64BzUN/Nc3PaAsYaO+Jg9MMUp7GDQu8sxJ0lQhfWNbXkaNplAJ5B
8PptE0Bzf1ZikEPUhFPQmV6c6Qnx4g==
=5cPZ
-----END PGP SIGNATURE-----

--PTHkGAXZ/U+oJFgq--

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5986277007
	for <lists+linux-spi@lfdr.de>; Thu, 24 Sep 2020 13:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgIXLew (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Sep 2020 07:34:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbgIXLew (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 24 Sep 2020 07:34:52 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DE6E2220D;
        Thu, 24 Sep 2020 11:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600947291;
        bh=zpGCrVK8tz1aZrON992tX07fTfb1T/oz6LsOj41Eb9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jtcDbfmy3QrqbK8tvcbhP0NsjYHl7W1Eaj9KnesXah2QJMh37kDDG45s7HTElChnQ
         QZENgO6x1gjPu6qR6Z7h40oI4c7zrQkR3QpVrs6ywSGDSlQaQBhVWBUg+na5oNWdC0
         QoqpcEE7J6a4m44fNnl7pG7LGW48WGgBIHFiXgf4=
Date:   Thu, 24 Sep 2020 12:33:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: spi: Add compatible string for brcmstb
 SoCs
Message-ID: <20200924113356.GC4754@sirena.org.uk>
References: <20200910152539.45584-1-ray.jui@broadcom.com>
 <160009511834.5702.10954218363830361529.b4-ty@kernel.org>
 <a1e13626-e87a-8114-74ae-560902ab9551@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Content-Disposition: inline
In-Reply-To: <a1e13626-e87a-8114-74ae-560902ab9551@gmail.com>
X-Cookie: Programmers do it bit by bit.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 23, 2020 at 01:38:55PM -0700, Florian Fainelli wrote:
> On 9/14/20 7:52 AM, Mark Brown wrote:

> > [1/4] spi: Add compatible string for brcmstb SoCs
> >       commit: d9f0cf9f1176d36d3824459d5b061f4719fcbb8a
> > [2/4] spi: bcm-qspi: Add compatible string for BRCMSTB 7445 SoCs
> >       commit: e0eeb76b818ad93718f9640b0bdad909b453a3b8
> > [3/4] spi: bcm-qspi: Fix probe regression on iProc platforms
> >       commit: 9a852d44b26f8e60e2ae13df563824c0f8489135
> > [4/4] spi: bcm-qspi: Clean up 7425, 7429, and 7435 settings
> >       commit: 3cf5d198785a6b454e6a97246795b0043aff9ac1

> Mark, can you also submit "spi: bcm-qspi: Fix probe regression on iProc
> platforms" towards Linus because this is a bug fix that is currently
> affecting the 5.9 kernel.

*sigh*, OK.  Please don't send fixes in the middle of serieses, send
them at the start of the series before any cleanups or new features.
This ensures that they don't have any dependencies on other patches in
the series and means that they can easily be sent as fixes without
getting tangled up with the development work.

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9shCQACgkQJNaLcl1U
h9B4Twf+NFkJy7KuNAOffATLKqqcClJiumK7L7QA6oQzn5MyuQ85EZ2YlPh8spJF
vNw1WzK+a0CQxCTi7s4jwEUZIR8G0Q1CqLAFxGk/F0bI3vHH7TpbGRvMpZ0/ixj+
fSTroeoBmtizi21WE7qOFqqmnMM89icDbtpuszMf/uXqqsfyb38GdZPa28s97m3K
wT91kmromhOILWvxFr+KZZBfm7auA9zCfS7D19thW4L7XZ8t//hFECZSgZ9/J9lR
BbjNPwusRL/r+b3dfIdAr4J2CSPEUolBX8s664HR/y8P9BmM4TEiMYHIuywmWYPA
CzDVA8Gdka3aB8Yb8apP6hMCG9EnHg==
=JdlS
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--

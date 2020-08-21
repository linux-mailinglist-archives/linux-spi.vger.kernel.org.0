Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2AB24D49A
	for <lists+linux-spi@lfdr.de>; Fri, 21 Aug 2020 14:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgHUMEL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Aug 2020 08:04:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgHUMEK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 21 Aug 2020 08:04:10 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAA6D2078D;
        Fri, 21 Aug 2020 12:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598011449;
        bh=29KlUcOwPwkaFaYaDe62OBwnN7uGZw8LVRWEmWhLjm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uKuHVwuSbH1mCfDDdptxFyuccwyLT8Rg1oq5t0t27/IMoNcHkS+XcLaUf1yK1Mgpj
         Z7Pstq2ESIAUHKVGHvl8j/Hs9n+shPgwxhzCTztkSXQkF2NPWFWVv1IIrOYzTVTsAV
         AfUtchbpSwz4xc9mWdKCk/khZIPpS5fzwV32bJsQ=
Date:   Fri, 21 Aug 2020 13:03:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, joel@jms.id.au,
        bradleyb@fuzziesquirrel.com, robh+dt@kernel.org, arnd@arndb.de
Subject: Re: [PATCH 4/7] dt-bindings: fsi: fsi2spi: Document new restricted
 property
Message-ID: <20200821120336.GE4870@sirena.org.uk>
References: <20200820170228.42053-1-eajames@linux.ibm.com>
 <20200820170228.42053-5-eajames@linux.ibm.com>
 <20200820171430.GH5854@sirena.org.uk>
 <b9fbd669-3573-a0c9-18d8-6c0c7926625a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CGDBiGfvSTbxKZlW"
Content-Disposition: inline
In-Reply-To: <b9fbd669-3573-a0c9-18d8-6c0c7926625a@linux.ibm.com>
X-Cookie: divorce, n:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--CGDBiGfvSTbxKZlW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 20, 2020 at 04:07:41PM -0500, Eddie James wrote:
> On 8/20/20 12:14 PM, Mark Brown wrote:
> > On Thu, Aug 20, 2020 at 12:02:25PM -0500, Eddie James wrote:

> > > Add documentation for the "fsi2spi,restricted" property which indicates
> > > a controller shouldn't sequence loops and therefore has a smaller
> > > transfer size.

> > In what situation might someone set this?  It sounds like a
> > configuration option rather than a description of the hardware.

> It is a description of the configuration of the hardware. For controllers
> that are configured to be restricted for security purposes, this property
> will be set.

The documentation needs to be a *lot* clearer - users need to be able to
relate this to whatever system configuration this corresponds to.  Right
now it says that the controller shouldn't sequence loops but there's no
indication of why this might be.

--CGDBiGfvSTbxKZlW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8/uBcACgkQJNaLcl1U
h9DI4AgAgJsVnzWSnS4PWV1kdy3NYIWrZ7v6ojfSo+askcLL+FZB/NiQPGb6dQDf
RQtHg8Uk0dDx+hNaOH3WFJJIY/UGRgkppRNhhEf+i3yJzA+L8Xq7xckuEYQHtnPb
vqliPcXM/Woixlm8dzOx2BzaN+k+HuMu3BDjmLYbNYMuYKoT9TP1Uxq8mqYfTLDt
0J/9jA+d2sVbbsd7I77MYOuABaXGz1UeseiUMuj7/78ttzG0MTdlNrhpqkqThC3M
VB8XDnwevNXWlFA4H8/ggf8NvxLHhzRK4Lr3brY+qWsVfzr7PpxT8nIOOuwDTAyg
IRyDkLEIcQs+uVAqgKTxPyJpEjGlzg==
=7OOQ
-----END PGP SIGNATURE-----

--CGDBiGfvSTbxKZlW--

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6781C1DED0F
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 18:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbgEVQS6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 12:18:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729040AbgEVQS6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 22 May 2020 12:18:58 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D43820663;
        Fri, 22 May 2020 16:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590164338;
        bh=KP2nU+GN8/OCDUXh17ONBK2JnQm5TqS96vJZfcVov1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WGNAmW/NL754P0/1LomK/Lu2LJA3CnqRfOsHAJzKVBNAuk2zJ/+2kbsXhtVBRRBFU
         KYJN/ER4mHoRZjQb52UEBU//OGJH2ngDoH1fBywZfDyHeFb1DQ7IqEjeqgSsD2M45E
         APF0Iq2u67kUK2W+Vf+5mimMqVdvDadM28kRHxX4=
Date:   Fri, 22 May 2020 17:18:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: Make spi_delay_exec() warn if called from atomic
 context
Message-ID: <20200522161855.GO5801@sirena.org.uk>
References: <20200522155005.46099-1-broonie@kernel.org>
 <20200522160233.GH1634618@smile.fi.intel.com>
 <20200522160417.GI1634618@smile.fi.intel.com>
 <20200522161001.s4pzjvzq6vwdivo3@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bvgsfYmVhxWy/2TA"
Content-Disposition: inline
In-Reply-To: <20200522161001.s4pzjvzq6vwdivo3@mobilestation>
X-Cookie: C for yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--bvgsfYmVhxWy/2TA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 22, 2020 at 07:10:01PM +0300, Serge Semin wrote:
> On Fri, May 22, 2020 at 07:04:17PM +0300, Andy Shevchenko wrote:

> > We may improve it later, though, to be smarter and spill a warning only when it
> > uses non-atomic delays. For now this is good enough.

> IMO this wouldn't be better than the current solution. might_sleep() is called
> "might" to warn that the called method may get to sleep, not shall, not will. As
> I see it it's better to warn about the consequences straight away, but not at the
> point when the sleeping method is actually called in the atomic context.

Yes, this is the whole point of might_sleep() - it's to ensure that we
always get a warning about code that might sleep, rather than only
getting a warning if we happen to go down a path that does actually
sleep.  This means we're less likely to run into bugs at runtime in
unusual use cases.

--bvgsfYmVhxWy/2TA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7H+24ACgkQJNaLcl1U
h9CG6gf/dhCO5x2pd1DsCnWK++I8WntgnYaFvr8Cc72hVtOjhiDHUcY/5TWg6HiI
C9m1aLuE2b7KK6tu1xuXBAApEyKAs1Hm+axJ5zu/SpV4vrjxBUNGfK3ScPVCnVyO
m9PmP5COt8+TyGzoA19Gg3QyGtdZPazTkLVNevs37ZqP9YZINVE3UNywtfO70RU0
yarjPQ84l4d3LVdvS9bDBqrLuOkgk4PA74BXco5y+bNmwrVV8CnnakUvsBF+0uZr
RDG3vZM2oDMa7ZJ9wFRRZEZM+ifFBAsmmPR+Lmkw+BnDNO+5RYsmEKBE3MOnKMfF
UN+OK8lO03onaEmnqL5zZDPTSbIwEA==
=IY1g
-----END PGP SIGNATURE-----

--bvgsfYmVhxWy/2TA--

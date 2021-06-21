Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66C03AE74B
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jun 2021 12:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhFUKmA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Jun 2021 06:42:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229707AbhFUKl7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 21 Jun 2021 06:41:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42CFB61153;
        Mon, 21 Jun 2021 10:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624271985;
        bh=zgKn2cpuQHF+2qa0GGW/2HNtTJsh2dw9eYQVZ+5waVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S11sfwUH0Q+XqzZ87eOI+NfxdnxsCDI/vqWFfQrYU4yBXmqChGeKV8ohh1VOPMbsl
         4FJVPZzgtldHmZMI2fqXvopHcPFJVSMZa2TskjNlgsWf2lK5nuUj5AhUSi2eBQ0dxJ
         YmfB63OjnEa8vOPiMPTj1gzru8FUikCB5/ta9ZZl02dbuMELA8ZheguLos+PWO5i8Q
         pNyzEHjdUJiBsHHdPLgL+CDWYM6R8Qi4+afBd/fpZSR2nRNVVBtM8gSPA/vKw4Ilkf
         HstdyyHCgr4F/6kVx2ycdla2wutHfqEZXCOBACBipLPbXdq8ZKf41yAihi0WreM5/a
         R4ieau/vXvsvQ==
Date:   Mon, 21 Jun 2021 11:39:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi: Remove unneeded parentheses in spi_map_buf()
Message-ID: <20210621103923.GA4094@sirena.org.uk>
References: <20210619111526.27776-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <20210619111526.27776-1-andriy.shevchenko@linux.intel.com>
X-Cookie: I hate dying.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 19, 2021 at 02:15:26PM +0300, Andy Shevchenko wrote:
> The boolean expression to get kmap_buf is hard to read due to
> too many unneeded parentheses. Remove them for good.

> -	const bool kmap_buf = ((unsigned long)buf >= PKMAP_BASE &&
> -				(unsigned long)buf < (PKMAP_BASE +
> -					(LAST_PKMAP * PAGE_SIZE)));
> +	const bool kmap_buf = (unsigned long)buf >= PKMAP_BASE &&
> +			      (unsigned long)buf < (PKMAP_BASE + LAST_PKMAP * PAGE_SIZE);

No, I think this makes things worse - to the extent there's an issue
here it's not excessive brackets.

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDQbFoACgkQJNaLcl1U
h9CtEwf/XSDSy4m8faQ1XcL20EMHIe5FLhxPqxqCdJojJeSAoI/3wBkqI4OkCdDy
tLzzQzENnoQGrf1Xc4mT/9iLLfAevqvypIStosLZkGQhqIFZSsnigVMGD3gYQYxN
zNytzmYr//S2OIqo2zES4A6Btw65NHZ0iHtwT4JSN+M3KHQZHtYAxJ0uQ7bRG0ey
UU1zLC6uoCfb9MMi0eSf2/lUfG71yAViQp8psfMnNebQBYcJQErFOfhVgywvAWkO
4ndbQo1BmioPz/sJXuLHh4E+Ld/iZ7WJLHv3BKH+3i35c1QV0q7ta+noql2bEc87
9YUyrr50yFREVOXUgaBfJMYX5GBUeQ==
=E/Oj
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--

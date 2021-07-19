Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30D53CDB00
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jul 2021 17:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244343AbhGSOkh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Jul 2021 10:40:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343962AbhGSOjw (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 19 Jul 2021 10:39:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C51261244;
        Mon, 19 Jul 2021 15:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626708014;
        bh=eZlfxmn16/DejZBT5q1Wtni1vItkSwB4wGlazbM0YlE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XgTL8aCZ82ReJIafFMisf5nVvWSN5hzj7dwNIYzyUVEDBxeOxaF4i04YvFw7Si85I
         pD2XDTeebny26MfXP/Il+RIkwyuyD8IgGzxKXqbDXOdkVlgLyB9ZX9XNdJyh450oKO
         VcjIr1nAz7bEfUL5lCM86mSFjujUsPBXHnjhBohtrMXXpsp1dr1mjxNbCB+BAygHiQ
         XR+6jOkf3O5tH9pwWn9Qvy9h0F08hFsyBkPvdYh2ItoJrUy9rz9SNdDNe9F8/YgKj2
         XtDpMOaowXqNcg7s7xdeJtpHHdHSlZZ+nhJdnUFr+JnTlbmRUwyppAncOhVhvYn96N
         l0b/lBBpfu4Uw==
Date:   Mon, 19 Jul 2021 16:20:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH 1/2] spi: fsi: Reduce max transfer size to 8 bytes
Message-ID: <20210719152010.GB4174@sirena.org.uk>
References: <20210716133915.14697-1-eajames@linux.ibm.com>
 <20210716133915.14697-2-eajames@linux.ibm.com>
 <20210716171936.GB4137@sirena.org.uk>
 <81a40f8690d297ebfb6697dbea63279bcf2f24fa.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline
In-Reply-To: <81a40f8690d297ebfb6697dbea63279bcf2f24fa.camel@linux.ibm.com>
X-Cookie: You will be divorced within a year.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 16, 2021 at 01:34:38PM -0500, Eddie James wrote:

> Security changes in the SPI controller - in the device microcode. I can
> reword the commit if you like.

How will people end up running this device microcode?  Is this a bug
fix, or is this going to needlessly reduce performance for people with
existing hardware?

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD1mCkACgkQJNaLcl1U
h9CTpQf/UhCO1XdGF7aljJI2cp2YtB4ew20JV3ml/uya+9qkrR+TxamAV9Yiz3I0
FuIE4j53u06I5QtBn/zan2iQBvVuBbtOZvLJKjRrMyUxPGrWKxwCjo4R6cmWID26
l5xWQnFxkhw3JX3ZGCnuyUJLzCkN5k05gV7faYgkN7h/K+2p5r0eIUKT9X4aPGzu
Nkw/Npv3ltnS0fcUTLreXs60lag6yInRrL2iYkJhxyEvndi7yS9Uc8CvZafpCrDl
hjKdSkQ4aRonuf2iUVN/6eUY8KJyB5X8SgrWohB/CkETMJVK8k3RZZk5M1HKH1aW
CTTqUFAkrr5gB1n6frcrq1PXAWqQFw==
=/M5n
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFBA34934D
	for <lists+linux-spi@lfdr.de>; Thu, 25 Mar 2021 14:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhCYNut (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 Mar 2021 09:50:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230101AbhCYNuq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 25 Mar 2021 09:50:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15B1D61A16;
        Thu, 25 Mar 2021 13:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616680246;
        bh=+kIS7hZFEwAfWJX+ckqBTUiJoo5OJwQnW+mqe6/TNXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oswcoo7LndgbvnOh7WCX19dq6ZQlbhns3QLQgvSSxBmq5k+xU5sbPmr/Or6kLTUHt
         hYnFxAFlvvsSTCv2En/XP6FWFlGtjkp4PL+sadzdcN/VdXwem/8usOOH0d1StQvHwA
         GEp/gOjD4zT+YGpCS8Iyr5dNniWKtLw4ZkMBcpdIFAxp6wVTzoG5/vcnBYk7EGp+jT
         yNaEk5KPp95XHYM8W72s3Mo/bNKnnqwrpNtzXX7YjN+0LFtV2HOA6WIVWqQJ0/5LQY
         TEFmkIcLFRWQYgV5pRU4r8OBiEuNorrW8ztCg4rnKN5+3+qApFFfKB8HHsAV25ZoEk
         /H0w5MIYJzPdg==
Date:   Thu, 25 Mar 2021 13:50:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@jms.id.au
Subject: Re: [PATCH] spi: fsi: Remove multiple sequenced ops for restricted
 chips
Message-ID: <20210325135038.GA4620@sirena.org.uk>
References: <20210324220516.41192-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <20210324220516.41192-1-eajames@linux.ibm.com>
X-Cookie: Offer void where prohibited by law.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 24, 2021 at 05:05:16PM -0500, Eddie James wrote:

> Updated restricted chips have trouble processing multiple sequenced
> operations. So remove the capability to sequence multiple operations and
> reduce the maximum transfer size to 8 bytes.

That's a very small limit, it would be nice to be able to identify
devices that can use the larger limit so they don't suffer needlessly.

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBclS0ACgkQJNaLcl1U
h9AaTQf/XScKdHHUWbgu5eMROSX3lR0+tZllXrx5bFEcLAPU6zYU76LccOISGM8u
jxZlKDWToQbUDGvU/tydxDnoJ8LvFvwdsCBuX9m4vyMyhYc61VUDwiizVQQkrC5U
8hpXTHXTaHG9IxTv4jm8HUf+QTwk8pWmjy+VXffWZWj/8abiFKKOvD1oQ1PQkmVe
bdjDWtzyIwC53tYOYzCYFNuIlVbgLAkEHv4/erPvC2qgBwdtaG3Obu+E13HdK3or
dcq271jI36x9GIf/WvbD85AQRmHMgVseZT+iaNwv9qh+7SDkcakHO9HIT5lFSpM2
F4gW+fA7IdI2DCX4cjt8LQ4Fft7gCQ==
=75mY
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--

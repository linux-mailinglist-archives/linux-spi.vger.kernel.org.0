Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B7C1F51D1
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jun 2020 12:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgFJKFo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Jun 2020 06:05:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727884AbgFJKFn (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 10 Jun 2020 06:05:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2CCA2072F;
        Wed, 10 Jun 2020 10:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591783543;
        bh=APaQDnwvqyDC5iMG3KTrDaueLYPZ/QB5u1pPBN97fzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i/tVvb7bSNJHPVR9o4oFfQvz+JUaC9+AfvZ9teYOr6qCELHB1Sz89Bt0fM6yHrVyR
         7dH8g6nfNICEus/twS/WfT+aacHtih//nzKTxVJMblzSq7tNtNp1EeyibfYVkiJn7X
         FAO+nBY7F5CWHRprRJzg9YDI1N4r3cFgY717ZLWk=
Date:   Wed, 10 Jun 2020 11:05:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexander Stein <alexander.stein@mailbox.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 1/1] spi: dt-bindings: amlogic, meson-gx-spicc: Fix
 schema for meson-g12a
Message-ID: <20200610100541.GA5745@sirena.org.uk>
References: <20200609165527.55183-1-alexander.stein@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <20200609165527.55183-1-alexander.stein@mailbox.org>
X-Cookie: Spelling is a lossed art.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2020 at 06:55:27PM +0200, Alexander Stein wrote:
> ---
> spi@13000: clock-names: Additional items are not allowed ('pclk' was unexpected)
> spi@13000: clock-names: ['core', 'pclk'] is too long
> spi@13000: clocks: [[2, 23], [2, 258]] is too long
> spi@15000: clock-names: Additional items are not allowed ('pclk' was unexpected)
> spi@15000: clock-names: ['core', 'pclk'] is too long
> spi@15000: clocks: [[2, 29], [2, 261]] is too long
> ---

Don't use --- in upstream commit logs, as covered in submitting-patches.rst
these have special meaning and cause the commit log to be truncated.

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7gsHQACgkQJNaLcl1U
h9BsPwf/d3EW/ZwwzGvj1esEpHD8SwSQ+yMMV19B8wr+cD2nLEjXFYIsqnrfSDVx
j6UU8sI0xLOXt0qIwdaRKGeM6C2FrNcrMWz7mykGzeErPcNLVhWn/aC6yEXDVpFw
jMP2rLcju1QccfOkPUJ4vl1kCBjCH5EF2wsVvsznwzChd6GeGubN5SHBxZHwaPYg
fuOWw0KdkFmbVQeXWyi1fCci3+QYvA/oWYGmgec6b/mVv9p27A228+zMNJ2jyOlb
TrzmRpvVv9BCQp81skBgn5ZQ/gy8XZjke8dGnxw4/FnL5FHYVV0dzehbzmWqTOBi
69RhVfacZtIKhjOpDq68m7H4gZH19w==
=1WyB
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C52218DB1
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jul 2020 18:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgGHQ6y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jul 2020 12:58:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgGHQ6y (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 8 Jul 2020 12:58:54 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 443E8206F6;
        Wed,  8 Jul 2020 16:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594227533;
        bh=8M6Yb1CrhNWLMCOcKsgvkbySDSF3ZKzqosp/1DO1Ma4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t3ZrTVcMrkNo5HHR+Ex2wNrC6pIbrQtZcYa5wNFeZgy07YdISjO3VhV3TJBYY0ja4
         GRDAEnbF6LwNVDOtl4YB8KFdSS5SyawLUOIGJQ20k2qU/Y39cKx2ZIDseaBpMT0z71
         EpYQWAOs8bWJyAvSq1S8mwNi2V37LRL3ZSHD/ag4=
Date:   Wed, 8 Jul 2020 17:58:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Zhang Qiang <qiang.zhang@windriver.com>,
        Petr Mladek <pmladek@suse.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2] spi: use kthread_create_worker() helper
Message-ID: <20200708165848.GA25961@sirena.org.uk>
References: <CGME20200708123401eucas1p1ec8fe745bb362c56f03798172a18324e@eucas1p1.samsung.com>
 <20200708123349.6797-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <20200708123349.6797-1-m.szyprowski@samsung.com>
X-Cookie: Sign my PETITION.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 08, 2020 at 02:33:49PM +0200, Marek Szyprowski wrote:
> Use kthread_create_worker() helper to simplify the code. It uses
> the kthread worker API the right way. It will eventually allow
> to remove the FIXME in kthread_worker_fn() and add more consistency
> checks in the future.

This doesn't apply against current code, please check and resend.

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8F+0cACgkQJNaLcl1U
h9Aj9Qf+JCia7cYZbN/n2MnUsjmNP20nQxIexzHxNRHBu7TH4CS9aGEc0G3AvrUd
QAAAktyW75uhb3M+yIqDvBBGqdWj8VvKhF6G+RYG5bjPHhcHvuEu3RyLk8vzPDmV
B48FJljGs3P6l7UNbTtOJyyigDSx99YYeiPvMrWJeBeYca2jjwdgnUkObu79zfsE
gmHW8CLw79KYXwOrfRAHhGGcFwQWq4rCOEsWKxUdOCtYfIeQ1QNpo5kGCFUdhzTF
B7JOqreOCTbUKXNcT1dVp6OyGyzgTRkGGXDq9w6vGvIVUsFBQDx8nlyOHkiaOxna
u1qhHoj5FKDzC8Oe8Dlv72KLAHJSMQ==
=6m7M
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C62D2184E9
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jul 2020 12:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgGHK0s (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jul 2020 06:26:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgGHK0s (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 8 Jul 2020 06:26:48 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D439206F6;
        Wed,  8 Jul 2020 10:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594204007;
        bh=XqNMpi4tSi+iPnKQlTA7D2lkXRhf2npCuezhwJNDgRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hFJ4DdaJUaOuz000SJgSOWGKy171Bi+YRedBCbAbjzl/A47iVqMBCo/i47cU285rX
         lKshiKJOtn1NgJOXnfdmiOs+Ly/rHywx1SrtPO08jqzV5Fc/6rJoRtUV2OyqWwwtC6
         1MeEVvlkk68tNkhPDaOHHvHu/D/tzq1M40MkzJtA=
Date:   Wed, 8 Jul 2020 11:26:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Zhang Qiang <qiang.zhang@windriver.com>,
        Petr Mladek <pmladek@suse.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] spi: use kthread_create_worker() helper
Message-ID: <20200708102642.GF4655@sirena.org.uk>
References: <CGME20200708070913eucas1p221ca64347d0ca03709eeee86decfd1af@eucas1p2.samsung.com>
 <20200708070900.30380-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hoZxPH4CaxYzWscb"
Content-Disposition: inline
In-Reply-To: <20200708070900.30380-1-m.szyprowski@samsung.com>
X-Cookie: Oh Dad!  We're ALL Devo!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 08, 2020 at 09:09:00AM +0200, Marek Szyprowski wrote:

> ------------[ cut here ]------------
> WARNING: CPU: 3 PID: 1 at kernel/kthread.c:817 kthread_queue_work+0xac/0xd4
> Modules linked in:
> CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc4-00017-g4977caef05aa #1193
> Hardware name: Samsung Exynos (Flattened Device Tree)
> [<c011184c>] (unwind_backtrace) from [<c010d250>] (show_stack+0x10/0x14)
> [<c010d250>] (show_stack) from [<c0517f64>] (dump_stack+0xbc/0xe8)
> [<c0517f64>] (dump_stack) from [<c01270a8>] (__warn+0xf0/0x108)
> [<c01270a8>] (__warn) from [<c0127170>] (warn_slowpath_fmt+0xb0/0xb8)
> [<c0127170>] (warn_slowpath_fmt) from [<c01512a4>] (kthread_queue_work+0xac/0xd4)

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--hoZxPH4CaxYzWscb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8Fn2EACgkQJNaLcl1U
h9AJlQf+OaBKci5Cb0F9VbFu5fVoWaiqo1ZU7n3Xnb2jHkAI2OTf5fXvBWFJ7Khu
gyzLd0GtPK0ZYzuk+FIuGXDGHKrUV34p1g7KTBEGBXvmb85QsDWzshTjlNTH8/WQ
iliVOnZQpk5oAfxMWMtSpYbaw4NrmeASf9dQZPcvnrtrFaJPiS4VNgcZG/IyQY8o
WlhQvLw7BVHpvKgoblZG34XfbWxA6eld0lDzMkj48WwQ2OTZHPmnw9t73Adt08FY
lfHhoSgCi/iOVqIy4CCg3sory+FH2XMPevAfK0YqC0/3MUJCgpAcjtC9OklY6+yN
9MT8NxmV0NbwzVsFEJ8Y6Vjz67B/TQ==
=Tj2d
-----END PGP SIGNATURE-----

--hoZxPH4CaxYzWscb--

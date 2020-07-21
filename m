Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E885228C30
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jul 2020 00:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgGUWrf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jul 2020 18:47:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgGUWrf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 21 Jul 2020 18:47:35 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EFD12073A;
        Tue, 21 Jul 2020 22:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595371654;
        bh=lC9beQZcJxAVoggStwsSQD4umxKrJ5gvYRxSjxfqKgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vx2lExdiuSTzdGyDGpUWaWm3KIVvWLX+wqdqJi/pB5vdLoMo7Hx7K8TbX5hX3b/WI
         3rJfUp6uDE82W2HgBA4+PnVgtCqN9E8bSfBTarxi9JrjF8Flrt0COeCscy4vDNTYz8
         BosH/RsIk27dGwTnoKIkR2ErINMfPJ7IE5Eky59o=
Date:   Tue, 21 Jul 2020 23:47:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] spi: lpspi: fix kernel warning dump when probe fail
 after calling spi_register
Message-ID: <20200721224721.GA33193@sirena.org.uk>
References: <20200714075251.12777-1-xiaoning.wang@nxp.com>
 <20200714075251.12777-4-xiaoning.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <20200714075251.12777-4-xiaoning.wang@nxp.com>
X-Cookie: Wanna buy a duck?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 14, 2020 at 03:52:49PM +0800, Clark Wang wrote:
> Calling devm_spi_register_controller() too early will cause problem.
> When probe failed occurs after calling devm_spi_register_controller(),
> the call of spi_controller_put() will trigger the following warning dump.

This doesn't apply against current code, please check and resend.

> [    2.092138] ------------[ cut here ]------------
> [    2.096876] kernfs: can not remove 'uevent', no directory
> [    2.102440] WARNING: CPU: 0 PID: 181 at fs/kernfs/dir.c:1503 kernfs_remove_by_name_ns+0xa0/0xb0
> [    2.111142] Modules linked in:
> [    2.114207] CPU: 0 PID: 181 Comm: kworker/0:7 Not tainted 5.4.24-05024-g775c6e8a738c-dirty #1314


Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8XcHkACgkQJNaLcl1U
h9ABZwf/QAz1ZkBEQ11WvbVv1FhvqZyXhY4kxfUBGqxMBeIkKzTZqZQCusd0T7Ah
47kcDS0t9QQE4haXfLRe7PiGvA16xTmm2px8W+vlQbkxnDIwYmIaBueWiiNXGL3x
tIiV3nicZgAtkdYHC+XZeVTYAgsZCzywC1la/kfSjYTAU0ltKIN+DEtkQu7gbaRL
Wh+0/Cqj8CKFJiNTyXIUiJrvRDmpbCCqUaVwhJxnom0P197kiD4SiJhp3KynaqWM
FQZvkIfFu+U/242IVGKbgOe1grcSKZ1fCdYBwON+F5RWvLy1HdLRNmK6uyEmoLXp
2HUXFj147kxJE/POHBVcdnidhfwwzw==
=XZW9
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--

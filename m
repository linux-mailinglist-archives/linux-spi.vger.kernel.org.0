Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105E622EAE7
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jul 2020 13:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgG0LL1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jul 2020 07:11:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgG0LL1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 27 Jul 2020 07:11:27 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC4B4205CB;
        Mon, 27 Jul 2020 11:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595848286;
        bh=5cjDhcqA22LmKpF1+epE71V5q45KFj1IeAEV+bx8KEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zwl1JoHUq8qXqIEHxk8e/QYK5paM+jXPuNbIsWBOMjuQkxkP20nHpBR+c7eMNs40n
         8KEHAM7jD/QrC6dtSdorxbp1lPzjMRQARN26ihMDxfTED12Y308emVDGYmd0DHjM/P
         4Z8bXbfMyJ1UcnUHuUL2S645FBnlTAY7cstJsGlA=
Date:   Mon, 27 Jul 2020 12:11:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/4] spi: lpspi: Fix kernel warning dump when probe
 fail after calling spi_register
Message-ID: <20200727111109.GB6275@sirena.org.uk>
References: <20200727031448.31661-1-xiaoning.wang@nxp.com>
 <20200727031448.31661-2-xiaoning.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline
In-Reply-To: <20200727031448.31661-2-xiaoning.wang@nxp.com>
X-Cookie: Doing gets it done.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2020 at 11:14:46AM +0800, Clark Wang wrote:
> Calling devm_spi_register_controller() too early will cause problem.
> When probe failed occurs after calling devm_spi_register_controller(),
> the call of spi_controller_put() will trigger the following warning dump.
>=20
> [    2.092138] ------------[ cut here ]------------
> [    2.096876] kernfs: can not remove 'uevent', no directory
> [    2.102440] WARNING: CPU: 0 PID: 181 at fs/kernfs/dir.c:1503 kernfs_re=
move_by_name_ns+0xa0/0xb0
> [    2.111142] Modules linked in:
> [    2.114207] CPU: 0 PID: 181 Comm: kworker/0:7 Not tainted 5.4.24-05024=
-g775c6e8a738c-dirty #1314
> [    2.122991] Hardware name: Freescale i.MX8DXL EVK (DT)
> [    2.128141] Workqueue: events deferred_probe_work_func

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8etkwACgkQJNaLcl1U
h9By2AgAgnTCFAi+3XM31B5xy1B70aDoOYf1tRMaXEQR97aYIRF+ihcgFzNIsmrH
E3lMnfNkmIdmCHpJpRyfgdH+zIMbya8rvWnQwiO60Ar+weSi6cB9cuRY/OvpKDQp
oz/4iFuOMzLB/+d8OABUsT1NlxvJGZR55VxQyCtWLXWCl47Qw53g5BS5iHSK0vSt
Qnlh/I+gGGdZ3AV/d6F5LlG0/ogsM0GW9qL06b5MBKHje93LJJao6YOczrYN2RIL
9Zt5nJ3a5BqgduNsas5XrxWjQ3QV00AIPwdKXziIhxMcQBmGv3r3dYpDQELHU5nr
WxgW50uDCZtetlfOcgTBIt4UREDmgQ==
=umFf
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3CEA21EF6B
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jul 2020 13:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgGNLhW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jul 2020 07:37:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbgGNLhW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 14 Jul 2020 07:37:22 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDF6722201;
        Tue, 14 Jul 2020 11:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594726641;
        bh=h7+gt/VkcwPo2ZUdjBEGzdFEcZNQAqnd5lCoJNEHyaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N/rk9dF+tcrKcHmaDs0I6uWgZSDowhLUzfr0ytVyyuak4YilDxnNs8/BDZKosy2dt
         ofUG9Y1V2yXWrx8Q605KI4bGf7JoKPfpWiFB1ctHuOzytM+XSXPbmxiaO3BxqgcFaq
         D370yyOa8clQ/g9O/RcGntuBVIabEWTAzFjLnltw=
Date:   Tue, 14 Jul 2020 12:37:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] spi: lpspi: fix kernel warning dump when probe fail
 after calling spi_register
Message-ID: <20200714113712.GE4900@sirena.org.uk>
References: <20200714075251.12777-1-xiaoning.wang@nxp.com>
 <20200714075251.12777-4-xiaoning.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3O1VwFp74L81IIeR"
Content-Disposition: inline
In-Reply-To: <20200714075251.12777-4-xiaoning.wang@nxp.com>
X-Cookie: Your password is pitifully obvious.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--3O1VwFp74L81IIeR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2020 at 03:52:49PM +0800, Clark Wang wrote:
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


Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--3O1VwFp74L81IIeR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8NmOcACgkQJNaLcl1U
h9Ag5Af/TwxSYf1uOmLZGORNmkh5vQDWWTlyZTCj85EDEzELZOHCFmRVcYZSm0dh
0Oj74biM+7bfq82kfGuAloMlDzpa9W1Pn3Ft3cIoK2//NXdc4liWUrYJArRqYEKk
x+lsGUJZxL8TfzB170y6HOHgrnNiXzzv0hMOJy1IX5mClNh8SKQEbqcAgssGkbLc
STo+T7GaoKlyRPTIdEq3n8JeyXbKuZe0sHXRjfCkl7K2LaHcpc0KNobUE0tZmY7J
yy5TNZF0EclnY78hvBR4Kzqyls1VgvXYPhMxG8bFWtDb65wMPZbv67fA6bOcp0eM
lVKavNVh9gTlJ518JXckcQCRpbM4EQ==
=NPb7
-----END PGP SIGNATURE-----

--3O1VwFp74L81IIeR--

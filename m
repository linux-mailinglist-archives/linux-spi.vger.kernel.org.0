Return-Path: <linux-spi+bounces-1519-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F28F2868B9F
	for <lists+linux-spi@lfdr.de>; Tue, 27 Feb 2024 10:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8CD11F21AF0
	for <lists+linux-spi@lfdr.de>; Tue, 27 Feb 2024 09:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E5F1332A9;
	Tue, 27 Feb 2024 09:05:16 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F341B136654
	for <linux-spi@vger.kernel.org>; Tue, 27 Feb 2024 09:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024716; cv=none; b=YIsUQ0ngv70gw7w/gOYhd90kcr10cMw9Vu12TtnHpzXtHlt6VU6g3JnMgOiIf6cPfwDfj7UDvWrVclfYB3ay+f4RWQ3u4bjnEeXLwCF+QJoM/U9djy87V7AAZOH1RM/5+YruE+5mNoa92k+Iz1vuuC3dmS7xHmff7YiQWWq+6s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024716; c=relaxed/simple;
	bh=k/tyiR3IzjEjWwmd4nmf0QxXZinjaE+TlRr4tTzfqkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYJX2z7aelnMIhjzkNjeNYSMz1cBwMx3v6xTlQrpciKxkIlFses6E9+FSNNHxVYvJzs4ZSozDYYoRY1fzzIOtjtfffa3Zjg+BWX+SgVo0zOuBzTi18TdHgnvNBmTdW/B/xJoVZKN7WZxwezT7IvafEbIfC+Xt8lEr8O5H3J+aYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1retOc-00065e-SA; Tue, 27 Feb 2024 10:05:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1retOc-003A8L-6j; Tue, 27 Feb 2024 10:05:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1retOc-00CLjC-0N;
	Tue, 27 Feb 2024 10:05:06 +0100
Date: Tue, 27 Feb 2024 10:05:05 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: Increasing build coverage for drivers/spi/spi-ppc4xx.c
Message-ID: <p6jiwwqxq5tkqgpipve46l6gyckjunaopmcbjo7h6da2taif2l@nuhpuagodhlz>
References: <qvuhez7vrcoui7i6s4yohd4ednneuoejcp6tw6iwzeefgpyvd6@fkwwtwozhakf>
 <0b29d980-b3b4-4437-be24-19f54b473224@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rfhmgqw7ekafbys3"
Content-Disposition: inline
In-Reply-To: <0b29d980-b3b4-4437-be24-19f54b473224@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--rfhmgqw7ekafbys3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Feb 27, 2024 at 08:54:03AM +0000, Tudor Ambarus wrote:
> On 2/27/24 08:46, Uwe Kleine-K=F6nig wrote:
> > recently the spi-ppc4xx.c driver suffered from build errors and warnings
> > that were undetected for longer than I expected. I think it would be
>=20
> long enough so that we remove the driver altogether?

I know at least one user who noticed the driver being broken because he
needs it and not because a build bot stumbled.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rfhmgqw7ekafbys3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXdpcEACgkQj4D7WH0S
/k40+Qf+McTNZyqk8elCNTKJEmtaH3li2C4DEQO+7AtfPhiLVsQVPAxDcO6QKt6z
ON64F4KzMK8LdBxBmi3a3I3zceBJxvF8zlyj6X6xTRq2fmaUGm4axOZNliSvqPzo
+tJ3Dm9GKa0cEPX31xYt+2JVsN3KLBxqMdT62XqpUp1nzvRwLC0DjNUujpfljE7f
n8MsLRrPQXHwrVQRKYGmJtxjUG0U4rY0FG4t/t7tO3XTOsrsIPm7oGbMcVNRPT+t
7MC8NJUdGHkfXL6il/pid2C/BP7Div/e/rU8aConqvkuG/38ruaCYAYl/YI17+iN
nkSDgHAltp5JO3Y06QoOqwMUIjNaTg==
=GKeb
-----END PGP SIGNATURE-----

--rfhmgqw7ekafbys3--


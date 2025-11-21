Return-Path: <linux-spi+bounces-11455-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D370C7A282
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 15:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C83794F281D
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 14:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B18345CC4;
	Fri, 21 Nov 2025 14:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bY/+SCHN"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74588344024;
	Fri, 21 Nov 2025 14:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763735001; cv=none; b=bMKBfoud8wna8kSl7iXtQuUwBVh1KFlkgXp0cQxAlgNOfHaxkaMyyz/6ZHtUWbsCB7J2wF3vkaAyrjmwy4NsKIxzAszjTu9FZmoilv+LF3SV3ZHCA9u05dQpgnMM7xrIpANxdoxOSmQNiecuV5E3YlrRGrdhYb28TLFu+YTJyIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763735001; c=relaxed/simple;
	bh=E3o8i+V0u5YHeHV7K5vFmZBQMV9gJn5G/yAV47cvbJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUZ6OFl8SsheWqMUtnqElf/lKVmRYLIBNKZ5+/yAQOAR/VSV+DL9AUk7BAZYRk3rXAogtVmUESuzthNKyvq5O1VDS3JvWWXCSpMCOH5IBkizWPMUIO72tfH0GVKV1T1kV5QbQQ91DfL9ngLsCcTyiREzkGrPCVxWKr1oRwDmw0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bY/+SCHN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A90C4CEF1;
	Fri, 21 Nov 2025 14:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763735001;
	bh=E3o8i+V0u5YHeHV7K5vFmZBQMV9gJn5G/yAV47cvbJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bY/+SCHNsl1FX3WdcuLRnX2HfmuRtVqjYf7fXGoaP1ozRUFWsM7eMTTdx3DkCb36E
	 CSv5Q/96R9Dzp1IhlsTxVdSdezCOAKGCpPDlgUFq94AO9MUGigFyjTAtKovwZw6Sb4
	 Su62MbXqoySnwGntadiMNLlEJh4lkTWCMGJMWsMgAh9oxPw4yi5QKZtPLtlzB/Ea9B
	 nE5bUh5pmOP8dvrXrtRM6FKn0dnjwLwT3kSUS9bsusyAiQvbJ7NE4TTi/P3f27ho3A
	 xY3NGP9a3xtaX6OY3ny4jFjh4otiAaj4DMZZll/ha5kqbPNdupFKE59EtuCfbRowbv
	 RkE6E0hptO1QQ==
Date: Fri, 21 Nov 2025 14:23:17 +0000
From: Mark Brown <broonie@kernel.org>
To: Carlos Song <carlos.song@nxp.com>
Cc: Frank Li <frank.li@nxp.com>,
	"rongqianfeng@vivo.com" <rongqianfeng@vivo.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: spi-fsl-lpspi: fix watermark truncation caused by
 type cast
Message-ID: <7af6aa81-de6f-4ac7-b6dc-e4a79ae80afb@sirena.org.uk>
References: <20251117030355.1359081-1-carlos.song@nxp.com>
 <VI2PR04MB11147DF123E2313B91CD8FBC7E8D5A@VI2PR04MB11147.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UTLYNt/SZpo6Xudb"
Content-Disposition: inline
In-Reply-To: <VI2PR04MB11147DF123E2313B91CD8FBC7E8D5A@VI2PR04MB11147.eurprd04.prod.outlook.com>
X-Cookie: revolutionary, adj.:


--UTLYNt/SZpo6Xudb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 08:18:17AM +0000, Carlos Song wrote:
>=20
> Gently ping to avoid missing...

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--UTLYNt/SZpo6Xudb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkgddQACgkQJNaLcl1U
h9DnnAf+Mzd/D3tDgwGnqiKK+ihy/oCQg/umjiEl9Rx4D6C1vlg2iyc6Ae4hvCaw
yO4rhu1vkQFidueMpRlOuW/GXWSVrce16Knjb8L4qqr8a/ALm4925PFUgUabt8pl
L9L4nn6NQTlgQKY3hXOj2HSlo55R03gH1zKvNoKK8sPJiHBeFyLpzvCfoVfkwXvA
WaaAtwgHm9A3rYUE7VM9vfzUQW4+nM16XrF0xLPeQgUaHRXDH64h8YZBqVDn0IKA
zhDk1ixsXKsU9dXeKwxHdTTqKrOr57V7y5rAqqNRPeY+xb/q3MooQMdU2uf+ycbQ
YWQ414/FdvmQsOWnMhHcFNuT7NfUrg==
=d+XM
-----END PGP SIGNATURE-----

--UTLYNt/SZpo6Xudb--


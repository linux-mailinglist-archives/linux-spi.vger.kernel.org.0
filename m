Return-Path: <linux-spi+bounces-6863-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE769A3A09D
	for <lists+linux-spi@lfdr.de>; Tue, 18 Feb 2025 15:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F2E13ACC7A
	for <lists+linux-spi@lfdr.de>; Tue, 18 Feb 2025 14:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29A8262D1C;
	Tue, 18 Feb 2025 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxZopk+M"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735642309B5;
	Tue, 18 Feb 2025 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890504; cv=none; b=IXmhhqM7At+8xuaqojiFH+zRcjt0O1ezHHIymdplzATp+YzKGIHBDPfywL+inlmw6WCh0OYV40Kzxvz3gDxvjlmI8WSRJG7EiZax0+EdAp9K1rXQkZrsgY6y6TwL9AsHr3ysXCse9SA0BkjEZ/3lMFjyhsVFlA/mHqdqHheitEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890504; c=relaxed/simple;
	bh=vhd1qtpo1JdzpatIl3cLegasb4zvWEmr+5D4nvmUfsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hm8qaUYQTQWtoEZ1QjKGK5Ki0aCRsscKRcEAnT8ZyVDZLzRdy1Xx9+eUXKJLq39qXmzefX+esCHZxF+oZko7gq/1MyIz6JZgnLvZ6N2mRO5QyCSaV98GWhhQ8rAU8FSL+QjGwzbLaDyi41kP21EhV3JFz9I/K1guzDVeWmComEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxZopk+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE7CC4CEE2;
	Tue, 18 Feb 2025 14:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739890504;
	bh=vhd1qtpo1JdzpatIl3cLegasb4zvWEmr+5D4nvmUfsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kxZopk+MmDffn+I+qcaMFBBKtmDMxSu5jiCHbVgP2o0gEMQ8lBFDEatsOKaeKK8i5
	 MwHKorHaYBLgQ6TQ+A82YzaEhYoYcSxBUBaIdpT+0KzLBbXu9LKI5BPC4RQwN5NqlA
	 MxCiCmzfiQEVfKXxl7krYfU6Nc5j/RPPaim/vbxVB8EkzjxtkZobed+vKfJxjP45Vx
	 8L+UYhveZHIA90yeFmnlx5M+mGVrLMGRgJfXNpFFvGbKCW/ISK/B2B0p4jE5XWNmZk
	 o+fWujqNzPxQCitaXCFcYCcc7mivMuqbE9aYnW/42IxGYgOIvSBAkOjj60SWfsuAyF
	 TyOxBKAd0gdVg==
Date: Tue, 18 Feb 2025 14:54:59 +0000
From: Mark Brown <broonie@kernel.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, andersson@kernel.org,
	konradybcio@kernel.org, richard@nod.at, vigneshr@ti.com,
	manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Tudor Ambarus <Tudor.Ambarus@linaro.org>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Michael Walle <michael@walle.cc>,
	Pratyush Yadav <pratyush@kernel.org>, quic_srichara@quicinc.com,
	quic_varada@quicinc.com
Subject: Re: [GIT PULL] mtd: topic branch for spi with Qcom changes
Message-ID: <Z7SfQ4lu2fponEiX@finisterre.sirena.org.uk>
References: <87jzbp9hnt.fsf@bootlin.com>
 <87bjwkoxwh.fsf@bootlin.com>
 <96bdefb1-4607-4a4a-8bed-b4d9b5971171@sirena.org.uk>
 <80746729-2b32-9a13-93f5-8d5c222ce4d8@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KvxwJgM+dWb73Ypq"
Content-Disposition: inline
In-Reply-To: <80746729-2b32-9a13-93f5-8d5c222ce4d8@quicinc.com>
X-Cookie: Editing is a rewording activity.


--KvxwJgM+dWb73Ypq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 11:25:24AM +0530, Md Sadre Alam wrote:
> On 1/6/2025 9:06 PM, Mark Brown wrote:

> > Thanks for the heads up - I didn't pull it yet so as you suggest I can
> > just leave it and pick things up from mainline.

> The QPIC raw nand patches are available in the linux-next. could you plea=
se
> pick the QPIC SPI NAND patches [1]
> [1]
> https://lore.kernel.org/all/20241120091507.1404368-7-quic_mdalam@quicinc.=
com/

That looks like it was posted back in November, I'd have expected
anything for this release to have been posted after the merge window...

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

--KvxwJgM+dWb73Ypq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme0n0AACgkQJNaLcl1U
h9C7CAf9GhX9iaL8H1BWXp96KRzkYlHWeeIWT7O52PE08NkbOC8mnuDlYL5yyG45
wbBly4US/3NeyEf7EtuOS/lXTPfcC1+6w7fEcIGk30BiEfQTsvKNjtR4+vUBAdXB
8qbv/RCZt77TJbd933SHZF3Lf8PWBCSxv34/DOA9vAsI7X68OKEu+UN4AwK3C3jP
PRobiMSnnvgZ1MGRHzTXk4KASUthkdbZJp6TEbQhq6rVL9P5M1XCMF+OR8NgCmva
TR2A42a1jT+kyCR0GCchbqf+dqjvKpGSsD85h4hp77vjJpwJ5r35PdO4XGNwoYRh
5cF/iganN6NcwFjn2l6Qtn70IX53kA==
=nmaR
-----END PGP SIGNATURE-----

--KvxwJgM+dWb73Ypq--


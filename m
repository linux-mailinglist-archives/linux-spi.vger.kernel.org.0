Return-Path: <linux-spi+bounces-12490-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2865D3B12B
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 17:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFB99306FFD7
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 16:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B10132694A;
	Mon, 19 Jan 2026 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzbJZ/sq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078912F2619;
	Mon, 19 Jan 2026 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768839917; cv=none; b=FifO7xRBgHaFr8eGq77Zegf86PtMwgHPuBhAdUcPrUULuLeBvM3JLQtAVOlydBecTI02ureFD3JEH02gR37e3jHunEvIHfEzoOgHhRQ2AAA2xumPCql7h+EZogabGVCXiHRvdM3iVRpvfzX5CQyAJu7S4U0vh6CS6bJq787uS9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768839917; c=relaxed/simple;
	bh=j/bkmTbmdLODJy0m+kOcEDtfSshRy8Al7VaLx1xfKJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BasAR9GX2k9T832zOzHT8PaEqxn9mUvvSmAxiiktbuQJ/Ew7k2XKuHpXvKT/gA+iw6jVpHdTs6boYL92+L/iLlac3+JOZzFiBm5RdKwnTVAoyYLOSmIcAlLgkDjST7gIwPuj0HNrzOylvNhavjkCJprjWYD7rCm0rhNcDHcaLnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzbJZ/sq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194ABC116C6;
	Mon, 19 Jan 2026 16:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768839916;
	bh=j/bkmTbmdLODJy0m+kOcEDtfSshRy8Al7VaLx1xfKJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rzbJZ/sqPK8LZRcCfK51VFqYITs/eIxzmFOUtQilWMFyOJ00K3WUpz8ZAoHulGn6K
	 H/TElTzNjkmK0Z+BGhA3Qxikhtkcn5P8hKn+BWHZrSiv3XzttLCKldRlxTkRAboz0I
	 ETo22/0US7qS+tlmH0kSyT8OQK6DK7dCO9/mPjxBm5SNzRT5Mb2oNnrkGePvbVLb64
	 SPwpB5BGGNRUeE3tajkVVwOgQzvoUXcPzm/pn6KvB+85TgxQ2ay/4813PIzwl8Dp6t
	 y394XHTa2lUY/StJ7Bi32OhsKOSLwCM20ci6cyN4xUNjpqdkcbDisJN9bwu5Jitlx+
	 WrgtroedJn2TQ==
Date: Mon, 19 Jan 2026 16:25:12 +0000
From: Mark Brown <broonie@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Aishwarya TCV <Aishwarya.TCV@arm.com>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	"xuhui.lin@rock-chips.com" <xuhui.lin@rock-chips.com>
Subject: Re: [PATCH] spi: rockchip: Use plain request_irq()
Message-ID: <4406022b-11b5-4622-9662-5c3ba054e5ea@sirena.org.uk>
References: <20260116-spi-rockchip-threaded-irq-v1-1-c45c3a5a38b1@kernel.org>
 <f8658bd7-7381-4770-935a-6a98ea3f652f@rock-chips.com>
 <a5b6c607-9b8c-4fa6-98c5-6ba848f7f2e2@sirena.org.uk>
 <9c9d2fa3-46f3-43e6-95d0-6b5ec6b6ea78@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hDOzrXk8FzfWLT2w"
Content-Disposition: inline
In-Reply-To: <9c9d2fa3-46f3-43e6-95d0-6b5ec6b6ea78@rock-chips.com>
X-Cookie: Does not include installation.


--hDOzrXk8FzfWLT2w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 17, 2026 at 10:10:09AM +0800, Shawn Lin wrote:
> =E5=9C=A8 2026/01/16 =E6=98=9F=E6=9C=9F=E4=BA=94 23:37, Mark Brown =E5=86=
=99=E9=81=93:

> > TBH it looked to me more like there'd been some deferral of more complex
> > work at some point but that didn't make it into the final code.  In

> Ah, indeed=EF=BC=8Crockchip_spi_isr() directly performs R/W pio in hardirq
> context which doesn't seem advisable, so probably some better
> improvement is needed in the furture. Anyway, fix the warning right
> now as $subject patch looks sensible:

Generally the best pattern with this stuff is to do PIO in process
context - it looks like the driver already has a copybreak to use DMA
for larger transfers on systems that have DMA support so this should
only be happening for very short transfers in which case the context
thrashing from going to interrupt context is probably hurting
performance anyway.

--hDOzrXk8FzfWLT2w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmluWucACgkQJNaLcl1U
h9BGTAf8DqPxL9iRh4yImrQOrl1QKw9rS96zsLVc8Wb0wPJLTBUwuc+vX24CW1qG
VbTXj7VulzvEMMLPPVu6MVFlOnUIeblYoyqIhvBx1BwBT6glaHECSlA/aoofxURZ
QBKQxeTpqT1kJXz4BUnh9XPAwKc9rkDbLs849tvzFvuvq0Z9xk27Zq1U96YQCYgO
8O4pShgAfU19mJUrSWltRw6EDMuNO2fCfPquUC3mqswLijINccPM9F0B71AhYAyb
/vLRsZuI+TUpLwy7oNa7iZH97+gR3sIV/eunD24GgC1fAt91pFU2YTpxzsl6bdcw
VPMiZK4jJxbF8PsPUVpZFtazIyswog==
=+Uas
-----END PGP SIGNATURE-----

--hDOzrXk8FzfWLT2w--


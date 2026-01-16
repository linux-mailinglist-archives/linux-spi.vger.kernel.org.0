Return-Path: <linux-spi+bounces-12448-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99533D33426
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 16:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E1AD30F0367
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 15:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5AB33A9CA;
	Fri, 16 Jan 2026 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7RCDi6o"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA58F33A6EB;
	Fri, 16 Jan 2026 15:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577848; cv=none; b=dZEbbSJ9pnmp323zELF+9H7A6CE+/FoFrUB10iv0g4M+EWzUfLFCNPMDGo4ICdA9qWDnaSQ1DSqSPZnTvNZm8Qo/ceT+Jci9IJBENj+UNMT0SLV9x9sOPxY2CP8zNktRMeRoRIAiDcFZsela8IGDigIsuTzoxFoU1Ug8kfjr5yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577848; c=relaxed/simple;
	bh=qiVgr628GGRLF6BCGNE6F1dNfg5w/bvsIxbfkIRZkqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YsbJWj5YV+lRFs+JGxpN3CsrpPt6Ycys9l4NDgY0Jr8bL8alWsEiAiTweoxzwTNMmZd04wgwSeC0OUNpzAuRj7klPKtIcDEVYsRpgcu4eHlkJHKaN8DxBvSCPMy6rILr6GSErlJ01ZEYDKsBnkTVMPG1sEt/9kNdWZNQvrPNCa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7RCDi6o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A40C16AAE;
	Fri, 16 Jan 2026 15:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768577847;
	bh=qiVgr628GGRLF6BCGNE6F1dNfg5w/bvsIxbfkIRZkqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n7RCDi6ogwDyc0P0xl1DnaT7khpYpVWRlnCeGr4QVmo6ydjHaF8Qh5lThqEdyP3ke
	 0j9cy0zk9xvtOsyjZDKPdjYCnOCNHpnAR4dUPJPi2dm983LMLA/KR6sjUPqPm6PPFo
	 66uOKRx9++/BtmbxvmAjUzRUK/roZWEqRH8I4hEWXWbUBZED1yKA0E8f7bNrgwxHVJ
	 T3zmV8P9r9xsh/WfEoMH7+xIsPybxG79XZJzZ7Hf3MvTnIAaUkV8MZbbDWg3pw61MK
	 liVO5TNo3NhA4UPFaY+FkvhUStDeVWSZyCF/7FYIdvCckuzrhJVU2DwJmY79p0z9Nz
	 rFCE2yPwCmG8g==
Date: Fri, 16 Jan 2026 15:37:23 +0000
From: Mark Brown <broonie@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Aishwarya TCV <Aishwarya.TCV@arm.com>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] spi: rockchip: Use plain request_irq()
Message-ID: <a5b6c607-9b8c-4fa6-98c5-6ba848f7f2e2@sirena.org.uk>
References: <20260116-spi-rockchip-threaded-irq-v1-1-c45c3a5a38b1@kernel.org>
 <f8658bd7-7381-4770-935a-6a98ea3f652f@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XPdBLVUHRgYjhzwD"
Content-Disposition: inline
In-Reply-To: <f8658bd7-7381-4770-935a-6a98ea3f652f@rock-chips.com>
X-Cookie: I've only got 12 cards.


--XPdBLVUHRgYjhzwD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 11:19:39PM +0800, Shawn Lin wrote:
> =E5=9C=A8 2026/01/16 =E6=98=9F=E6=9C=9F=E4=BA=94 21:23, Mark Brown =E5=86=
=99=E9=81=93:

> > The Rockchip driver has since interrupt support was added used
> > request_threaded_irq() but not actually supplied a threaded handler,
> > handling everything in the primary handler.  This is equivalent to just
> > using a plain request_irq(), and since aef30c8d569c (genirq: Warn about
> > using IRQF_ONESHOT without a threaded handler) the current behaviour has
> > triggered a WARN_ON().  Convert to use request_irq().

> Is it preferred to use threaded version if latency is not a critical
> concern ? I guess the original intention was to use

> ret =3D devm_request_threaded_irq(&pdev->dev, ret, NULL, rockchip_spi_isr,
> IRQF_ONESHOT, dev_name(&pdev->dev), ctlr); ?

TBH it looked to me more like there'd been some deferral of more complex
work at some point but that didn't make it into the final code.  In
general it's better to handle things in hardirq context if they are
appropriate for that, and for a SPI controller the end requirements are
coming from the device so you have to assume they're going to need
things to complete promptly.  There's overhead from scheduling a task so
no point in incurring it if it doesn't buy you anything.

--XPdBLVUHRgYjhzwD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlqWzIACgkQJNaLcl1U
h9BZEwf9E/UdYem+/snD3D/JY1NMjR4Ze+1L8MvjU4ZY8KuZIFJqMYDOQY6Hb2Ce
qL6AiwhxKtCZwYpFLT1KAN9QP7aLxEd3wEwSDmOrMrsSUnAntzGMEYIDTh4Nn3pH
ekSmtMPNFXgLRULZn9IeeNuNxMz+IZCfw6yZvmubmyP9NyMmllZg7UPCVNfXJZfu
aJiil1rcQI7cLiBU2rGHNNB8Vsq0K6CcpF5z/w2I5FkYTnC7XQ2WiZP/+gCvA52K
3G4GdhdRfH9bYJgKH2+PU0+fkvJTVNs5QfXp1H/UgAL1CGOM4jedtwBeII4hLh/9
/2OecQXsuvIE0aH/VcNZqDmaYzNYPw==
=4SUn
-----END PGP SIGNATURE-----

--XPdBLVUHRgYjhzwD--


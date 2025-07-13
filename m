Return-Path: <linux-spi+bounces-9093-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A91B03319
	for <lists+linux-spi@lfdr.de>; Sun, 13 Jul 2025 23:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0EB27A77E6
	for <lists+linux-spi@lfdr.de>; Sun, 13 Jul 2025 21:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0081F03D8;
	Sun, 13 Jul 2025 21:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKKhwScQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722DB8F6F;
	Sun, 13 Jul 2025 21:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752442778; cv=none; b=cM6VoAxmDt2UWNWXwov/7MENaJeTT9uf8MBzZRDyr9OEj/eQr9ktNTosuex181CF7LJcgKmhT38VXB4oFm8KK4rWeOPRQp8yr6YomCC44pck/pjet2MEQeyAetfPCA6AXfUoHI1wH864BUO9XkajM6DvzgctUjEo7n+GODtmAp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752442778; c=relaxed/simple;
	bh=YSrt0LWfWRdksY8QMUpEOHq0A5fYcLMOLZzuTkQ77EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyHilyas3AQuN4VmuwzFOvXw/H4S/fA4MP9hAxobndQ9a/adKb9VdCm6ZV7TflD4a9ppIzNnt/OkFHomvYVM4Uo9rnraNrRVJhBYGPMT/v9FFzgZor1cBIBAtyRCzm4hd4pNqOKvwusES5ECuBBQp+jubS6QoWpjz2wn1huo8wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKKhwScQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33189C4CEE3;
	Sun, 13 Jul 2025 21:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752442778;
	bh=YSrt0LWfWRdksY8QMUpEOHq0A5fYcLMOLZzuTkQ77EI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pKKhwScQ60kZehCCzPxpD1riC37iYnjOun1IfShAVz/hMcnx9gsh+jMnEh4uNkyBY
	 vCrEeVsMgjL+zMrGttJzaRuX2AqVTJFJgqK9iGC2ixyrlIAVz+Eb1ABKNAAw+o51JX
	 kdH6fAWgoQjrv+9eHWHT2B25M9xI6ZFwnpNYkpTpsbcn3vYhLzBlr9TRj5n526LyhQ
	 Esor5DNI3icOD9iw1LGAL+dmLiYpuEWhgC2zzo3PSMbAd4IeZPDMzTw2S8DWtkVpYg
	 rp1FB3iwAi9LncymKg5ri73EoTy50Tw+anO+nDsmVuFuWeqzJtFzcv7dBGov8P1+Pu
	 wtQKLWbmmh7mg==
Date: Sun, 13 Jul 2025 22:39:34 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Rapha=EBl?= Gallais-Pou <rgallaispou@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: st: Switch from CONFIG_PM_SLEEP guards to
 pm_sleep_ptr()
Message-ID: <176d79e3-753e-48a2-be9f-1994cf147cb1@sirena.org.uk>
References: <20250609-update_pm_macro-v1-1-819a53ef0eed@gmail.com>
 <ed9e407e-22a8-49e4-b1ec-0525265351a6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9LVPfmrjaXbSnfl+"
Content-Disposition: inline
In-Reply-To: <ed9e407e-22a8-49e4-b1ec-0525265351a6@gmail.com>
X-Cookie: Save gas, don't eat beans.


--9LVPfmrjaXbSnfl+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 13, 2025 at 03:56:48PM +0200, Rapha=EBl Gallais-Pou wrote:
> Le 09/06/2025 =E0 23:21, Raphael Gallais-Pou a =E9crit=A0:
> > Letting the compiler remove these functions when the kernel is built
> > without CONFIG_PM_SLEEP support is simpler and less error prone than the
> > use of #ifdef based kernel configuration guards.
> >=20
> > Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
>=20
> Hi Mark,
>=20
> Gentle ping ! :)

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

--9LVPfmrjaXbSnfl+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmh0J5UACgkQJNaLcl1U
h9DotggAhDi8EIVY4ETjB9iZMP8Td7WZ7laeRSuWaZQDVsXBHDkW9xWoR8cH+T2H
mb17c/GZ5+sMHsoayi0NA/ZoBl44tZJpewmQCd7NJKUkoPXDvncKIU2hpK98J3KI
IJVTSpt1vIJ8wL5BeKHui/IialTE2HdhSK1VABY8EBvMcgdAwnRw+VzbS/ndyy3V
9RQou7tkb5YEvdD+gjUNTS5N738aABPsi76RoVntxYpi2CteB+uNW0f6xhRc/aCV
v557WVFRxqizBESB4Ti1h2xuOb/FxH/rh2GM8o45U6bZlhFLXfj9s+lRCm/PyceK
+yeyClwfAaestTpsfrz0sIJqnmVlLw==
=2mVr
-----END PGP SIGNATURE-----

--9LVPfmrjaXbSnfl+--


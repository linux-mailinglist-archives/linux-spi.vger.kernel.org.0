Return-Path: <linux-spi+bounces-4424-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEE79643AF
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 14:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A531F2330E
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 12:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59095192B96;
	Thu, 29 Aug 2024 12:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ldaznfxl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2C0191F9B;
	Thu, 29 Aug 2024 12:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724932845; cv=none; b=o9ocq9MneWFIVqTvPPM/Zc7ePQkewT50STFSyAxMo9eHH7qPE/xl1Iw+6N8lhb3ShVZyKE39LmMbOJjtwz+Lj5N+3NK0dpt5hKlKiv0nlw9/wLe1XMceySEkEtv0SXNXe6rLrEnjwQD/GZsO+aEzBm8PaHHHWZ32lYL0AqBfBQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724932845; c=relaxed/simple;
	bh=6Ft/KL8L7LgfrsPn4DMB6dyWVmbt8YFZqfDlGEBBKeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwZ7wKj0IzRIt9JjFoadHHTN1kKaL4Z2BFTOHgE7mXvPbO+cLVUcDupduWgkLIFOKAOSgX55OMT4cSwTUQ4fhUbrKq9SEMYCcvHSR4aByX6vwzA97zVK0wtGoGcMB54hsJpA70FY4YbvQflPaS0DrtDhP2MinJxIMA3R9S5OGMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ldaznfxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831A9C4CEC3;
	Thu, 29 Aug 2024 12:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724932844;
	bh=6Ft/KL8L7LgfrsPn4DMB6dyWVmbt8YFZqfDlGEBBKeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ldaznfxl2LBMdXPQF/xQnyBbZU6H/f1ComEyOf2LvXHfJFPgMi26OGlFtmuDor17G
	 Fvb5EqMsLpdRyNA2chsc++YgEoL72AUDudCVNjebTeoc9WJHSXu/oy/NWK4ASd0vS+
	 h4qQQzrRhox2GLvS0kFL5oa7dmIzv9c5C2Ew0YT3YxQXsje1W6+aYz6sdYH59nXcFe
	 SQ9Xh6qQo4FaqzBpXu+EN2odzCIEQScAyEwgZvfV5M3KuUlE2g0CiRFM1zSyQ93Xej
	 WdnJ2hWrG5/TnIVBNvJxUpFSYSGKNcW9GkKENalokaswfdwAgajLCVfGNyl7IAENOi
	 6wqu0EgrvYcTA==
Date: Thu, 29 Aug 2024 13:00:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-spi@vger.kernel.org, otavio.salvador@ossystems.com.br,
	heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH RESEND v2 1/3] dt-bindings: trivial-devices: Document
 elgin,jg10309-01
Message-ID: <39934c0b-f98c-4635-8b96-e36f678c13e7@sirena.org.uk>
References: <20240828180057.3167190-1-festevam@gmail.com>
 <0d6314a3-75a9-4f21-947b-194eaf1fe12f@sirena.org.uk>
 <CAOMZO5Cjrj1V+qmheaOLkvn3gjQ5ocLodx5ijmOKha=FKpqoGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8df5Sr0o2HsxnqA4"
Content-Disposition: inline
In-Reply-To: <CAOMZO5Cjrj1V+qmheaOLkvn3gjQ5ocLodx5ijmOKha=FKpqoGA@mail.gmail.com>
X-Cookie: Go 'way!  You're bothering me!


--8df5Sr0o2HsxnqA4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 09:09:30PM -0300, Fabio Estevam wrote:
> On Wed, Aug 28, 2024 at 8:25=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:

> > Is there some reason why this is v2 and not v3?  b4 gets terribly
> > confused about what version of the series I might want.

> That was my mistake, sorry.

> I can resend the series as v4 to avoid confusion if needed.

Please.

--8df5Sr0o2HsxnqA4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbQYuYACgkQJNaLcl1U
h9BPxwf5AUpff60o8jZAUVsojvd3bDcohpFYfImunFESIl+amxSAUx2Hg/i2HO9u
KMYHDbwaI8QbrUX1y2TkxUWX2wI2f7PDjJnw2xfStW21YT8Y17pKLzln8CwtgItT
dnUMDjHftBKFWFKUGbntm5KEKpi5i4RYWEXSHuEDxBJOSrh6tUoutMhi5SqCSSGB
Y4d+wDZbz1g0hhym9NJHhIhMzjlC+LJ+9csyLM2/vMROln3r29z1LzbPm1YroIC8
7gIQUSW5isamRRbZCT04J5uJKfw+9zJn0Co3ZvZbsyWU2aWDg1IDq3JZ6cfm37P6
Lz0R+lBbIvMRkl26P2APN51mnER8iw==
=fwdq
-----END PGP SIGNATURE-----

--8df5Sr0o2HsxnqA4--


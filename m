Return-Path: <linux-spi+bounces-4123-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5325494524A
	for <lists+linux-spi@lfdr.de>; Thu,  1 Aug 2024 19:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08F111F2AF74
	for <lists+linux-spi@lfdr.de>; Thu,  1 Aug 2024 17:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480D11B8EA6;
	Thu,  1 Aug 2024 17:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="G/bhEbg1"
X-Original-To: linux-spi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C6B1B3742;
	Thu,  1 Aug 2024 17:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534781; cv=none; b=NYgzQu3+8V3LxkjbKKTunaNfdN9mmQF8SPWN5Apk9TMJnUVLReAxUy1uRZGVEYYEn4W3+MFdTrap9EfH+n0l1r7908fTY9JJDuNR16/w+b90qLEp5IeP1xpT3zueZ7fB12hhDK2yfZ0OmbBdZ7sFw76DPUrp664OWRX2/PaQPd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534781; c=relaxed/simple;
	bh=plPRch7khvdAriYZO0F9005i5wgrSxJb/YiEPJWYkFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohOSFy/artks2sJVKWtBrptz2loUegFyNrKdTA5TpHH5VgnrH6DPqHf75DOlJbmdVIFPMKoN9hHoyxSEYv50JJtyQ8Py6mF4v6KPq6NkN+Dioxb0G/rWGqMEwTOlAgRpfm5byl+8jq/dMuMzlwO7Ywt83DyXp/zF2a7ilD/7gBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=G/bhEbg1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722534777;
	bh=plPRch7khvdAriYZO0F9005i5wgrSxJb/YiEPJWYkFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G/bhEbg1eVN3rqNZzOh80+QsuKt9VtBremwQMBtx5urDTORG4Fx6F+wMCDpMIZfIc
	 2mkejcpQInq1yKR6XbpgR5WIKQ132JPwAvpRH1ZXzXOejsBqq0gl0f4buhLs3+rbQ2
	 uigzrA4eqyWpY1KdbucqiM+jUYI3DTLQX4v0BkikCVI2vAPTjaJaQOh8YIqpyJGfcW
	 TAdC84s5F7klp5+rTwp9avBKKJC7z9JG8rKzQ5Z7iyxpNJmDh4NT83xqVBrB8AsXZD
	 /dbEQw3imsPrqJniqsXZdW21lnYjiKDX9pAu/v2skFrgUmeX96TAdCfhZPMjbLJntf
	 FZC/DElIEujjw==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 95623378000B;
	Thu,  1 Aug 2024 17:52:57 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 3E709106097C; Thu, 01 Aug 2024 19:52:57 +0200 (CEST)
Date: Thu, 1 Aug 2024 19:52:57 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc: Lee Jones <lee@kernel.org>, 
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, Mark Brown <broonie@kernel.org>, Urja <urja@urja.dev>, 
	linux-rockchip@lists.infradead.org, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@collabora.com, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: rk8xx: Fix shutdown handler
Message-ID: <wad5fdqxwoq2wy35wbhwk5jinpgyz6xmxnt5aqddci777qctsd@qay2lr2ubkws>
References: <20240730180903.81688-1-sebastian.reichel@collabora.com>
 <c4d6da27-3b23-4a96-bad0-17f2392287ef@collabora.com>
 <22969419.5W6oEpyPa8@diego>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sjgkp6qu6zakxj2y"
Content-Disposition: inline
In-Reply-To: <22969419.5W6oEpyPa8@diego>


--sjgkp6qu6zakxj2y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 01, 2024 at 07:41:44PM GMT, Heiko St=FCbner wrote:
> Am Donnerstag, 1. August 2024, 17:31:33 CEST schrieb Dmitry Osipenko:
> > On 7/30/24 21:05, Sebastian Reichel wrote:
> > > +	/*
> > > +	 * Currently the Rockchip SPI driver always sleeps when doing SPI
> > > +	 * transfers. This is not allowed in the SYS_OFF_MODE_POWER_OFF
> > > +	 * handler, so we are using the prepare handler as a workaround.
> > > +	 * This should be removed once the Rockchip SPI driver has been
> > > +	 * adapted.
> > > +	 */
> > > +	if (is_spi)
> > > +		pwr_off_mode =3D SYS_OFF_MODE_POWER_OFF_PREPARE;
> >=20
> > This prevents the syscore_shutdown() step from execution. Is it better
> > than not powering off?
> >=20
> > I'd rather skip registration of the power-off handlers in a case of SPI=
 :)
>=20
> Or blasphemous thought, we could live with the warning-splash for a bit.
>=20
> From Sebastian's log I assume the WARNING comes from the
> wait_for_completion() in spi_transfer_wait(), and I guess the transfer
> with the poweroff command itself will already have happened then?
>=20
> So the device is most likely still powered off in that case?
> Not sure how much of "bad taste" that thought is though ;-)

Yes, as far as I could see it works fine (the splash from the commit
message is from exactly this solution running on RK3588 EVB1 and the
board was powered off properly as far as I can tell). But it felt a
bit strange to knowingly introduce an error splash in a fix intended
for being backported to the stable trees, so I switched to the current
version before sending.

-- Sebastian

--sjgkp6qu6zakxj2y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmary3QACgkQ2O7X88g7
+prEYA//Uzr1RcaVsc7UcEd+nR7XbTVEUENkCiIRu3A94zcGi/bF5oS11QxvbLvY
3LaPGcAdLg9goCYf4umh/k4lUNrFrlPA5733nLg6XTl3IWoeLTSLrpsLOWLGELre
usMKLB+ZbJsmWY9h0YBD6x8tru8d30Zi6DU90oVq4bJXUFLyfVxoFunUwD2pp1Zo
59FU6xPMsncOf/1tecfIIXTYUfREjBU+mzoY7GRaHhk0H4hSZ5Ubn9xw3kOoPeE4
55sQnmjWUWHI6CSpdDtnbGIDR0p2pQfpbEpJNyR+exvQWj/QlWvCJ1/VfoQpiCXC
LHXQeq9QiXcdHM/u39yZIhrVD7CokAyM/DDKnYCnV7T41vLeYB/+LE01HQpnIYyq
pcGM/BlLgOer/BLuwgkNYxshmqE75+BLaJxfA6Weh4Lkd1V3QtIxn6PKL4cFAdtS
c2FHk3qhHHdKhX2Ruy0WEiB96zCaBITsQm9EAiUrin7VzrYxxq69FA2LFRiJcRpH
PihEXDhRFYe7qEmIXzOa1vhsKvH7FFqfjTUY+dbPFzyMXwSI5iOX4FKYBvS3iNtj
b+UY2HpaWLs/vlaCiDGJT6q656KcShB0dQkZKNmfNL5XM2S8pAzGqbjpAdt2IYlL
5kyFxnwWs268HZ7epaey/dRkajBiUI2WJGsOIvg9L0d0LrL4T+Q=
=taLl
-----END PGP SIGNATURE-----

--sjgkp6qu6zakxj2y--


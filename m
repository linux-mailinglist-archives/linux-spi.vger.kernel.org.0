Return-Path: <linux-spi+bounces-7302-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE26A707A9
	for <lists+linux-spi@lfdr.de>; Tue, 25 Mar 2025 18:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78B917A4C34
	for <lists+linux-spi@lfdr.de>; Tue, 25 Mar 2025 17:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C811226139D;
	Tue, 25 Mar 2025 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsStRpa7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C114259C9A;
	Tue, 25 Mar 2025 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742922336; cv=none; b=NmcRF0xH8hBgfMqf5Sf3JL8tAoCIY08up49n+K7AwbysLMWtOHc2ip4tqkU3vhvLQHB9QwOC5jk41T8+3Xqe7OogufbdQUcaJyzaFptBrkt9aKw4XUAgOQ1asLpN2sIJ9Gh19T63LZctSNt/+zNiI7xC06+7OfhRq7UK4nurZpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742922336; c=relaxed/simple;
	bh=5yU3u+CDnmrMW45YgaIsW3e5UapxxBK5S45/SpyHRmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWHFJw7eKT4WFMe6YdFjvfDwL8zJF5brn6rwMGIepKIGMbfA90TGIOiGiSSTk1gE4SJDF6qrNHktjrePCsptDQuCIxbHuAINbkggBa9ubH0YEq7AKr+K0ZDKjtLPejcnZ92Vi1NmoZreZPEGjXOwCNWc9kR2awNGiCe6urhL6wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsStRpa7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so56740415e9.2;
        Tue, 25 Mar 2025 10:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742922332; x=1743527132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=shudnTnMcZQE6Z8Abv989lI4tjn5DVI+u4yjqvP2Wak=;
        b=QsStRpa7OoBYVRkqsJGLPBkbI4bGoqQHtVrTTls7J98tFJtqEZe0tqBtAIw9/bSLZt
         eZ4DB+4LrQq2BFug10uvLZcAV8ABviiRnf7VIZ2XqAwiiitxf39xF/uTQguLYRI/jhwk
         9/pznyVMmif875OIpXBMeKZJp//5jXAQjoneEE2i6xgoI/b+Ce5CopcACHuQExRSsQ6t
         RDXZC43v4FuwU1RECXXW6aS/3auKWeCyy+umm2K1TGXiUfINcqj/xPEu3eLTGEuuRETO
         wDPru8REs4jTtKIrvlh0UiMT5dsTux412sTt/XVfVY6mNZNl2Lb2QqemufpaNMgI9QaY
         XV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742922332; x=1743527132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shudnTnMcZQE6Z8Abv989lI4tjn5DVI+u4yjqvP2Wak=;
        b=EB6BIjHlE4s1Wbbg4Vw4Sg4013OL/58Dhl6MwnUaITlJz5H2Rl0QdZN2r/fMnQrDWX
         LfJw+Fa0hs5l04igqfmc0um6hOz3cenMMSlCWl1U0I5HlYN4L5emZ4hOkpJKjuCHa8zd
         oz2se+kNVygb8ZgedrRqCpxY+XwBX4pxgJzsImF+t9EvXli++gLg8J+6evbJXDOlDBGz
         YYaJ72s4qf4ZHTSipmZZ/1zfP0pavcSbsVYf5rhHu54sSJE7SpUlRJoUb6KbeMvms8BL
         InpkyuS6OBJrF0QyhSXJz0wvZjbIdQAT1XqfGbnDWoD9gLPQpZqHL7r9pddqDBjkdZxL
         tKlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUG25Fgq4VK5bEku0zJfFu07r+iTLZ4hDAuqSrlEietqvtSpdQywJ2XCN7TbI+/Yk8ccqlnmtieUW8Sc0=@vger.kernel.org, AJvYcCVPlXlAjG8i3Eb5Rxw30s/0ZiWFQZ/J81I50ozR1YFfdcdsjz/dlKxkPhtdf/dMHX2lPPmYAuF+MR1+gDo=@vger.kernel.org, AJvYcCWHd5Nip2T9GDKhSTdSxjYELW/OXQ2Duua55tPRTIEwDSu+Aaix+PBFqtpW5+fDeXN5cA/4eaPoLy4p@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8tqzI+pB5H6fiNk7STYCIZrtcf6tlQ+mDmokdfB/v+BWbYkJl
	YOndSgIXu4JT/KjgLWB/ceoa1NIZPcFvsV7SNhc/fxoOjmGp28Tp
X-Gm-Gg: ASbGncuIvbK7ecyDL/6DQpMNXUaSNNrwy9iia/p93KU7VdDbRFnyYK3wLmSPFGXxNyp
	lv7TO3ZNR3iTR5/X5GIH8SD/JKaNJeE/BI2mnfggZPy3S0Fl4q8gLrzXNNykUPkC/Iy932af+1H
	JfAyIxcUpKVpQKpznlqAdBv1qTGRkFvP2kaXyOEcSMr4o5gpPMPSsJ+xR+yCf8Yyss4/ZseIHRq
	l8AxAnH4g5T2cxLJ3euO7h4/siboNm6dIU75yjFvl7jGTkpZ8UnsdaPeuQxqU/ZZn4AA9f0Mezr
	0upnqirNRGDkV/mK22KhGO9Xoqi4Eld7KnFkztUK7kWS/dT+cE7R3NGL8hbPbrwDYhnwzfZ4JZM
	mf1NTP6tGMohTWA0l3h68He66E0rQTcM=
X-Google-Smtp-Source: AGHT+IH+WyIZBQj+Vj+WtPbkhG62zV8RdAY27GOJQfguy+1ko9FaZxHVtxJcEOQROc/QWxyxavF6xQ==
X-Received: by 2002:a05:600c:3c9a:b0:43c:ec97:75db with SMTP id 5b1f17b1804b1-43d509ec467mr188395925e9.11.1742922331833;
        Tue, 25 Mar 2025 10:05:31 -0700 (PDT)
Received: from orome (p200300e41f4bef00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:ef00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fceacf3sm159465055e9.3.2025.03.25.10.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 10:05:30 -0700 (PDT)
Date: Tue, 25 Mar 2025 18:05:28 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Arnd Bergmann <arnd@arndb.de>, jonathanh@nvidia.com, 
	skomatineni@nvidia.com, Mark Brown <broonie@debian.org>, 
	Laxman Dewangan <ldewangan@nvidia.com>, linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rmikey@meta.com, kernel-team@meta.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, noodles@earth.li, Jarkko Sakkinen <jarkko@kernel.org>, 
	Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH 1/3] spi: tegra210-quad: use device_reset_optional()
 instead of device_reset()
Message-ID: <q53apce4sltvnyd75j4o7taatocxiduq56fqsoxp3vrjmaqphk@o5kce2wb3dnz>
References: <b3da27ce-161b-4462-a608-c36f4b0696ce@app.fastmail.com>
 <fbeca9fd-38a6-49ba-bb5f-6df5302d139d@sirena.org.uk>
 <6cf8af69-634e-40fa-af45-912540b29aac@app.fastmail.com>
 <20250319-aloof-rottweiler-of-perception-4c1ad4@leitao>
 <5doq6itaz6uicvqcn37q2dkaxyzy3etz5qgv6wlsyd5troqlag@yqs6ltjp3gsz>
 <20250319-unbiased-rousing-finch-95ecdf@leitao>
 <ac44uxpojpov7fcdx3qfiif3idhbp2hrrr4efqeat6jazbosv4@uoy72g6u3ibf>
 <20250321-colossal-binturong-of-debate-055aeb@leitao>
 <5dky6i7v2ml3eggy5slmxcw2rqi5xofcan2uqx7alcvh6744cp@el5ybhfevgfg>
 <20250325-delicate-kittiwake-of-emphasis-3eeb6c@leitao>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ns4kgdpicpewaf7y"
Content-Disposition: inline
In-Reply-To: <20250325-delicate-kittiwake-of-emphasis-3eeb6c@leitao>


--ns4kgdpicpewaf7y
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/3] spi: tegra210-quad: use device_reset_optional()
 instead of device_reset()
MIME-Version: 1.0

On Tue, Mar 25, 2025 at 09:56:10AM -0700, Breno Leitao wrote:
> On Mon, Mar 24, 2025 at 02:17:11PM +0100, Thierry Reding wrote:
> > On Fri, Mar 21, 2025 at 09:28:34AM -0700, Breno Leitao wrote:
> > > Hello Thierry,
> > >=20
> > > On Fri, Mar 21, 2025 at 01:40:44PM +0100, Thierry Reding wrote:
> > > > Can you maybe help clarify at what point you start seeing errors in=
duced
> > > > by the recovery mechanism?
> > >=20
> > > This is after a while. Something happen to QSPI and the warnings and
> > > device reset failed start going haywire.
> > >=20
> > > Most of the machines are fine, but, some get into this situation.
> >=20
> > Is it always the same devices, or does it happen randomly?
>=20
> We got this in two different and unrelated machines, already.
>=20
> I want to come back to how the driver should behave. We probably want to
> distinguish what is the correct behaviour we expect from the driver,
> they are (IMO):
>=20
> 1) The reset handlers are NOT optional and the device should fail to
>    probe.
>=20
> 2) The reset handlers ARE optional, and we should mark them as such.
>=20
> Can you shed some light on what is the right behaviour we want to
> implement?
>=20
> From what I am hearing, we are more inclined towards 2). Is this
> correct?

Yes, I think 2) is what I'd be inclined towards. _RST is clearly not
available for at least certain firmware releases, so they are de-facto
optional.

Even if they are ever implemented, it'd be wise to keep supporting the
case where they are not available, so treating them as optional is the
right way to go.

Thierry

--ns4kgdpicpewaf7y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmfi4lgACgkQ3SOs138+
s6FTsw//Rr2WFvIKfBSUnUczfzuuyb5HL1n3pO1Q4k98xGr+txHsXECM8GhkBdZo
MSnZ9EN2sd3/2yodGUEPPn3wURKBLzWac0yyoXvaYbm6S3/XjAuSEFQLPd1qeLbB
5VzH+8FKqqVmiKxSPP24CprLdkjNA7ChXAnzoFyk6hmofx4iqm2W4uXvCDcfENDh
U/ogU0SMTcFAjuG7pI9RtQpTJZwQfctECWgLpK6JVBvLuEzzYBgrYsmO0u5TkHbw
DRCy96Bbt882uJeWUpHMxmRCBYmj/DW1iKFE+09ZIyeXGV4C7dHiawNFIhSnAnWl
Jv407cE9JVZtuoNLU4wBhtSFaO209Xe9Bcmd1+BrJKsixfEdD554Ok6Ae+gK+icU
3Ev7ZV42t7Ab/UPcaQOarjBCCA2UduajFOTjQFUMJIPThzw/ag6bVB38wDJyuV45
hKNLWhs0cr9JlySnwGDdGHlG7NtSb2IYkutNHSWs3w45SLPlBtC5XSGTdsLijWqs
pLoAZ1QTZNO/KYIvL+xt6HDQMbX6WoMxQm+4kFAextSt/WMpcXtwcvWuT3bnKxDu
NuezJdAMfHpaWPkRwSHej8uNWJCotW5SeFrbCr0VPKxa4jdliq23H8t3WjuI+TkP
rTY4OPiOHchuwOEWjYolb8Z1qBNpUlX5cx3xw/tpIsVxCkyK0J8=
=FbUJ
-----END PGP SIGNATURE-----

--ns4kgdpicpewaf7y--


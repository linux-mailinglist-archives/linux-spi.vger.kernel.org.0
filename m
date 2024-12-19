Return-Path: <linux-spi+bounces-6118-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A489F76A3
	for <lists+linux-spi@lfdr.de>; Thu, 19 Dec 2024 09:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC0F1883F41
	for <lists+linux-spi@lfdr.de>; Thu, 19 Dec 2024 08:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC84C2185AD;
	Thu, 19 Dec 2024 08:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TJNRhKeP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0005321858F
	for <linux-spi@vger.kernel.org>; Thu, 19 Dec 2024 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734595355; cv=none; b=Kf19SCRmxJfxLmiI1HztnK+MHCfCaLCdnWbmo3cAAFVuQbuaQ8V9laTU5CtoStp0uj/M1J6clFJEbAf194l+IbdgolqWYR0UO1XAEFIf0VjlyEJK+IgT4LTp1FGTjH06dnRB0UWA9QNpXDM2waDBld+KY37dB6SZDQsoIHeYo38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734595355; c=relaxed/simple;
	bh=aiwLkYq+DscnftUiJFmweOP5DVdX7e9GqJStU8U3NNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYVSdc4ZnG+JHEdF78ZVb9wpHbuvEoHpRHNkruvzdRS01gz7W4DFW4cG+R0NLp8QJ2lWsg9I0YjnqgZsfzYZGCxUVb8zPfOSEpObUMVcy2fWCtkm6dbVlUDur4n+7POYYGiyhRUysTVRKNa8a/G4t7VRNM9uSAOaCWXhGLy28gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TJNRhKeP; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aab6fa3e20eso77781066b.2
        for <linux-spi@vger.kernel.org>; Thu, 19 Dec 2024 00:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734595350; x=1735200150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WjUJ+MgYS+D2Xi48xGpIDu3m6rTpWdtuQ0fvl1xZJvs=;
        b=TJNRhKePK7HuwPeaxRWFcTWfVWmg88DjEY33NSOp2EElODS4jO0VLfEi1Iq+f79jF1
         zXl13JdqLcEPfsmMRUzHhNGShe0ELanmbihzjo4QNKmBCQPXhGyoax39Or8BcqIWw7rg
         Syrqrbkf7Cg99Qh9Ln8iGso5b7CSLk+FgI2DqDQYLZmBbDGL1A0+RwMi9tLdATMsT/07
         yrJ4dpyYneDVDmYVbaWGqXxG3ILQfc/g4hnRerTii0mApymwxqMWcjLwI7zBpQsWigEO
         7/9m3D8UEb4SCISbKIdRo0nUxGFFyww/QN+CA5ui7eTAMIG0Bzdps03TxBAgoXe3RIT+
         YOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734595350; x=1735200150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjUJ+MgYS+D2Xi48xGpIDu3m6rTpWdtuQ0fvl1xZJvs=;
        b=h2NVT5ATq6ryFlNlOIZObVndD4bEVZyAlMyqLe2Jvm91pE5gHdCSJLuXnIIgeVfHKX
         7tbC84RwELLVuQBE4qrG6nKTw2UzLs3Uwn2A5vRh7RVJO7t0pctQa6RsP1Agd298Chwo
         OMIfWiti6zfTp3j3vgpSysJAfYEPBHyAu9wttitCAhBbmTJ7fLXfQ4I3wY12x+7O+B3E
         wIBtRH27mlU9Z0TDQh65u20T+wmXC5IKaCLpq+283CGku84TJvT/RjYOvNrYu57OJ7OI
         rAbdK0VxbF/MeFwvCXadb6FpqxtGHaS/9U3a/dzJ5I+xUl+G1jXzmuOVJ/MV1/bylRPo
         qWmw==
X-Forwarded-Encrypted: i=1; AJvYcCUCa1iWi2kupF9TBFR0xQsZEOITEiITJwON+8GyQB2qEVmJDCLa9/5RACDjWHGPfTgB8eALOAqowsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSCfUqHxOnxnIu5mBSGmy6gqMBOAuuuV8D2Y/fJBGxirONc8Y0
	T+h1Ws97F8C0hLoNw+BEmRym/xvQJOrDwuluFK5Yl4F1Ly8unIpFP+tD/ZUElYI=
X-Gm-Gg: ASbGncv/AJpEeq91A7rtXtnuT1bpLGbK/dmmj+eAwo2W06bQ10UpjDhxJBYY7E5EGX1
	+86xYNJ2TNANuQOdPbNF+eI74hfeuQz0Lk5MHEYnZubAWsDOMUA8VI95y3oxH9IS6Bf49znVp4q
	Eu8tOuTC7X2oO2su+BprrqT0XH/kXKSWoyh3lHzwgDWqDsZTPd9Qy6iPGHczLc+/Yb0Rc6h4NLn
	WjZRXi/a8gNZtt01SBGric08EvdfDhP4paRxJma0AENp8wAkFHOrNM1ThoJqA==
X-Google-Smtp-Source: AGHT+IFymixMAnkWaX4fV/aHcmRiFHDGFHrEcU4QbpNBo+9WLjyyAuyOz3fKyaLCYItmz3NSHlLhHw==
X-Received: by 2002:a17:907:7842:b0:aa6:7f99:81aa with SMTP id a640c23a62f3a-aabf46fb0ddmr464097066b.6.1734595349930;
        Thu, 19 Dec 2024 00:02:29 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f0159f1sm36823766b.154.2024.12.19.00.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 00:02:29 -0800 (PST)
Date: Thu, 19 Dec 2024 09:02:27 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mark Brown <broonie@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: spidev: Align ordering of spidev_spi_ids[] and
 spidev_dt_ids[]
Message-ID: <o74qqp36r3mgdk7muqtc3zqp7dkqqixfutirf2eeniatckoxw3@pjgfaokp5rvv>
References: <20241217114226.1223724-2-u.kleine-koenig@baylibre.com>
 <CAMuHMdVzyq6L+9iNhtSdGpAJOKyu2vkzvveHXt0in9xUhD6mLQ@mail.gmail.com>
 <tk6wlbylk7aqfd3sys2jitpnbdz4xomdg2yr7hsppxyptgbek5@3vtvajq7krun>
 <CAMuHMdU0FjXBgFLUxxvQeODPsU8xf+LAdQCg4xpAn_omJeA9WQ@mail.gmail.com>
 <CAMuHMdUEXFFXt1EkGafv+-arG4x4hFQMGO6E14O7zguyGT0kmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iae6gilcnvvocmsg"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUEXFFXt1EkGafv+-arG4x4hFQMGO6E14O7zguyGT0kmQ@mail.gmail.com>


--iae6gilcnvvocmsg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] spi: spidev: Align ordering of spidev_spi_ids[] and
 spidev_dt_ids[]
MIME-Version: 1.0

Hello Geert,

On Wed, Dec 18, 2024 at 08:10:57PM +0100, Geert Uytterhoeven wrote:
> On Wed, Dec 18, 2024 at 8:02=E2=80=AFPM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> > Further improvements could be:
> >   - Generate spidev_spi_ids[] from spidev_dt_ids[] at runtime
> >     during module_init() (consumes cycles :-(,
> >   - Teach the subsystem matching code to strip the vendor prefix,
> >     to get rid of spidev_spi_ids[].
>=20
> Oops, and modutils, as the tables are used by userspace :-(

Then how about a build-time check comparing spi and of module info?

Best regards
Uwe

--iae6gilcnvvocmsg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdj0xEACgkQj4D7WH0S
/k6hvggAn3PAeIFwyYl9riUPLS9NWpF9sOnVDeR0Ea0n68f2ausEOB0dT3pwkOAB
78b6+1g63aWHLwWg+ApMzpHBjjJ3g4b4Gb943pwJltFLlp+8HeC3d5C4dO7RlLrJ
ronMmdgAjWxbYdwUN0DKNIZw0r08fHFlWvsGGlZxGjPD1g3EyINP76a1/KZtuptP
OVHTCtpYp8ATJUIG6oBRD9WZLzFA3cq9iG1yduU6h3EvbE2dWSd0FpPEj/Mti9gU
K5LuVJJirJzw4yFEqtISZ30XQYLnHeEidv61FFU6Bg82CLBrlxtz/Or4aSd/vJG9
4055gUvxn3RBIbBsVjKOhKTDR4Uo8A==
=q96t
-----END PGP SIGNATURE-----

--iae6gilcnvvocmsg--


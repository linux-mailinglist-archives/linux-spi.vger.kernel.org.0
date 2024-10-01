Return-Path: <linux-spi+bounces-5074-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADF898B509
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2024 09:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95426B20BB3
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2024 07:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CF1282FB;
	Tue,  1 Oct 2024 07:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nu7Q59sY"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CC12F3E
	for <linux-spi@vger.kernel.org>; Tue,  1 Oct 2024 07:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727766079; cv=none; b=BmvekdRYk2oiumZ8eaY3dmXUrtmroQd/3NyQabCA6bT8IbrBzpNvRjtLYDBUIHaQMNqHEgfWtQ2CXjTFCVagTICs/2hFFwbkc1tYLWgIImTtFEDl2psqrEnsidYvEvf9WHyIFJaDk6RRfELEHgOtuIk0qmLsXyrdqffGiveIJq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727766079; c=relaxed/simple;
	bh=9JRY0bFr+/tcHojOjx54YfAfpBuUyjuS4Mt8TdXeU0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3c0DOFlPIWQWIg3ABkmlHlvvJL9oRzpOQzsVA9BPKhzrSXYJ/7+kZ9LIMp+DPtltvkIdFSN5vmjxYrq65Y9f8cT1DtZTdoRvAPqb2MxpSoPwtWjT06p+kz/Cvuwi3e4XwyoOJ9ZQQ3MUgYDjYl8nfsR+IgXWKnb4UFA+PkfqxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nu7Q59sY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cb5b3c57eso46939935e9.2
        for <linux-spi@vger.kernel.org>; Tue, 01 Oct 2024 00:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727766074; x=1728370874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BuO5BtxyDdcEHBQ7ooD3RwGrujD0zyqCtMaX60eVcKQ=;
        b=nu7Q59sYOKghMkcR6wzm6qXdiD1tABtBN66N7MEzujLc6lW2GBA6I4th/aDpCtZ2pF
         9CA8JTxu/owzLgqL39UVFsqbHHInYe3LPhBhUmnB7RkDuYB2ncmj5+XnM2zE5MnYA7Fb
         HpW3FJBhH72PeeWFHA1F/RlKIyRzXMqI8aP3rQdztHav/cH3gCQh07WIc2T2TBQ28ie0
         bvNiJYQ8ttBkwkhaP5/DuyZvC9gHk2f2GWsRzV9Hmwr+E6BkENV3mF1472HHL3+vK50q
         ynC7/yIqWHgq+tgQNz9+1cg9LZjfPI5aBT4vIwXnmLro2DDnTcLKXCRm3kiKFQb7EEav
         T37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727766074; x=1728370874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuO5BtxyDdcEHBQ7ooD3RwGrujD0zyqCtMaX60eVcKQ=;
        b=R2oL4P/BV9F+p6UAvmL9zh6JNcUwbM3Pl+HGGLbCGXW7Hm4Gkrefa6uInvTdTKq3Fv
         LUxpdjkRM/XGEMZZPeZzqaNt9NUF0ng+zC/PvRLaH6kwJCN6+55HLVjiYRHUMp1uUzJQ
         9hPy3VSI0DsQnGhXK+T1aKLqV3w2uQ9sh0nQnrx2KXQdIC+Yc4hmzxKXH/dD17/w04mn
         CxmYkEAtg82r8PnMHZ+IyOAK24RKWK8Da1GDFtsOSPdRm4HqoqfgqgiG+z79FRVIDkn4
         HjqwMJ18b+PFm7rpQOyOH5vcm9N1aPhQRqbCwbyV33alMuocPiSTTl0Je7/761y27G/v
         d8bw==
X-Gm-Message-State: AOJu0Yx6rq7rl8vEMZrbeAnVFTLYUc4rnhxYY6Y7AThYUjzHX1FPEktE
	SCi0mtT2BvBySauPUreXmaIzFHr1CidEG1dRn0mcEOw58YfKSYj1+2ICuicl6eD4f/IS0u8vA/J
	s
X-Google-Smtp-Source: AGHT+IHSmr45yafOPUALwBLjRrfAkGvIlTow4na15wgxiFbhuVE6Kd1W38wzdiyf9822sqBHvdPr9g==
X-Received: by 2002:a05:600c:4451:b0:42c:b7f9:4bbd with SMTP id 5b1f17b1804b1-42f5848819emr110497455e9.26.1727766074103;
        Tue, 01 Oct 2024 00:01:14 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:16bc:53c2:d875:4357])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969f23d5sm175130825e9.13.2024.10.01.00.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 00:01:13 -0700 (PDT)
Date: Tue, 1 Oct 2024 09:01:11 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Subject: Re: [PATCH] usb: Switch back to struct platform_driver::remove()
Message-ID: <oaiu4632is6qr2oo5lelwfkws5uyx5vt7ffzickc6gu3xcnedq@al2dgegf7osx>
References: <20240925113501.25208-2-u.kleine-koenig@baylibre.com>
 <172773252710.2210210.16049963643059937141.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ban77yewd4cdz34t"
Content-Disposition: inline
In-Reply-To: <172773252710.2210210.16049963643059937141.b4-ty@kernel.org>


--ban77yewd4cdz34t
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Mark,

On Mon, Sep 30, 2024 at 10:42:07PM +0100, Mark Brown wrote:
> On Wed, 25 Sep 2024 13:35:00 +0200, Uwe Kleine-K=F6nig wrote:
> > After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> > return void") .remove() is (again) the right callback to implement for
> > platform drivers.
> >=20
> > Convert all platform drivers below drivers/spi to use .remove(), with
> > the eventual goal to drop struct platform_driver::remove_new(). As
> > .remove() and .remove_new() have the same prototypes, conversion is done
> > by just changing the structure member name in the driver initializer.
> >=20
> > [...]
>=20
> Applied to
>=20
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-ne=
xt
>=20
> Thanks!
>=20
> [1/1] usb: Switch back to struct platform_driver::remove()
>       commit: 494c3dc467768782f93f1433650c56b08feb54ea

I had some doubts if you fixed up the subject (s/usb/spi/). Funny how
your reply works, 494c3dc467768782f93f1433650c56b08feb54ea has "spi:
=2E..".

Best regards and thanks for the fixup,
Uwe

--ban77yewd4cdz34t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmb7njQACgkQj4D7WH0S
/k4kNQf/b0b1QtgeG9OUanhLMuqPlBrR3oEK3JediWLmdZPis034Tca0xGo/nAf0
bjyJhRgdTbV8a6k8SapbdY8kL1fzifH2TDjJ9U601d+7V8twumsDEXlmPuhVuut1
14su1rCz2f0IfXQ0r2us2P3mh5k6b65op0Zl8NTRR8RMk/RRdBm9HGk6siFb1PRd
LRZBTMq2VofI90Vw7dZbKJdQq76bIQmW0W7vR8iTkLG36GBzpZ3kX4YJVTe5Uz25
R5h4ZT5BaNEPQVquSXus+etompjAoOqaroKP+4Cm3TqAp8CEZBybysucM7nHZhel
xVExSLLSPhlbiaoE4LR4qPqpyjUYfg==
=IkWD
-----END PGP SIGNATURE-----

--ban77yewd4cdz34t--


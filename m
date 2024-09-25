Return-Path: <linux-spi+bounces-4959-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048E2985A30
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 14:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9CA21C23814
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 12:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B3818C347;
	Wed, 25 Sep 2024 11:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Y1XkjUD9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F141B3B09
	for <linux-spi@vger.kernel.org>; Wed, 25 Sep 2024 11:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264511; cv=none; b=jWrH3psVQwqbAZPT7l6uckiEiR2mkBWcnGCJIN0OYQquYsBuSEsJnvh7WLBO8THILsY2pepIoP9996q+1c2M+ec7zsfN1D8g2uWOik0dyhHqrM3El1z3XZV7gbzGRG0QBDT41/X3Fkqj1T7EGY/zOAFd3sRffvzrIQJAQG5y1DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264511; c=relaxed/simple;
	bh=Nkl4nJCnOUhZme7VISS3TAqcBwgiJbdcajccxTweDjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVahXGeebYhyofisJCONFGr/MFwj1nUq1U/j4BMlgeOB9gQ+s8fvki1cGAY6LPEF//5xshumx6pjdl+m0/hNuBof9WHd0JhXXO/dQAcA5qPZeBHMcSb1bfofP/g5AbIg610uJrizuLHRkESdMta0Rj8UDGapafLyDuWtgV3oAdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Y1XkjUD9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cb0f28bfbso57700095e9.1
        for <linux-spi@vger.kernel.org>; Wed, 25 Sep 2024 04:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727264507; x=1727869307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nkl4nJCnOUhZme7VISS3TAqcBwgiJbdcajccxTweDjs=;
        b=Y1XkjUD9gf93P5Na2SEalBLljBqpdcTcSNaoJY2ubQw0u1Byf0+wRYHm8wq7XJlX26
         jrkheFrmQZ/byX0Q/aOcXR4LvkUX995p+CS0Ita+4Sm3E41xddSeeCoR5rmqak9Xg738
         N8RhgsQ4pWTrn+KtxngxEPQ4diUVa2aQ19lyayXyv1apr/7PmzzalromgMruMRMfoTDP
         cFVxjj+4+9SP1D5bLeeNwSd1S3wqeVegnItgMBS1ixsareJvyjIK4fM/2YwAFRPZyON4
         Pm1DJNF2LWeDS1HdJxqPO2vYCQZbm6RiXupGFaiHwbs8WmFARhD/hdNT70f3nU4NmWaz
         BECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727264507; x=1727869307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nkl4nJCnOUhZme7VISS3TAqcBwgiJbdcajccxTweDjs=;
        b=dn5BQIW/e8uDNtSSdTv6qUSaYI67HikTMEOr8YPKVHUj8bLOaMQgrbiqtC79RGlmgy
         LRBJZKBI7pIQ791MYcBYGZMe1RQPBSkO2yrLT0oR+0EI6iow+9B5KbyskvhEghZTR7S3
         mFYHeKkAqkt8pIX0RTnft+i+fddvLIoEBYonSzxvj6HNJaBUTVhrVaPcdeuwM5euWTub
         lnHaQ/zEn9RrbaqR263ppyc2UEzVudLQLZrmDh2zr3iTSAyhYSn6I/IYyI2txTkVgMBW
         X0fPYEIC2aMC+Xv5eikcuZ/bX+YlGV2L4f6ZArrYKK4URoWByCAw72Wx4JjlptUdMvEG
         BwQA==
X-Gm-Message-State: AOJu0YxkXUQDm8dx2tlRErFwgVv/MkEyKvWxN6Egia5ezbZdubQnokSV
	FNBMOCfknQoGSR+gwrU+RmEH0teqo8pC/8pD89ks02SddHUJ2J8uQxg+WV2g1NyiZ9IN9jlMayt
	D
X-Google-Smtp-Source: AGHT+IE55jLga2qshKlqf9/8pAlszeHARF2Wc/G0dCf4BjreZcgEjl9jKYgImj2XpJKBrDE98XgdZg==
X-Received: by 2002:a05:600c:4f8f:b0:42c:b2fa:1c0a with SMTP id 5b1f17b1804b1-42e96145ee1mr16289685e9.23.1727264506725;
        Wed, 25 Sep 2024 04:41:46 -0700 (PDT)
Received: from localhost (amontpellier-556-1-151-252.w109-210.abo.wanadoo.fr. [109.210.7.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a362bcsm15796775e9.36.2024.09.25.04.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 04:41:46 -0700 (PDT)
Date: Wed, 25 Sep 2024 13:41:44 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: Switch back to struct platform_driver::remove()
Message-ID: <rv3skxgyilvscnrwxwhhtqkcdie4u7iezizhpb7qymwumlbyam@wa24gduwblpk>
References: <20240925113501.25208-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pb454cdx5zhul5wz"
Content-Disposition: inline
In-Reply-To: <20240925113501.25208-2-u.kleine-koenig@baylibre.com>


--pb454cdx5zhul5wz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

sorry, I fat-fingered the subject prefix of this patch. I fixed it for
this reply. Please tell me if I should resend or you fixup s/usb/spi/
in your tree while applying (or if you have other concerns of course).

Best regards
Uwe

--pb454cdx5zhul5wz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbz9vYACgkQj4D7WH0S
/k5bNggAm+1eYD35tl7qk7QVjIlmJ+QWPvdy0C1zD2cf+c0ln2QbaLuKOEX7U5/i
YYzQSwVka5gEbfUhwIDQogCYYpCJ3Sn1POjhnI6JvC9q+J7FqACE6fVGbe0ei62i
VsN0gj83tasc6eX6UuZwWITbmH+WooVVBQaSD91CaDPQPNyCujIZcNTgGnM9VuCo
38N69JpPyk31TXjwVwwlJ8iuqikTLhbMNEx9Ndb3FdGMzhVIWa/iBLex+7+liCBc
weiPlP63ysLIJFuWauQfiQrc08j22DpcCLHGRNy3rWqRoMR8eBKquK84ff/cdPwy
zcEl6qEKJpqG+D9761ugmuIV0N297Q==
=et2U
-----END PGP SIGNATURE-----

--pb454cdx5zhul5wz--


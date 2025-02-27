Return-Path: <linux-spi+bounces-6958-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C006DA47A93
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2025 11:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E600188C625
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2025 10:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C05122839A;
	Thu, 27 Feb 2025 10:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MA2R6RIr"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC168229B00;
	Thu, 27 Feb 2025 10:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740652986; cv=none; b=LbMeMCd2k/3tf0bHG1scPdTNf9EspR5ddO89wWQM5QRaR/j5ZMR8t/x6UNuzgTkAN/0a7hTHAnxilZjc5Gc+74Lyq3Iu3zrbyxPlJvd4S65ggRo51Vb+w+IEWIOmGx8jp7wO9K7BaKuXFgl959anVMkmdTSRJA7HYpTcZbP67VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740652986; c=relaxed/simple;
	bh=q/kXL5Us3S1TImJ8vPmYLcGTSwjqZYa/nCqiSG53O7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2ifTuw0R2CK+sPDEivf8vNVfYgCssfSfHXCiStJLd4+/SorTtH0L3nXTI/RKAIVBXVvlJmJaqSeBn80D/oJ742G/ZV9YSuSUIpllORQ5sMxQKNsg0MpeqwoOUp+YVLZlt+sFCWmL0dXo2RCIbB0tbjjDVVEyO8N7XHqDoY44ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MA2R6RIr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43aac0390e8so4998305e9.2;
        Thu, 27 Feb 2025 02:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740652983; x=1741257783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BiNB3394BHNPK8DuKnzmxQtxRBBmLgR2/ry0wUMsOLA=;
        b=MA2R6RIrAAMNPE7sV6SDsH2Ro0GtTW5MVwrwKLzsA4xbBubJBFk4hbSHKkRf3UAC31
         e8HSKBWGbGnN5GmslsXnVfZ19YkL86AkTq/SSgAd8eW6U7DWNbcVhp9MzsHfv4QVFF2B
         6zGotO1zfj7X6ZIE0isiH+1/oXhhM4Uy1pGn6xYppMz4p45A3RNn2xd7oMnuJXxadzfO
         7m0gANql8gMW2lU1QlkuBbZ5WbOS+QBg7IV050wXr36duwvUdgbmR7oQF9j+zf3yCzE5
         hqvx2T7cyq3epU3GiCqKz9bw7l+j1YM4O1rUBAGBE59RWV0ypHp/Bf8kaXpqLBqafW5N
         z9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740652983; x=1741257783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiNB3394BHNPK8DuKnzmxQtxRBBmLgR2/ry0wUMsOLA=;
        b=r0my6A7wCXhbd/sEuujpwROUtKwsvUBnSflaDrnp6yR1fn5MTcC0uY0XveulaIRtW0
         QunFPcaCBmKQsj8vCrXGYmZL3PRl+dnSPb8mq6pX0CrSauCxgHHVT8IlS/E+yD0QrSk4
         9n72eRG/6cTFgKVTDUvs9KLcAl+6YoCSthte4eWfuLcEew6nePkuBU5ByUpsP+z3CbpU
         YOqVRzcoYUrq5CiXo1gBpcGT0PMcMaiTrAKSwiyYYb97ObiYvCo7TeD6lhSW/xox8WeT
         DcXxOLcM/gn8xpXydVqatuT+cx+O307xcDQIwCIQd9yjWNBxDWha36W8Wr/WRDvgDsh1
         PLXg==
X-Forwarded-Encrypted: i=1; AJvYcCVYVGd0R5k01uqNsS1E4oyME7Rw8rHmMOujHsl9nVmIblcZcgAHB0bkjUsNelogjlBLH7F4doPm6S0S@vger.kernel.org, AJvYcCVwOFwImIBSWoa6tYFz+EAFOX38C7i7cAGQq5/0qqUwzHa3GGIJnHxv7Y9K0HtGlWAiVvs0cjjL4501jPE=@vger.kernel.org, AJvYcCX/S+ruhE8jtZS/Wr9hrTNxn/vtOMpj/W9q6UywWlQ6wl7FFzef2hOKQb1n4pO32HkEMkc4o9h8e+DSPr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ+4TEcX4a9ckY+6v1RbJCsMcl1jSLz0yX0gI8lkf02akQxyvr
	T4c7LsS6LeHXkWMoM2OzV73+IZU7RZ4jzaBxKXpIyW3wV9o2zy2fE7VNFQ==
X-Gm-Gg: ASbGncuQxdcuaQ+qzrhWrq6KpjlcQMck0gJf5HoCct4U55cIIvhwwL+HajsfLA+F14B
	PY98t1DU51kacrLZfzZ7m0LdwleufGhjE4efylpR659+rtqK2vUdCqFp1f4Q0S8tPIf24x8bSl0
	LlhgRoVNJE3RBA9WKTPgknmYTUC7h7ohU+47M2xnX33A1MDGBuDf/+/R1BtaOB091YpYzrqvtaE
	TMq5oDanPRNFiLoj2yEJKp/6FfFfo1k+TSa0KDhgSlUOplfUcuP+X2Z7itnSMLOjzVs7svhmoii
	ITdfewok+u40YK+iiSBZ2a10+6mm8hPkxHODA6YmVdYyQKTzf/rhKLnexbkzcg8zg0BQ1NQQRYy
	WHHV2s0vBX9rO
X-Google-Smtp-Source: AGHT+IHFm0dUQ/NPjHHsDvyLGniaYHPyJmvRPPSkxTkyil6HbVz1xJ2cyk/bcrn9hLQuuLZq/+2M1Q==
X-Received: by 2002:a05:600c:458e:b0:439:91dd:cfa3 with SMTP id 5b1f17b1804b1-439ae221d72mr208925685e9.29.1740652982970;
        Thu, 27 Feb 2025 02:43:02 -0800 (PST)
Received: from orome (p200300e41f187700f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f18:7700:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba52b97bsm50615215e9.8.2025.02.27.02.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 02:43:01 -0800 (PST)
Date: Thu, 27 Feb 2025 11:42:59 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Vishwaroop A <va@nvidia.com>
Cc: jonathanh@nvidia.com, skomatineni@nvidia.com, ldewangan@nvidia.com, 
	broonie@kernel.org, linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kyarlagadda@nvidia.com, smangipudi@nvidia.com
Subject: Re: [PATCH v2 2/6] spi: tegra210-quad: Update dummy sequence
 configuration
Message-ID: <accylk4mbwwaln3ruvolqouhxsxzwjengf3k4c6ypz3piolul6@ukojglmcka2x>
References: <s355cib7g6e3gmsy2663pnzx46swhfudpofv2s5tcaytjq4yuj@xqtvoa5p477n>
 <20250212144651.2433086-1-va@nvidia.com>
 <20250212144651.2433086-3-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uz2pkkg3tjvjfanl"
Content-Disposition: inline
In-Reply-To: <20250212144651.2433086-3-va@nvidia.com>


--uz2pkkg3tjvjfanl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/6] spi: tegra210-quad: Update dummy sequence
 configuration
MIME-Version: 1.0

On Wed, Feb 12, 2025 at 02:46:47PM +0000, Vishwaroop A wrote:
> Adding support for the dummy sequence configuration. The dummy sequence
> introduces a delay between the command and the data phases of a
> transfer. This delay, measured in clock cycles, allows the slave
> device to prepare for data transmission, ensuring data integrity and
> proper synchronization.
>=20
> Signed-off-by: Vishwaroop A <va@nvidia.com>
> ---
>  drivers/spi/spi-tegra210-quad.c | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--uz2pkkg3tjvjfanl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmfAQbMACgkQ3SOs138+
s6Ff6RAAlXU8Q7C2JLdGnPQeITUXBqVMr19Qc1jw7721A1+FwGZSSx/xBY0C23J/
RM7bqUuOcGPdy8F4oL3m+ACwhiAwJOq32qxKjRVf8UGRHY2zgeK3DL8m0KvLm1zg
ehf0z/jtQNdJbM1sEekIiFlYrGMuhELqHAYrJdsxUhC+NiEJP/Vif0JTo/StveBP
e43GoqUyI3QqGsHshEp1aHcyeOJoXRlwHvfrtchVlDNaN3RGad5C/a2UMIH0Q2F4
m6rNBmqvSUfDzk4e9xS+NC5zMkUr5PustygCOcyuEHdhuJ7XH8FeGwOJ65QIj526
AJ7YFJPVLxEriaeggXLws2/Jh32mivPLTr7CuVV6AN0oA4ESsAQbAxyFHwMYVd1J
ZrGPkk9FxMEKJSIZbOAvR70xT52Y9NoctFr7nBo0/DZlMQ56m2k5gwh+vFUfU7Ql
0WtPzJkRK7jCJFJ1LZTcv/37haxVyhVT41hrzgrXJ0LNYw8MprVh1wq4pncGaFLt
TR2tsuCYSFJ/YOOIRDr2TvBCH67A36WdWI99tLIGoD4WAuSyPbA5r+bhY7lysV7D
CHKFpyl5oxv++vZ+j3weszPpxLP4ZYrepRhPVTeNlpZmGCgYNm0T3AwoB4I+VkLL
oB9m+IQk26clam6AF9z2FEYzvGjXxQUWOKx0UdZw0ySh2Kvnb2k=
=t2rG
-----END PGP SIGNATURE-----

--uz2pkkg3tjvjfanl--


Return-Path: <linux-spi+bounces-6960-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BABBA47AA6
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2025 11:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CFF31652F9
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2025 10:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1797421CC66;
	Thu, 27 Feb 2025 10:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fiwmyp/A"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB161DC997;
	Thu, 27 Feb 2025 10:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740653147; cv=none; b=SWBuLBvEJq/ioidkSbgAsQyqoKoqj72aFzZahSeBKUfbKb6AMniDNS+HWoXSlnBixK/FgV0DrhrEemnCiYxUCYMbK0hMf7kzY9dhrZIp24UTUGmGXWQWNIsOp+SOqeT/xgCgSP0NDb++o2GawYrEdo3UReC7owRvYUORWQU8owc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740653147; c=relaxed/simple;
	bh=GF6MqLajYgoE1gfFr2cIFRVWnqQhcZcf8amj44FPoe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6DPSq8spMqjvj0KBh1d1Kfu1fUKIXHbjvIduCK/jEoGn4M9NYfvQi1ZNzxecZuCZQQ0AMgt5qzsbvCTxTrRJvzs7tpzD2JqT86sIfdO3lLhmHDWAQ9k66ctW/oq4oyJZxVvlpOoXaWmrWRBI/k1cTMBF3ntIR5GJ63mKBIwSNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fiwmyp/A; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abf178f4cf1so45976866b.1;
        Thu, 27 Feb 2025 02:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740653144; x=1741257944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GF6MqLajYgoE1gfFr2cIFRVWnqQhcZcf8amj44FPoe8=;
        b=Fiwmyp/A88XoIEqYU+Imo/uXBfrPlEow7RSkH9lMOz4QY4OUgZpVlc8B2Mmi7hdU27
         LDYT2RXtu2vpwC79h0ujzyrrhB28lpDWAF+0GcQkQ6YYUPzNMxk6VBrO032ucGp4dUbd
         jqHbabHZ+Cw0pMRax07ARfOv6CkKJGtOx8NLxKcZalyOUKrlbGw69ociyMlNGxy7d1B1
         hBIWiYihzBmsS9KqmV0X4pufKr6aIWpiNyLsdXMlTTVrC/gJE7aCo62v4zQsRVs+icsj
         yg/oxT1V7f1MaqHdUwNkQboHsxkNTbq8KnulZ5jeWg8K5ybwkRQNVaPKvmOiZ9BdCQs9
         jCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740653144; x=1741257944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GF6MqLajYgoE1gfFr2cIFRVWnqQhcZcf8amj44FPoe8=;
        b=KQvzL5QsZktwaqPedtp3x7TpD81Y6xqmMfSd3anoIz88N3fyVbgYSzQYPJRjg0a5iK
         8GmeVhZej05hb8N3+wFkd8QXtVr8+4gaYxEz6pn3HVZMrkRlJ1kISaB4eTJwsFtXydH1
         DkkO8aqavCyDeVfv+WTE+nHKsL7YAi+iPnLdatUfyTpt4sp9vobksWjw52zwnHb2H2by
         HZfEtzKqBcosL1zrewRjDCClQdvtDMfESm3tRC4E59AhE7iEBPZznMzkGJkSVr3gTIaN
         ZD3WpTJC+RmKEj56F1tx1nCVWXdFw5a22gjJY+YF/1IacY1H7FrSTC1wDJHX44sNjH7E
         rMxA==
X-Forwarded-Encrypted: i=1; AJvYcCUXsCelmC7F/fbwuTtYwuN7iB+g5uC7gI3HB6aQusPD7JeliGvKw7ZTDe8czpLjWPyYCP7c1FRcO4tt@vger.kernel.org, AJvYcCXETvVnPHC6H5zGLKySBnQiLy0RiKUxhEQYBqm0yQXNA+tCesvfssCGlSgFGRvb0DTyM5tHElcH9+3+dDo=@vger.kernel.org, AJvYcCXW8/BsEPrZ3MCqjgDzY7tAnQnqqXisB4fiDGLvTTSu3X3RJWNgDIJERgW4kEfg7ao0l2yRZ7jcwp1y6Ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGSm9/TbqzUAI+ThyN9/nxKGIpKoSFL71dv5XynsI0D3OIGb+F
	Ky2tGH9aNRp6nVd0VwA7YsGTGRjBkuMP+BuDn0ana6gSdk+SVI9l
X-Gm-Gg: ASbGncv2pm/KnZPFQ8YIKgdDsFPzUVfOK0ywB9Tt76ve1Tdg75uWFkKfukYknI8jRLq
	UbybIiehuYj1/T/UdCJtKjG8O+VVv13+VLHmsdDA/NCQcf7NC9h40d/jP3sswOx+e3oa0q5/BqU
	y9BILo3c2qnmI1mCKmMNeIF8WkWM1jEb/08J8cDi5seZr7Xqvig/IqJmw5h9xPeELMN0J18HSVV
	illJnuR29hjuKVu/+PhAG9MpcaESXRkKcxDI5zQdhigTZFjDBWJQS3roH0XKqanM1li+iL9dCOA
	FFJ5xVC4r+iiiakbyl0fSbABdlIwv6EpWOcjBFgF9SBQr9njnrvxE0rhTNwKy+DC4UVjlWIAifn
	GX9Yy7If+LWvS
X-Google-Smtp-Source: AGHT+IGo5t21gYG6fQyyoESaWcOTheCPaEWx814DqIVAIXSww6J4BbkgEZQX9XG54WIlPguWDPSyPg==
X-Received: by 2002:a17:907:96ab:b0:ab6:db3e:2649 with SMTP id a640c23a62f3a-abc0d9ca19emr2223415866b.14.1740653143532;
        Thu, 27 Feb 2025 02:45:43 -0800 (PST)
Received: from orome (p200300e41f187700f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f18:7700:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c75bfd7sm102641466b.148.2025.02.27.02.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 02:45:42 -0800 (PST)
Date: Thu, 27 Feb 2025 11:45:40 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Vishwaroop A <va@nvidia.com>
Cc: jonathanh@nvidia.com, skomatineni@nvidia.com, ldewangan@nvidia.com, 
	broonie@kernel.org, linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kyarlagadda@nvidia.com, smangipudi@nvidia.com
Subject: Re: [PATCH v2 4/6] spi: tegra210-quad: remove redundant error
 handling code
Message-ID: <jj62d2fa5kiwrcerjj7twxqkxjc5bmvc37ipsencfb3rvotwzl@drsp6dv2vm2c>
References: <s355cib7g6e3gmsy2663pnzx46swhfudpofv2s5tcaytjq4yuj@xqtvoa5p477n>
 <20250212144651.2433086-1-va@nvidia.com>
 <20250212144651.2433086-5-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2rxevx6zvipfhukv"
Content-Disposition: inline
In-Reply-To: <20250212144651.2433086-5-va@nvidia.com>


--2rxevx6zvipfhukv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 4/6] spi: tegra210-quad: remove redundant error
 handling code
MIME-Version: 1.0

On Wed, Feb 12, 2025 at 02:46:49PM +0000, Vishwaroop A wrote:
> Remove unnecessary error handling code that terminated transfers and
> executed delay on errors. This code was redundant as error handling is
> already done at a higher level in the SPI core.
>=20
> Fixes: 1b8342cc4a38 ("spi: tegra210-quad: combined sequence mode")
>=20
> Signed-off-by: Vishwaroop A <va@nvidia.com>

Again, the blank line can be dropped. Otherwise:

Acked-by: Thierry Reding <treding@nvidia.com>

--2rxevx6zvipfhukv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmfAQlQACgkQ3SOs138+
s6ELwg//UDnviL5pzm9ky4WgsRMuYMgGYckIlppa+BPfeHtaxPl2IL3vju1Zl1Kw
ZzLxD1oEmvBgZ9XwvRz/3J60gXPIRnwdOw0Vf/JasIuC/PdtCCZNkdcjUQkupt7R
lQo2uDz/7WuA6fo+xyeLxBE2FOIUZfS1kC40mOe607KPTXY4nwEKazqVeBe+5BEQ
Eyo6h0ZvZg72t7Q6y8Ik2vvM+6To/uH6RB5seNTW/PIfE2kUuIjar60jYIUsiJlQ
Rj62HX4O3/lVz+KAjM1vrR54+FwS4tJz73Tj1vjOYIEtOlMaANpoGPU+FH3I9fDG
FcN6xjm5jl8L6u40gF9Kg/kG00tRAHzGnVUs/1Z/hJibIL75JvobqHbQpnHUBkis
ePI+Yzh6OUPvOrbO2GzWbSbrYhtLMDG0ndAX89Vcvu3gaXB9PzxQb6QIJfljWQKt
l5cxu5oVc7vh0kNXARZ/VHY/FDI+zdWNW2P4dZyXBOmWCOiRDa34kjduwRADuCiP
JTb6MkdwNaediMkbpegIRNVS70qvMPD7rDALaM8O1q0kH8yCxExfKHr2+oU7/zuw
fQDAVOmx3gy6TgFdDPPGBYHcV8DLBjbfxt4h6dlAU26q0UJ8KMcvbR6i10cZfE+K
Vj8s83w4jEZFddENt79AWDay8bJYTcvNiQQU1v1BZCjJiIunJsU=
=V9KT
-----END PGP SIGNATURE-----

--2rxevx6zvipfhukv--


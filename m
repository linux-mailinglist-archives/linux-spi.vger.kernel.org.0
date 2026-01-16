Return-Path: <linux-spi+bounces-12440-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3263ED308B6
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 12:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 862CD308A438
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 11:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180F33624C0;
	Fri, 16 Jan 2026 11:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBLl3WHN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97115378D64
	for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 11:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768563530; cv=none; b=MP5aOMnlf9mGXSAl6tEczazausZdM4tZCyeBob4Pl2E8gAZ1xSvKcU9cv11yWt62iFsTfwMbjxIgvmP5njt7YgxkJTvSAA8QjIk5A6fR9FzHBTckHdZ0Fx1EM4Ku+4m3jpTHoNXiZ7eTKRRF6Cg+qU3fWYAdjadvl7T/vbl/tEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768563530; c=relaxed/simple;
	bh=JgyYgcS8CcGilSVKxJ9eQyxKoJSY+A1itzOT4gN6XrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbxkwiUlRc3o1eGFlJaR6dOoSD85gWOBfFkdJVM65YV91gGo3z5RvcSRI7qhKf5bdBMQsuRV9iuKutWM/zefM7jkguKaoSBj1EEvY8uFzvksfbPiTm260G7iKgpxzS+mWLfS8xxART9glVIJE+Sk4q57zkIYl3a9W6INuXwxukU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBLl3WHN; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fb5810d39so1518808f8f.2
        for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 03:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768563527; x=1769168327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UIAVqbemGbAL22EA98ouwFZbhO0tWeaqEmSZvM9HDKA=;
        b=PBLl3WHNx6wpRZoRbu3Zr7+o1k3sbB6s8VyLWddtNwnshnB8l3n4OAr18fY3lCd6Ar
         91Fgzl6GXWu3SArvRUv3M+2madYhu/0r7K439Bykw6Vt9EcCU6y0R7PO1FWeTVgPlkqw
         5X4oZ4gmhSPU6VcgUSiuzeiU/fQ9I6rYj8lwpoKwHg0vPRCyAYfvNYJwsW1rnoEr64zB
         dYqTsRNAx2wCGU7OvEnEw9k2by+YVlQD0bFJQMH7KOc28KCednhpDEBojBM5vSQDlNOu
         VDbJf37AbiBUZRw49hEu/ziETjyVxzcwwjQJRk5ID6xc2LUJs9y3H0YvF141TPsXKWpv
         uvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768563527; x=1769168327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIAVqbemGbAL22EA98ouwFZbhO0tWeaqEmSZvM9HDKA=;
        b=Af8PaUjI8EbdCaqMch3Jcgt8YRLRmgYT/xW0qnSFSI6+71Xx8xhq1v8m24ql4EJBmq
         krQCdNUEt/jMXkYce3t1dhzukmrBzvtu3y3WHak1T+Zvd3aM4dHqaJJg+egDuAmIOTE+
         YhUrGKiiq1q3Ujbd0PholN4ENtGG1KPODaweRHYALmU0u1pwhI1buhhs6s4JKWNe+y/a
         iN1tJeiCY7NYGQ6Y4OplBTdpQooqbrqLACxLW5ulpCTdj4mslVOm5xAy1jKGbef/VqqJ
         qpQzpppS7LSNi6Xr3HJ+kqlkPrzYl5ZA4ltQb14fe5SY/Vo0kpswdg+ZnEHeWPtoPQQ6
         71qg==
X-Forwarded-Encrypted: i=1; AJvYcCVucs5X+SaBVIeAvyykg684/aAb+pSXB7FYcG49iPVwQGqcn2aCbQ02kMUdqV4+NQ3Fj2PILrYHH40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymt51j7lABAqEx9jh478HrfZ2pXm0A9l7/siQHkd6F4RtS1wLj
	XmlHKnqOOuLFOX5V6ESoOwyntRETTTf4erC81QBECrZeBylU2WGtvs2o
X-Gm-Gg: AY/fxX5Vs+a+vYQnNuaj0f+MDwQki078IMOWe2hI5N47OOcnPFM5T1+ztpR7n0J61yX
	wlUvyV5hCDNLrcNZKvwa0zfVBPn/+Q00AMp5g44Qn33r2zw5TDDg4VlPP879knR+ttNbksuyypT
	cc19BZ7MKC8VXe9OkTMcfuj9kX3wjjvWt5C7/mAHzB9FhZgOJs1dqtC3gxKgEqG1UlM7++/DNmX
	muEaIW2519gtxEDEfo8V/SD59UUFxwzTUoELKLh0F8S2HOW4VlqOCNhTFdfDjLFODgtYg84cta3
	kMIAtebVP8l7iCn7fINhWh0B193Scsj4fGFOwSnaR5k7Qru9bxC1tBN3z2iynoQ2MVGcRJniJwF
	ATo3YR3w0rFytc7SICq2Gsc5CUWOksT/6T9Hb5GvqG6zJ5lE4nuEzFc/0izdQAcAJtytOnR9J59
	mdjGGyHYjqidiI91nMBF0UD60/ieMzIjiYK7gVlvPZU5qmK1A9VQvCqiKuJis9ocBkn6oR6M5ul
	g==
X-Received: by 2002:a5d:64c5:0:b0:429:b751:7935 with SMTP id ffacd0b85a97d-4356a06611emr3358227f8f.56.1768563526908;
        Fri, 16 Jan 2026 03:38:46 -0800 (PST)
Received: from orome (p200300e41f0ffa00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:fa00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997eb1fsm4846980f8f.35.2026.01.16.03.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 03:38:45 -0800 (PST)
Date: Fri, 16 Jan 2026 12:38:43 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, 
	Sowjanya Komatineni <skomatineni@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, 
	Mark Brown <broonie@kernel.org>, Vishwaroop A <va@nvidia.com>, 
	Thierry Reding <treding@nvidia.com>, linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, puranjay@kernel.org, 
	usamaarif642@gmail.com
Subject: Re: [PATCH 2/6] spi: tegra210-quad: Move curr_xfer read inside
 spinlock
Message-ID: <aWoiFebhTHbYibQO@orome>
References: <20260116-tegra_xfer-v1-0-02d96c790619@debian.org>
 <20260116-tegra_xfer-v1-2-02d96c790619@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ag5n44g6ynxo5r4q"
Content-Disposition: inline
In-Reply-To: <20260116-tegra_xfer-v1-2-02d96c790619@debian.org>


--ag5n44g6ynxo5r4q
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/6] spi: tegra210-quad: Move curr_xfer read inside
 spinlock
MIME-Version: 1.0

On Fri, Jan 16, 2026 at 02:41:42AM -0800, Breno Leitao wrote:
> Move the assignment of the transfer pointer from curr_xfer inside the
> spinlock critical section in both handle_cpu_based_xfer() and
> handle_dma_based_xfer().
>=20
> Previously, curr_xfer was read before acquiring the lock, creating a
> window where the timeout path could clear curr_xfer between reading it
> and using it. By moving the read inside the lock, the handlers are
> guaranteed to see a consistent value that cannot be modified by the
> timeout path.
>=20
> Fixes: 921fc1838fb0 ("spi: tegra210-quad: Add support for Tegra210 QSPI c=
ontroller")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/spi/spi-tegra210-quad.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

I think this is the root problem of one of the crashes that were
reported. The problem seems to be that the high CPU load can lead to a
case where tqspi->curr_xfer is modified after being copied to the local
variable, and before the check. The window for this is very slim for the
CPU based transfer, but for DMA based transfers I can see that happening
more easily.

Acked-by: Thierry Reding <treding@nvidia.com>

--ag5n44g6ynxo5r4q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmlqI0MACgkQ3SOs138+
s6Ht/RAAjVW/ac+wQNXyvQAjL4gyJIvv2NdNt8KwU0dhVeNdEzgpAK+3Zm/HXvXq
y3lamgrGoPxhLGEvcT0ruAA1Gh97IRRH4rSq1+y8lwL2tVWRw8ckRm2TKkam1eaX
D/+5Pt+dTV5OQ/0MhGDFg5pM5u8DbWQgrIpy/PGpO/+xkPzq+mwcHBju9qamRoif
nHNt4bO5BCWGsBu31n+Uv3a81G7tok48qbJ3GelBNbZ6AMeAy7r+ZDL+CK20kym/
IzFsQWBUaVMvjSJVbefzmMyXPaiuVoyB+k8iCqDmgCqZ7HOLHVMfH/IgYjfe6ITj
I0RUy10Y8fWSWubKm13IMAh5rRraPxJ18dkiJXehpc+oBxuZxj6pJfpb8kMRTIJK
6BlNkiFooRWHFxVQ9hQ1ItWYqTOTFIRFb4EWbAQtohOtoW9Tapo/Ny/EgI5tK2mI
BcmaqJIkyM6VY73q5NOt2cdZ0+mgV7WI9wLGq8d/nQ9f7Nr+J43uH+K64XXEPMRB
hOXxjmdtJVlLp2+qB5rhx6tBh4mGQeha1LuaT0b2x8rjdW9mrZyXh35AcxqesMjx
ZM2EgQNnJpNnkIRA1eq+v67WiEQylXlPjNKiTg7hS266GowqSW9ensqq6iyaLc/H
fp51ICThq3a8f+9QZ4PQS4niY9ixA2VWWeOydZp4g5SG8U68vAo=
=ovOC
-----END PGP SIGNATURE-----

--ag5n44g6ynxo5r4q--


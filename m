Return-Path: <linux-spi+bounces-11793-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A66CA83AB
	for <lists+linux-spi@lfdr.de>; Fri, 05 Dec 2025 16:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFE68334CA1E
	for <lists+linux-spi@lfdr.de>; Fri,  5 Dec 2025 15:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675EC316903;
	Fri,  5 Dec 2025 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ymQMBfHT"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03051DC997
	for <linux-spi@vger.kernel.org>; Fri,  5 Dec 2025 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764948635; cv=none; b=X2bYE2rRpebfnH8JKtE5sTRUs1atWou0nZaqbAus+T1gZVvC0QufruFzncA1j7tKz2XRHKZLfQfoSC6RsFyhTB0aFKNNp1TMs1XpzkRO3nPKH+xt4xzMnmvOu2iQoM4ym3wOZvK7v/wp26Uj49c0JxEhpy2UnyH1RNT4Bp+eK2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764948635; c=relaxed/simple;
	bh=bnF87if676vlxacDwch5pHFPRT0g1yDIFuiGnidHF4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlJ4ThCzw6cazdq0BmISc7s+4z9P8YvIUs1iS2Jc2NKFedflbfqvkXB0eMS18gtqhp+GL/qWrVrvqjRy51GFmM3c/V4ybGx/Gs1BktyvwrPiy8TbBEjVGOJMNOb5lMF2vOaaUH1d7/BO0ENzylGxIhXiY3EORpD66UhkhxK3PfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ymQMBfHT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso11680295e9.2
        for <linux-spi@vger.kernel.org>; Fri, 05 Dec 2025 07:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764948621; x=1765553421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bnF87if676vlxacDwch5pHFPRT0g1yDIFuiGnidHF4s=;
        b=ymQMBfHTdviE/LSJeor2jrlkRUPhA7tYmPVMSylZVXk6ddlu91w/Ei3BzdsD0oigv2
         9EkEWEE9zOo0FW4eU5+E0JqQEOM5oHwnf6F/sV5hJTUjXxwvAzo/xkoEQz2oaPvrKrtX
         mm8RkI9t1gNufiNyYRm7IGUQVVYcZEyIaCFWZbLZbnyzQ7w+0x1JpzN22L1Lh8emiKYl
         l0+hs9Y3ZNit/cXFfeNalleHE7iHyjhumKePYw4sGGnaXkgFdTYpp1m6kor6unI1a+Nb
         N5N3amg+ccermXbfc1L5abo2/pdeQQnZl53NgsyOv0F3LZl6D6UR3Ri4j8PAfGYiDEvq
         T38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764948621; x=1765553421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnF87if676vlxacDwch5pHFPRT0g1yDIFuiGnidHF4s=;
        b=UJUymdCohecne0JIP3XqIvbJWFWnvQoRSaXt3PXDyNy5Op7cOyXnjJ8JezQbMH6gdb
         /8BUvq6p7iYPAwWO61M5/kWdgCV98oPl3bfFQW5zUUtZniOoeOeCUwleY7ABpQoF1MLj
         x3kgwQNnKAa8P9osafaoGzniFnqvVAiVjF2gaTwsLKLcQQy9QtawOhdZtrm33x5r/z8q
         vFL/9RF20mu5PozGmUPN86Zu7iTIM6Yo7vvab75XcQpL7NkSmD/sscmfEL3Bgrsfoqm0
         1U7a+G6QJNJoAxGfY9pscEMaLmaYkUDohVtUxpnI8JDLwJaAMalYAaV+Xp12xEPN7Ksa
         +GUA==
X-Forwarded-Encrypted: i=1; AJvYcCVBgFWyubnQV20sieoNqrH2stLxZ5eB+zaR3+FfcWo0HP0kiorS+KUwFuZyIWVrbaa7pRNei2iabQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFLz1cAlW0ch5pYgM2xmDLLflDVhvsJbDArGyy5Z8eXlapgfz8
	gohDLLl/elHoc4mDZYAsyaJ6LmupCphzCv/FVAbeZmO2ZlWMLTAD5g9J9pAuX9cvvvc=
X-Gm-Gg: ASbGnctUSq94sNe6QUzhDXmNZOYu6pby9Moq9kZZSS09kHvitLj18vJwHhY0kDJIxbp
	//iM6hVNJORBXGn6NvwJJFgCP9XeoTmOPMHqK0aMk5An7b07PLMcXkVsMg8WIx3DuQF6T3tDCyh
	q3JIm2RggpT9Kw1zDuRFdIHiu9xREeXUV7Lr1BiHrniN5z+sn1th16hMbz/NncThJs1/jlLA6Iw
	0B6n6Hglvj+gH3EiZdtDMGmg2M0wO1euwQ2Ec8VYpp4xvymMWu3CycrOWU0alxYixyt4HxX3LAD
	dwfh/3SjR41C/YTjMr0Rl18vQMpm1fit38qIRdYSx4mrQraeAO7WNLh2Mh6vQxkuQaqW8Tzef61
	7HEdRVr/WHQ4iXMm0TdmRRc5TrPoTgoKz+R8LtGtCt5ckqmPCGi3X+UW4ujXs4zfscp6DUieqhE
	4WFxq3NmwcVhc7kIRPBNHIfb6YbPZxA8E02kir13mwMgRU0hQd+5j/uRUM7FzKHC2a4SG9s0IgA
	w==
X-Google-Smtp-Source: AGHT+IG9OTpWAaFioAhUqNYkEUIfjg2JVgLW6606fMapNPZXQsf9lwNr2Fe2wAiolNVCjjQfc9D6Gg==
X-Received: by 2002:a5d:5f45:0:b0:42b:39d0:6386 with SMTP id ffacd0b85a97d-42f731e98eemr10449236f8f.31.1764948621389;
        Fri, 05 Dec 2025 07:30:21 -0800 (PST)
Received: from localhost (p200300f65f0066080f2a7d55dcab4de7.dip0.t-ipconnect.de. [2003:f6:5f00:6608:f2a:7d55:dcab:4de7])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42f7cbe9065sm9319885f8f.8.2025.12.05.07.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 07:30:20 -0800 (PST)
Date: Fri, 5 Dec 2025 16:30:19 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Eddie James <eajames@linux.ibm.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Ninad Palsule <ninad@linux.ibm.com>, linux-fsi@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, 
	linux-spi@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 00/12] fsi: Convert to bus probe mechanism
Message-ID: <tkg3ut5prrbur6dqh7elxmu4djqj6dgsymmdzalg5gtqgnn6jn@6pi2fskmnbyb>
References: <cover.1764434226.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yfs5kz5w2cta6clk"
Content-Disposition: inline
In-Reply-To: <cover.1764434226.git.ukleinek@kernel.org>


--yfs5kz5w2cta6clk
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 00/12] fsi: Convert to bus probe mechanism
MIME-Version: 1.0

Hello,

On Sat, Nov 29, 2025 at 05:57:36PM +0100, Uwe Kleine-K=F6nig wrote:
> for the quest to drop .probe(), .remove() and .shutdown() from struct
> device_driver, convert the fsi subsystem to make use of the respective
> bus methods. Some cleanups are also included, I noticed those while
> working on the conversion.
>=20
> Regarding how to merge this series: There are two drivers touched that
> are not in drivers/fsi, namely drivers/i2c/busses/i2c-fsi.c and
> drivers/spi/spi-fsi.c. The easiest would be to merge this series through
> a single tree because the i2c and spi driver changes depend on some fsi
> core patches and fsi_bus_type can only made private when these are
> applied. I tried to quickly resort the series to only need three steps
> when merged separately, but this wasn't trivially possible, so I hope
> Andi and Mark give their acks to merge their driver changes together
> with the fsi core changes in one go.
>=20
> Note this series is only compile tested as I don't have a machine using
> the fsi subsystem.=20
>=20
> All the calls to get_device() I found in these drivers look a bit
> suspicious and I think there are some issues with lifetime tracking. But
> I didn't try to address these, so I'm just mentioning that here.

While working on more such patches (for other subsystems) I found a
problem in this patch set. Please don't apply it yet, I will prepare a
v2 (and then also explain the things that need to be done).

Thanks
Uwe

--yfs5kz5w2cta6clk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmky+oMACgkQj4D7WH0S
/k4phQf/TtGRlPwbVYnyLP0xN1AzA3+J1cbc7ZQfmjPBA8VMd4NuPfJYbMYA9S6k
v4ssPKpvMCGVgU9DVWY+HMAmtejMLoj322bJ0N/8YAt+eTlFTfctwKNRPZWU7Nbs
HHQhj9D4Z6/mCwYdULVTeLZRzTf7lJf8MPFdlhpnHcAZrlzEt5MM1fHsMKf1TRl7
whcDek39s9jy75CN3kR3Cb6LtmRG5eigVl6JOQ220UgKX5tZ4kKzuvDHZQAvCxzF
pzM5L7aPOU7xjDH/d2M2CB7ooQ/OslKGo+qZ4aJu0Y9zGMEwuti9fGQ5AV75tkgL
5Iaaxj8c2PLV0tWwemlo5uyUUYN+ng==
=e/VW
-----END PGP SIGNATURE-----

--yfs5kz5w2cta6clk--


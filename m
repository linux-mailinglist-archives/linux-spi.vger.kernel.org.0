Return-Path: <linux-spi+bounces-7290-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7F5A6DAE5
	for <lists+linux-spi@lfdr.de>; Mon, 24 Mar 2025 14:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76DD0188D583
	for <lists+linux-spi@lfdr.de>; Mon, 24 Mar 2025 13:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863DB1A5B87;
	Mon, 24 Mar 2025 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="do/6Derf"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D163638DE9;
	Mon, 24 Mar 2025 13:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742822238; cv=none; b=hZEqR+qXzvgY+RFfAck8Uwo0NSkcU5EOcXY97WGw3Hq/Hv6rfFtMRHsbSn74omkuxt14fJD/7PIIUTCXg5OZAeRUa4yuFp6YMcRE0binDLbIjh+7t/M9+PmLDx1vYyRa6uy/M5uovD158c52+2EaVBfF8amae4MsqP5yPp09B8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742822238; c=relaxed/simple;
	bh=ymC/lN6PUWuCBpRKT3Z6QFQR5aZ8mrbO6Bd5DhYLYus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQtoVG0M12bFyKTRB+18gOWAGI2WqLqPJETnhJv6plNQk+8TFB3TIhgZwgNcwqXL7n6AHBdDW5zGb8scTK124d9qtieUKY5WRYmYx2ca70UTxIwMDN5T7lFKgXf9UTPQj+FEV0k4KDVshr0hyFL8umva9wPsGP8B8BOnp6XaDYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=do/6Derf; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so40532845e9.3;
        Mon, 24 Mar 2025 06:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742822235; x=1743427035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ymC/lN6PUWuCBpRKT3Z6QFQR5aZ8mrbO6Bd5DhYLYus=;
        b=do/6Derf8HGy5Ukk+9hraq/XFS7qNASeU7P9WVm1PSoz5QxvW7r+Ma5UiPI1CxpdDA
         fENEhz15+QVMycXscdmFBw8Vlpaqr71aPVomLVsArFMaXGI2qraHXoTfgKpcH+dPHwxz
         MqgwKvTXRRVl6ORc5SXLgeLfWXIo4LvJNJ1RlA0wg0yNjvZEulhH5eLAXRK+Bx6Atz1C
         FboWzlZ+8pWrzfrtsitshcsg+0PlfAzSu9pgtm4fXBjdxXqDtznHsQNfcS0DoSL7Oo/M
         uo/yZJ58bnqFmPjzVkY1Uz5LsHY+9A21X3iVTgzpovuR25Og7aNLHpGMult5QauN8qIq
         BnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742822235; x=1743427035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymC/lN6PUWuCBpRKT3Z6QFQR5aZ8mrbO6Bd5DhYLYus=;
        b=l00KK6GwtK76fl1UKVMtId8XQbX1nV9Rf5YEf9av0qOFTCIvTkczyQtl++CKjlIRwD
         tDBqpeTNfu2LYPyFIohkO0sb7aEwR+u0Ctd6CIwGsAXjkkbbLxJWmNa1qQISI/6NzNtU
         EzImxExevT7F3bHFbqVofAyWp8RZtDLBrRGjULO8YIi/o9MODmm9HJVV5L7uL5WLvCib
         kFev91or8VQdQvX6yXJ1HlWS48754n4gpfUWdluBMc3eaNRi0ukYRCCE4K0ZE+vEN/qr
         NWp+qc+Ga0MrRdbqsUrVfF9+Yi+1foMYb9xQmfK4YjuyuahGcyUH+hxAuOgw70slmolZ
         oICg==
X-Forwarded-Encrypted: i=1; AJvYcCV/gzSyeFV0iEZPEONRsex/QgSvMqKhh/tVzmooG4q5gBcWwKlwJKqHa+dh4V9tnCkOs3CNS4NS/ztu@vger.kernel.org, AJvYcCW/Of/wivE0zWbdirx8DWvcrgkZ7mIg6zixWPvDHFcdDzmAeoeJbw4jSLxdSVlev8Da+oon4yG4DqsYmfo=@vger.kernel.org, AJvYcCXqcj6sdhnkG/Le9eHR3u4acYzHpn8e/6w3JeUMEkkJtYl+y5nh+jE1ruV54f47PUdhl5dRWgdtsFN7iNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw487kyOCVaEDSE3TjWt1CBaTyO+vYyJRP2ywa5I01EFxEkVQCV
	IPvS8IS0mSP+NhLpDgmMF2E5MNvL/Cace3vfWfqRe3OaCJVB7T1p
X-Gm-Gg: ASbGnctaqA90qTCeKX/21kt2pd1I3Dz6X5HGx/RXiiymOnSBIjxKpG6e7cmxM2F6umo
	LATEFkdguwIKltCLfT99ulN6MbmtUzSMklLli7Qau1bWxoQdXGhbeYkiRbcjlZeZC8NeICpTxXq
	7lNyk0ATALMzMxHZvBWjrIcPlQX8SUOWboMZ24UyM9/oE+G0RsTfZJoBRqJ72sOV5ImIQ9xf4sr
	t7d1dGGUQZfG0+xQoRIW+l80afXt3XdW2HDAYWCPcpCGP3NuTbDYok5GzUX412sD5HtuSz3gi64
	nasCPfDrtzhAWodWuFB7UkevWu6EQt+dyky+40ckUVkzcYj4mJYaL90Zbga+s2+/O6BFjmRq78X
	PAbycxEVXwpdbE4RXbtm5U96icy5j83U=
X-Google-Smtp-Source: AGHT+IGe0gHV1GSB3L8WhkVQFiSrfEFXxs9l6uZj4iY57AsHW0VtjQuNu23z2tvZC5MugocybOnpGg==
X-Received: by 2002:a05:600c:35ca:b0:43d:b85:1831 with SMTP id 5b1f17b1804b1-43d50874314mr127391455e9.0.1742822234866;
        Mon, 24 Mar 2025 06:17:14 -0700 (PDT)
Received: from orome (p200300e41f4bef00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:ef00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9ef155sm10761092f8f.89.2025.03.24.06.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 06:17:13 -0700 (PDT)
Date: Mon, 24 Mar 2025 14:17:11 +0100
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
Message-ID: <5dky6i7v2ml3eggy5slmxcw2rqi5xofcan2uqx7alcvh6744cp@el5ybhfevgfg>
References: <20250318-boisterous-adorable-chowchow-cea03b@leitao>
 <20250318-psychedelic-thundering-guppy-22bba2@leitao>
 <b3da27ce-161b-4462-a608-c36f4b0696ce@app.fastmail.com>
 <fbeca9fd-38a6-49ba-bb5f-6df5302d139d@sirena.org.uk>
 <6cf8af69-634e-40fa-af45-912540b29aac@app.fastmail.com>
 <20250319-aloof-rottweiler-of-perception-4c1ad4@leitao>
 <5doq6itaz6uicvqcn37q2dkaxyzy3etz5qgv6wlsyd5troqlag@yqs6ltjp3gsz>
 <20250319-unbiased-rousing-finch-95ecdf@leitao>
 <ac44uxpojpov7fcdx3qfiif3idhbp2hrrr4efqeat6jazbosv4@uoy72g6u3ibf>
 <20250321-colossal-binturong-of-debate-055aeb@leitao>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uguhcrmvhwayxkts"
Content-Disposition: inline
In-Reply-To: <20250321-colossal-binturong-of-debate-055aeb@leitao>


--uguhcrmvhwayxkts
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/3] spi: tegra210-quad: use device_reset_optional()
 instead of device_reset()
MIME-Version: 1.0

On Fri, Mar 21, 2025 at 09:28:34AM -0700, Breno Leitao wrote:
> Hello Thierry,
>=20
> On Fri, Mar 21, 2025 at 01:40:44PM +0100, Thierry Reding wrote:
> > Can you maybe help clarify at what point you start seeing errors induced
> > by the recovery mechanism?
>=20
> This is after a while. Something happen to QSPI and the warnings and
> device reset failed start going haywire.
>=20
> Most of the machines are fine, but, some get into this situation.

Is it always the same devices, or does it happen randomly?

Thierry

--uguhcrmvhwayxkts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmfhW1cACgkQ3SOs138+
s6E3GQ/+L31/EZ225/eABVw8BRZKczAWZbPsdM9lZqxlDyNSKo7Z8897d6E/GedI
bB3zDHSMkE338OboxuumgZLY/iZuXLpR+kY3vl+49J3A96kUPlYLXvqdi7ugv/SO
6lg+63rr4/Yc9GQG+5R3u2F3kxLCJTJt3suoINZbHR+BA+qgOnsEHAJQTyMexMOx
zYoOOdwkJYpz2nwxdAdFVkhcey3AHLnJq8qLsOaY1l8sTDaLB1OHKt6TagpAB6eO
mu7+QJjLs1gx2TQnhwIYtvltcXum0RV622U8Ns0q35Rlcgj20ZMi6rBwx7u5PtyD
QsWHifKjT3FioKr0ConvuDFOb8AhH3BIyfeH6b89ud+Y/5hqNMQJaYCegqsQIsCf
jzNOzMwbj17ae2UNJtVJGXG7+2vXBYbkqkoEczQkZW/wraXtXS2/Aiayx5Z7y5mG
/Mdw50MK9TJAGp6CU6LNjVUsEZLLLnk8YvKr+40Y+EugvcaLv6Vai99QMPoKUYb1
WSwnvDCixR5xH2K8NaoPtHUU9XJiSHY+yWNWkz8yqafLPUL/06ObhAZ7q2qM4uvx
OTPKI4/8ZvCOvL18aHY7IDs+cwvxykmIq29YBj1g1XJXXftXUs0iCqFqH9ZQirzZ
lDfyuUPfMeVXwGAFTiGEhlSh+LJ4jesKFKY9s+ePLpVCU0vq27o=
=aPx0
-----END PGP SIGNATURE-----

--uguhcrmvhwayxkts--


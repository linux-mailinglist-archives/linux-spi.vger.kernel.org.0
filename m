Return-Path: <linux-spi+bounces-8897-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A24AEDB9C
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 13:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F75716EC54
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 11:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97F1283CB3;
	Mon, 30 Jun 2025 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtuB5ZcL"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31624280CD3;
	Mon, 30 Jun 2025 11:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751284200; cv=none; b=iPzN4SxNSC4yIMUCy35zmtrM5P5a5GVb8ktRwyJQ3BkvKzbAvyWL6q0RTFtlWlULeBR/kUniQJ93QGHHynIR+WWH5TCxfsJIIcG1q7yB5FSAWFR1kwWf/eJGFNpg8/m1vwVt8/Sei/0eGDfXmUwV0so8c6iZElx8kzWHjc4ERqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751284200; c=relaxed/simple;
	bh=qqNIeRCf19Ug+nbDmeAEBTRJ5RiReN0RZNqWqx0jz/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMCUy7be9TBBSHkBVOHAirJweN23lPYfgDLC7Ohyy2QFC3CXkX9fhLvqYkVSdh0+PxsimpfdS3kYxwaOAkHSYKYyLOoA2GH/y3rsSbBez6KaDTulSgorNCXbM9Gfwu7tWQQVWSmc5PbJ+ZA8l9zdyM+UvLnn61DIB5KLUR4I6is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtuB5ZcL; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23694cec0feso40761735ad.2;
        Mon, 30 Jun 2025 04:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751284198; x=1751888998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P7L0gD/O+S1jlluxpetyO6tXkKKPauMUBX5PO0vsdCY=;
        b=AtuB5ZcLOErbOyrUy11mSf6CPTG2fPUP3YPL+eDkBjvPuGOhGmi1GakhTDGVUvFzUx
         CP3Ao11ZnidztdDlWUkmvvyEcFg+KUWz0Q5ucYQzvnRTFoHqawk4+OApp0UAaXFEH7CS
         SxE172nrryorbZRgzD9ubG8EB7MtNB7WTEVTYGkWaTNW1B72QaGKMkeNW4njkLxyUkqA
         bF/nOEzShAffw97zb1q5eEtbh4A9XC170dLsj24kXledAixp0Im9gbrUm7iu+4dBnUZ8
         KtnoYBj4fBmoDdKJob7dlG+frLRydYmpn/pJPCf8I6wfOD32BEoZzgLftgebi86eXK9s
         yMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751284198; x=1751888998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7L0gD/O+S1jlluxpetyO6tXkKKPauMUBX5PO0vsdCY=;
        b=XEMUQm9n/5LLge5wZY3iG33SADq8xejmIjvNS6DAoRGE89HewEDg0T9nfc/OFM0Adz
         PV4bHAYKvfhOJ2fj+L9ieAkpxLSxkLL0YtmrD+VrUMw+icsI1Uwwjsjl2kZcDmJErZU1
         Tm0jIcctTbe06/YGeD3X2Dj4F5LPvlsWBB1cUggyolRDgalry5sbjelcgP0UccHlbg51
         xhFE6c+dXgVmN6BcinQTMUlUCouY6GQCScRVnOM7UJFccsZPobbwxtEI2wGDUODnW1u+
         C/YHwJyWcKXf59wMnC9Qm4zOHu8tR/QT1SYed9CO6c0PcYjqwTS0xEyut7IBlGCfZr0+
         74tg==
X-Forwarded-Encrypted: i=1; AJvYcCVt1HXSNqIMS6/ESRvozVZpXbNXHdrdKx6cRTrbnri+B/WPvfn96yIlqMj2bYOsRF+NBBebbXKIFazA@vger.kernel.org, AJvYcCW4sWS6eMKnfm2fEQdiZNh9iFqzZgEVYI4iDqlJlVfRx9+RCNBj35NtVfT0m/jaNFY3ntZcHCI8Rb3B@vger.kernel.org, AJvYcCWYA3hUj1nUJ2JJ+DS7TUd3x2apXgrCcSfcjdkrYAA8JJ+xkrnLuek3UnYecHV08EEeAlgBp4KK32VB7OAa@vger.kernel.org
X-Gm-Message-State: AOJu0YxpfiuqLD9qLe/xbMUEAFqXy74Ze/jbI84NsaX8QmPjVAa5uAgI
	EWM8zsWfA7URz2PRoePwHq3PyZbKHT4KScqx+DYt5PPQRjTYR+F+gt6t
X-Gm-Gg: ASbGncuHxnlkn7N6b8UJ/JCtbg3kNGjuQq1YbH3Jrr932YWWdXaZmz7yRvsqHXluE1Y
	mdoZ7Ln6oA3yGz1RObPIs9q24kCr8BLJcMT3pD4YIiwL8dkcNSwkwh6V+jJfzrWyym/ZFm/0b0K
	7Y0R1pN5vXyFCniCUYENks4+zayYxe9UDwVDkAK3qMdDCEmBzpEAN0+kRoXw9DBxoCHUZrk9K1x
	9qJQ5v+riA5p/o8jJ/5PM/ZRvXO5vXztXzOei5r1iuK1UqmV1KyBJXG2wTryfSJWelk76KsBnFp
	PoJxrr7SCGsS8m6STVA65WdaxiVEvu/vNYGwvrhyRzl1bnKBh1A=
X-Google-Smtp-Source: AGHT+IGRukL3IXabxcCFKZppPUsWom7Io06VY/r+HS4hnkGjXR5xf1Ph8KP/wp7fO5A2N87ZPa2p4w==
X-Received: by 2002:a17:902:f745:b0:220:ea90:191e with SMTP id d9443c01a7336-23ac3cf5451mr179954255ad.4.1751284198016;
        Mon, 30 Jun 2025 04:49:58 -0700 (PDT)
Received: from localhost ([2001:250:5800:1002::cd55])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b34e300d808sm7928785a12.14.2025.06.30.04.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 04:49:57 -0700 (PDT)
Date: Mon, 30 Jun 2025 19:47:40 +0800
From: Zixian Zeng <sycamoremoon376@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Longbin Li <looong.bin@gmail.com>, linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org, sophgo@lists.linux.dev,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/4] spi: dt-bindings: spi-sg2044-nor: Change SOPHGO
 SG2042
Message-ID: <aGJ5XAYZ1nmQyBQT@calculate>
References: <20250629-sfg-spifmc-v3-0-28db1f27e999@gmail.com>
 <20250629-sfg-spifmc-v3-1-28db1f27e999@gmail.com>
 <20250630-ancient-quail-of-joy-effd60@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630-ancient-quail-of-joy-effd60@krzk-bin>

On Mon, Jun 30, 2025 at 09:17:09AM +0200, Krzysztof Kozlowski wrote:
> On Sun, Jun 29, 2025 at 04:23:10PM +0800, Zixian Zeng wrote:
> > SG2042 is not fully compatiable with SG2044,
> 
> Typo, run spellcheck.
> 
Thanks for spotting that! I will add spellcheck to my patch checking script next.

> > So it is necessary to become independent const
> 
> No capital letters after ,.
> 
Ok, thanks

> Anyway, explain why it is not fully compatible.
> 
I have asked the technical staff of SOPHGO, the SG2044 and SG2042 are indeed incompatible with each other in some places because of the hardware details, regarding the configuration of the OPT register and FFTrgLvl(fifo trigger level) bit setting.

> Best regards,
> Krzysztof
> 

Best regards,
Zixian


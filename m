Return-Path: <linux-spi+bounces-8903-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3CBAEDC6E
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 14:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32E907A7973
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 12:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A64289831;
	Mon, 30 Jun 2025 12:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7B8gy6C"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9CB287251;
	Mon, 30 Jun 2025 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751285548; cv=none; b=lOWlDc6GTcYHoGnJ7Bg9VAq98PXHJ/sU+TZTOD7SpY31gpN12zIwt3U3t+C51VjJzBRJf1RfMJd6pKG36+EHSVz4Fvzfvc8Gd1YYL33brAVi6CkCqG9KRH0D4t1Aj/ErK1x+sQnLQmdWUJowFbgG/1G2LSbxvPtfekbWcDegRnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751285548; c=relaxed/simple;
	bh=ymAm2RGsauWyqhaGIKdrhj01x13vqQy3GTjiWCnEznI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGcll/t1iHGbpiu77vYbYZww8YsalmoooENXp0wUQo4lcnmVlC2FepjN76KSzCIurXmn1e4UgT8NieyolkEQlFxNJ41Hc/YYc6yE9RiWWyBQivCNI9DBbHE2T4bVRUU+kN7796O2NdTM+02pDzliE6G8fgNcGLGHwICjEpqLYkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7B8gy6C; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b31e076f714so5044974a12.0;
        Mon, 30 Jun 2025 05:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751285547; x=1751890347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9kYgTWxigFnMh6J+7o3rXH2dHsX5hLP6u8Al9k3eKS4=;
        b=B7B8gy6CqaZryVm5kzfiTAxCrTHwctQFEwzXrSaPOWP/4lTNuhuZN+y0M/k4Pt0bWZ
         liS8OFfihJfm226Qb3LkQzEd0T4NqbKiXQL0mlz9uPHTX81oxb8YPI/ilVlSlh+vjmtR
         UWwCAyLcRP0MESXYsau3lwacR2gORp1LY22Q0nPR1jn9GZJi68VwGeLU7TpL5QE9D2vB
         ZWCin1BJBQ0mDXrOlonM4Jd7u76qUO4H3uY857Kt8/oQiuonBr6DuX4Tr5WIxJ7EvFZd
         qO4g7tH3eXozztOVY4Y31mNP+6LrhbT64nPUPGIS+A5OaaS3S9Doq/3Tuj0CRS0XvPDC
         9qYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751285547; x=1751890347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kYgTWxigFnMh6J+7o3rXH2dHsX5hLP6u8Al9k3eKS4=;
        b=SNkWSrULNV/XepQQ1HmfaAqKNak2fVNEGOqihms6jLl5ws0vr29N2+LaRrdTjKouqr
         tGH6wO3dgISBMy9pi0Z+xJUGVbAcGjKgU857uojLijn+mZA8JiB0evO6aMswcJNsGHZe
         o++ADZCEhGQej4t1JXld6Zd+lAEzM+Tw2TpldqTmtX6MQUBUBEkCy7P77fUxlYtnTVSd
         HB9vviTxZ6x7H6qL20cKj5ey3BUsTYJghIOMBQ1yucw3oimShU15jfzPdhDrFnquElky
         h0888e3klwazBUJPpGugJO5EhCw/TdGhg6wcfkqXgR6zKR07bKY0Lj9kgJsPkd8YfRN8
         yYQg==
X-Forwarded-Encrypted: i=1; AJvYcCWH/yvFUttYAKBdg3ziGcqINVatHW+yO9B6L2W0DOMvueNIb4TFtva1t1ti+mx7NVcreIzEIfXzIXWdZN/z@vger.kernel.org, AJvYcCWcr32YEa0MC0XPgD2agEJ5oiHl+3XdMNy5k77eGuM2gPLhUbXusix7Ym6OWKZqn0BexT+3e8ITn3ot@vger.kernel.org, AJvYcCXzIPen8ejNaTHddwcn1HitGnNY6mDGRQIIxgGX5OcI2G0MB62HtN/JVVufZryIez+cvi5sA/EpeOoq@vger.kernel.org
X-Gm-Message-State: AOJu0YwV8wpSJu8tJE59wn/x8aAwGM/DzvTJEoHkU//Ui3zDi/w8OjVz
	3Pax2CsGzm8PWsTXN0cKDHGdDh7ldezWyz/YVMBsqx0cY9WvEBH8lGcj
X-Gm-Gg: ASbGncsx9IEzqawCvQRZ/P9HZVfoIYKRqrfQRuLCU3Twyylq0BsKKguYS/m4NIIIYWH
	8SpK9PuuYlArBvjEyezBV3VxmzNc4ejSGrn1uGOEhvO2H8OdvOlsc7Os/js9ljo3KLBLmctGK00
	4Xd2zGgtKo6B/qbdPZbHiwwVzV992fPytWFW8efErYvFhba8el6Swr4hfKFA1DQ7K20Pm7l7opy
	HyX2L4qoF8pbIHTEbkK/mffmmqzUov/uCaeYD/qTzfNFg8grNiqPPBprGNf1zIxsSjJ/xNkZPHg
	a7T6AMxD58z+lcjJ1Wv0gPo5HIFQQYHJNKa0IR8DviDm0eqPrwg=
X-Google-Smtp-Source: AGHT+IHsIFpQ45mX5GXGIU8w06ZUsQgrAuvEXHa4TYUkn6AoK+LxDTuZVhduM++WcW9fKEEMhIst4g==
X-Received: by 2002:a17:90b:55d0:b0:311:482a:f956 with SMTP id 98e67ed59e1d1-316d69bf0cbmr24097074a91.5.1751285546499;
        Mon, 30 Jun 2025 05:12:26 -0700 (PDT)
Received: from localhost ([2001:250:5800:1002::cd55])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-315f54412c6sm13168373a91.43.2025.06.30.05.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 05:12:25 -0700 (PDT)
Date: Mon, 30 Jun 2025 20:12:22 +0800
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
Message-ID: <aGJ_JtThs7VpRIwa@calculate>
References: <20250629-sfg-spifmc-v3-0-28db1f27e999@gmail.com>
 <20250629-sfg-spifmc-v3-1-28db1f27e999@gmail.com>
 <20250630-ancient-quail-of-joy-effd60@krzk-bin>
 <aGJ5XAYZ1nmQyBQT@calculate>
 <4afcef9e-db98-4679-b9c1-40ffcf4861c6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4afcef9e-db98-4679-b9c1-40ffcf4861c6@kernel.org>

On Mon, Jun 30, 2025 at 01:55:58PM +0200, Krzysztof Kozlowski wrote:
> On 30/06/2025 13:47, Zixian Zeng wrote:
> > On Mon, Jun 30, 2025 at 09:17:09AM +0200, Krzysztof Kozlowski wrote:
> >> On Sun, Jun 29, 2025 at 04:23:10PM +0800, Zixian Zeng wrote:
> >>> SG2042 is not fully compatiable with SG2044,
> >>
> >> Typo, run spellcheck.
> >>
> > Thanks for spotting that! I will add spellcheck to my patch checking script next.
> > 
> >>> So it is necessary to become independent const
> >>
> >> No capital letters after ,.
> >>
> > Ok, thanks
> > 
> >> Anyway, explain why it is not fully compatible.
> >>
> > I have asked the technical staff of SOPHGO,
> > the SG2044 and SG2042 are indeed incompatible with each other in some places
> > because of the hardware details, regarding the configuration of the OPT register
> > and FFTrgLvl(fifo trigger level) bit setting.
> 
> So when driver binds with sg2044, the device does not work? Or what
> exactly does not work?
> 
> All this is supposed to be explained in the commit msg.
> 

I got it, I think I had explained this in the driver patch[3/4].
If this reason is acceptable, I would like to ask whether
the explanation should be put in the binding patch commit msg [1/4]
instead of the driver patch commit msg [3/4]? or both?

Thank you.

> Best regards,
> Krzysztof

Best regards,
Zixian


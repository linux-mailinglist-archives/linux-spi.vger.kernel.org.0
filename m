Return-Path: <linux-spi+bounces-7035-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D05FA4F3AD
	for <lists+linux-spi@lfdr.de>; Wed,  5 Mar 2025 02:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4857188265D
	for <lists+linux-spi@lfdr.de>; Wed,  5 Mar 2025 01:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B741143736;
	Wed,  5 Mar 2025 01:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CekRta1O"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094E11EB3E;
	Wed,  5 Mar 2025 01:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741138168; cv=none; b=EDB/8CWzJLAj6WgAq/UmvMeHOnJniXyZqnnhmhUNAHSQWYbCLTCnkOl4Ns2eFWi8Ssy9Ky2+h2AaEM9ZY6sRq4pxK39fwiCd7GO1J18S7H/SIYAO8nI6noYk3Si7+u962PAA+QwTlQdLI8j2X/MMXZwHS9TE/+s1EM4UUP4KW4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741138168; c=relaxed/simple;
	bh=Mkts6pb/AOEqCXZVNVRMrjdozYBbwYAMrEF68H7BQiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODwnrsq8KJnxnLmpqeUK2+/9AmensZqFECNeoqglr++EGxi74DEAIoMs4KzskIN6JyhuEk/fftIDzWyq1gp53/Sc4Vq355As5baJHwO5WYSd9iueW7OaRcFWRtcKmWp/ualiEL2HGXM9GHDGDrrjnvsbaI8fHyR1dBb8Fa5InD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CekRta1O; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2232aead377so123505885ad.0;
        Tue, 04 Mar 2025 17:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741138166; x=1741742966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lMhzBhCrPjIqQGQg1Wg59vv0ddj0LU+xkyGOMArKoKg=;
        b=CekRta1OuL6hdbJoR7m6jLssy55M3E/xjuGBtj+Ax8UJlnqx7uDVjGhmudWE/gSrXL
         Je0nQV+3gE+XbgJGWGThFSpoufLW5QsYygIV4ItTko7+GCioI5R/r5ejFXVzU73d5oPh
         UQnyw0STgrP1137bBBzkD2s02hVV+i13xKlCysh5AF22jOTOEZ2+FHOCTUbAEWv3T+Ku
         SsExMX5eGhMkyHHrc37SkZ0U41CCLS3REjJbHPLlSmQ3a2R2grzG3oinJQ880GxhXTm8
         13yI7xb4Nkeya+ZkJzoK7m0ZSJqeWGebHQNnpt/wqDAnTYOpvwpnP2OLujUtmRalfF3H
         i1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741138166; x=1741742966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMhzBhCrPjIqQGQg1Wg59vv0ddj0LU+xkyGOMArKoKg=;
        b=JDtU8MyYC26nqVKClplVdh0A6EW9Pt+FKaywM30ArXDSdtKFtogXhiqS4QYHAQOJ4v
         iUGSX7Xo+2Ls/xt33OegZkshxH/W+iyTMnxnEbIB6Jsj+LIG9VHO2S1Rg6T1gzqMr2xJ
         C/++/PrbN84jIqM9NM4RZKWsKc2tnNJ72C4ESyuwTb57oD77SN/7Jf3c2XhzR++iCVoo
         hw0DeZH7nPXDIu+mV1ReLG2Fqe2Iw1pvbTUdPvFOitAJelSPrJAwcLdJy4z1TBKeIj0z
         BMafOp2mYhMHP+YHHCjIVywopGP2HdPiyftkLhPjn/RPLyRrt1Y2f1dptZOD5jMh1+VD
         ZMog==
X-Forwarded-Encrypted: i=1; AJvYcCW4f22WW2/A8tXrsQB6ENbC5qxqsizwKM2OIPwTMWkz7E40s5TAku5IZT+2WlHZIyjRDQ471Y7+1Emjz5yG@vger.kernel.org, AJvYcCWAbv5HB+ezMSn1kqfiIw/C6QtOrG0lYxkT1Jb5e2iaCbMSXZ6cXRh2GPNNJTlV3SYKV26pKKLyse7/@vger.kernel.org, AJvYcCXz/+kR2gB6Ho6Hm5w+snmSjQaCDbfqo4SBO4FUwVxTKwh2PbvOr6gWmYKMP/tjP2RfKx13C1Lf2Uc8@vger.kernel.org
X-Gm-Message-State: AOJu0YyNqR/7Kzo1cqflnAyXpbo68T7VIHG5wqCT0vWzXt1uwSwrlMbv
	ay44t/KN7qYuoXWB/nRyAr4eiyiAqzPJv8xSFnl9tPjhOiTwNv7L
X-Gm-Gg: ASbGncs/XzEkYbWMGzOs5vGoR1VGi/i3Fkkz3OlJ9DKZrOUpTLfH7DzYIPhcQg5cUCE
	4Zl5HgwkaWZpFbr/UTvqY5WNKyWCtHbfiiYHn821Smxe/00ypcNRw/c8ilTt5TRijgQXGNtECzB
	oaOLNCYxUw+lg6qIX1hcfRBD7oawo1DWsPesULkWod2zd2xRGf1Tf+EwexTHvw+a5QFk0+oVLPs
	C74fhtOuyWwsW8wlYSzCg/y8w8Bh9CJ0JvHsixTDHalgjBQOevwbg2NxCICIarTxRR5OaSoZ5k6
	PccZglP7ADYVycIw59qd2kc=
X-Google-Smtp-Source: AGHT+IGMYeB1wOukNuf5Z9VnV6HZIq+bca5LXw8M9agga6DcCzRyxOH6Zle9qOflX6ikXDadlX9ecg==
X-Received: by 2002:a05:6a00:1788:b0:736:533b:f6fa with SMTP id d2e1a72fcca58-73682bef664mr1796095b3a.13.1741138166235;
        Tue, 04 Mar 2025 17:29:26 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::460])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7362c92271fsm8578986b3a.1.2025.03.04.17.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 17:29:25 -0800 (PST)
Date: Wed, 5 Mar 2025 09:29:24 +0800
From: Longbin Li <looong.bin@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Inochi Amaoto <inochiama@gmail.com>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	sophgo@lists.linux.dev
Subject: Re: [PATCH v2 0/2] spi: sophgo: add Sophgo SPI NOR controller driver
Message-ID: <oghkqkoilkg7ny5saa4fi77hcawkdbeih5zg5aaliv6kf42jee@2nmyxje7itse>
References: <20250304083548.10101-1-looong.bin@gmail.com>
 <PN0PR01MB10393099D28CF3DF75A0F414CFEC82@PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PN0PR01MB10393099D28CF3DF75A0F414CFEC82@PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM>

On Tue, Mar 04, 2025 at 06:14:54PM +0800, Chen Wang wrote:
> 
> On 2025/3/4 16:35, Longbin Li wrote:
> > Add SPI NOR driver for Sophgo, including read, write operations.
> > This driver is only suitable for NOR flash.
> If there is a next patchset, please also replace "Sopgho" with "SG2044" in
> the cover letter, including the email title.

I will correct it, thanks.

> > ---
> > 
> > Changes in v2:
> > 
> >    Fixed following issues as per comments from Yixun Lan, Chen Wang, Inochi Amaoto, thanks.
> 
> I feel like you left out Rob, and you also left out his signature in the
> first patch ;)
> 

My fault! I will add his signature in the next patch, thanks.

> > 
> >    - Replaced "sophgo" to "sg2044" to avoid conflicts with other drivers.
> >    - Improve driver code:
> >      - Improve coding style.
> >      - Removed the [PATCH 3/3] in previous submission that based on the baseline not submitted.
> >      - Added error handler to destroy mutex if probe fail.
> > 
> > Changes in v1:
> >    You can simply review or test the patches at the link [1].
> > 
> > Link: https://lore.kernel.org/linux-riscv/20250224101213.26003-1-looong.bin@gmail.com/ [1]
> > ---
> > 
> > Longbin Li (2):
> >    dt-bindings: spi: add SG2044 SPI NOR controller driver
> >    spi: sophgo: add SG2044 SPI NOR controller driver
> > 
> >   .../bindings/spi/spi-sg2044-nor.yaml          |  52 ++
> >   drivers/spi/Kconfig                           |   9 +
> >   drivers/spi/Makefile                          |   1 +
> >   drivers/spi/spi-sg2044-nor.c                  | 500 ++++++++++++++++++
> >   4 files changed, 562 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml
> >   create mode 100644 drivers/spi/spi-sg2044-nor.c
> > 
> > --
> > 2.48.1


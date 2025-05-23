Return-Path: <linux-spi+bounces-8272-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43436AC240D
	for <lists+linux-spi@lfdr.de>; Fri, 23 May 2025 15:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E22A43CCC
	for <lists+linux-spi@lfdr.de>; Fri, 23 May 2025 13:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE1729292F;
	Fri, 23 May 2025 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdO6QroD"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC41529293D;
	Fri, 23 May 2025 13:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748007074; cv=none; b=ZD1BbmN+7jh+RvYNpFyqx2RxvKcc8UGxsmJSsuTetZGUMnWaTyO4aRlehE1TKMwiGFHdTpvcuY/NvVOUZD/UA9fuKr2dHTywP6g1tZQ1LzwJQU9yGcCbXiJVJTXyxaX9DBRuXyhsYSzAZsxleBPhi0meBQ53Jspjcr/ML+CRp+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748007074; c=relaxed/simple;
	bh=x7MXJmmi2wAWHuMNAG2bEFBDQGLJOpgvMJzqXoNhxPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kA70auKTaWpFebm1AAUFioQvp5txuiELyyWoQp1w/h4sM0rv2JgvT4oPCWeWcJWnUEFQ9M/BRxoIRS0TVTQpOsMJcUoipdUX6Q25qMhSK7SYK2+6edtEb6e/h24jA7tylPh2wdT8thcpl3JTr91C3JqoulAiyaevwsG6Soj/HFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdO6QroD; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2320d06b728so51991745ad.1;
        Fri, 23 May 2025 06:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748007072; x=1748611872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UHviDmj3xu42QGU1Ib9f7zk1dVsPa60dS0RLUI16fXE=;
        b=XdO6QroDz9kfB71KqXq0UzmofZSxtfQvK1q83r9HYRv8RyacGcOwRG4vCfpSNp5PQH
         xcrJQfI9RfDO5DcD/zOTNJht+j4DIa7PsHVfxTZddwsYONuQc3QebvtElv8mhzpPfxws
         kgg+Z4MIeUpzy8seZFaeX3E715xZRwdHuOWRArBAXdbc/PljP78tilpu8k+9CGj3/52G
         aUngl/IdCK30gMhCl1Rdh7BHq5JqViuWP7ETF9ZfHDyyjtJWuwNz0a2J/DmMaK+wHNv/
         aEx2MV4/fL4Fww7BJU7GuZAxoSpnzTiPJYnGPS0EOkmgUvpkMWty1d2e5UtmmjhqaI3X
         9yng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748007072; x=1748611872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHviDmj3xu42QGU1Ib9f7zk1dVsPa60dS0RLUI16fXE=;
        b=pn7SDX0+P8WApSW0o/7kFCEoVos/1SPJO8yjqY492ZsyjHU82AeDJjA2AOCGbxV7Jd
         BT7f62qqcukq7+i8bOHhrCOwxk9tV5DUMLAoMmeTzKkFYJPCnczygvMLqWDF5AVEH+1p
         PkLEukJzIDnl8/w8qRAZaWAD+CQK0uUqAWUi5F4YhFSkQC8aqHDxqk4voolqWCPWkNKI
         pTljvR9ygFMD4VICIokeHzPEXbOZqgEzplvPahnrco/e89XTwhLTuqJry/6hgR1YKdfj
         FPAl4e0AD0CI7NE784rnfcON21ydmCS2NBnZ8XTfjM4EKyrGUdOInb1/wXUZw8ssfdYa
         YrMA==
X-Forwarded-Encrypted: i=1; AJvYcCVY81tki2Kgrs1VszQoVwf2OyJIybQbMIBUyNnymnV7YMtbFPSLCtW9sszSMRI2D9izS/RKXMziU+l2LcwO@vger.kernel.org, AJvYcCWD+rk2Jtw8Ft3OSe9g+voXPKo4suldFtr4wsvlHa0jnUsHWKZxy6oq8H6fZ0x4Tg2ub86lREi6ShH8@vger.kernel.org, AJvYcCWkzyv0zw7fEhav6eHoJ84m8/Ta4bamjA77BZ6HBWDmGAy9LYez4+Trp5xWoo25jT1+iUe7Vsfvv3nu@vger.kernel.org
X-Gm-Message-State: AOJu0YxK/+3OZenPsx+JuiwXMcA4IwnPgJob+fhqslGxsVEaqMx6dJ5x
	DMNPMI+2tkwqNIakOeIrxG+/HyGv+xMv4HT2fhcK33kZwIOdPM2puNJq
X-Gm-Gg: ASbGncuFCtZtcb9ybZs880wik7lCKKb12dB2P1S1XTsDEyzWZEcQGiqb/EFnmTvRuYv
	72cTO8GzD+o5+LLzbcie3NCDGMP+hmqk/JvAoyZquq3eIhjMqhRM3MdLh6ZF+jw3ew+qnpjbeaq
	o1+mzbT1HcXc37weP+gsIhDmZLlUCsJTGLIdb09rLR0rILLwX7Gkts/6GEpZtOGHwGbHahr1UUd
	N9Ay8p1o7TGUHRTix9Two+QUJLmI5asLuVsoesWvEIyBiQ+aYJLHb3g6ptFGraj2zqgfU36YjUg
	yEH8m3TKfPxDxR72thavbqHBmorAkcgxloKcBBe+
X-Google-Smtp-Source: AGHT+IGLbgtx4Af3Q4/lm93aVPuKQYWmNhIgnWUD8AgPn231XjLOFnnKcHeakMtqv3fSR76ZQS0WhQ==
X-Received: by 2002:a17:903:18d:b0:224:c47:cbd with SMTP id d9443c01a7336-231d3257fc6mr419336045ad.0.1748007071336;
        Fri, 23 May 2025 06:31:11 -0700 (PDT)
Received: from localhost ([2001:250:5800:1000::3fc8])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b26ecfc85e9sm12505536a12.11.2025.05.23.06.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 06:31:10 -0700 (PDT)
Date: Fri, 23 May 2025 21:31:07 +0800
From: Zixian Zeng <sycamoremoon376@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
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
	Longbin Li <looong.bin@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	dlan@gentoo.org, ziyao@disroot.org
Subject: Re: [PATCH 1/3] dt-bindings: spi: Add bindings for SOPHGO SG2042
Message-ID: <aDB4m6THbV19qjwP@calculate>
References: <20250523-sfg-spifmc-v1-0-4cf16cf3fd2a@gmail.com>
 <20250523-sfg-spifmc-v1-1-4cf16cf3fd2a@gmail.com>
 <5ce44ff6-831b-4128-9fab-7658ffae550f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ce44ff6-831b-4128-9fab-7658ffae550f@kernel.org>

On Fri, May 23, 2025 at 01:33:13PM +0200, Krzysztof Kozlowski wrote:
> On 23/05/2025 12:54, Zixian Zeng wrote:
> > Add bindings for the SOPHGO SG2042 SPI-NOR flash controller,
> > which is compatible with SOPHGO SG2044.
> > 
> 1. This wasn't tested.
> 2. Breaks existing boards, so you did not test DTS either. Do not
> reviewers but machine for such trivialities.
> 
Sorry, This is my bad. I admit this is a pretty stupid mistake and
I should have run a full dt_bindings check rather than the platform I
am testing currently.
Sorry for taking up your time, I'm sure this is the last time for such
kind of mistake.
> 3. A nit, subject: drop second/last, redundant "bindings". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
> 
Thank you, I will remove the redundant "bindings" next time.
> 4. Please use subject prefixes matching the subsystem. You can get them
> for example with `git log --oneline -- DIRECTORY_OR_FILE` on the
> directory your patch is touching. For bindings, the preferred subjects
> are explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
> 
Ok, I will do it in next revision.
> Best regards,
> Krzysztof

Thank you again for your detailed revieiws and links

Best regards,
Zixian


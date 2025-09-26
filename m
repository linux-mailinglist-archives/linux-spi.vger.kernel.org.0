Return-Path: <linux-spi+bounces-10297-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0072BA25D5
	for <lists+linux-spi@lfdr.de>; Fri, 26 Sep 2025 06:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F262F1C02861
	for <lists+linux-spi@lfdr.de>; Fri, 26 Sep 2025 04:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEEF26D4C4;
	Fri, 26 Sep 2025 04:07:25 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B0B1E285A;
	Fri, 26 Sep 2025 04:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758859645; cv=none; b=ciXGFg8Bg/o47P5809//YVd3mg0t+D6rwPfILf1ncNa5zg+lUUYO658KQQdQbtCDUQLaL1LW6Tv7YRkT2Gb9XvUsUUurJCo1hVB5WQgOpNXl7G0gf7q6+TyeKBc9OnneOu3fy2c97Dm/J6cIv0641bUXmiMflUdvR7+stNiW3c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758859645; c=relaxed/simple;
	bh=roQeEiP+p/oaDTsgvdcZ3zKhLA37iUpBPXtwfDrnVzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8OEigBX7/tnzADfcTJJ9BetA1QcUoGAXEj+AY44s37bXnceQ+wui04Ya4yG+nJ+jayQRPtvxDCkZ3u6nL3mrjjjwSWrI8T8DWwKN8hFtGD28tB6AtBbiLr/RH+13TB2amoRviSDo8u0exulRd0AUVk4tt20epytzqscJYnfRGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [180.158.240.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 01DA2340E85;
	Fri, 26 Sep 2025 04:07:22 +0000 (UTC)
Date: Fri, 26 Sep 2025 12:07:13 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Alex Elder <elder@riscstar.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ziyao@disroot.org, junhui.liu@pigmoral.tech,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, p.zabel@pengutronix.de, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] riscv: dts: spacemit: define a SPI controller node
Message-ID: <20250926040713-GYA1324993@gentoo.org>
References: <20250925121714.2514932-1-elder@riscstar.com>
 <20250925121714.2514932-4-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925121714.2514932-4-elder@riscstar.com>

Hi Alex,

On 07:17 Thu 25 Sep     , Alex Elder wrote:
> Define a node for the fourth SoC SPI controller (number 3) on
> the SpacemiT K1 SoC.
> 
> Enable it on the Banana Pi BPI-F3 board, which exposes this feature
> via its GPIO block:
>   GPIO PIN 19:  MOSI
>   GPIO PIN 21:  MISO
>   GPIO PIN 23:  SCLK
>   GPIO PIN 24:  SS (inverted)
> 
> Define pincontrol configurations for the pins as used on that board.
> 
> (This was tested using a GigaDevice GD25Q64E SPI NOR chip.)
> 
> Signed-off-by: Alex Elder <elder@riscstar.com>
>
Reviewed-by: Yixun Lan <dlan@gentoo.org>


-- 
Yixun Lan (dlan)


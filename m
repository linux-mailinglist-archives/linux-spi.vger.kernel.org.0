Return-Path: <linux-spi+bounces-6008-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D97B69ED10D
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 17:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA40C167923
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 16:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5000B198A38;
	Wed, 11 Dec 2024 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMUHue++"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111B924635F;
	Wed, 11 Dec 2024 16:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933768; cv=none; b=I8R68YJv54YcD/v3uhX8wqdbIgn8jzfSD3yiXY5eKtQ6BvgJC3TZk2spw4C+0fvpe7pmxRsRODGlcxPumxh8l8zAotf8tmr3Em0aC1lq+IrreJJMWtceVy+qS2fuk67OyWqHfOCCh0F9WS56ZX5VMH82ZC+g6RLevENbhK5lpT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933768; c=relaxed/simple;
	bh=oKBNSq3mc2lrPbEFRIMyv15AXFDjsWHNQwb9AyrvQDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvTbgelojPKh/PsuXVlBU1RNtlCzkPnKQLbRvNF8F5qafBh/ulpuzm7I0a5RNQfukeBwtTCH4kCYwfZHMDFe7jTP+cpTxW7YvogvDpvublnzkQCPR5yX6wAByTTToQfYrDn/O/AfoNICReCQYy7/IScnLlUks5+qx2j5EWpuN14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMUHue++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C55C4CED4;
	Wed, 11 Dec 2024 16:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733933767;
	bh=oKBNSq3mc2lrPbEFRIMyv15AXFDjsWHNQwb9AyrvQDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iMUHue++r6KT0HH4KJSJE6Lofit49dMv2k3Ulo86AA3BGcy02NKU6uZkZbfvs7UeC
	 KdK7D7C+hntWMNDumN0PiyrTFISDGveYwtjllhVu0dlo72zKiAexCw2bJIAUAg+SXN
	 WYzGqqvhz1R6BzGj9UvwjHrkwX9LosVPIsL+Nbjlfhlh4AJqSnrWI0Tit6GQi/1WxW
	 kd10hVlNNGdy3gEHN4qFD65rfZxeHLBYzZ60FIM7GWSyNNYBYaN5zz2Y8Tndd8yewK
	 +7m+ALcEzwxLVKv47zl6VI3btLjovpVKif3MAwBuO2sQJXn1JVxtPF5bEINRNlLd3W
	 GO9e0EXcr0GVg==
Date: Wed, 11 Dec 2024 10:16:05 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: alexandre.belloni@bootlin.com, romain.sioen@microchip.com,
	linux-arm-kernel@lists.infradead.org, claudiu.beznea@tuxon.dev,
	arnd@arndb.de, linux-clk@vger.kernel.org, mihai.sain@microchip.com,
	devicetree@vger.kernel.org, conor+dt@kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	nicolas.ferre@microchip.com, sboyd@kernel.org,
	dharma.b@microchip.com, linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org, varshini.rajendran@microchip.com,
	mturquette@baylibre.com, krzk+dt@kernel.org
Subject: Re: [PATCH v3 03/13] dt-bindings: atmel-sysreg: add sama7d65 RAM and
 PIT
Message-ID: <173393376441.3234883.1609232326529788470.robh@kernel.org>
References: <cover.1733505542.git.Ryan.Wanner@microchip.com>
 <96e64f01eee264ad0ac4c720a7a1cab4f95c206b.1733505542.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96e64f01eee264ad0ac4c720a7a1cab4f95c206b.1733505542.git.Ryan.Wanner@microchip.com>


On Fri, 06 Dec 2024 12:59:48 -0700, Ryan.Wanner@microchip.com wrote:
> From: Dharma Balasubiramani <dharma.b@microchip.com>
> 
> Add SAMA7D65 RAM controller, PIT64 DT bindings.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  .../devicetree/bindings/arm/atmel-sysregs.txt      | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



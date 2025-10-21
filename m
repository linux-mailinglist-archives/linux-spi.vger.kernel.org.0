Return-Path: <linux-spi+bounces-10752-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D845BF5F10
	for <lists+linux-spi@lfdr.de>; Tue, 21 Oct 2025 13:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 592964EDD1D
	for <lists+linux-spi@lfdr.de>; Tue, 21 Oct 2025 11:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1A02F1FEC;
	Tue, 21 Oct 2025 11:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqrI2t5l"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FEB2877ED;
	Tue, 21 Oct 2025 11:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761044637; cv=none; b=Y22RQ0AoKU/PnjBNK9Eqj6XmOPw7kuZ9wGWlhWtDmHtE7yR8q9gxw3DwLLuWpC9ke2YJpaPtAvWstZyy2gLKJl+LZUGw2PRWHPu+4qO15+LDugn0DhBpmiWykUuGnnPKWIvnx8rxuFx42mSsbZJm7rIuR64TSfeEjc//uK+Ixco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761044637; c=relaxed/simple;
	bh=SHxSErjxeIC0wJXIpapagxucXuEJ6b+Lz5V6ebB91Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDPPaZdE60Q2KNx9jpf9RjT6H5pCBLJEOqeMvyZoVD+I/CN+RCwDi2OZATAXUa3ocwKSnBQksMhDkt/irwhoB6dmxz2L7ohjctH+hCGkJCIsg3Az2B9SS4gimLtrW4A/SlvRpBHWN1DvCXxsxEpescaTNwaBtmEwb8XedMVQ49Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqrI2t5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5423FC4CEF1;
	Tue, 21 Oct 2025 11:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761044636;
	bh=SHxSErjxeIC0wJXIpapagxucXuEJ6b+Lz5V6ebB91Qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RqrI2t5lnFarLBNV6TXNE1G68n9BjBDrq3MS/p+FfQkLw7SIRuP4nafZxK88irvLO
	 OYI+VkTDv+GOj7YPVaVOlzoQQyC9aapITX+52Od/FDPgSfIOtawAFW7IYWnRYn1ymH
	 E+hCVHPt/PHhsgwHrph1ac/Zh5RG5MXYyg+Teaynmvut7uVr/bkv8BohQX646vjMSL
	 eaGUN0z4TLo/c85WFWY/7MxzoGOiALNqA5z99di8EXBlhxFY7eQlKURwJLjehmSMcb
	 NHsdhpTtVCwu/46+nKEAIX5ZMUUVcuWUrBW0AKIo7EYmxpxto7+AbIQFQ2uHSCVtm5
	 n9yTCldJQnkmg==
Date: Tue, 21 Oct 2025 12:03:51 +0100
From: Lee Jones <lee@kernel.org>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Pavel Machek <pavel@ucw.cz>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Steffen Trumtrar <kernel@pengutronix.de>,
	Pavel Machek <pavel@kernel.org>, Mark Brown <broonie@kernel.org>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] leds: add support for TI LP5860 LED driver chip
Message-ID: <20251021110351.GF475031@google.com>
References: <20251007-v6-14-topic-ti-lp5860-v4-0-967758069b60@pengutronix.de>
 <20251007-v6-14-topic-ti-lp5860-v4-2-967758069b60@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251007-v6-14-topic-ti-lp5860-v4-2-967758069b60@pengutronix.de>

On Tue, 07 Oct 2025, Steffen Trumtrar wrote:

> Add support for the Texas Instruments LP5860 LED driver chip
> via SPI interfaces.
> 
> The LP5860 is an LED matrix driver for up to 196 LEDs, which supports
> short and open detection of the individual channel select lines.
> 
> It can be connected to SPI or I2C bus. For now add support for SPI only.
> 
> The original driver is from an unknown author at Texas Instruments. Only
> the cryptic handle 'zlzx' is known.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  drivers/leds/rgb/Kconfig                  |  27 +++
>  drivers/leds/rgb/Makefile                 |   2 +
>  drivers/leds/rgb/leds-lp5860-core.c       | 222 ++++++++++++++++++++++
>  drivers/leds/rgb/leds-lp5860-spi.c        |  89 +++++++++
>  include/linux/platform_data/leds-lp5860.h | 305 ++++++++++++++++++++++++++++++
>  5 files changed, 645 insertions(+)

Please see and respond to the most recent v3 reply from Jacek:

https://lore.kernel.org/all/5d8ec4c3-1b36-470b-a1c7-629060a154ce@gmail.com/

-- 
Lee Jones [李琼斯]


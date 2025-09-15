Return-Path: <linux-spi+bounces-10014-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB0EB56D7D
	for <lists+linux-spi@lfdr.de>; Mon, 15 Sep 2025 02:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF7674E14D5
	for <lists+linux-spi@lfdr.de>; Mon, 15 Sep 2025 00:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564C51C8629;
	Mon, 15 Sep 2025 00:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFpdMdw2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26177CA4B;
	Mon, 15 Sep 2025 00:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757896942; cv=none; b=rEaS1wSBlcE9qD2je1i4DroeURF2xcDhzSJaUmEoG2as6mmGwy0vOlcQZ9MKqOk8b9o2BCwLAHmW6M+ePsB3YKOTFmMuSZZCljntN5h8Hn6AGsrXiqO2Idqxr3xlOe5r3UjhZ1793D70NCfO1b+OQRzNXI0W/eUGvGoK+BXCNkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757896942; c=relaxed/simple;
	bh=3xACFaqhY1F692TvG/OmTq2sJbLJr7G7sXl5J74b0RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tr7UT1R7E202AtojN+OuYelurVcqOUb+Qaqyq9VLeqO1AkePXkRHvXGvX0ImeqMEKyUFqZm1R5f/fHrAi/aduPUeBkPCj0n6oLAYZ2c4FD+X6YzGx8dVgyO/SAKDf49tbQ3gTvy9AiSBLwZ7u4O7QPN2+3mrjSbmzY3i/i5jHNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFpdMdw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F59BC4CEF0;
	Mon, 15 Sep 2025 00:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757896940;
	bh=3xACFaqhY1F692TvG/OmTq2sJbLJr7G7sXl5J74b0RU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cFpdMdw2lJTFxWMx7uTYKvPyQ7pfjq53ez/oI9lCQBCqxmnu3p4ZPR2UnFAcP0JLj
	 /pExl8TWPOdF+xD1BmY6EJ2DOgGh/UrH8mzEaymg3HlnAFVZu+IzZQgb75eZWuaCZ1
	 jR696pFMA7cmHI3REdvD3nZ7CZtKhjcqZFSdobfKYLxUti9P5QjszjWlBU0gagFU8r
	 ilLakIoF9XGFmfQOCHyURPhSPhvskEPXnuUyx3vQT90gmj8axJvsKpUDsn/1kpEI5X
	 0pV1cOTsidUJ1Lfp0y2elSfDzeZ+DjBiEHOyqRzC6NVlZqsB+Zw6byoXgCFF4PYV4e
	 TFoG2mCtx1ZgA==
Date: Sun, 14 Sep 2025 19:42:19 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, kernel@pengutronix.de,
	devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Steffen Trumtrar <kernel@pengutronix.de>
Subject: Re: [PATCH v3 1/3] dt-bindings: leds: add lp5860 LED controller
Message-ID: <175789693917.2329297.10620456480639839593.robh@kernel.org>
References: <20250911-v6-14-topic-ti-lp5860-v3-0-390738ef9d71@pengutronix.de>
 <20250911-v6-14-topic-ti-lp5860-v3-1-390738ef9d71@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-v6-14-topic-ti-lp5860-v3-1-390738ef9d71@pengutronix.de>


On Thu, 11 Sep 2025 08:59:31 +0200, Steffen Trumtrar wrote:
> The lp5860 is a LED matrix driver with 18 constant current sinks and 11
> scan switches for 198 LED dots:
>   * Supply range from 2.7 V to 5.5 V
>   * 0.1mA - 50mA per current sink
>   * 1MHz I2C and 12MHz SPI control interface
>   * 8-bit analog dimming
>   * 8/16-bit PWM dimming
>   * individual ON and OFF control for each LED dot
>   * globat 3-bit Maximum Current setting for all LED dots
>   * individual LED dot open/short detection
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  .../devicetree/bindings/leds/leds-lp5860.yaml      | 111 +++++++++++++++++++++
>  1 file changed, 111 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



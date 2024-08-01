Return-Path: <linux-spi+bounces-4122-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 062999451A1
	for <lists+linux-spi@lfdr.de>; Thu,  1 Aug 2024 19:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFF841F2373A
	for <lists+linux-spi@lfdr.de>; Thu,  1 Aug 2024 17:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D8C1B3740;
	Thu,  1 Aug 2024 17:42:15 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AD7182D8;
	Thu,  1 Aug 2024 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534135; cv=none; b=LIIbX8J20+j6YoqMVfBMFukc9YWKFAHbwalbgJ4mrUEqtIaUT2H1JAT58GfOb7H3lS3U5ev1UIbZB3LU/dszFP1+6m1GDHXHnp48xdBZZnuLwFIGX1zqIC7VhrKHWnW1Ljjd8WQr1KJY0794+5tCkn5EveJjaT7SZ+L3Wa+S9D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534135; c=relaxed/simple;
	bh=GBxNEGvNfLlADh4TyarxUqlT33EY9R0QGqH2VAI9rGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9faKxZsuktdOAaRlSb+4DYxZQYHKjYGQ+KK+D1OSblmDrlBaukjAhTn1jiRqfg/HfNmt/fmSWKECm4Dw4dBUcZOHzFU4xP3qqSEzSxukEUt3gCdzXV8Pi/RSZ8MW5O1SGt8yOvMvZOdQnsV0JXlOp1FIslU/SEUol38xBryc88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e86192c.versanet.de ([94.134.25.44] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sZZo9-0000WR-Mm; Thu, 01 Aug 2024 19:41:45 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Lee Jones <lee@kernel.org>, Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Mark Brown <broonie@kernel.org>, Urja <urja@urja.dev>,
 linux-rockchip@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: rk8xx: Fix shutdown handler
Date: Thu, 01 Aug 2024 19:41:44 +0200
Message-ID: <22969419.5W6oEpyPa8@diego>
In-Reply-To: <c4d6da27-3b23-4a96-bad0-17f2392287ef@collabora.com>
References:
 <20240730180903.81688-1-sebastian.reichel@collabora.com>
 <c4d6da27-3b23-4a96-bad0-17f2392287ef@collabora.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 1. August 2024, 17:31:33 CEST schrieb Dmitry Osipenko:
> On 7/30/24 21:05, Sebastian Reichel wrote:
> > +	/*
> > +	 * Currently the Rockchip SPI driver always sleeps when doing SPI
> > +	 * transfers. This is not allowed in the SYS_OFF_MODE_POWER_OFF
> > +	 * handler, so we are using the prepare handler as a workaround.
> > +	 * This should be removed once the Rockchip SPI driver has been
> > +	 * adapted.
> > +	 */
> > +	if (is_spi)
> > +		pwr_off_mode = SYS_OFF_MODE_POWER_OFF_PREPARE;
> 
> This prevents the syscore_shutdown() step from execution. Is it better
> than not powering off?
> 
> I'd rather skip registration of the power-off handlers in a case of SPI :)

Or blasphemous thought, we could live with the warning-splash for a bit.

From Sebastian's log I assume the WARNING comes from the
wait_for_completion() in spi_transfer_wait(), and I guess the transfer
with the poweroff command itself will already have happened then?

So the device is most likely still powered off in that case?
Not sure how much of "bad taste" that thought is though ;-)


Heiko


[0] https://elixir.bootlin.com/linux/v6.10.2/source/drivers/spi/spi.c#L1671





Return-Path: <linux-spi+bounces-2464-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1498AE2BB
	for <lists+linux-spi@lfdr.de>; Tue, 23 Apr 2024 12:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF051C2189F
	for <lists+linux-spi@lfdr.de>; Tue, 23 Apr 2024 10:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4FD84DF2;
	Tue, 23 Apr 2024 10:46:03 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE9884A54
	for <linux-spi@vger.kernel.org>; Tue, 23 Apr 2024 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713869163; cv=none; b=fT78MdpJEp7uv5DecoGXnLjjzFmNDjncA2MDBQZZnw7mB8Cotyv/7w6xbsuLzUOF2ChU1f+AetdwVBrpsk55LtG7xyMCc7T6EbHDQ8Qx94yVRvxdkIQMfIM9S3suzGazlFastAl6rc1eYMQ9bk+/GRDKJupCqFbZ0gtM31/FNeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713869163; c=relaxed/simple;
	bh=YHj9CO2Ph+yeklRl8YRMvFkvyX7ArzTT4hFBWj08RXY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+ud4hNJSLbc3fPWO/v70qn5jh92gpYjqZ6PWl5pSUr4fH42kBPSmNb6ey6+1nu8clEiS0x6BbTq/fdZJJ9/fburUCWy/dGSDG4BZQwBVKXkNyLwAFXw2Q6oWZsRQziZ6Pdab3ETZSIFmS7GxaxEcDJfutlJu5ReWlrhBbZKDuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-208.elisa-laajakaista.fi [88.113.25.208])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id a81e100a-015e-11ef-b972-005056bdfda7;
	Tue, 23 Apr 2024 13:45:53 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 23 Apr 2024 13:45:52 +0300
To: Heikki Keranen <heikki.keranen@bittium.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
	Petri Tauriainen <petri.tauriainen@bittium.com>
Subject: Re: [PATCH] spi: mux: Fix master controller settings after mux select
Message-ID: <ZieRYJat7Y0ISbks@surfacebook.localdomain>
References: <20240422114150.84426-1-heikki.keranen@bittium.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422114150.84426-1-heikki.keranen@bittium.com>

Mon, Apr 22, 2024 at 02:41:50PM +0300, Heikki Keranen kirjoitti:
> In some cases SPI child devices behind spi-mux require different
> settings like: max_speed_hz, mode and bits_per_word.
> 
> Typically the slave device driver puts the settings in place and calls
> spi_setup() once during probe and assumes they stay in place for all
> following spi transfers.
> 
> However spi-mux forwarded spi_setup() -call to SPI master driver only
> when slave driver calls spi_setup(). If second slave device was
> accessed meanwhile and that driver called spi_setup(), the
> settings did not change back to the first spi device.
> In case of wrong max_speed_hz this caused spi trasfers to fail.
> 
> This commit adds spi_setup() call after mux is changed. This way
> the right device specific parameters are set to the master driver.
> 
> The fix has been tested by using custom hardware and debugging
> spi master driver speed settings.

> Co-authored-by: Petri Tauriainen <petri.tauriainen@bittium.com>

Since it's already applied for the future please note, the correct tag is
Co-developed-by and in accordance with Submitting Patches it must followed by
the respective Signed-off-by. In this case it had to be

Co-developed-by: Petri Tauriainen <petri.tauriainen@bittium.com>
Signed-off-by: Petri Tauriainen <petri.tauriainen@bittium.com>


-- 
With Best Regards,
Andy Shevchenko




Return-Path: <linux-spi+bounces-12208-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DABD0230B
	for <lists+linux-spi@lfdr.de>; Thu, 08 Jan 2026 11:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E66130C4E15
	for <lists+linux-spi@lfdr.de>; Thu,  8 Jan 2026 10:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF33B43B817;
	Thu,  8 Jan 2026 10:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJukXlDr"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0869D3ECBD8;
	Thu,  8 Jan 2026 10:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767867327; cv=none; b=YI17mWn8hqcVS69EUecVwLvtGnG3vBtIw9kI4Rl4Hz5/X7SNrXFYZOh2caC6WNQGXwOIFA/VSVjb1ORkfsFLcLSlCVPlSn0KGpYHLgoRfUGQjESFmp6Y6cp74oUP167itmbSGXkbLNvfcv5p/oMwAlhaUkyo2138i/m6ShtuF00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767867327; c=relaxed/simple;
	bh=/Jo4ameylI0QDhXxQi0CCzG2dUsmHBJUDcZwLC5zwbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSn33Ieq/8Sfpe+4EwndNhkW+sTPWS/NDsaagPnnsdCbhCz6oG5RzaiZKiHanu0Gwwk3DZOLIKWclvTYIVDDnSzoEnkMEFTk8++XOhC+LR+xBgmz+JnnCg+8AVWSwSBPlwh8YapP49yqaYw1C/fKvTaJLi+XNNOPuOgE3Fld9c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJukXlDr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BDDC116C6;
	Thu,  8 Jan 2026 10:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767867326;
	bh=/Jo4ameylI0QDhXxQi0CCzG2dUsmHBJUDcZwLC5zwbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VJukXlDrCbJOTEghDXLqYk1LyiTsHtYPsvhcEAYVvGBcAW4OMHxk8hZ77RIvCbAq4
	 Gu49EpVeij/ehMx5DaJK1xGB16fgOe5CikVuGooTBvXGcmnHLC95wIGuwQT8FUVYim
	 68EfHiAngHTaO1CLjU91vdCTD/5wOyWNwh3TqgSwc7AdZxLZf+YxJfA5sXbHDZx/MQ
	 prM1AV2uhEVuH4MDU58jbwMXdMUSd2aOX04Mh+iLCHRzFvK5SOA4GtJPZoj1yPZPaa
	 hTDj2e/FtJIBcmLvFriUiYGzS4WxRpISQRRNPfR9WVHwPlVCERGEqQ4XFR0T7Zzqxj
	 XjK9vT41zh1ww==
Date: Thu, 8 Jan 2026 10:15:20 +0000
From: Lee Jones <lee@kernel.org>
To: Otto =?iso-8859-1?Q?Pfl=FCger?= <otto.pflueger@abscue.de>
Cc: Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mfd: sprd-sc27xx: Integrate power off and reboot
 support
Message-ID: <20260108101520.GA302752@google.com>
References: <20251110-sc27xx-mfd-poweroff-v2-0-fd5842e732fe@abscue.de>
 <20251110-sc27xx-mfd-poweroff-v2-1-fd5842e732fe@abscue.de>
 <20251120153024.GI661940@google.com>
 <aSNFk7tZqcgBqYsI@abscue.de>
 <20251126153619.GH3070764@google.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251126153619.GH3070764@google.com>

On Wed, 26 Nov 2025, Lee Jones wrote:

> On Sun, 23 Nov 2025, Otto Pflüger wrote:
> 
> > On Thu, Nov 20, 2025 at 03:30:24PM +0000, Lee Jones wrote:
> > > On Mon, 10 Nov 2025, Otto Pflüger wrote:
> > > 
> > > > The SC27xx PMICs allow restarting and powering off the device. Since
> > > > this functionality is rather simple and not configurable in any way,
> > > > make it part of the main PMIC driver.
> > > 
> > > This sounds like more of a drivers/power thing.
> > 
> > This was originally in drivers/power, but according to [1], it should
> > not be a separate device tree node. Using a separate driver without a
> > separate device tree node would still involve some code here that
> > instantiates a platform device and selects the right platform data for
> > it.
> > 
> > Registering the poweroff handler directly seemed less complex, and I
> > assumed it was okay since some other MFD drivers (e.g. rk8xx) also
> > implement the same functionality without a separate power driver.
> > 
> > Is it a good idea to use devm_mfd_add_devices here instead?
> > 
> > [1]: https://lore.kernel.org/all/20251002025344.GA2958334-robh@kernel.org/
> 
> Well that is quite the predicament.
> 
> Let me catch-up with Rob out-of-band and see if we can come up with a
> solution.

The discussion between Rob and I led to an "agree to disagree" moment.

I still think that a node to describe this device is the correct
approach, however without Rob's blessing, you're a bit stuck.

I think your best bet at this point is to remove the
devm_of_platform_populate() and replace it with mfd_add_devices().

-- 
Lee Jones [李琼斯]


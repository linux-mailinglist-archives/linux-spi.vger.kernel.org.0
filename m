Return-Path: <linux-spi+bounces-11468-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3ABAC7E513
	for <lists+linux-spi@lfdr.de>; Sun, 23 Nov 2025 18:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C75C2348C2B
	for <lists+linux-spi@lfdr.de>; Sun, 23 Nov 2025 17:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D3B243367;
	Sun, 23 Nov 2025 17:42:37 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7698D1FE44B;
	Sun, 23 Nov 2025 17:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763919757; cv=none; b=qkL++4x1jabAoqfsEJJkPu+y4MvD8Qecg8ZgNtaYLG47N6lCCNiH0LfCoVCAYD2F/gWjcLxR3NryYC1vebeUv6avx0nxFh3PGso94pAz20Gnq6BTBRye6MKLzyMxPZr9rDagRHF7esN6KC3G4gLP0AuMeg0OKQKIchJEn8LyqPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763919757; c=relaxed/simple;
	bh=wk6jAQWxbc/Xlho1VfPqGQyUzyaYR6+Mmm4FbIJGc2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3EjUlrkYcNnxffvYalKbLDeYPoZ0igYpw7kBOb/GdexqWeapBovG/iJDvdfOEEaGkGqkSUHte6mAHoSKT35N9YiRdikyCcPUoZrBEsDciKMci6EUa4Ss5dIq0j0rrmsicdmx4ZoeLW1iUOLsHwf38INrgsFk6/rhp1gOgY4UKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id 74E381C0038;
	Sun, 23 Nov 2025 18:34:16 +0100 (CET)
X-Spam-Level: 
Date: Sun, 23 Nov 2025 18:34:11 +0100
From: Otto =?iso-8859-1?Q?Pfl=FCger?= <otto.pflueger@abscue.de>
To: Lee Jones <lee@kernel.org>
Cc: Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mfd: sprd-sc27xx: Integrate power off and reboot
 support
Message-ID: <aSNFk7tZqcgBqYsI@abscue.de>
References: <20251110-sc27xx-mfd-poweroff-v2-0-fd5842e732fe@abscue.de>
 <20251110-sc27xx-mfd-poweroff-v2-1-fd5842e732fe@abscue.de>
 <20251120153024.GI661940@google.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251120153024.GI661940@google.com>

On Thu, Nov 20, 2025 at 03:30:24PM +0000, Lee Jones wrote:
> On Mon, 10 Nov 2025, Otto Pflüger wrote:
> 
> > The SC27xx PMICs allow restarting and powering off the device. Since
> > this functionality is rather simple and not configurable in any way,
> > make it part of the main PMIC driver.
> 
> This sounds like more of a drivers/power thing.

This was originally in drivers/power, but according to [1], it should
not be a separate device tree node. Using a separate driver without a
separate device tree node would still involve some code here that
instantiates a platform device and selects the right platform data for
it.

Registering the poweroff handler directly seemed less complex, and I
assumed it was okay since some other MFD drivers (e.g. rk8xx) also
implement the same functionality without a separate power driver.

Is it a good idea to use devm_mfd_add_devices here instead?

[1]: https://lore.kernel.org/all/20251002025344.GA2958334-robh@kernel.org/


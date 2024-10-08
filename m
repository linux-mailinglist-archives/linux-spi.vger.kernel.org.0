Return-Path: <linux-spi+bounces-5149-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3B599500C
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 15:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18FE21C246F9
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 13:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962EC1DF97B;
	Tue,  8 Oct 2024 13:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h1e0UWeT"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705251DF978;
	Tue,  8 Oct 2024 13:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394272; cv=none; b=JW83h2Zpea1Hkv62pY+tzyiSk054+lc/sifAU9WsZibs88z1Hle3GcTaHxgi9lQULflEeE5IZO3TPBa/LjfuPBqNUslM6BODZRAmG3sXZ5JbYPUdJ1q37jUTXGmnGBIaNhFfM7aU2yWH35cBVBt8PzFZw3Pn6KjAYOU++lVzw+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394272; c=relaxed/simple;
	bh=Ka0LAzRHGohiEHtrGoJMIPegJU0CmUNQAZsdKWVj+98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhKi/zREkAQUwg8stPxpNf50w2xx/ZnOLE7ODiSbbxQ6szh/MwoAFWFxyIrIPN7OKMi2B4czSJ/OvQ2GlZaMTua7ZpU4uc8H7/CadO6mpXsQ805AN6SiABgqoBWqf13wNO2mLJivy/fWZoKen4npSgRagXPk3xLH2vCWh8SyM/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h1e0UWeT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D1DC4CECD;
	Tue,  8 Oct 2024 13:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728394272;
	bh=Ka0LAzRHGohiEHtrGoJMIPegJU0CmUNQAZsdKWVj+98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h1e0UWeT9/XMcrLegnrhI+5IfBnv4BynAYs6MMbKA+8GjFI1xwdWlbvNA/EOk1wXj
	 cMig09qVCflTAd1Qm91sxeFzoGixOFEPQNlkL24sTuMcqnjjibgl8xe0U5R2Hpfwdy
	 12SpW74f5vKgrj9Bw4WdZIWt3cMj1WErrbWv8pOA=
Date: Tue, 8 Oct 2024 15:22:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mark Brown <broonie@kernel.org>
Cc: Dragan Simic <dsimic@manjaro.org>, linux-spi@vger.kernel.org,
	linux-rockchip@lists.infradead.org, heiko@sntech.de,
	rafael@kernel.org, oss@helene.moe,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] driver core: Add device probe log helper
 dev_warn_probe()
Message-ID: <2024100815-flaky-prelaunch-f5c0@gregkh>
References: <cover.1727601608.git.dsimic@manjaro.org>
 <2be0a28538bb2a3d1bcc91e2ca1f2d0dc09146d9.1727601608.git.dsimic@manjaro.org>
 <ZwPvcFvK4l7JT1X9@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwPvcFvK4l7JT1X9@finisterre.sirena.org.uk>

On Mon, Oct 07, 2024 at 03:25:52PM +0100, Mark Brown wrote:
> On Sun, Sep 29, 2024 at 11:21:16AM +0200, Dragan Simic wrote:
> > Some drivers can still provide their functionality to a certain extent even
> > some of their resource acquisitions eventually fail.  In such cases, emitting
> > errors isn't the desired action, but warnings should be emitted instead.
> > 
> > To solve this, introduce dev_warn_probe() as a new device probe log helper,
> > which behaves identically as the already existing dev_err_probe(), while it
> > produces warnings instead of errors.  The intended use is with the resources
> > that are actually optional for a particular driver.
> > 
> > While there, copyedit the kerneldoc for dev_err_probe() a bit, to simplify
> > its wording a bit, and reuse it as the kerneldoc for dev_warn_probe(), with
> > the necessary wording adjustments, of course.
> 
> Greg, this makes sense to me - are you OK with me applying it?

No objection from me, now sent a reviewed-by



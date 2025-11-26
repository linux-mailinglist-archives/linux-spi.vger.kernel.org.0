Return-Path: <linux-spi+bounces-11603-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7687C8AB16
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 16:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A32324E76C3
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 15:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5426833A037;
	Wed, 26 Nov 2025 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKGEJjlf"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E14733BBDA;
	Wed, 26 Nov 2025 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764171385; cv=none; b=MXhoOj6Q853iWUb1glNVAfOZ4HtfW+cG1av+AsG3g517SvYCkjuSczU0ebJi3BhKDdPBHI7sLUY80KzhpFz7z3Bk/5ub7zmZ1D4NLC9jgNvOmK1CW1bEc9rasv6doPGWzN2nUHNJUKb+KucJqF0Rm/mFVp92GGTTqXAb8O7ttq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764171385; c=relaxed/simple;
	bh=2MQISJEaGUjzori/Q/GS0jFijTPjs4Nrhe+U8h7pujk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aP90enan0BVwziP62aK69D9AKhODM8LflJxNf+D8ugwlBFYswm5A5eFLx/yKbaXRBkB298hIWxS2wuIx7Ty+VUAuPskLjPQU7aB+kkqIJ8sjfrBl4gs+qOQKY38shRxXB7Q8jAU6xsP61hrV3LYiit/evybpoWI1/QJg8/Frzbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKGEJjlf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0ABC116C6;
	Wed, 26 Nov 2025 15:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764171384;
	bh=2MQISJEaGUjzori/Q/GS0jFijTPjs4Nrhe+U8h7pujk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IKGEJjlfv1lyK718tdCuIv8ElkKZ+ZjryiqCf9dHn6Y7p1WEnjTwr/lR0emcdWSPH
	 apI4eVAW31/Ext9e2YU/09g3bemCFm7FSprt5e+npuF7+/m+dqqEhviVYXxhputFdY
	 SrfExbI27Fq3G1uN6/09H87ioUWagEe675hquFmqgbwyexxUr3hWJHBjvDP8JykW7g
	 uPJ1qRCIJ9Z5Am8jth56gz8PzQ+AXsWvk+mkBXZoUQEQ4shBg3CQwVzBS+l3biocRn
	 p5R4OG/3fQ1P8sKFNmDY0/MRkVnbkwQIHgDKkhHhcJwYdCpU9X7UCzNvStAoclifof
	 92CL86NgLvVmA==
Date: Wed, 26 Nov 2025 15:36:19 +0000
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
Message-ID: <20251126153619.GH3070764@google.com>
References: <20251110-sc27xx-mfd-poweroff-v2-0-fd5842e732fe@abscue.de>
 <20251110-sc27xx-mfd-poweroff-v2-1-fd5842e732fe@abscue.de>
 <20251120153024.GI661940@google.com>
 <aSNFk7tZqcgBqYsI@abscue.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aSNFk7tZqcgBqYsI@abscue.de>

On Sun, 23 Nov 2025, Otto Pflüger wrote:

> On Thu, Nov 20, 2025 at 03:30:24PM +0000, Lee Jones wrote:
> > On Mon, 10 Nov 2025, Otto Pflüger wrote:
> > 
> > > The SC27xx PMICs allow restarting and powering off the device. Since
> > > this functionality is rather simple and not configurable in any way,
> > > make it part of the main PMIC driver.
> > 
> > This sounds like more of a drivers/power thing.
> 
> This was originally in drivers/power, but according to [1], it should
> not be a separate device tree node. Using a separate driver without a
> separate device tree node would still involve some code here that
> instantiates a platform device and selects the right platform data for
> it.
> 
> Registering the poweroff handler directly seemed less complex, and I
> assumed it was okay since some other MFD drivers (e.g. rk8xx) also
> implement the same functionality without a separate power driver.
> 
> Is it a good idea to use devm_mfd_add_devices here instead?
> 
> [1]: https://lore.kernel.org/all/20251002025344.GA2958334-robh@kernel.org/

Well that is quite the predicament.

Let me catch-up with Rob out-of-band and see if we can come up with a
solution.

-- 
Lee Jones [李琼斯]


Return-Path: <linux-spi+bounces-5085-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3FC98CCEB
	for <lists+linux-spi@lfdr.de>; Wed,  2 Oct 2024 08:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F95D2874CE
	for <lists+linux-spi@lfdr.de>; Wed,  2 Oct 2024 06:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF55C2260C;
	Wed,  2 Oct 2024 06:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOoTtVwX"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F1A28F4;
	Wed,  2 Oct 2024 06:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727849256; cv=none; b=Fi8Sm3011HCmDbB43GPVrkeboRhu2px/inbAtY8nWJZ/ZOPaY7TXqfB/TwU1lH0qIg0rpCs9UUvTS4BPvf3ew8xDtx/Yza54KxP8GX5QjZfjNp8F+FHwGlITiP6yEgYKPp4DAZCVsX7tQJiTte4LnNXCU7+nroXQwgSsxvFUI8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727849256; c=relaxed/simple;
	bh=OKz73NO+N2ceXLSa0W/Bhq5vFk7XVDonKmi/1w2khug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtZ4dG5tmKbNvEY33q3cxp/zvr+y5K67UMxzKKEWm4oWDKmll0vPsk3jpu9G42swbqEOu4vOKcYTUdcSBLDICCLp2jKMSXFsXIMAVMPSkpc7RTll0zr0XgMo4vU0zvBKLEmTGvw3ZE049rx3mdD/MpIldgRNGdPuhPjXusG73pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOoTtVwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7324BC4CECE;
	Wed,  2 Oct 2024 06:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727849256;
	bh=OKz73NO+N2ceXLSa0W/Bhq5vFk7XVDonKmi/1w2khug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nOoTtVwXejkQKRugYvq5SpxECGOHUfUgxbXJDO2D4iB4tshEtwAeM5qsgrQe0gywJ
	 NIeI7dY/P9kGJ2jDSHMN/kWig0khPXJ4pTQTe7MHu0dLJZxWIBngU0aRzGiMxrIMP+
	 Elc69ld/cEhFjJZ7rWf3ocxSm2T0fTSWFLye7vxFJU3mjvgW5Pltcy1E2j7C24Czj7
	 6a/tSFcn4an9eoZGkj2V+o0+WOQ++EsQXfQxhjIelu6zpMWKcnBrXjZ8H7vREZHrcX
	 QlpANri5bxaIQdLT1slG2BaDLxNWvAsUOKQuFNszRP2mHJRKJBrcYVUTTLTjZjjHeA
	 7WBz7Pexj5OSg==
Date: Wed, 2 Oct 2024 08:07:32 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Alim Akhtar <alim.akhtar@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: (subset) [PATCH 1/2] spi: s3c64xx: fix timeout counters in
 flush_fifo
Message-ID: <xbfyok2lvzxknt5aiaa4jgrkabl4eircidpnuktux7vetp6dek@cniaesdxaj4d>
References: <20240924134009.116247-1-ben.dooks@codethink.co.uk>
 <20240924134009.116247-2-ben.dooks@codethink.co.uk>
 <172782953761.2314893.16208330510622172964.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172782953761.2314893.16208330510622172964.b4-ty@kernel.org>

Hi Mark,

On Wed, Oct 02, 2024 at 01:38:57AM GMT, Mark Brown wrote:
> On Tue, 24 Sep 2024 14:40:08 +0100, Ben Dooks wrote:
> > In the s3c64xx_flush_fifo() code, the loops counter is post-decremented
> > in the do { } while(test && loops--) condition. This means the loops is
> > left at the unsigned equivalent of -1 if the loop times out. The test
> > after will never pass as if tests for loops == 0.
> > 
> > 
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> 
> Thanks!
> 
> [1/2] spi: s3c64xx: fix timeout counters in flush_fifo
>       commit: 68a16708d2503b6303d67abd43801e2ca40c208d

This still had some pending comments, besides I think it also
needed the Fixes tag.

Andi


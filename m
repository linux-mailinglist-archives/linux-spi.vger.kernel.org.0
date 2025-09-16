Return-Path: <linux-spi+bounces-10046-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B24FB59743
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 15:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05B31883894
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 13:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C9E1DF261;
	Tue, 16 Sep 2025 13:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBSaukzj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6870284E07;
	Tue, 16 Sep 2025 13:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758028650; cv=none; b=oOxkM+RSLfrMnEuzsmLnZYG1SZt6+2WvQ8XMHWp3pWS+eSWYNdFKtwni6v4bURpxyIVgtLs60JXIed8cmX7J+JmqzRF+79Q0RapMyBjwN3GmogNMqjRJV4iTxDceMndg77k/iZhnTsQ4GXEGw8i0LTtMP3UJ4vJfFmDaUvvHF2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758028650; c=relaxed/simple;
	bh=3t8ZsnXaWXeJN2lg5VW6FMHXGeclZ+Rixxfa9OmBFFE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a74Va4w+EzvrO8jl/4J7acP8X56AMYfiQYD70NWywioH4wEhjHuW2t7/wd7zlC6eYHAQ2V9kxvKIPRtlHB6uQtaQoI1iAmQ6w7ed9Hd90yKZbulvDLbhL9LO7+jje0ikGkIsKw/CBEVcPS8jkF14qU5dNY+V6nYYJfAOaqpWvmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBSaukzj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB14C4CEF0;
	Tue, 16 Sep 2025 13:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758028650;
	bh=3t8ZsnXaWXeJN2lg5VW6FMHXGeclZ+Rixxfa9OmBFFE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YBSaukzjv01zvCYkxPcJBGQq6SRcosbJBGyOTjLSFxR7AqCJyuX7eEUl0Nf9yD5TZ
	 woPRfu9dNVdrt8hUGmWk6JUzIjrCEKbMF6Lu3ypmVkboe+wf6GM/viuEMoEi1+HMgD
	 yiXTo+BPZRRHeMQabwUHBWDTW50xGtN8/MAkBj+nEgmENbS+GV4257HLVcvtrInp0k
	 ZZZQs5W2cwxd7C0HsxnwFFzT09toh9nAwpOOPCTs7kgH6L54hFHP5igwhOjxfeimVF
	 Q1pB7BKjLsB+PxHou65oqrmQxx7WwQXUWjtegWxBv9Qgh4XgO6z8vryT1zCffx+rli
	 oRkpGo/2bDyiA==
From: Mark Brown <broonie@kernel.org>
To: Liang Yang <liang.yang@amlogic.com>, Feng Chen <feng.chen@amlogic.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, linux-amlogic@lists.infradead.org, 
 linux-spi@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250913201612.1338217-1-colin.i.king@gmail.com>
References: <20250913201612.1338217-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] spi: amlogic: Fix error checking on regmap_write
 call
Message-Id: <175802864838.134241.18442416794301154547.b4-ty@kernel.org>
Date: Tue, 16 Sep 2025 14:17:28 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Sat, 13 Sep 2025 21:16:11 +0100, Colin Ian King wrote:
> Currently a call to regmap_write is not being error checked because the
> return checke is being performed on the variable ret and this variable
> is not assigned the return value from the regmap_write call. Fix this
> by adding in the missing assignment.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: amlogic: Fix error checking on regmap_write call
      commit: 18dda9eb9e11b2aeec73cbe2a56ab2f862841ba4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark



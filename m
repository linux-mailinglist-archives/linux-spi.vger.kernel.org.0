Return-Path: <linux-spi+bounces-8393-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12ECAD1F1B
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 15:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C54417A6896
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 13:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FE125D522;
	Mon,  9 Jun 2025 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODzXGffl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF31F25B1C5;
	Mon,  9 Jun 2025 13:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749476450; cv=none; b=liAXg8uKWS+f5dEmX5Zd0h6Z44W62jXjCuv100BRvJG1tBINMlCULjRKON4gf6FYBhlDDEPa3Y6csmwXHzZUmjsroUPN2AZh5KsQhhOm1FScWXn6OHvWXa3ZYPLu3fKbpORPH7m+wjQ9ZexKQ2K144oxo+wj/qZUS/q8RhP2QDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749476450; c=relaxed/simple;
	bh=F1aqTjBRQnFnGblh+To52pURYZgvRaaeerBAldcPAZU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HVOiDcT4bgm34Wj9bx/+SWytdbLPz+r5R0kzNvDvxMNpHeDm8bV1i6Tce7iHTo8JTOeeLKMxiLLme6+nIHmE8bX0tY3YSo2JIJMtCXkL/mIJOIYOT10fJW0YxK5VkoWNPmlir3nhKAe8nq4llBQ9T8/gdM8GQxfF//8iEiKDJ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODzXGffl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3357C4CEEB;
	Mon,  9 Jun 2025 13:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749476449;
	bh=F1aqTjBRQnFnGblh+To52pURYZgvRaaeerBAldcPAZU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ODzXGfflEPD8LOudRwcQsaCG7o95VziaCkoFEJUD7pz90wvqScETgC/oNiSUMetZc
	 Pg5kDnf/QBjDosYDz2rOcDYmPVjTFRjAco2lO2uti6XAfb2+5agYyhFUv71Ya346NN
	 geEH4Yx1uZ9Y6btEvAq3+oAGt1OvLMGSy91gpe0HWvJqtrux76Y23joJLVv8Xw9ZAb
	 iuHUAFWywEHXGefDv9RS6/W2T87dXXC9buXOzPIExHiznB7SURJ0x9zW64xXso9usx
	 J0DWXlKcnb93SyL3r5wV+bsOaGZMgz/h/yQgkaizz5umP4NcAP1i50+tOATRzd8v+F
	 Ym/2YpvL12CHA==
From: Mark Brown <broonie@kernel.org>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <aEKvDrUxD19GWi0u@stanley.mountain>
References: <aEKvDrUxD19GWi0u@stanley.mountain>
Subject: Re: [PATCH next] spi: spi-pci1xxxx: Fix error code in probe
Message-Id: <174947644859.127013.15989165632026703633.b4-ty@kernel.org>
Date: Mon, 09 Jun 2025 14:40:48 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Fri, 06 Jun 2025 12:04:14 +0300, Dan Carpenter wrote:
> Return the error code if pci_alloc_irq_vectors() fails.  Don't return
> success.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-pci1xxxx: Fix error code in probe
      commit: 2b74aea6d078ade810a3b0f7d1bcfcba2eaad416

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



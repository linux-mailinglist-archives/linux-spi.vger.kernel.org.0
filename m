Return-Path: <linux-spi+bounces-5458-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A3A9B02A6
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 14:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E9A5283855
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 12:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7C41F7551;
	Fri, 25 Oct 2024 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVQNW2B/"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ED81F7541;
	Fri, 25 Oct 2024 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729860113; cv=none; b=XnD6xE4rut7quwFGfKPUSPmfl0+57U7FRPCLeXGUAkRg+o32urc/NJEB8S6yht0ZK7lg+O41P2Vbvz8RrGLBWhYtzqOQ/ZchkmNx8i1ByvvuSMRY/5fIJKH1m0eTYjBQ5ioDugXgoZd2JRf20EPKAhrm5GeHWx4AEAwb2qm0jqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729860113; c=relaxed/simple;
	bh=TVY/SltFwwPQtKC0Lm7uKRwmTou17zLjJV55JX7/80Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Hprjf1cargkbcDJ0vhhYa4m7Mx/AlzxCRMZznv5ClcX2DPFbUAmM+I58Lq7D0jZC06viBqGtAJPVBJpPm7lW/1/xpf1Bj4/VL9uhqZF0WGJnjl2MPf9UMUQWjX3MGqknkj+mLvWihoVJYGJmK/YE4tEfAQ6bRSP0UWcNLh7esb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVQNW2B/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093DFC4CEC3;
	Fri, 25 Oct 2024 12:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729860113;
	bh=TVY/SltFwwPQtKC0Lm7uKRwmTou17zLjJV55JX7/80Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gVQNW2B/CWjAoOAYyV99f5GdiBhI1NwH++4Xr+DSAvLsHWNdn+f/U6N2H/lcsTgqa
	 cxUJuQCgOhuN8VDJTz4RrHhEGLFXBbb/MKUxDJRexxqmA43P2/b9NFbfLLbCOs5rYz
	 +KUMan2C42+nru4x35V9PzQ1e90B/y/7ZvDUjNzr6guv9/SZvCDo9W3ay1LNzKIofB
	 ZKiNXDNBBrdKmfemsJXHAcTLZAFStjYaoivl2p661v6RSDAz9h6IoUhE3kttQPqiI0
	 2Vx1C2Q4kFVgjdHaUHX1Dgvv20SIk8IK4+4ObBXV1gWkXq4w+sI1XMpblOnCm8ITSK
	 2MSIPkx+qhrDw==
From: Mark Brown <broonie@kernel.org>
To: Yinbo Zhu <zhuyinbo@loongson.cn>, Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, 
 Philipp Stanner <pstanner@redhat.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20241024140426.157444-2-pstanner@redhat.com>
References: <20241024140426.157444-2-pstanner@redhat.com>
Subject: Re: [PATCH] spi: Replace deprecated PCI functions
Message-Id: <172986011063.56829.8216886296945405855.b4-ty@kernel.org>
Date: Fri, 25 Oct 2024 13:41:50 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Thu, 24 Oct 2024 16:04:27 +0200, Philipp Stanner wrote:
> pcim_iomap_table() and pcim_request_regions() have been deprecated in
> commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
> pcim_iomap_regions_request_all()").
> 
> Replace these functions with pcim_iomap_region().
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Replace deprecated PCI functions
      commit: a992197bfcbb14e5a027796e06f86226c4444955

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



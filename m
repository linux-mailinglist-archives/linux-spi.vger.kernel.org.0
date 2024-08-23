Return-Path: <linux-spi+bounces-4290-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9A495D966
	for <lists+linux-spi@lfdr.de>; Sat, 24 Aug 2024 00:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8528BB22511
	for <lists+linux-spi@lfdr.de>; Fri, 23 Aug 2024 22:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EAA1C93B4;
	Fri, 23 Aug 2024 22:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuB06APX"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7AB195;
	Fri, 23 Aug 2024 22:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724453837; cv=none; b=oKug8Rz04hpavn2pl08jU7maAtuUCl59msZlRoe3CsSI3n/VsQES1s+73RsbeTVDDpd9GZEiIjD/35cvy9lScqc5EIupeJwRHjsK3phQpbPEa30iXHCzHXwhepjU0umMavR2eAXTyQEOgy3NNX4Hjs7KDCk9A8fkfT0zQLcaoWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724453837; c=relaxed/simple;
	bh=5re0XXR5mMdIdi6tFfPqPdlxaclMxPhMNEH4/z7dZyY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ui35kwPLhRihcWHIku5WgQa3OhRjHxEKrwY9Lx5xx57kY+VW5FS1iVH6raaIlAxV4AcZlvbThRWL0RA5QAviDaXghRBwwOB4ckYYfu1O3haX1Bcp8Qa3M5/AQrke44UOdqXvyOv6bIfz1sUT7Q4uAwv+pi1ebwOx4gdaS/oADCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuB06APX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10BCC32786;
	Fri, 23 Aug 2024 22:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724453837;
	bh=5re0XXR5mMdIdi6tFfPqPdlxaclMxPhMNEH4/z7dZyY=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=DuB06APXyTAKSMi6OlPwnSqwvvVomlNUhFx7Y57PGJc1DYO59tBWOnJWLBFt+Xy/L
	 2F2TWlU52hNiiswGvB26J+jlKZNWarQ4jrs4bTKJZD49XvR5v2a6cMkYdv8a6vicla
	 YtdwPxsS1ZFJuHTIHbeDp648kMZMAfF2IAA/ZsGDRsXaPmnoOYU4+rhbBGLFPToaWC
	 JZI1NxGzti92u8fuGKy+K7mDCt/yp9xD9N9Ll8RqEQxhWUi0OY6rVvVl9LlYWif+Ru
	 hrKGk96uk65pYwS1tgKxzyMab/Ev7zh9rNlfZ+xYpEp7Ei97s8FIJ+L8KZRsU8SCRl
	 86VOZFlVCGBVg==
From: Mark Brown <broonie@kernel.org>
To: j.neuschaefer@gmx.net, openbmc@lists.ozlabs.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240820123518.1788294-1-ruanjinjie@huawei.com>
References: <20240820123518.1788294-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH -next] spi: wpcm-fiu: Use
 devm_platform_ioremap_resource_byname()
Message-Id: <172445383531.842317.17431935290870556217.b4-ty@kernel.org>
Date: Fri, 23 Aug 2024 23:57:15 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Tue, 20 Aug 2024 20:35:18 +0800, Jinjie Ruan wrote:
> Use the devm_platform_ioremap_resource_byname() helper instead of
> calling platform_get_resource_byname() and devm_ioremap_resource()
> separately.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: wpcm-fiu: Use devm_platform_ioremap_resource_byname()
      commit: 3bf2a5359b0bde22418705ec862ac5077312e4c2

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



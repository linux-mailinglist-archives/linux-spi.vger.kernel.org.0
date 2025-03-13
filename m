Return-Path: <linux-spi+bounces-7137-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCDAA600CF
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 20:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A9587A732F
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 19:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752EC1F130E;
	Thu, 13 Mar 2025 19:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNCpUT0C"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478941F0E40;
	Thu, 13 Mar 2025 19:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741893194; cv=none; b=Jb7nd851h6pO+yNWCowmfgnXiAFSHgOXorzAX6gckkWge69iqIzGIJJkQJfagAW8Kbl+hq2dtlN+5YGQXz++xfs2QCiAI4EhDi89xWybn1VvJL/WMUs47CEifGzrzVGtB2C96Iuwm+aAKc5slpB2/tYeJQacSMlyjJDQv5SLYz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741893194; c=relaxed/simple;
	bh=PKhDG3gPDTlDzzD5ctJaM5hyaOxCZNvNZmFZmwmJyWs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Z/zlYT6Q7pyTBL4Et3u7lE0IpM4tIoO+ZVkcK5vWoUw+/aXRF0PZUqU1xnah1oypLYOhacGKa7SMTb71eiPzL+Tt9MaCLL5zP30qKTDT3bHRZkKLI9DJk0sXT3i8n2+o0xB/eE8OdWrKzcTJS8Q/LGKCZegdvjN6HP2N8ul4jUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNCpUT0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C08DC4CEDD;
	Thu, 13 Mar 2025 19:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741893193;
	bh=PKhDG3gPDTlDzzD5ctJaM5hyaOxCZNvNZmFZmwmJyWs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KNCpUT0CLTVuUdNijzvfzXA34nQgLAz+6SfWPqZQB99THv98ng/4S9oOAX57gnrdd
	 6c60DxH3xZiJSoWgOp4B8Gp/Y41TNqzS8/CBol1aE4tk6dqmMQ5rzn0+GPCpks4L6D
	 0Bz20qQT7GQi1ymnRg/whU60XcJ4UlrXT7ND9EqmTQYgTy29lzDiZh/8ZegGTepng0
	 svnSP1hcCSUjUbXW6XU4QtbUnas9YRR3YdSwviAt37uGp+kfOWFFFlltcR8czikipx
	 CI/FqeKWtvBXDWjZ3D3/YGELdOdiz45Wm6ilAKfi3iGn+IQHEcAy2xzsRkq6zVHPbZ
	 3j8t/1xE2fbfg==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Richard Cochran <richardcochran@gmail.com>
In-Reply-To: <20250313111442.322850-1-andriy.shevchenko@linux.intel.com>
References: <20250313111442.322850-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: Use inclusive language
Message-Id: <174189319234.699259.4090896593048951237.b4-ty@kernel.org>
Date: Thu, 13 Mar 2025 19:13:12 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Thu, 13 Mar 2025 13:14:42 +0200, Andy Shevchenko wrote:
> Replace "master" by "[host] controller" in the SPI core code and comments.
> All the similar to the "slave" by "target [device]" changes.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Use inclusive language
      commit: 91ce208d7ab7ab7703537a054a0c31cb53bbf302

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



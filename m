Return-Path: <linux-spi+bounces-4097-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E2A9416C5
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 18:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75A90B2625F
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 16:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FD418950F;
	Tue, 30 Jul 2024 16:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4FYAK/S"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4099189502;
	Tue, 30 Jul 2024 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355415; cv=none; b=Cj5SFibgk/EoAEGoiPz+nxiLHJGd5CXoNgJ0MU7S2M+IfJxmJpjc7spR7iVJOgA6IPG6HFQQ/pELKqd7p5idzwR0bhjVwZW5qhrZ96/paKrDxG57jhAuio3r7PBwqavYZgJ3HyYhCwQlxV5a/30VLI6TBuH+PbYpe3gJcbY5eAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355415; c=relaxed/simple;
	bh=CljDSdE3OCwmphTKkzCs9oeNnrV1nzj5Vikz7sjGvYk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PQkDl9vymVJu5WqMRQfAmaVMmxaj2z8z18KqDPSXxlLhyenMSFF+//RH38Ls1lsxiSmmgYOyHNF1RgvpNbD5z7gpLm3HkYv968Q7lNvBxgMpYvcQ0WGh5/03Us16BRfTGcXeYpWnqK26JxODmG8baFs1i9W2Efx+hGINE20RD24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4FYAK/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA60C4AF0C;
	Tue, 30 Jul 2024 16:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722355414;
	bh=CljDSdE3OCwmphTKkzCs9oeNnrV1nzj5Vikz7sjGvYk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Q4FYAK/Sb0t7ZD5/2/iL1r6Iw2BDYih5w0Ju0tKTektgRw/q/llGuMAjTVAoo4EoN
	 vdsoL9UDYQPepGcWn8IEGKg52VTyvpMS+9JaCWfP/7CjB5k2kAGOO+OyRhjuBMm4Nx
	 6h0j7sR4rTKfnlYowP+HWWzY59Pj9oGb3Dp9/WMbYrAEHtGj/rd/v94LxVpkee+2Ah
	 6XyZ/hpd+YQNbbwLQYYcAgw7o3P9uqQkynb59Df1RzC2BTt5ddx1GiiVcESMSQpZNE
	 aNdqvD/kHjYJ70fdTI33pnKiVOVszn6NQy4IwjmBd4WaLWUZz0k6otDksWZvnAiDmW
	 zOp5hgc5rofWg==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, Witold Sadowski <wsadowski@marvell.com>
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 pthombar@cadence.com
In-Reply-To: <20240730131627.1874257-1-wsadowski@marvell.com>
References: <20240730131627.1874257-1-wsadowski@marvell.com>
Subject: Re: [PATCH 1/1] spi: cadence: Add 64BIT Kconfig dependency
Message-Id: <172235541276.81832.5972598331291316161.b4-ty@kernel.org>
Date: Tue, 30 Jul 2024 17:03:32 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Tue, 30 Jul 2024 06:16:26 -0700, Witold Sadowski wrote:
> xSPI block requires 64 bit operation for proper Marvell SDMA handling.
> Disallow bulding on targets without 64 bit support.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence: Add 64BIT Kconfig dependency
      commit: d58ecc54bb09e3dfc0b43a82a6e1602a44bbebce

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



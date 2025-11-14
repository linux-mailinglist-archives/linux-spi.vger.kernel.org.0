Return-Path: <linux-spi+bounces-11216-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6338CC5EB07
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 18:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A1C93C40BC
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 17:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A767333744;
	Fri, 14 Nov 2025 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYFOMluP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2214E32827C;
	Fri, 14 Nov 2025 17:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763140026; cv=none; b=Yh19efEZGO8DAkoWuVlf0lE2tQF32nAg8goQo8sIXzK92dszDxicCSheRkP5MXVk3HYa0TOr3kJi6CYdscwe95Y1dswNsSGxndOAkJz/oXRmR55ervj9ZnFrzNms3FcWFj4XQOssg9pMa4C+WHXZngA/x8GaH6wtAbGbBTVR+dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763140026; c=relaxed/simple;
	bh=fVbGn07LMBYKHCsspwgdAMfEY+hThFtyzzN4L3toIvM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nyJCs71tdFL4ElGFFYOeMe2TzJ28oBt9tE4QVQz7SkYgaY/RWS2QSJXVRdForQj3OR2JQ8bwnP5GDSkIS7OXZG+caJL/QN1TmRPsjPUhepFm1FZ6y2lEj3unKCS9n9oYBnFDfdL3MLHZmUG3qK9ZrhUHAQZs9S/S17JLauDB9rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYFOMluP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F8AC4CEF8;
	Fri, 14 Nov 2025 17:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763140024;
	bh=fVbGn07LMBYKHCsspwgdAMfEY+hThFtyzzN4L3toIvM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uYFOMluPmdiwWYwSZXuamzuPZmtopjlyJwIakS4OPVwR258Vek9Yv/nPAXw5XLkCk
	 LOqphGSbPJvlz5djRUZqjTJivAWLpljynyX35WGqJXbewWTCdoo4BkS2zzYfHRjexN
	 2Hl1MVLIBi50qoe33BZiIRzYQ9HbL/uDSW17RHAJ8v++smSRT99JndTIafax5IMHUG
	 zV3aJMTYl+NHjY7iqgBvsxz00B77vo3kQ3VvR0Uzt5VP++vJ31Sun8415C8h+2fPWn
	 NXZYf3vE1Fl01aKm89N4zHWWMwGzZmQL2vHUvUcfaeJr8Aiq7Me+XOJXCSrngh/Li/
	 hjeHjktNYxzIg==
From: Mark Brown <broonie@kernel.org>
To: khairul.anuar.romli@altera.com, vigneshr@ti.com, 
 Anurag Dutta <a-dutta@ti.com>
Cc: u-kumar1@ti.com, s-k6@ti.com, linux-spi@vger.kernel.org, 
 gehariprasath@ti.com, linux-kernel@vger.kernel.org
In-Reply-To: <20251105161146.2019090-1-a-dutta@ti.com>
References: <20251105161146.2019090-1-a-dutta@ti.com>
Subject: Re: [PATCH 0/2] OSPI pm_runtime fixes
Message-Id: <176314002296.180192.13926737123146984065.b4-ty@kernel.org>
Date: Fri, 14 Nov 2025 17:07:02 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Wed, 05 Nov 2025 21:41:44 +0530, Anurag Dutta wrote:
> This short series introduces fixes for OSPI pm_runtime to balance the
> runtime PM reference counting.
> 
> Logs :
> https://gist.github.com/anuragdutta731/238dbc6d9ff7927c63cd4dcfc51dfa97
> 
> Anurag Dutta (2):
>   spi: spi-cadence-quadspi: Enable pm runtime earlier to avoid imbalance
>   spi: spi-cadence-quadspi: Remove duplicate
>     pm_runtime_put_autosuspend() call
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: spi-cadence-quadspi: Enable pm runtime earlier to avoid imbalance
      commit: f1eb4e792bb1ee3dcdffa66f8a83a4867cda2dd3
[2/2] spi: spi-cadence-quadspi: Remove duplicate pm_runtime_put_autosuspend() call
      commit: 10eaa4c4a257944e9b30d13fda7d09164a70866d

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



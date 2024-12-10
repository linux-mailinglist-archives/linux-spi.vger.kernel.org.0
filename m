Return-Path: <linux-spi+bounces-5990-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4EC9EB18F
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2024 14:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C365188CED7
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2024 13:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C703D1B85DF;
	Tue, 10 Dec 2024 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikJS7Vp/"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA151B85D1;
	Tue, 10 Dec 2024 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835653; cv=none; b=NTHIPIbGtRfmmXrvuNu3J4OKVYtOehgBCHCE47ppzsN/rIJWdi6Dwnk1oxLbUsBiMnWPNQoQ8HpZihmAnbqySNc/FmNppTMEcMNEwmqvY2ebtV3Rkqwzg5rAX5SrXs0GJlD3SS6KZjacSDGRgJLbT7RdZ2Ti/j69PXvvnYTiJYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835653; c=relaxed/simple;
	bh=MIAxjIrD/lQ/XU1a7Wha9ESXrTCJKMU1xX6Hab/QdPQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=useFASYKbifjBrfWzEkl+VEW6BDkcftA6nu+/Yykq0A8c53G9LQKpnLMUm3qPn9p/g9yfOydaDbrVs7jTUSbV0W4FOf3v/xIuLRJjzXmiW9BOq469u20o9sLWiaJry90azROmHMc8UWJc46u3mV0ZIKPBsrmOgTqY6a728dflKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikJS7Vp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4104C4CED6;
	Tue, 10 Dec 2024 13:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733835653;
	bh=MIAxjIrD/lQ/XU1a7Wha9ESXrTCJKMU1xX6Hab/QdPQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ikJS7Vp/nie0FJ5JFNlxCSZpO3Splxs5tL1yMayfWaVGdQpsABgrAx6wDO8Yv/c3H
	 DbU+1yG+/4HF3e5e+WE+m1/5fWOV9DBynRekfkp6DTGg2ArspwKBnfQfjQl6lgUmLk
	 3J54ZheUj9qzsq7+J8CcWP7vuAz4y9eRjb3DTb55AKz96E9gPy4boitPH+KS/uOY/U
	 CEVE4dUwjrB2JDwwJJwEh4vUYUMAFml5O5v64p5/6FHCvFwzqz3FJeOWwnRBOhzwsn
	 IExFIKQlhgh/ECiO8Ig1m2g9ZBGAlDhuXFCAWWCY22TGVKeVK0+QMdHCi+M6uM4sRF
	 YfFIhPymfuo6g==
From: Mark Brown <broonie@kernel.org>
To: heiko@sntech.de, luis.dearquer@inertim.com, 
 Christian Loehle <christian.loehle@arm.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <1f2b3af4-2b7a-4ac8-ab95-c80120ebf44c@arm.com>
References: <1f2b3af4-2b7a-4ac8-ab95-c80120ebf44c@arm.com>
Subject: Re: [PATCH] spi: rockchip: Fix PM runtime count on no-op cs
Message-Id: <173383565160.34030.9711673452793299443.b4-ty@kernel.org>
Date: Tue, 10 Dec 2024 13:00:51 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Fri, 06 Dec 2024 19:50:55 +0000, Christian Loehle wrote:
> The early bail out that caused an out-of-bounds write was removed with
> commit 5c018e378f91 ("spi: spi-rockchip: Fix out of bounds array
> access")
> Unfortunately that caused the PM runtime count to be unbalanced and
> underflowed on the first call. To fix that reintroduce a no-op check
> by reading the register directly.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: rockchip: Fix PM runtime count on no-op cs
      commit: 0bb394067a792e7119abc9e0b7158ef19381f456

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



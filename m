Return-Path: <linux-spi+bounces-11643-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F51C902F9
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 22:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A6FD4E1DF4
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 21:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D1030E0C8;
	Thu, 27 Nov 2025 21:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPXWcu+W"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4F22F360E;
	Thu, 27 Nov 2025 21:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764278467; cv=none; b=K62fO/3W88ZJnFqwSwkjl+s+SgEY58ZS1O8N6O63W9UFr3p9EPgyaUuIB5OFVu4ii9xF8G+uinb6HDpMoOFxcszo8gGOBgRyjwvPZnT4h5ZjaipLyYJZ/CzyWXWOBvwCH0QNQljRL/D84Gtlhzbgl5eMzJ+UD2SG2DdDtXEYolg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764278467; c=relaxed/simple;
	bh=dgsAfZ7S0L0Bi8BTONJHCHniC8yusQyBp/CFEde4yaM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QB/uB6k5esxV8pmKo6gBevH7cPALMjDnYYBWpos62CThD+VwMjGrtGM63mCBOIX6CaiFfyD7ICyXlVKcx8FzE4TMwExVqoHGH3FLyourdQwrX1vfjq385sO+LmURt3kSigpl+EwlDTRImkVkuR8Vh34KRb74mcaM6moHjOcn9jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPXWcu+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A58C4CEF8;
	Thu, 27 Nov 2025 21:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764278467;
	bh=dgsAfZ7S0L0Bi8BTONJHCHniC8yusQyBp/CFEde4yaM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=vPXWcu+WG+R2ut107mVW87z8+ojeQVdcU5wysf0WENgMNcTaVaB7Zz4XLfZ5M4Wfq
	 trPwstpIpw6ZMgqU5llEUEVZaXbfY8rR1hUabUWqCzCH3AIvHQtPoIl6ezmuLRT1r3
	 6Z65MnsTnb/s8hQ4xTQm+XwRfGiX1Jpd5UHrCzLS9B746EvjzeNSWi+JTgrAzYN3Gn
	 2lUn573xLfdhqApM4Um/g1obFHvmw7N1NHFSnBH1fjIUUiBwriRWAZspOCEiDxsSfv
	 PdKjKExgx4M6CPnhW2AEfdqi/zFl8FoLWxkkvI222HtXbh7YKuHIhLTNT/K4qnnHQy
	 +c6eq8OleRF8g==
From: Mark Brown <broonie@kernel.org>
To: Haibo Chen <haibo.chen@nxp.com>, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>
In-Reply-To: <20251126202501.2319679-1-andriy.shevchenko@linux.intel.com>
References: <20251126202501.2319679-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: nxp-fspi: Propagate fwnode in ACPI case as
 well
Message-Id: <176427846537.166028.5032840309459905636.b4-ty@kernel.org>
Date: Thu, 27 Nov 2025 21:21:05 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Wed, 26 Nov 2025 21:25:01 +0100, Andy Shevchenko wrote:
> Propagate fwnode of the ACPI device to the SPI controller Linux device.
> Currently only OF case propagates fwnode to the controller.
> 
> While at it, replace several calls to dev_fwnode() with a single one
> cached in a local variable, and unify checks for fwnode type by using
> is_*_node() APIs.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: nxp-fspi: Propagate fwnode in ACPI case as well
      commit: 40ad64ac25bb736740f895d99a4aebbda9b80991

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



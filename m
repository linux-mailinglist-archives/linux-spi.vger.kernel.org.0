Return-Path: <linux-spi+bounces-7138-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC5DA600D1
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 20:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2942719C30DB
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 19:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17421F2B94;
	Thu, 13 Mar 2025 19:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F77Efrdr"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51F31F2B87;
	Thu, 13 Mar 2025 19:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741893195; cv=none; b=XkWNT6NmsRiyWID0uLk22Xtj0WPUTnvbZZTcaFxDhqoqwmnXx4hrktggSR6lrPCETcCx+Yu/ecrdiqXPQ2vKL5dRakYUGLJMl5Z2+bwGYPBfaQQS6Voqifn6nRUML6TjP7+2prItnsG1T2pjhKz/tiAmKIfPIyBZM/YcGwtzOhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741893195; c=relaxed/simple;
	bh=N22MyzkKwqj4vxV9Vyr12JuaCiPNFW2zlx1xKuj1HH4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VD1Rno08EpBG7IwH1GqtdEypF69+ZKbRu8JYy8ToeyefT6DAM6ukifcpw3B1sHOhssxReXImNHzKfxmt0MmoSHS99gb8ZZ9CibQFB4naP+7G9d6rE7FSVMNc97b5y77gyJ+XYSsELD1xh6woMKj5QbjJwW9UUM9lvpTi/A72Z2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F77Efrdr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207D2C4CEEA;
	Thu, 13 Mar 2025 19:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741893195;
	bh=N22MyzkKwqj4vxV9Vyr12JuaCiPNFW2zlx1xKuj1HH4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=F77EfrdriOnuLrpKNohTchdVd8aAPTqOmXlZEiVsiYFK5buIhoNsSShdJagvW5Jc+
	 8VVlYB7lM8g6zdZ/MzMeQqngm0Ij9XMI92l3+RQGhY/tC6HvXVT3K5KyP8ePovciTz
	 hbYkOWqB36FoKTRxDhv2XVwJ7oOjcIGz4kXDKWGWgma2n8X9PyGn5vEoiRhi8b1sdJ
	 RLW9R11VF5qWGHvNaF2NVoifI/nn4+jrsmkdK2A2qUBvNqPJ5BZAINRKTr2ESEFhXX
	 UmsHdASA/pYoY89WJ7/CeyJPNCLD8z+81tneJobHU7LUFO6f94KnRnjnGtLxz/4oMb
	 xWI2S9dKl2qdA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Richard Cochran <richardcochran@gmail.com>
In-Reply-To: <20250313140340.380359-1-andriy.shevchenko@linux.intel.com>
References: <20250313140340.380359-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/1] spi: Use inclusive language
Message-Id: <174189319385.699259.5547652902184937667.b4-ty@kernel.org>
Date: Thu, 13 Mar 2025 19:13:13 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Thu, 13 Mar 2025 16:03:13 +0200, Andy Shevchenko wrote:
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



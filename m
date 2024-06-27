Return-Path: <linux-spi+bounces-3624-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E174C91A771
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 15:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4E31F26011
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 13:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFF1187332;
	Thu, 27 Jun 2024 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h82BYtUM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859BF187321;
	Thu, 27 Jun 2024 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719493836; cv=none; b=IZIMpgiN5+QszFyBrT9Zpl/d/7LmJ9lH5KLKxpnPa4gqW95nYVCklyb4jFj1ZmVurSqfYV4FhIyfmp2kxLK/S2VZGM05xa6322K97K+HsoJ3ETjMjt9tWV61nukRWtlLrnPfiuBY7C+2MGy+mTmmWosYKUHIJnwoABbRPyroz0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719493836; c=relaxed/simple;
	bh=YteVNbdJfQbzvswLjA0cIlxv0f9DQKGOyyXY8dVAAtg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UF6PeSmfDwFAKNLLmlARotAIn5u6H0EmTzjn06leGeQhN/4fZT0zN/m+lUMCW2DVXLCAhDOUztdOthKXaUz23pw8zg9j89IpVrPYiFO6rXdWcuTlTemY5MBy3Co6b7xe2LRAZFse2aUKHq8GdmuxQIhxS3xXwHC811pz+U2cSMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h82BYtUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00ACC4AF0B;
	Thu, 27 Jun 2024 13:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719493836;
	bh=YteVNbdJfQbzvswLjA0cIlxv0f9DQKGOyyXY8dVAAtg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=h82BYtUMQtRXZE58bKIFUZtFU6LwtjjFpfjvzgFQNDeZPPwBVwmjO/XVa5iDnbUYU
	 OI1vFP/l7KGd/FbwNuL1SFFE7objn7UfAeRUo7Cyithntc4A0BaeCgYBVxLTMjP+Gs
	 GAY3af4QHJ1VJ6jn1SQVThvLfMcMGcVaUN7i+xXUPiXnWDnXmQ9EDB2yGg5tSDSZDL
	 7dsNN3FyJa2W7GSinUAZ2a2/mzbwz7PYkaiLzQ+qmW+o5zxYFoAEh//2un9wZMEnVT
	 f21mpxjiYYxEEVSrGRxAWj/jXdSAhOp87jvUP53cqMFuaMiY7mdHa55rdhMOC6Xb79
	 kRW373bRsev/g==
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240626-spi-axi-spi-engine-remove-drvdata-v1-1-1752e372dd5d@baylibre.com>
References: <20240626-spi-axi-spi-engine-remove-drvdata-v1-1-1752e372dd5d@baylibre.com>
Subject: Re: [PATCH] spi: axi-spi-engine: remove platform_set_drvdata()
Message-Id: <171949383469.269360.17015273164063018941.b4-ty@kernel.org>
Date: Thu, 27 Jun 2024 14:10:34 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Wed, 26 Jun 2024 14:45:17 -0500, David Lechner wrote:
> platform_get_drvdata() is never called in the AXI SPI Engine driver, so
> platform_set_drvdata() is not needed. Remove it. This also lets us
> avoid the final error check in the probe function.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: axi-spi-engine: remove platform_set_drvdata()
      commit: 89c2657429c4822a2697077bbb3a8d126d826ced

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



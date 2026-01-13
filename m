Return-Path: <linux-spi+bounces-12328-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C51C5D18870
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 12:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02E5C301A72F
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 11:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7FB38BDD3;
	Tue, 13 Jan 2026 11:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBkROKMT"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82F42BE620;
	Tue, 13 Jan 2026 11:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768304573; cv=none; b=nS4qcfn/qFYW+dKHuPC85XIF0JKJuviK7cFafPrCzcyARwRXnzP4nurNAfNz+cnfoGd4C0BL+mbd4tMJGZQ8D/Ls1tg23cjQ9HRTw0uj/aYrJfSI8OcSP3SYDIkECvIZdoc+B1sqPpih9zwHYDmMqxamqcQbhUyumvplya6scWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768304573; c=relaxed/simple;
	bh=agevuoXnSFpyj8tR6f0Quta7RPrJDOnsP1WFdyq0NyI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NY1/ZjRYrHM/kYRs0swEJ7tb27WHrXcb9N5SDp3dq4g+raO8ENPj8jkDZC8P+KHzsGn+CKVJt6tFLdjf28MJp4moj+aZRENpFxXr/4YWMyzAJ0juFD3A5PjRU3qp64SZJuVBWQuapITXC7zYenlYTTISR71vxI6OeGMcWF5Hjm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBkROKMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E217C19422;
	Tue, 13 Jan 2026 11:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768304573;
	bh=agevuoXnSFpyj8tR6f0Quta7RPrJDOnsP1WFdyq0NyI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DBkROKMTG/Rpn7PwaCm5r4c0ZA7FLtB7bTmAPgVBmM0wSTnsD3hRFQR6EiY47X/jD
	 RmUybtOu/WdMtMZkb3WzyTf+q/KLIXKY+nGbSnYb4u/ZOmzJBc/LCa9nnoadbVnIlp
	 8jZ67vhgmuAWm4FnsFPfXyE3RzhO0ljSEInwg6ai5o9CLSh9gBW2roiuGl/kbxIr//
	 5Q+KlBc79yrDjjDbNnUr/DxiXNxu85MArGbn+4NnYw2AtV/wRey7+ixQwzOhYD4q3x
	 LV/tRcpPt4Sgak35f5sJII3Vv7y1zalhynMUkncGU39LqAZqvqKfWTTaVnrG77c4/C
	 nUciffX90/4Ww==
From: Mark Brown <broonie@kernel.org>
To: Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Felix Gu <gu_0233@qq.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <tencent_AC7D389CE7E24318445E226F7CDCCC2F0D07@qq.com>
References: <tencent_AC7D389CE7E24318445E226F7CDCCC2F0D07@qq.com>
Subject: Re: [PATCH v2] spi: spi-sprd-adi: Fix double free in probe error
 path
Message-Id: <176830457213.25724.9815535994112539882.b4-ty@kernel.org>
Date: Tue, 13 Jan 2026 11:42:52 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Fri, 09 Jan 2026 20:49:53 +0800, Felix Gu wrote:
> The driver currently uses spi_alloc_host() to allocate the controller
> but registers it using devm_spi_register_controller().
> 
> If devm_register_restart_handler() fails, the code jumps to the
> put_ctlr label and calls spi_controller_put(). However, since the
> controller was registered via a devm function, the device core will
> automatically call spi_controller_put() again when the probe fails.
> This results in a double-free of the spi_controller structure.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-sprd-adi: Fix double free in probe error path
      commit: 383d4f5cffcc8df930d95b06518a9d25a6d74aac

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



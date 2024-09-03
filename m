Return-Path: <linux-spi+bounces-4550-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDAB96A9C2
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2024 23:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1FFA1C24604
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2024 21:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EFF1EBFE9;
	Tue,  3 Sep 2024 21:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJHsfpS1"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55951EBFE1;
	Tue,  3 Sep 2024 21:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725397674; cv=none; b=CvZzC6jkmXgT04cjBF1tlIPuFm2xlqNqFCghV9M8bnf+SjSzlRs2nLAMcS32ei9nzcMCk1tOtHu46ujUvOpLStUFAPKR3SOuIt5n3zW1MpYEEV8oa49y1xzNpAidC/ADlxVqTmPHLv9GJWGgHlHq8vomg7eWmY03dl3or14CmXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725397674; c=relaxed/simple;
	bh=+c/HZrNUFSwGZX/50JUBYF7FvAAul3DQIfv1DDbccro=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ns5webpfDdLss1AsLBnzNBA908BRe6CRfLRL7RI3a6jTCFZnXZdupBpmwq4tt3sUQZ4SOvE3mvOMBMA21JqeVEVaNOVMnvxGZk9gr+7JglDOW9RsJ6+l2YD+64qpYhtWcAY6Ok07ks9gW+5Wwl9zkyCIWjHdfdocjMmpdtr+DDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJHsfpS1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C2FC4CEC5;
	Tue,  3 Sep 2024 21:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725397674;
	bh=+c/HZrNUFSwGZX/50JUBYF7FvAAul3DQIfv1DDbccro=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OJHsfpS1WQVSLVilcUw7dNQPSuThThnWWj7zoFUO8Ur3kHy59tniGYJnxzZCiqwCK
	 l999NWcckjQ461jlCau+gKxzZ4qqtubJSFM+S8EeS2MuG+q19amqRcdqDD7gowx0V3
	 GR8LXG9Aiwm9rfedLF0tZDZUhcdnmiLa9FUDE0S3s+0AJGbD45Q/xPSd7jnh4dmCfO
	 N7WhfKdzIaB1GqBf364GHOfVk+o/Ywc7/ic9FpThQKASJtslAysUBcwM1AgpqNZxXC
	 pJuMvk8LgvGyLyuR0P6O1VPj/38IZUlQbV40zSmCwcUpKKtPKSQJA440NysGh912kx
	 ZChMFmsql3D/A==
From: Mark Brown <broonie@kernel.org>
To: Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, Yang Ruibin <11162571@vivo.com>, 
 Nathan Chancellor <nathan@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 llvm@lists.linux.dev, patches@lists.linux.dev, 
 Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <20240902-spi-revert-8a0ec8c2d736-v1-1-928b829fed2b@kernel.org>
References: <20240902-spi-revert-8a0ec8c2d736-v1-1-928b829fed2b@kernel.org>
Subject: Re: [PATCH] spi: Revert "spi: Insert the missing
 pci_dev_put()before return"
Message-Id: <172539767218.139258.12953765191983738123.b4-ty@kernel.org>
Date: Tue, 03 Sep 2024 22:07:52 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Mon, 02 Sep 2024 17:43:06 -0700, Nathan Chancellor wrote:
> Commit 8a0ec8c2d736 ("spi: Insert the missing pci_dev_put()before
> return") added two uses of pci_dev_put() with an uninitialized dma_dev,
> resulting in the following compiler warnings (or errors with
> CONFIG_WERROR) when building with clang:
> 
>   drivers/spi/spi-pxa2xx-pci.c:150:15: error: variable 'dma_dev' is uninitialized when used here [-Werror,-Wuninitialized]
>     150 |                 pci_dev_put(dma_dev);
>         |                             ^~~~~~~
>   drivers/spi/spi-pxa2xx-pci.c:228:15: error: variable 'dma_dev' is uninitialized when used here [-Werror,-Wuninitialized]
>     228 |                 pci_dev_put(dma_dev);
>         |                             ^~~~~~~
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Revert "spi: Insert the missing pci_dev_put()before return"
      commit: bf62a8c7908ee8e0ef61d27d9ff65bf12f41fb0a

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



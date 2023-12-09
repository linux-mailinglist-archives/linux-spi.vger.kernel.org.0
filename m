Return-Path: <linux-spi+bounces-189-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1536880B5BE
	for <lists+linux-spi@lfdr.de>; Sat,  9 Dec 2023 18:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A356DB20C56
	for <lists+linux-spi@lfdr.de>; Sat,  9 Dec 2023 17:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1956F18E04;
	Sat,  9 Dec 2023 17:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyahjScw"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15BF187C
	for <linux-spi@vger.kernel.org>; Sat,  9 Dec 2023 17:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93297C433C7;
	Sat,  9 Dec 2023 17:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702144346;
	bh=gsQJnkRivnNQaWFxwTJwyXNKadVnLfGIQtassmDXzrc=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=EyahjScw7rUBwBb/Az7C8rjCyGbWBP2vletcQoCYAVX3lZtsSre80mv2GTrMxr8NL
	 wprw/YvpHGwLGj/sZiX9SDTz7FVKb5qIotkQ+B8/P/85viFFIP+a1yEfzicL47ah6F
	 dzv8ahYF12/m6GQdGJh97D6v15BT3yG3Mdgzj8lOzx3qCZJg38CSKsdiK3OUbLdSh7
	 wobRmNhaIHKEpmxsurpyd3X8r0pPnKNjMZtlbFhrMhLPDkaBJO56vjkYBsZHGH7JtU
	 PJ6cbj3wg8xwT+uTAWodibo7rXHRwgq1lFRGvmrxQjmspB83REx/HKAPSbVN1DQW6s
	 WuPvkLfJtz1Bg==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231207221426.3259806-1-andriy.shevchenko@linux.intel.com>
References: <20231207221426.3259806-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/2] spi: pxa2xx: Update documentation
Message-Id: <170214434538.2928550.6458260404490253992.b4-ty@kernel.org>
Date: Sat, 09 Dec 2023 17:52:25 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Fri, 08 Dec 2023 00:13:38 +0200, Andy Shevchenko wrote:
> A couple of documentation updates.
> 
> Andy Shevchenko (2):
>   spi: pxa2xx: Use inclusive language
>   spi: pxa2xx: Update DMA mapping and using logic in the documentation
> 
> Documentation/spi/pxa2xx.rst | 59 +++++++++++++++++-------------------
>  1 file changed, 28 insertions(+), 31 deletions(-)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: pxa2xx: Use inclusive language
      commit: c3aeaf2f0ec8af93189488bda3928a1ac7752388
[2/2] spi: pxa2xx: Update DMA mapping and using logic in the documentation
      commit: 8bc2a3634b87e2235535b5527f83ff529df68b56

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



Return-Path: <linux-spi+bounces-164-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E829A807A0A
	for <lists+linux-spi@lfdr.de>; Wed,  6 Dec 2023 22:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 245781C20FB9
	for <lists+linux-spi@lfdr.de>; Wed,  6 Dec 2023 21:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DE860BA7;
	Wed,  6 Dec 2023 21:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgVVunDe"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C69495F2
	for <linux-spi@vger.kernel.org>; Wed,  6 Dec 2023 21:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B951C433C9;
	Wed,  6 Dec 2023 21:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701896691;
	bh=w1X5YST37DXPLXf47U5xpecEc5SmKQf5AI9a4hURkos=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AgVVunDeAF7xTaBXWDHaJ03UBy9hxFDjwpejCYaqNQT0O0MUALToObWN2Gh3RWPxK
	 OxTSH2RSj2kFGznCs+328Zk+a4rgAh0TBJvvVzu0NCu25ikv4rJqy//x4ty2fChliG
	 8KbQBKadAR61JxQNrS2iqTv+IHo3yYCYxA8NWiocWNJ4k/QgPUuCN2Z9svMxlMDQbm
	 +IdvIVGUpRDuPW2qk0wLn2Tiy5Lcfzl5HCjfPHHFg6n6HK/Ci1Vmwnb7fchA6IaJcJ
	 Lowf8okB9+79VR1mFitpZ5ax2AnJK76AZdDhDL7HZWy1Ox18eA7Aj+6aQzRcVqRZ8P
	 xY3zgF2ro2KSg==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-kernel@vger.kernel.org, 
 Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20231204-axi-spi-engine-series-2-v1-0-063672323fce@baylibre.com>
References: <20231204-axi-spi-engine-series-2-v1-0-063672323fce@baylibre.com>
Subject: Re: [PATCH 0/9] spi: axi-spi-engine: improvements round 2
Message-Id: <170189669029.80266.9452036179086302633.b4-ty@kernel.org>
Date: Wed, 06 Dec 2023 21:04:50 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Mon, 04 Dec 2023 11:33:26 -0600, David Lechner wrote:
> We are working towards adding support for the offload feature [1] of the
> AXI SPI Engine IP core. Before we can do that, we want to make some
> general fixes and improvements to the driver. In order to avoid a giant
> series with 35+ patches, we are splitting this up into a few smaller
> series.
> 
> This is a continuation of the work started in [2] which has been applied
> to spi/for-6.8 [3]. This series must be applied on top of that series to
> apply cleanly.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/9] spi: axi-spi-engine: return void from spi_engine_compile_message()
      commit: 2e0d75f8dd9e31b3fb175f780494dd7dd988ceae
[2/9] spi: axi-spi-engine: populate xfer->effective_speed_hz
      commit: 9d023ecc31859c7f7c8ca27b5fec52b2dbb8086f
[3/9] spi: axi-spi-engine: remove spi_engine_get_clk_div()
      commit: 1fc8dc5721bbc7a21cb4cc60c35eb8031942542b
[4/9] spi: axi-spi-engine: fix sleep ticks calculation
      commit: be9070bcf67057b7b03c5acc1980d3897448ad20
[5/9] spi: axi-spi-engine: remove xfer arg from spi_engine_gen_sleep()
      commit: e006c181dd9ab006d7b0982d35ef7951fbffe825
[6/9] spi: axi-spi-engine: implement xfer->cs_change_delay
      commit: 125a8390995df1a350e9e16e6da11d010e1e7f76
[7/9] spi: axi-spi-engine: restore clkdiv at end of message
      commit: 3106edac599f59e1298b034a19a43e7da002fccc
[8/9] spi: axi-spi-engine: remove delay from CS assertion
      commit: 0db60d821e485a1c9b8080dbec1ba9871efb6a65
[9/9] spi: axi-spi-engine: add watchdog timer
      commit: 07d33c2810bb5fe67747d11f76980ed68602e287

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



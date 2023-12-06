Return-Path: <linux-spi+bounces-166-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE0A807A2C
	for <lists+linux-spi@lfdr.de>; Wed,  6 Dec 2023 22:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4B411F21849
	for <lists+linux-spi@lfdr.de>; Wed,  6 Dec 2023 21:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA2F43172;
	Wed,  6 Dec 2023 21:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAisxGcy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E373D6E58A
	for <linux-spi@vger.kernel.org>; Wed,  6 Dec 2023 21:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49C31C433C7;
	Wed,  6 Dec 2023 21:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701897027;
	bh=rGPn8HGgSrXfUFoTORaabqTJX16UmOAh3OQk5yZKldo=;
	h=Subject:From:Date:To:From;
	b=pAisxGcyXK/B0nro6fj3ZrKpCTc0XtN2az2kJH4Ufg/b7baKCywzSgylcnLQxy1BN
	 pXMV7Noe3dBRhuSG6a0KiNPY84yZkTsNSR8J9+pke7/vx0WtmhM9ugWc6SFtxjpHYf
	 Z2TH2G7oqdK301C4rSGOySOQHeMTb8D6b92v0EB0gaRaPgQaoBZF/CbUxYHsw4Bka9
	 RJhKXI1Jrnugksc6EwM6VHSrz7srqHsGyVjV9x4wO+rm5VoOdXnI31d/81VWAu0a+4
	 OjBxaAigYzeX1mZk+NHU+D/dY8Ormv4SZCtLyRzak4JJBG00MUS7uEc8W6P2CnUVA6
	 pCC6ek/M31tQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2EA9DC00446;
	Wed,  6 Dec 2023 21:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <170189702713.18685.15110162956942911432.git-patchwork-summary@kernel.org>
Date: Wed, 06 Dec 2023 21:10:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: axi-spi-engine: improvements round 2
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=806728
  Lore link: https://lore.kernel.org/r/20231204-axi-spi-engine-series-2-v1-0-063672323fce@baylibre.com
    Patches: [1/9] spi: axi-spi-engine: return void from spi_engine_compile_message()
             [2/9] spi: axi-spi-engine: populate xfer->effective_speed_hz
             [3/9] spi: axi-spi-engine: remove spi_engine_get_clk_div()
             [4/9] spi: axi-spi-engine: fix sleep ticks calculation
             [5/9] spi: axi-spi-engine: remove xfer arg from spi_engine_gen_sleep()
             [6/9] spi: axi-spi-engine: implement xfer->cs_change_delay
             [7/9] spi: axi-spi-engine: restore clkdiv at end of message
             [8/9] spi: axi-spi-engine: remove delay from CS assertion
             [9/9] spi: axi-spi-engine: add watchdog timer

Patch: Revert "spi: cadence: Add SPI transfer delays"
  Submitter: Nam Cao <namcao@linutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=807448
  Lore link: https://lore.kernel.org/r/20231206134446.69048-1-namcao@linutronix.de

Patch: [v3] spi: cadence: revert "Add SPI transfer delays"
  Submitter: Nam Cao <namcao@linutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=807486
  Lore link: https://lore.kernel.org/r/20231206145233.74982-1-namcao@linutronix.de


Total patches: 11

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <linux-spi+bounces-245-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B4980F179
	for <lists+linux-spi@lfdr.de>; Tue, 12 Dec 2023 16:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C74D228178C
	for <lists+linux-spi@lfdr.de>; Tue, 12 Dec 2023 15:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4340476DD2;
	Tue, 12 Dec 2023 15:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/G/vlQb"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F4476DD1
	for <linux-spi@vger.kernel.org>; Tue, 12 Dec 2023 15:50:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8922C433C7;
	Tue, 12 Dec 2023 15:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702396229;
	bh=QzuYZC4yebnQvX97RMPITGRQGMMloDkWmaT/w+1e4dI=;
	h=Subject:From:Date:To:From;
	b=L/G/vlQb35jHqkp0VAJP+Lof6jAwp74OTIbkoa49QFyMQGL7zKVIeBEPTgfuW034U
	 K4a0ssERzrNbwAexASHfUQktspIGx1ubsTjH1GvV+UoS7LEuY14XCH1D1FeXgMDW2E
	 LRKGDHDIuIXQNNPVFgqeSXPdnZy1zxLcnygkoaHgKMmuC6vaPIA4RMbgKOY7BDwuRG
	 NQcxgMIIgY2T26+fpH8gNmnDicwuEk+5hDFKemjNHaxxuHHj3QqUfrygLvhuazrVnx
	 KaSMf7rA0QUb761MgHc+MWR3lAJWAiOgw7/m5fJ/hcNLVM7BbTAPp+hIvkU5aZ1726
	 LZcg/2bdb9oXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C90F6DFC906;
	Tue, 12 Dec 2023 15:50:29 +0000 (UTC)
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
 <170239622976.5060.2967580405734536855.git-patchwork-summary@kernel.org>
Date: Tue, 12 Dec 2023 15:50:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: switch to use modern name (part5)
  Submitter: Yang Yingliang <yangyingliang@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=804800
  Lore link: https://lore.kernel.org/r/20231128093031.3707034-1-yangyingliang@huawei.com
    Patches: [-next,01/26] spi: sprd-adi: switch to use spi_alloc_host()
             [-next,02/26] spi: sprd: switch to use modern name
             [-next,03/26] spi: st-ssc4: switch to use modern name
             [-next,04/26] spi: stm32-qspi: switch to use modern name
             [-next,05/26] spi: stm32: switch to use modern name
             [-next,06/26] spi: sun4i: switch to use modern name
             [-next,07/26] spi: sun6i: switch to use modern name
             [-next,08/26] spi: sunplus-sp7021: switch to use modern name
             [-next,09/26] spi: synquacer: switch to use modern name
             [-next,10/26] spi: geni-qcom: switch to use modern name
             [-next,11/26] spi: tegra114: switch to use modern name
             [-next,12/26] spi: tegra20-sflash: switch to use modern name
             [-next,13/26] spi: tegra20-slink: switch to use modern name
             [-next,14/26] spi: tegra210-quad: switch to use modern name
             [-next,15/26] spi: spi-ti-qspi: switch to use modern name
             [-next,16/26] spi: wpcm-fiu: switch to use devm_spi_alloc_host()
             [-next,17/26] spi: topcliff-pch: switch to use modern name
             [-next,18/26] spi: uniphier: switch to use modern name
             [-next,19/26] spi: xcomm: switch to use modern name
             [-next,20/26] spi: xilinx: switch to use modern name
             [-next,21/26] spi: xlp: switch to use modern name
             [-next,22/26] spi: xtensa-xtfpga: switch to use modern name
             [-next,23/26] spi: zynq-qspi: switch to use modern name
             [-next,24/26] spi: zynqmp-gqspi: switch to use modern name
             [-next,25/26] spi: cs42l43: switch to use devm_spi_alloc_host()
             [-next,26/26] spi: ljca: switch to use devm_spi_alloc_host()

Series: spi: pl022: clean up some unused variables
  Submitter: Nam Cao <namcao@linutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=808781
  Lore link: https://lore.kernel.org/r/cover.1702298527.git.namcao@linutronix.de
    Patches: [1/2] spi: pl022: delete unused cur_gpiod in struct pl022
             [2/2] spi: pl022: delete unused next_msg_cs_active in struct pl022


Total patches: 28

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




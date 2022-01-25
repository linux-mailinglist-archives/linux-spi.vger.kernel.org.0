Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1356F49B24B
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jan 2022 11:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346850AbiAYKs6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Jan 2022 05:48:58 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:39940 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359764AbiAYKnf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Jan 2022 05:43:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D81FECE17C7
        for <linux-spi@vger.kernel.org>; Tue, 25 Jan 2022 10:43:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32635C340E0;
        Tue, 25 Jan 2022 10:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643107408;
        bh=/rrUl+qR1YNVIgqUDkL0H2qNI8hz6wKuxvCchemjhDU=;
        h=Subject:From:Date:To:From;
        b=i2f4jpykV5wuetzkNRVSTMyZKDUvNOINFUutSKo24ixa0LBL+Bp0ZjtObBqWU0SQT
         dWputjbq20cekv5p3eNHnuaCzD42ojgxYfsC5ha2JGmpMOfuFfMoyE+eDPqho94I6M
         rpwxpLmx4btXn3RTz5QUvABZxGcTMQRZ7UTRi0ef2AA1nN9XBBRJo5ywenJ2hW19bK
         bf+wjeBZzYbqNA1ebvxZVVB080TMa4hRnpXc13F0g8DzAN56Ez8VxbzwYHM/dS+NKe
         WQchsp55sO8SIimW71Va0Tus7m2pV6MSM2Drxn4VJUAO9UJQcBFEukNI0uAx+LLJr7
         DwVRtv3Tr5qPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 120F4F6079C;
        Tue, 25 Jan 2022 10:43:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164310740801.20501.303001098958988080.git-patchwork-summary@kernel.org>
Date:   Tue, 25 Jan 2022 10:43:28 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: dt-bindinds/dts: support i.MX8ULP
  Submitter: Peng Fan (OSS) <peng.fan@oss.nxp.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=586229
  Lore link: https://lore.kernel.org/r/20211126074002.1535696-1-peng.fan@oss.nxp.com
    Patches: [V6,1/7] dt-bindings: i2c: imx-lpi2c: Add imx8ulp compatible string
             [V6,3/7] dt-bindings: timer: tpm-timer: Add imx8ulp compatible string

Series: dmaengine: kill off dma_slave_config->slave_id
  Submitter: Arnd Bergmann <arnd@kernel.org>
  Committer: Vinod Koul <vkoul@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=584207
  Lore link: https://lore.kernel.org/r/20211122222203.4103644-1-arnd@kernel.org
    Patches: [v2,01/11] ASoC: tegra20-spdif: stop setting slave_id
             [v2,02/11] ASoC: dai_dma: remove slave_id field
             [v2,03/11] spi: pic32: stop setting dma_config->slave_id
             [v2,04/11] mmc: bcm2835: stop setting chan_config->slave_id
             [v2,05/11] dmaengine: shdma: remove legacy slave_id parsing
             [v2,06/11] dmaengine: pxa/mmp: stop referencing config->slave_id
             [v2,07/11] dmaengine: sprd: stop referencing config->slave_id
             [v2,08/11] dmaengine: qcom-adm: stop abusing slave_id config
             [v2,09/11] dmaengine: xilinx_dpdma: stop using slave_id field
             [v2,10/11] dmaengine: tegra20-apb: stop checking config->slave_id
             [v2,11/11] dmaengine: remove slave_id config field

Series: [1/4] mtd: dataflash: Warn about failure to unregister mtd device
  Submitter: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
  Committer: Miquel Raynal <miquel.raynal@bootlin.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=576757
  Lore link: https://lore.kernel.org/r/20211108093153.63792-1-u.kleine-koenig@pengutronix.de
    Patches: [1/4] mtd: dataflash: Warn about failure to unregister mtd device
             [2/4] mtd: mchp23k256: Warn about failure to unregister mtd device
             [3/4] mtd: mchp48l640: Warn about failure to unregister mtd device
             [4/4] mtd: sst25l: Warn about failure to unregister mtd device

Series: Add basic SoC support for mediatek mt8195
  Submitter: Tinghan Shen <tinghan.shen@mediatek.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=598221
  Lore link: https://lore.kernel.org/r/20211220121825.6446-1-tinghan.shen@mediatek.com
    Patches: [v7,1/4] dt-bindings: arm: mediatek: add mt8195 pericfg compatible
             [v7,3/4] dt-bindings: pinctrl: mt8195: add wrapping node of pin configurations

Series: [1/3,v3] spi: s3c64xx: Delete unused boardfile helpers
  Submitter: Linus Walleij <linus.walleij@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=606407
  Lore link: https://lore.kernel.org/r/20220118230915.157797-1-linus.walleij@linaro.org
    Patches: [1/3,v3] spi: s3c64xx: Delete unused boardfile helpers
             [2/3,v3] spi: s3c64xx: Drop custom gpio setup argument

Series: Update the Icicle Kit device tree
  Submitter:  <conor.dooley@microchip.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=605968
  Lore link: https://lore.kernel.org/r/20220117110755.3433142-1-conor.dooley@microchip.com
    Patches: [v4,01/14] dt-bindings: soc/microchip: update syscontroller compatibles
             [v4,06/14] dt-bindings: spi: add bindings for microchip mpfs spi


Total patches: 23

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



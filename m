Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE0574FAB8
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jul 2023 00:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjGKWK5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Jul 2023 18:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjGKWK4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 Jul 2023 18:10:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF28C1BCD
        for <linux-spi@vger.kernel.org>; Tue, 11 Jul 2023 15:10:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16B14615FF
        for <linux-spi@vger.kernel.org>; Tue, 11 Jul 2023 22:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D32FC433C7;
        Tue, 11 Jul 2023 22:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689113424;
        bh=2N45kPJGNOEMqN72lEin5gqQAjL5C2nkMosZGu2LOiE=;
        h=Subject:From:Date:To:From;
        b=ALfXhODh7wcPUsUTEzShhmw8RIzQPrxesoyCEXlY4NGyVLC0O7VWkULiS8YeurD7A
         SrNmbApi3Oi5nLN5dhwXgQAIZNtGPNPsKymLdRruRQM/C80sOVH1XOPeWUfPVlLc8t
         Lf98IdVermVDZDWf0MSe8hvjRCCDCHKgIbJknyurPPGYVNH2CjJeGPFOmkRmrCauMG
         xa5L+N7N90YVGIhN66kcBboaWgSQzTUM2PVDhmz8gor7y7QYDnsbNsdIesiQmYjNI4
         VKSwucGdrP6/UiL+y+ilKrYPyFBD6xvhGRYrt2Gt7kGE/+Q1WaLcl/ZJ83r/HyaLiY
         5s6urvEXvNNjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5974EC64458;
        Tue, 11 Jul 2023 22:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168911342428.2660.8798110489802143652.git-patchwork-summary@kernel.org>
Date:   Tue, 11 Jul 2023 22:10:24 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [1/7] spi: atmel: Use devm_platform_get_and_ioremap_resource()
  Submitter: Yangtao Li <frank.li@vivo.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=762911
  Lore link: https://lore.kernel.org/r/20230706032727.9180-1-frank.li@vivo.com
    Patches: [1/7] spi: atmel: Use devm_platform_get_and_ioremap_resource()
             [2/7] spi: davinci: Use devm_platform_get_and_ioremap_resource()
             [3/7] spi: ep93xx: Use devm_platform_get_and_ioremap_resource()
             [4/7] spi: spi-nxp-fspi: Convert to devm_platform_ioremap_resource() and devm_platform_ioremap_resource_byname()
             [5/7] spi: rspi: Use devm_platform_get_and_ioremap_resource()
             [6/7] spi: tegra20-slink: Use devm_platform_get_and_ioremap_resource()
             [7/7] spi: s3c64xx: Use devm_platform_get_and_ioremap_resource()

Patch: [v3] spi: stm32: disable device mode with st,stm32f4-spi compatible
  Submitter: Valentin Caron <valentin.caron@foss.st.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=762980
  Lore link: https://lore.kernel.org/r/20230706081342.468090-1-valentin.caron@foss.st.com

Series: [1/3] dt-bindings: spi: tegra-slink: Convert to json-schema
  Submitter: Thierry Reding <thierry.reding@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=762757
  Lore link: https://lore.kernel.org/r/20230705152603.2514235-1-thierry.reding@gmail.com
    Patches: [1/3] dt-bindings: spi: tegra-slink: Convert to json-schema
             [2/3] dt-bindings: spi: tegra-sflash: Convert to json-schema
             [3/3] dt-bindings: spi: Convert Tegra114 SPI to json-schema

Patch: spi: Increase imx51 ecspi burst length based on transfer length
  Submitter: Stefan Moring <stefan.moring@technolution.nl>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=760937
  Lore link: https://lore.kernel.org/r/20230628125406.237949-1-stefan.moring@technolution.nl

Patch: spi: rzv2m-csi: Convert to platform remove callback returning void
  Submitter: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=763335
  Lore link: https://lore.kernel.org/r/20230707071119.3394198-1-u.kleine-koenig@pengutronix.de


Total patches: 13

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



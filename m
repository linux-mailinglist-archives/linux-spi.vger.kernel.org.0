Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1281C7319C0
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jun 2023 15:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343874AbjFONUZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Jun 2023 09:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344105AbjFONUX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 15 Jun 2023 09:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F3A191
        for <linux-spi@vger.kernel.org>; Thu, 15 Jun 2023 06:20:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95C4B625C4
        for <linux-spi@vger.kernel.org>; Thu, 15 Jun 2023 13:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE41DC433C9;
        Thu, 15 Jun 2023 13:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686835222;
        bh=WJUxwWMi3jkyrpIDm9F0axFo1zlOM4+XYJs9uUNOl3A=;
        h=Subject:From:Date:To:From;
        b=I2V+0mnmghNj0SCNa2INuFxrvqgaquzeJSjIbCxDYC8vptIhqY7+3IDvxOCo9Dmva
         HTlHrd387Tsx4yuR/W+UFePnG8lAv7zrbDjj7j3tzXqCQQtQUBGowYBm3ThjcTA1Ba
         PRDTb/b86acVRHg1R42nT5ybgG1fONIXIV4YCkR297YrchPX5TO/Ma756N3IomtWnE
         nB6C5AKHuPoZqY7tcMZMQhTHCo7qnGHswc5Z/sVsndrpcbUMe7ihfH716+nfiE/p7+
         4POVBaVKPOA3gZ8WG/4kHPq6yebpBn/dJzzMTpbfEAoBT8L/chONQcC5teeoyUGRqL
         3hk5+ZpikfgqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C86C4C395C7;
        Thu, 15 Jun 2023 13:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168683522173.6025.2868770835119706736.git-patchwork-summary@kernel.org>
Date:   Thu, 15 Jun 2023 13:20:21 +0000
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

Series: spi: stm32: add spi slave mode
  Submitter: Valentin Caron <valentin.caron@foss.st.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=757057
  Lore link: https://lore.kernel.org/r/20230614102628.202936-1-valentin.caron@foss.st.com
    Patches: [v2,1/4] spi: stm32: renaming of spi_master into spi_controller
             [v2,2/4] spi: stm32: use dmaengine_terminate_{a}sync instead of _all
             [v2,3/4] dt-bindings: spi: stm32: disable spi-slave property for stm32f4-f7

Series: spi: stm32: add spi device mode
  Submitter: Valentin Caron <valentin.caron@foss.st.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=757363
  Lore link: https://lore.kernel.org/r/20230615075815.310261-1-valentin.caron@foss.st.com
    Patches: [v3,1/4] spi: stm32: renaming of spi_master into spi_controller
             [v3,2/4] spi: stm32: use dmaengine_terminate_{a}sync instead of _all
             [v3,3/4] dt-bindings: spi: stm32: disable spi-slave property for stm32f4-f7
             [v3,4/4] spi: stm32: introduction of stm32h7 SPI device mode support


Total patches: 7

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



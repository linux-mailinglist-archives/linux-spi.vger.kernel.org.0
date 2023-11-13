Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A177A7EA3DE
	for <lists+linux-spi@lfdr.de>; Mon, 13 Nov 2023 20:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjKMTk3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Nov 2023 14:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjKMTk3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Nov 2023 14:40:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D42AD72
        for <linux-spi@vger.kernel.org>; Mon, 13 Nov 2023 11:40:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19D33C433C9;
        Mon, 13 Nov 2023 19:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699904426;
        bh=epLpWYyPow5bpMSBr3ZYFQycpRxkd4evS9Ub7LvUEYk=;
        h=Subject:From:Date:To:From;
        b=l/DluRfsQLynHmU+HG738l9DXYHjl3L74rdRXLiXoYzQ2SBMXnnRo1KgULYpmqSDP
         xa6GXTIFnH+6wg6ufPv56qei9n0FMlP2kQkbbZMzaz2z0DsoAHf3V7LNUMXjNhYR7P
         efUHzXWiirG5EA+EOpx0QsJbE0O9XEo/c+bONICPbKfdZwskidCPfDvDfuwDdfaBUy
         FSAEoe8HVFftwUI1u3Q0wZG3w9+5O+vpVPcpYaYeVToi0qE3m3/HEFnMkT+kebCxWp
         G5DGHMPMtPEWeSi1T0NnB8IXuczbzumTBjsPuO/Gj+MtOsmgdYWTQNYj7GCKqYhjqC
         KVtV8fVwmm2hg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2FA2C04DD9;
        Mon, 13 Nov 2023 19:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169990442583.11731.5468363796080086680.git-patchwork-summary@kernel.org>
Date:   Mon, 13 Nov 2023 19:40:25 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add STM32F7 SPI support
  Submitter: Ben Wolsieffer <ben.wolsieffer@hefring.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=798501
  Lore link: https://lore.kernel.org/r/20231102193722.3042245-1-ben.wolsieffer@hefring.com
    Patches: [v2,1/5] spi: stm32: rename stm32f4_* to stm32fx_*
             [v2,2/5] spi: stm32: use callbacks for read_rx and write_tx
             [v2,3/5] dt-bindings: spi: add stm32f7-spi compatible
             [v2,4/5] spi: stm32: add STM32F7 support

Patch: spi: spi-ti-qspi: Convert to platform remove callback returning void
  Submitter: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=798919
  Lore link: https://lore.kernel.org/r/20231105172649.3738556-2-u.kleine-koenig@pengutronix.de

Patch: spi: spi-zynqmp-gqspi: fix driver kconfig dependencies
  Submitter: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=799124
  Lore link: https://lore.kernel.org/r/1699282435-884917-1-git-send-email-radhey.shyam.pandey@amd.com

Patch: spi: cadence-xspi: Drop useless assignment to NULL
  Submitter: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=798895
  Lore link: https://lore.kernel.org/r/20231105143932.3722920-2-u.kleine-koenig@pengutronix.de


Total patches: 7

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



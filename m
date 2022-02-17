Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5984BA888
	for <lists+linux-spi@lfdr.de>; Thu, 17 Feb 2022 19:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239866AbiBQSkc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Feb 2022 13:40:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243607AbiBQSkb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Feb 2022 13:40:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9D74BFEA
        for <linux-spi@vger.kernel.org>; Thu, 17 Feb 2022 10:40:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44AB1B823D1
        for <linux-spi@vger.kernel.org>; Thu, 17 Feb 2022 18:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4F88C340EC;
        Thu, 17 Feb 2022 18:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645123213;
        bh=uc/BR9arzipJa/dOI+JvofTv0oDr1m075n0MpRJFsss=;
        h=Subject:From:Date:To:From;
        b=VWX3nnVgv8iDx8MGrwwAWmtSu4NWOXhHEYdZqlhSwqUsNsAHkz/267nlmfPIbMjrN
         n61eSxu/FA4g1+OdwgwZxyK0jhBEq73IYo8Fkct3MWMK/ygRLXctPvBQ3RgYSgLHzR
         UqGR1kuMeb82++rztNTJtfRjlwoVQrLXPpNfft/2xU+TOy7xkyPFVC2Hpdt1pFknm1
         Crj+ZSaCJRk3n9jam9PF1R7bUonqDn72mOonI+OpjbTq6t2A1HmIzjDG0b6nUF/S5z
         nrqEpsQMlWqIo7wMNJwCnW6nelQkl1hmpoV4wapdHUGbM7S7lO+m45R8gMuVKHmEiH
         zSTUK1DrHd9NA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C82B3E6D446;
        Thu, 17 Feb 2022 18:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164512321374.2540.8068377713874691508.git-patchwork-summary@kernel.org>
Date:   Thu, 17 Feb 2022 18:40:13 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Patch: spi: mediatek: Avoid NULL pointer crash in interrupt
  Submitter: Benjamin Gaignard <benjamin.gaignard@collabora.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=610034
  Lore link: https://lore.kernel.org/r/20220131141708.888710-1-benjamin.gaignard@collabora.com

Series: [1/6] spi: rockchip: Stop spi slave dma receiver when cs inactive
  Submitter: Jon Lin <jon.lin@rock-chips.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=613337
  Lore link: https://lore.kernel.org/r/20220211034344.4130-1-jon.lin@rock-chips.com
    Patches: [1/6] spi: rockchip: Stop spi slave dma receiver when cs inactive
             [3/6] spi: rockchip: Fix error in getting num-cs property
             [4/6] spi: rockchip: Suspend and resume the bus during NOIRQ_SYSTEM_SLEEP_PM ops
             [6/6] spi: rockchip: clear interrupt status in error handler

Series: New support and problem adjustment of SPI rockchip
  Submitter: Jon Lin <jon.lin@rock-chips.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=614755
  Lore link: https://lore.kernel.org/r/20220216014028.8123-1-jon.lin@rock-chips.com
    Patches: [v3,1/6] spi: rockchip: Fix error in getting num-cs property
             [v3,2/6] spi: rockchip: terminate dma transmission when slave abort
             [v3,3/6] spi: rockchip: Stop spi slave dma receiver when cs inactive
             [v3,5/6] spi: rockchip: Suspend and resume the bus during NOIRQ_SYSTEM_SLEEP_PM ops
             [v3,6/6] spi: rockchip: clear interrupt status in error handler

Patch: spi: meson-spicc: add IRQ check in meson_spicc_probe
  Submitter: Miaoqian Lin <linmq006@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=608620
  Lore link: https://lore.kernel.org/r/20220126110447.24549-1-linmq006@gmail.com

Patch: spi: bcm-qspi: check for valid cs before applying chip select
  Submitter: Kamal Dasu <kdasu.kdev@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=609218
  Lore link: https://lore.kernel.org/r/20220127185359.27322-1-kdasu.kdev@gmail.com

Patch: spi: dt-bindings: Fix 'reg' child node schema
  Submitter: Rob Herring <robh@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=608851
  Lore link: https://lore.kernel.org/r/20220126231326.1636199-1-robh@kernel.org

Patch: [1/3] dt-bindings: spi: spi-rockchip: Add rk3568-spi compatible
  Submitter: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=586477
  Lore link: https://lore.kernel.org/r/20211126154344.724316-2-frattaroli.nicolas@gmail.com

Patch: [v2,1/3] dt-bindings: spi: spi-rockchip: Add rk3568-spi compatible
  Submitter: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=586695
  Lore link: https://lore.kernel.org/r/20211127141910.12649-2-frattaroli.nicolas@gmail.com


Total patches: 15

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



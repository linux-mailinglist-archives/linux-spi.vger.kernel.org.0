Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F856AC092
	for <lists+linux-spi@lfdr.de>; Mon,  6 Mar 2023 14:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjCFNR0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Mar 2023 08:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjCFNR0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Mar 2023 08:17:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068AF298DB
        for <linux-spi@vger.kernel.org>; Mon,  6 Mar 2023 05:17:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC582B80E19
        for <linux-spi@vger.kernel.org>; Mon,  6 Mar 2023 13:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56743C433EF;
        Mon,  6 Mar 2023 13:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678108642;
        bh=iTxHtU2pGNdD+uI7pjj9FDHqBsIb2zcqys7AkL7EDis=;
        h=Subject:From:Date:To:From;
        b=KNMmD9YMlsv7r3r8Yb4CMcM4GCLHhrOhcXBEflCCzaQFZtAaI/Ak5+QeRTKJGbgu2
         w4ByXMvJei03ZWI7w3UoMfgDnjrho1BuItJNRK8CQRL7lkPxK6RaEoW5bjynIslr9M
         hV0Esy5auDLl6rqz79JdkLjLeHwupuARWGvD4M1X3NMYVL34GI/svu6c9pZjBcd4cX
         oSy+LkO+QfxpdCKNtzI4c6VAH14bbfAXmyUrfs/Nkird4uzXc4yM+eviW7Lcf5kQg8
         gDWo7AM634ykTrHomBDrs+/FvtWUP+dM7eXd002vtMw2oWud+Lf/RlGyTwfb2V5IPY
         KY3hrUCJQKlEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33EA0E55B15;
        Mon,  6 Mar 2023 13:17:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167810864215.919.18083932093829444049.git-patchwork-summary@kernel.org>
Date:   Mon, 06 Mar 2023 13:17:22 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add MediaTek MT7986 SPI NAND and ECC support
  Submitter: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=716758
  Lore link: https://lore.kernel.org/r/20230130030656.12127-1-xiangsheng.hou@mediatek.com
    Patches: [RESEND,v5,01/10] spi: mtk-snfi: Change default page format to setup default setting
             [RESEND,v5,03/10] mtd: nand: ecc-mtk: Add ECC support fot MT7986 IC
             [RESEND,v5,10/10] dt-bindings: mtd: mediatek,nand-ecc-engine: Add compatible for MT7986

Patch: [v1] drivers/spi-rockchip.c : Remove redundant variable slave
  Submitter: Lizhe <sensor1010@163.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=724903
  Lore link: https://lore.kernel.org/r/20230226063334.7489-1-sensor1010@163.com

Series: Support AMD Pensando Elba SoC
  Submitter: Brad Larson <brad@pensando.io>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=713500
  Lore link: https://lore.kernel.org/r/20230119033918.44117-1-blarson@amd.com
    Patches: [v9,01/15] dt-bindings: arm: add AMD Pensando boards
             [v9,05/15] dt-bindings: mfd: syscon: Add amd,pensando-elba-syscon compatible

Patch: [v2] MAINTAINERS: Update email of Tudor Ambarus
  Submitter: Tudor Ambarus <tudor.ambarus@linaro.org>
  Committer: Miquel Raynal <miquel.raynal@bootlin.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=707029
  Lore link: https://lore.kernel.org/r/20221226144043.367706-1-tudor.ambarus@linaro.org

Patch: soc: qcom: geni-se: Move qcom-geni-se.h to linux/soc/qcom/geni-se.h
  Submitter: Elliot Berman <quic_eberman@quicinc.com>
  Committer: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=718716
  Lore link: https://lore.kernel.org/r/20230203210133.3552796-1-quic_eberman@quicinc.com

Series: [01/22] gpu/drm: remove the shmobile drm driver
  Submitter: Christoph Hellwig <hch@lst.de>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=711612
  Lore link: https://lore.kernel.org/r/20230113062339.1909087-2-hch@lst.de
    Patches: [01/22] gpu/drm: remove the shmobile drm driver
             [02/22] usb: remove the dead USB_OHCI_SH option


Total patches: 10

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



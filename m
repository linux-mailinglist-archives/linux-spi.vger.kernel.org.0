Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A227869112C
	for <lists+linux-spi@lfdr.de>; Thu,  9 Feb 2023 20:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjBITUV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Feb 2023 14:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjBITUU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Feb 2023 14:20:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2142CFD4
        for <linux-spi@vger.kernel.org>; Thu,  9 Feb 2023 11:20:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98B9561B9A
        for <linux-spi@vger.kernel.org>; Thu,  9 Feb 2023 19:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A0F2C433D2;
        Thu,  9 Feb 2023 19:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675970419;
        bh=y2JTbsQ+wyeQq+O3YkTxmy0jDf6Csx9ga9xJhn8Mm0Q=;
        h=Subject:From:Date:To:From;
        b=pDVbMSOfTQE4mKmTGWyI28e8X7nijYCfhP0dfcIiTMezQioue1d+p8ayScOxeXlUO
         1KqKJdryBoPZUqRExyjhSr6p7vhSfF5qX4p0eAI0QyoqUh7PyppV43yhv5hyKaPGJd
         ws18Hyb8p8J1toFHAxzmmW8giXycfHo14RylWrRt0Fy1RiEgCNOC8dRB6Ho+6Rfd4i
         tEMQDBDvZIECwJzN4aVJuLhykKj6ornP4nVWO7NywKOwDgc6Kq90piB7J9aXHJaqEM
         kY2w0T8/NdXQF6Tz4udoVswMcXZPRMllgFKo63T4knDxj1jT02a3rqXjv1AhcTvWZG
         Fogxgx7I8IBsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF38BE21ECB;
        Thu,  9 Feb 2023 19:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167597041886.16862.5132925769131715003.git-patchwork-summary@kernel.org>
Date:   Thu, 09 Feb 2023 19:20:18 +0000
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
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=716758
  Lore link: https://lore.kernel.org/r/20230130030656.12127-1-xiangsheng.hou@mediatek.com
    Patches: [RESEND,v5,01/10] spi: mtk-snfi: Change default page format to setup default setting
             [RESEND,v5,02/10] spi: mtk-snfi: Add optional nfi_hclk which is needed for MT7986
             [RESEND,v5,04/10] dt-bindings: spi: mtk-snfi: Add compatible for MT7986
             [RESEND,v5,05/10] spi: mtk-snfi: Add snfi sample delay and read latency adjustment
             [RESEND,v5,06/10] dt-bindings: spi: mtk-snfi: Add read latch latency property

Series: Add MediaTek MT7986 SPI NAND support
  Submitter: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=717546
  Lore link: https://lore.kernel.org/r/20230201020921.26712-1-xiangsheng.hou@mediatek.com
    Patches: [v6,1/5] spi: mtk-snfi: Change default page format to setup default setting
             [v6,2/5] spi: mtk-snfi: Add optional nfi_hclk which is needed for MT7986
             [v6,3/5] dt-bindings: spi: mtk-snfi: Add compatible for MT7986
             [v6,4/5] spi: mtk-snfi: Add snfi sample delay and read latency adjustment
             [v6,5/5] dt-bindings: spi: mtk-snfi: Add read latch latency property


Total patches: 10

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



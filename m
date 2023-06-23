Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E413173ADE6
	for <lists+linux-spi@lfdr.de>; Fri, 23 Jun 2023 02:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjFWAkZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Jun 2023 20:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjFWAkY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Jun 2023 20:40:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D031A4
        for <linux-spi@vger.kernel.org>; Thu, 22 Jun 2023 17:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED1876192B
        for <linux-spi@vger.kernel.org>; Fri, 23 Jun 2023 00:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F543C433C0;
        Fri, 23 Jun 2023 00:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687480822;
        bh=f2Rx57Q/vvnFcaQQyn6p115Olz5vZ/pZYFCTmNzTxII=;
        h=Subject:From:Date:To:From;
        b=hw8BVCmI8yLTMVka8E1jOpS6kDVfSHoKzWbP42dPIbjvOsWuxEN4KWZQi/LNS623O
         7KeQSu+sXRU/6jIb5Itryi6Er3K+/ovEKpAHQViDJVoQR7J8EuTq2USYEUzLjHYwKa
         mAj25omMiXPrJHVsHVdL/meGxri6K3Dg1YaAPK0eFIpUMNd7fSeMv+p88EV/+qiY3+
         v8d4OK1tJWIwoHhA285v9nwWrbpb1ySbH+3chlC9q4QU0Cj2MnhkAieZVFIq0pG5Gp
         Eptn+dXwL+p2GYld66Ko4W63t5NqnUqE0rkh5W4XE3honBcZPMyEIwaNtBiIhBu46s
         2Vwe3Y1Ase76A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 270AFC395FF;
        Fri, 23 Jun 2023 00:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168748082207.32316.5161873821890817988.git-patchwork-summary@kernel.org>
Date:   Fri, 23 Jun 2023 00:40:22 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

Series: spi: stm32: disable spi device mode for stm32f4-f7
  Submitter: Valentin Caron <valentin.caron@foss.st.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=759096
  Lore link: https://lore.kernel.org/r/20230621115523.923176-1-valentin.caron@foss.st.com
    Patches: [1/2] spi: stm32: disable device mode with st,stm32f4-spi compatible
             [2/2] spi: dt-bindings: stm32: do not disable spi-slave property for stm32f4-f7

Series: spi: Helper for deriving timeout values
  Submitter: Miquel Raynal <miquel.raynal@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=759425
  Lore link: https://lore.kernel.org/r/20230622090634.3411468-1-miquel.raynal@bootlin.com
    Patches: [v3,1/3] spi: Create a helper to derive adaptive timeouts
             [v3,2/3] spi: atmel: Prevent false timeouts on long transfers
             [v3,3/3] spi: sun6i: Use the new helper to derive the xfer timeout value

Series: spi: Add CSI support for Renesas RZ/V2M
  Submitter: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=759475
  Lore link: https://lore.kernel.org/r/20230622113341.657842-1-fabrizio.castro.jz@renesas.com
    Patches: [v2,1/5] spi: dt-bindings: Add bindings for RZ/V2M CSI
             [v2,3/5] spi: Add support for Renesas CSI

Series: spi: Add CSI support for Renesas RZ/V2M
  Submitter: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=759147
  Lore link: https://lore.kernel.org/r/20230621140944.257352-1-fabrizio.castro.jz@renesas.com
    Patches: [1/5] spi: dt-bindings: Add bindings for RZ/V2M CSI


Total patches: 8

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



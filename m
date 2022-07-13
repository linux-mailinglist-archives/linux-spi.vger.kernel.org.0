Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3E557392F
	for <lists+linux-spi@lfdr.de>; Wed, 13 Jul 2022 16:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbiGMOuU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Jul 2022 10:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236536AbiGMOuR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Jul 2022 10:50:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDB12AC74
        for <linux-spi@vger.kernel.org>; Wed, 13 Jul 2022 07:50:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A20E61E07
        for <linux-spi@vger.kernel.org>; Wed, 13 Jul 2022 14:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC422C3411E;
        Wed, 13 Jul 2022 14:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657723814;
        bh=gnORu9MC/aCnKESPsPmz1yiNDNBEKoL31kXVSbn5cRs=;
        h=Subject:From:Date:To:From;
        b=tb9hkjve1yzMODPL+Mg94aqJiIfGfALbXUr641khsseUNuOdBu6jJprCqDQe/qgS7
         ADWnKgFb6TTBBq7niJ3stiF6XIGACqxMG6JCN2Jw8fWEAgfmjWibHFn081gQVw1yBd
         7wbIXvxhz6tDYxgKhjAT+Ruaf+37cJIGtpSFRwrOR2wETkI6E4hKEZh0dDmPx92il0
         J4yYz1VyI7keqb6CRTuu9j3IWWkVkOEZ/FCxs0Iu0Hh2rDmapFMJ46JyYQdY0ptnOq
         nemtJIAz6YVo+dwqs4YWOXG3hSvpVD6HWIFrDMAYkocf9ie9kkbQJMdnPtMlXBIMDE
         h5+QnIfeHFaXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D24FDE45223;
        Wed, 13 Jul 2022 14:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165772381380.8919.1458026579394292288.git-patchwork-summary@kernel.org>
Date:   Wed, 13 Jul 2022 14:50:13 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Series: Add support for Intel Thunder Bay SPI controller
  Submitter: Srikandan, Nandhini <nandhini.srikandan@intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=659146
  Lore link: https://lore.kernel.org/r/20220713042223.1458-1-nandhini.srikandan@intel.com
    Patches: [v6,1/4] spi: dw: Fix IP-core versions macro
             [v6,2/4] dt-bindings: spi: Add bindings for Intel Thunder Bay SOC
             [v6,3/4] spi: dw: Add support for master mode selection for DWC SSI controller
             [v6,4/4] spi: dw: Add support for Intel Thunder Bay SPI controller


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



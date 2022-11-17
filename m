Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7BE62D9DC
	for <lists+linux-spi@lfdr.de>; Thu, 17 Nov 2022 12:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239948AbiKQLu4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Nov 2022 06:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239889AbiKQLug (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Nov 2022 06:50:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C396E57B
        for <linux-spi@vger.kernel.org>; Thu, 17 Nov 2022 03:50:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 520C06151F
        for <linux-spi@vger.kernel.org>; Thu, 17 Nov 2022 11:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC141C433D6;
        Thu, 17 Nov 2022 11:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668685817;
        bh=yAGeMBDQDrqWwPN9Rj0Gwngua00+Xm9aDBfD8avtaFA=;
        h=Subject:From:Date:To:From;
        b=O+57R86F7f5DHfkJriTsRMJ1uxJ5lwFaoSF16oi+4j96KTJd6G2RQzMZnCMOZGbRM
         evbHRom7NCE0gzDJzFYKM0LebvBIoP8IZ3MRdVBIdATrKKibPe3DqouDKCoyETrWxK
         yL3auWMtaiHp2G28/hapig2jCYRjCYqT1FbcYFeTe/0AM7m+cU1QMGtgpoorzExSED
         3e6zCw9YOFZQisIaaUhNATBoGnHfF2rwvb16KwTEpFQQz0LHGFVIwgPDFMX1YU2w+a
         D+6TPKf8eRYNeJxnVTPvwJ9h0XMuq5oS97tl+lqzlHiGnpRDv7ulCe9mqLJs961bqa
         ehkC61SdyNW7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C251C395F5;
        Thu, 17 Nov 2022 11:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166868581757.18382.5497112011581224043.git-patchwork-summary@kernel.org>
Date:   Thu, 17 Nov 2022 11:50:17 +0000
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

Series: [1/5] spi: tegra210-quad: Fix combined sequence
  Submitter: Krishna Yarlagadda <kyarlagadda@nvidia.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=682511
  Lore link: https://lore.kernel.org/r/20221001122148.9158-1-kyarlagadda@nvidia.com
    Patches: [1/5] spi: tegra210-quad: Fix combined sequence
             [2/5] spi: tegra210-quad: Fix duplicate resource error

Patch: spi: tegra210-quad: Fix duplicate resource error
  Submitter: Krishna Yarlagadda <kyarlagadda@nvidia.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=696293
  Lore link: https://lore.kernel.org/r/20221117070320.18720-1-kyarlagadda@nvidia.com


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



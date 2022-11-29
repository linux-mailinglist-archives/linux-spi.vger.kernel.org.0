Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B46063C0DA
	for <lists+linux-spi@lfdr.de>; Tue, 29 Nov 2022 14:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbiK2NUV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Nov 2022 08:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiK2NUT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Nov 2022 08:20:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4F1205E8
        for <linux-spi@vger.kernel.org>; Tue, 29 Nov 2022 05:20:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF2C6B81269
        for <linux-spi@vger.kernel.org>; Tue, 29 Nov 2022 13:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FFE6C433C1;
        Tue, 29 Nov 2022 13:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669728016;
        bh=0JHUzWW1zobPgI+wsdbzrFKmYCQOVJLI4aXz0vfzxWQ=;
        h=Subject:From:Date:To:From;
        b=IaHptuHvArivYm+tyR+r6kf5LfYR6F6xq7S2EmIfwLU/iebLVYalC/iC8iH72k8MZ
         bPNE2oWk/TQdOguXOO0ckeVkXFdPnzfgDsMJYnlbbqRiO+k40Hds14+K4ksGFh3+va
         fpfgXxL25WTvY1QXXzgrF4iex5K+SaT0jf6D+QHwHBvqUUClmlPhjdtnmuyat5eQ+P
         obi3+PIOKWEMi4hG0PBpS5QXQ+paHBAKMpSoIpRYvf7en32VREsMVHVsMY5ef3OOIr
         TX97Av/kie9CKRNqPbU/wueUPAf0YQePbnISpharI1WGjUkxqybh3j0UKtOkXWeTJW
         51nFQlHidnweg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46C0BC395EC;
        Tue, 29 Nov 2022 13:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166972801620.5997.3607137978501277303.git-patchwork-summary@kernel.org>
Date:   Tue, 29 Nov 2022 13:20:16 +0000
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

Series: nuvoton,wpcm450-fiu binding example fixes
  Submitter: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=700033
  Lore link: https://lore.kernel.org/r/20221129102225.3598044-1-j.neuschaefer@gmx.net
    Patches: [v2,1/2] spi: dt-bindings: nuvoton,wpcm450-fiu: Fix error in example (bogus include)
             [v2,2/2] spi: dt-bindings: nuvoton,wpcm450-fiu: Fix warning in example (missing reg property)


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



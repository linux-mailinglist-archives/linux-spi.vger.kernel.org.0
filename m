Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E694171EE9E
	for <lists+linux-spi@lfdr.de>; Thu,  1 Jun 2023 18:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjFAQU0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Jun 2023 12:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjFAQUW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Jun 2023 12:20:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922EC133
        for <linux-spi@vger.kernel.org>; Thu,  1 Jun 2023 09:20:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26E456475A
        for <linux-spi@vger.kernel.org>; Thu,  1 Jun 2023 16:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FC95C433D2;
        Thu,  1 Jun 2023 16:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685636420;
        bh=Ws5vkuPQ2I36WeR5eA0cc7Io9RP5bSglAdK5BqUQLYs=;
        h=Subject:From:Date:To:From;
        b=An0I15RBJnlNvFY8ncBd7fSKqLGKkJAY/cP7VJi4EEDmDbu+tDRhfjN7LcF1akaLs
         o/d2CCUHNLDPwdCpeQlQDEdxYiM1TyR/iwgQZoz/0ZOR+2fe7Qg4xyXB5qPsacTVPk
         +bpPpRlPPWJ896QHDQVqTaYqATpOvgjLeUqBltowWDvOH9zp6UwfFKOn62AC5IgHoD
         21m6aItlkVfT2GzC6vJQCH5sLHy1cJtiWcT+MIpVQtIRtWeiHUYrkOVGz8kJa7Q5Kn
         veQ7PnQPlgLSMGFWmVmCEWFVVTKZ7blt3AWgzt4nS7sqA4IzeXDmJeYRBW5aSqbJZt
         +CkQOZFP5bEDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56D7CC395E5;
        Thu,  1 Jun 2023 16:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168563642028.13246.9302053385354475689.git-patchwork-summary@kernel.org>
Date:   Thu, 01 Jun 2023 16:20:20 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Patch: spi: dw: Drop empty line from DebugFS init function
  Submitter: Serge Semin <Sergey.Semin@baikalelectronics.ru>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=752461
  Lore link: https://lore.kernel.org/r/20230530221725.26319-1-Sergey.Semin@baikalelectronics.ru

Patch: [1/1] spi: spi-fsl-lpspi: downgrade log level for pio mode
  Submitter: Alexander Stein <alexander.stein@ew.tq-group.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=752587
  Lore link: https://lore.kernel.org/r/20230531072850.739021-1-alexander.stein@ew.tq-group.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



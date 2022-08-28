Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67505A3FD7
	for <lists+linux-spi@lfdr.de>; Sun, 28 Aug 2022 23:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiH1VKT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 28 Aug 2022 17:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH1VKT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 28 Aug 2022 17:10:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6A9E027
        for <linux-spi@vger.kernel.org>; Sun, 28 Aug 2022 14:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEDAF60E98
        for <linux-spi@vger.kernel.org>; Sun, 28 Aug 2022 21:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3AFBEC433D7;
        Sun, 28 Aug 2022 21:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661721017;
        bh=acaR8AVo2HQYXyfXjvPhMisvpwRjekoqu3lHEvsGLYs=;
        h=Subject:From:Date:To:From;
        b=ilEimF/SKMWJvf7RfbjmTc5L97Is9kgrhonwPEWoDdG53wLa+vf1KG62YeQPntf+r
         4pDC3xR5LtJW2FViG2qJomcyz2Z+XdkkNiaY4G8UCL+0V0ELeZ/GjyRvJWqRugnxjz
         +oRARn8dPNetUfkk5VkmmEgAS+FXnvR89IYtUeTuk73326gXjxf6oR9WGJLhI5puPw
         jbbS/w09jKhbrsY/zZyAJYp7g8U63GY/eqjEc8cpnh9Gn+wbJg82bnO1030gp6lpXV
         M3xb5bGKOXtKXEhbjXefcgJVwXhm5GbZ/ZkiDKje+bF7zZBITLQasWaFg37US4qXxC
         nddZMTgL7x+Ug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07C44C5A8AF;
        Sun, 28 Aug 2022 21:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166172101694.11666.11403293411277014504.git-patchwork-summary@kernel.org>
Date:   Sun, 28 Aug 2022 21:10:16 +0000
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

Patch: spi: stm32-qspi: Fix stm32_qspi_transfer_one_message() error path
  Submitter: Patrice CHOTARD <patrice.chotard@foss.st.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=671402
  Lore link: https://lore.kernel.org/r/20220826092031.1393430-1-patrice.chotard@foss.st.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



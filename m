Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB947621F1
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jul 2023 21:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjGYTAZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Jul 2023 15:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjGYTAY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Jul 2023 15:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93F61BD5
        for <linux-spi@vger.kernel.org>; Tue, 25 Jul 2023 12:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BD5E61876
        for <linux-spi@vger.kernel.org>; Tue, 25 Jul 2023 19:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8510CC433C7;
        Tue, 25 Jul 2023 19:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690311622;
        bh=xQQSpLzyGK8uDOMFUTOInUybn8Nx/ScwFjAUdwROJZA=;
        h=Subject:From:Date:To:From;
        b=eX/LNkZDaYdNwBDCNKKmg/rqieOYsoOlxtTQERlcAKkJvGItrnS8tluPLrt/ur7yk
         C50j0aQXhGPfvjn2C9DvMpdJiqDWUetsIYRbHvPpDxE725wANVw/yXvjlV9szz/i0j
         2Yx45TU6bDNK+xq8sAbxNhWbVSE72dE73qWgTbXGaA/Q2y2//F9PcevLChp2yCFajm
         hCuc/ZjhsyReecQN55uT7PMP9ZrDK0uw3RMPqLL7J0yU/j43MUhXXa/Ztx54LefojE
         JVU6LVEDiY5Iy7tK2zxXREdoNg/b/0xxFjsY8n/DtopvW/TmsNsybbSGurGvKiiDcy
         Z/EEinXXB5W/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F004C59A4C;
        Tue, 25 Jul 2023 19:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169031162231.25906.17991143550626836182.git-patchwork-summary@kernel.org>
Date:   Tue, 25 Jul 2023 19:00:22 +0000
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

Patch: [-next] spi: fsl: Remove unused extern declarations
  Submitter: YueHaibing <yuehaibing@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=769325
  Lore link: https://lore.kernel.org/r/20230725135411.21152-1-yuehaibing@huawei.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



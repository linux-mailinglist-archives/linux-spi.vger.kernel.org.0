Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C336E6989
	for <lists+linux-spi@lfdr.de>; Tue, 18 Apr 2023 18:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjDRQaY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Apr 2023 12:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbjDRQaX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Apr 2023 12:30:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CBF72A8
        for <linux-spi@vger.kernel.org>; Tue, 18 Apr 2023 09:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F97763676
        for <linux-spi@vger.kernel.org>; Tue, 18 Apr 2023 16:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A2B3C433EF;
        Tue, 18 Apr 2023 16:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681835421;
        bh=1QJOIGztRvYW9BvUlglAE8p9pfBx1j5g4FqXQeezhNw=;
        h=Subject:From:Date:To:From;
        b=hrVbfWVHwIGQkOGWxDVEGTd8Pgb44vB3Tw5+DCGOxFrx/LFhioBKEc1FT9v64nbk9
         lwB2TXmJ9lEsRs7dP0ealWbBDWTTV2Hdn8LA8CZ7Vpr14o/NZgROhgypJ6WPMiqVNk
         nkBEJOztiEuulwkGKWJbhy2hJHzoRC55evZaZ4484RVQ4F25CE5SfvL1BNgV/2bmfP
         2FEKxpiJmbwyjm4XZrAY3NtDJFMAM2sLJo3x3Tp6dUQDqKUJg5uupmt4HRNDUDlaxe
         NBToR0V0Pr6QnLjMvFARdcrwHXFda1QkGhVWhbu8smuPpeP21KFDu33XOty+QT23Mc
         /FL0UDwEdxTng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 63421E330A0;
        Tue, 18 Apr 2023 16:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168183542132.14505.17128239763581004158.git-patchwork-summary@kernel.org>
Date:   Tue, 18 Apr 2023 16:30:21 +0000
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

Series: spi: spi-cadence: Add Slave mode support
  Submitter: Srinivas Goud <srinivas.goud@amd.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=740979
  Lore link: https://lore.kernel.org/r/1681825625-10265-1-git-send-email-srinivas.goud@amd.com
    Patches: [v2,1/2] spi: spi-cadence: Switch to spi_controller structure
             [v2,2/2] spi: spi-cadence: Add support for Slave mode

Series: Fix PM Hooks in the Cadence Quad SPI Driver
  Submitter: Gole, Dhruva <d-gole@ti.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=740396
  Lore link: https://lore.kernel.org/r/20230417091027.966146-1-d-gole@ti.com
    Patches: [1/2] spi: cadence-quadspi: use macro SIMPLE_DEV_PM_OPS
             [2/2] spi: cadence-quadspi: fix suspend-resume implementations


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



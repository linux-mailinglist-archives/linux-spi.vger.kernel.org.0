Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAB555D040
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jun 2022 15:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343818AbiF1KkW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Jun 2022 06:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343572AbiF1KkV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Jun 2022 06:40:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9165D2DD73
        for <linux-spi@vger.kernel.org>; Tue, 28 Jun 2022 03:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EAA861941
        for <linux-spi@vger.kernel.org>; Tue, 28 Jun 2022 10:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87FAAC3411D;
        Tue, 28 Jun 2022 10:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656412819;
        bh=K+Zjkfu0HwSragQ8UAdUdli5ooJDZs9GR870kX/k5DE=;
        h=Subject:From:Date:To:From;
        b=C4VDmRV7UKk9BUo0xEA1xQs8QG2KAaWd9EE+7/TQOLeSe3QOjV+CuXKYLV3dDtIad
         GQrMM8p8O9cHR217Qf0yl30lhuNajNw9/8sjGmYpsA2h81h+9JdtEo+wpvXjB+ZcUI
         Qtjri5hYx0tykhsVgpAmNxrfn7nN3cmoudeO2bCOH/WgBfhUvp7eh6/jR3SJCFuzoY
         q7DuR/A7k68C2K5PTySPI2NllwuUWhvjuHcJAF+8sJoMJREIDJhcD2t7aW7IxqUC3N
         TJ8uSj/1tEQabZtmXaEIvCrd6ORK4WvmFT8GoQz3v9wvT8bIJHDV1DUmaptrkU5D/u
         1RbMgCkK7TByA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66B3CE49BBC;
        Tue, 28 Jun 2022 10:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165641281936.18137.9739749183929662477.git-patchwork-summary@kernel.org>
Date:   Tue, 28 Jun 2022 10:40:19 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Series: Optimize spi_sync path
  Submitter: David Jander <david@protonic.nl>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=652193
  Lore link: https://lore.kernel.org/r/20220621061234.3626638-1-david@protonic.nl
    Patches: [v3,01/11] spi: Move ctlr->cur_msg_prepared to struct spi_message
             [v3,02/11] spi: Don't use the message queue if possible in spi_sync
             [v3,03/11] spi: Lock controller idling transition inside the io_mutex
             [v3,04/11] spi: __spi_pump_messages: Consolidate spin_unlocks to goto target
             [v3,05/11] spi: Remove check for controller idling in spi sync path
             [v3,06/11] spi: Remove check for idling in __spi_pump_messages()
             [v3,07/11] spi: Remove the now unused ctlr->idling flag
             [v3,08/11] spi: Remove unneeded READ_ONCE for ctlr->busy flag
             [v3,09/11] spi: Set ctlr->cur_msg also in the sync transfer case
             [v3,10/11] spi: Ensure the io_mutex is held until spi_finalize_current_message()
             [v3,11/11] spi: opportunistically skip ctlr->cur_msg_completion


Total patches: 11

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD22F62C008
	for <lists+linux-spi@lfdr.de>; Wed, 16 Nov 2022 14:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiKPNuT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Nov 2022 08:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiKPNuT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Nov 2022 08:50:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4A63B9
        for <linux-spi@vger.kernel.org>; Wed, 16 Nov 2022 05:50:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A99961E0D
        for <linux-spi@vger.kernel.org>; Wed, 16 Nov 2022 13:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00760C433D6;
        Wed, 16 Nov 2022 13:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668606617;
        bh=F62mQNGDhI4puxT9nKkkqsB44PTy5bKdmZpi+vF5Q0Y=;
        h=Subject:From:Date:To:From;
        b=p2+ATYjS+i5SQOaqHJUR+XsoTMZaclEBtAUSFVy2V+lr9frHnCCtCcCpng6qlapJf
         mIppwvBvdqN6OTk6lSDRFSdG4O8teZg8CqAcWQSB/0E4xPjyk4LRZbE07Qc4rUFLSL
         XkUKDDR2Fd8u5ut8o1gHIwJoo3WlHjcx2raRdlxgqoAacN+IpzVAhAhYnqEFealMYf
         a87hkGdofSUqoBO0W4VpggL57VMBphIyQ2KMD1jMdDwgpztNhIVGcon/5I6Vu+7Nvk
         2ZvtMhkoimvvMpq45FjRYn5asWMOT9Vx4qv2lxtsHJ08bdH61lSFgJU3H7YJCFj8Jw
         ZL2QvPf8JUYuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1621C395F3;
        Wed, 16 Nov 2022 13:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166860661679.6212.2712921144594779329.git-patchwork-summary@kernel.org>
Date:   Wed, 16 Nov 2022 13:50:16 +0000
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

Patch: [v3] spi: spi-imx: Fix spi_bus_clk if requested clock is higher than input clock
  Submitter: Frieder Schrempf <frieder@fris.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=695655
  Lore link: https://lore.kernel.org/r/20221115181002.2068270-1-frieder@fris.de


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



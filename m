Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8C766A50C
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jan 2023 22:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjAMVUa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Jan 2023 16:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjAMVUX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 13 Jan 2023 16:20:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789A07A20B
        for <linux-spi@vger.kernel.org>; Fri, 13 Jan 2023 13:20:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F5AD6232D
        for <linux-spi@vger.kernel.org>; Fri, 13 Jan 2023 21:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77952C433EF;
        Fri, 13 Jan 2023 21:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673644821;
        bh=tJB4HVSnPNpJq70ZlGkZGUU0tk8D+7rqtbfPkEgRJiM=;
        h=Subject:From:Date:To:From;
        b=RAtIxJ5iCrJTCskG1rTaDvjm51B/JBPVVxgWdaDlbNixU32f3YU43TQcIoIkEFEBc
         foG+qA3i3b2Dj9oHadc+FKMcd3yWrw3zJkZ1bFuZ8yXCHpEAh9NYjEtFe369zVXiiD
         +TuHbzHqkYM0mdt1eXWPAwfU048Wvq1kIfSBxvmR55nEXc1fN8rlNCtnMNaT9swCgq
         wfoxPQz/B/JSDOWyYc+wijSzTDHhMaH81fHAeHzkONuzldJKa/V02ddGAb2g7Otdhj
         7cRdfoVNOIIvew0yHsH6HSSo5dEFVKydxqtwi0/d65VYMvNAmfbOmn9zL9w9ap7KIe
         fgLD7eaaz1fPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 57065C395CA;
        Fri, 13 Jan 2023 21:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167364482135.21086.10837970639809270630.git-patchwork-summary@kernel.org>
Date:   Fri, 13 Jan 2023 21:20:21 +0000
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

Series: SPI core CS delay fixes and additions
  Submitter: Hector Martin <marcan@marcan.st>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=708730
  Lore link: https://lore.kernel.org/r/20230104093631.15611-1-marcan@marcan.st
    Patches: [1/5] spi: dt-bindings: Rename spi-cs-setup-ns to spi-cs-setup-delay-ns
             [4/5] spi: dt-bindings: Add hold/inactive CS delay peripheral properties
             [5/5] spi: Parse hold/inactive CS delay values from the DT

Series: SPI core CS delay fixes and additions
  Submitter: Hector Martin <marcan@marcan.st>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=711711
  Lore link: https://lore.kernel.org/r/20230113102309.18308-1-marcan@marcan.st
    Patches: [v2,1/3] spi: Use a 32-bit DT property for spi-cs-setup-delay-ns
             [v2,2/3] spi: dt-bindings: Add hold/inactive CS delay peripheral properties
             [v2,3/3] spi: Parse hold/inactive CS delay values from the DT


Total patches: 6

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB55660931
	for <lists+linux-spi@lfdr.de>; Fri,  6 Jan 2023 23:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236595AbjAFWBV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Jan 2023 17:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236762AbjAFWAz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Jan 2023 17:00:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242B5872B9
        for <linux-spi@vger.kernel.org>; Fri,  6 Jan 2023 14:00:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DC6BB81EF0
        for <linux-spi@vger.kernel.org>; Fri,  6 Jan 2023 22:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F22BC433F0;
        Fri,  6 Jan 2023 22:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673042417;
        bh=3ffCJn0HH15SgeKiVlzQn04fu01udyWzP9YZlNod7dk=;
        h=Subject:From:Date:To:From;
        b=XePX9PseoTw0fhU7YjZxg0lma75NO6MtvDp369Tm5+VZbQEITdA41p47lWtohtm5s
         nBaW/TXloPTUqLqoZEQIxz8L0Astiqgz9MOaWYNI5dOSemvFJEVR/6l8gDlUTE+ydw
         a6MeokMvGXLM0jaZef9T4nOmtQ3NRo/+jf1HUq3NR5dVmFoNaa8LDNUyVnbej8OvuW
         6w+d+B4cg4aNv6XKH5D+ZURUtu74Qur+negbAH47eIl0lBooFzkcIZAeARxMfln2q8
         fIMJTt9bEtKHLPquEZqbJ2VEzjlwTLiY5ORDLUYzFsjwnJL4R6UBrer8tCUOElt7za
         O6rt76DmfK6Cg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5FA7E57254;
        Fri,  6 Jan 2023 22:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167304241680.27890.2186339934888729619.git-patchwork-summary@kernel.org>
Date:   Fri, 06 Jan 2023 22:00:16 +0000
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

Series: [v2,1/2] spi: spidev: fix a race condition when accessing spidev->spi
  Submitter: Bartosz Golaszewski <brgl@bgdev.pl>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=709492
  Lore link: https://lore.kernel.org/r/20230106100719.196243-1-brgl@bgdev.pl
    Patches: [v2,1/2] spi: spidev: fix a race condition when accessing spidev->spi
             [v2,2/2] spi: spidev: remove debug messages that access spidev->spi without locking


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



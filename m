Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BB14D089A
	for <lists+linux-spi@lfdr.de>; Mon,  7 Mar 2022 21:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbiCGUlU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Mar 2022 15:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245164AbiCGUlS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Mar 2022 15:41:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6E37C7BC
        for <linux-spi@vger.kernel.org>; Mon,  7 Mar 2022 12:40:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F4266150F
        for <linux-spi@vger.kernel.org>; Mon,  7 Mar 2022 20:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0091EC340E9;
        Mon,  7 Mar 2022 20:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646685619;
        bh=2EFUlUj9BSpvXlxDUPkTgRleBJPYhLuV7vstTBmBJnY=;
        h=Subject:From:Date:To:From;
        b=fR0aCnzUtw5082QvE6j9vr3kDiX9svXmuuL4ctg+BA0M7lvN9LrwNUpj19UyQxjm8
         0T3lpSfGQ8eCHZsRBMhOpfo6lE4iPfTEbcItrj/rvT/oMTb+vKHbSpT4VHvTUXA7Ow
         vJPoKSayJ40K1KNamfOI2wUS2SDTabn8GeSl57EP9fWF5p7Fyv6ExBjtj0EMmTP/9F
         31R6kXWctx2e9WG5BLxufL2ZgnxD1MqfZ/saaCxY6StSOKCIKuzIlIQ2rH6J2HbkZW
         hBMxwlnrUwb+MLuK5jJ/U9k5WnhsTKT9rxjsoQIo8/uJWc+P9KJMMx+WTKZksGsXRZ
         5s9+s5okv4bzw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D05E6E7BB18;
        Mon,  7 Mar 2022 20:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164668561879.22209.1867407482171889021.git-patchwork-summary@kernel.org>
Date:   Mon, 07 Mar 2022 20:40:18 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Patch: spi: npcm-fiu: Fix typo ("npxm")
  Submitter: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=620720
  Lore link: https://lore.kernel.org/r/20220306142312.109017-1-j.neuschaefer@gmx.net

Patch: dt-bindings: spi: Fix Tegra QSPI example
  Submitter: Jon Hunter <jonathanh@nvidia.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=620955
  Lore link: https://lore.kernel.org/r/20220307113529.315685-1-jonathanh@nvidia.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



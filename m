Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63345544E94
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jun 2022 16:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243779AbiFIOUS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Jun 2022 10:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243905AbiFIOUQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Jun 2022 10:20:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9885525F41F
        for <linux-spi@vger.kernel.org>; Thu,  9 Jun 2022 07:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 531A1B82D07
        for <linux-spi@vger.kernel.org>; Thu,  9 Jun 2022 14:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D98FC34115;
        Thu,  9 Jun 2022 14:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654784413;
        bh=P8E9kc6tIqM4CrvxYJxpyx3jd1WVlcZe5Ft6qUWQ3H8=;
        h=Subject:From:Date:To:From;
        b=njP1wIyF+TIHWuR/acBSdhSBMtZh+fIUPIKIyOp9e+0wLdK7ERt6JvOGtXm2G/rwF
         vhinItEXdruC959/CmT5c/fVcm165MhwsV8DM3eaaOX90hfgX7r1IJ4bPyUMoTJBo1
         +alY22bo/1ENx/lNVREFCmdi32RxsdDMYj3zoBsvsyT8Wd6WIscsI5zvwKHKDfYH4w
         4M8PaqcrZoaxMWhIenVBx5CYdzzzTX6ibrZXkvWqu3n07LsDxG0/qSAmZnI5KIofsG
         zegZM+Bd3rrn1VM87hTeoVln/7AXhOqnAt+R5uum9albcTVyLyatT8Wv6TkEpPKyfO
         /I6QH6CY+4uWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFCEAE737ED;
        Thu,  9 Jun 2022 14:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165478441286.24947.18441196795140046436.git-patchwork-summary@kernel.org>
Date:   Thu, 09 Jun 2022 14:20:12 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Patch: [-next,v2] spi: Return true/false (not 1/0) from bool function
  Submitter: Yang Li <yang.lee@linux.alibaba.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=648722
  Lore link: https://lore.kernel.org/r/20220609071250.59509-1-yang.lee@linux.alibaba.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



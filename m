Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C3749FD6B
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jan 2022 17:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiA1QAM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jan 2022 11:00:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44782 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiA1QAM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jan 2022 11:00:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6F6C61EA3
        for <linux-spi@vger.kernel.org>; Fri, 28 Jan 2022 16:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5EF19C340E7;
        Fri, 28 Jan 2022 16:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643385611;
        bh=aRSchdZyAHxjR1MkmMHkHKfNJ9/0XlWNBj97aXdo8rY=;
        h=Subject:From:Date:To:From;
        b=UX+JZx2RwnqLgaTbYC9CQ+UqFieSXJZ+lvvqjpyNC61cNPk6Yc3pS8wgYXmTiXFQh
         xK3if6F0XdVK80xg1qN7QAhtL13v2/LyFZJ2bmBuzCqUIBnPH0mdbBj9d1I6OMiVOZ
         XtnJ9Z3HR0D46PD8tyKDEXC1qsmrt/MPWMNum1oD1M65NpMDsoRPOG1m/991ERQUgT
         mycsMfkl9WcuQhTsnVl4Mvfx5G5LbsOPzu8ZPBymtuNbf8qSaYtPBX192QP9wN/ePw
         YsIQH2ojt/bwh6lmsoYrqUCS1YLRQQIabii+OIIuUwG/lcEgfwIy09gX6wbDifiXTT
         PeOScgJ0uMe4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3F8CBF60799;
        Fri, 28 Jan 2022 16:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164338561118.28831.1268255260410321045.git-patchwork-summary@kernel.org>
Date:   Fri, 28 Jan 2022 16:00:11 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [-next] spi: Fix missing unlock on error in sp7021_spi_master_transfer_one()
  Submitter: Yang Yingliang <yangyingliang@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=609069
  Lore link: https://lore.kernel.org/r/20220127115815.3148950-1-yangyingliang@huawei.com

Patch: spi: sunplus-sp7021: Unlock on error path
  Submitter: Dan Carpenter <dan.carpenter@oracle.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=609518
  Lore link: https://lore.kernel.org/r/20220128135611.GA29554@kili


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



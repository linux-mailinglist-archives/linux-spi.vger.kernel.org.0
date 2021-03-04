Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A907032D62A
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 16:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbhCDPLQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Mar 2021 10:11:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:37258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234075AbhCDPKs (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 4 Mar 2021 10:10:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id C589464F6B;
        Thu,  4 Mar 2021 15:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614870607;
        bh=e5oowndzo+ceUMVwHbPDHyGX0mtv+/na2UJ+Ttqtx7o=;
        h=Subject:From:Date:To:From;
        b=fZxF27K9giubn5fu6BE9mlOuv+pyCNB3z/rJUMDqOBLwDOd9lU+SqOzzLeYE8KSjS
         81O28UEf5oCPc/8E+yvPBsSQ2/uclVU4zzgCevMIQF+QoVXa4vFvyFd65MaPmNPG6y
         euudmJB5xNTSRoeYYqq1vRR7R6PL40x6c6514WO4/OftNzYSAyMUn2efqZlUay+ojX
         Pt5divA2t8TfA+FSjvlYbJDnWds+9Xx9DaoMpxWu9wUUI2mL84By3LDJzvzCu4I1ZD
         xOmfUzam8vZM1DUGGwTNVSaoq1kpick09VdMXkli4XnNncJNY53oBJ9rlrCa1DRomd
         TRUusxDZ80dSw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B55F4600DF;
        Thu,  4 Mar 2021 15:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161487060768.4521.595721421826327113.git-patchwork-summary@kernel.org>
Date:   Thu, 04 Mar 2021 15:10:07 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: [v2,1/3] parport: Introduce module_parport_driver() helper macro
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=433931
  Lore link: https://lore.kernel.org/r/20210216110741.1286-1-andriy.shevchenko@linux.intel.com
    Patches: [v2,1/3] parport: Introduce module_parport_driver() helper macro
             [v2,2/3] spi: butterfly: Switch to use module_parport_driver()
             [v2,3/3] spi: lm70llp: Switch to use module_parport_driver()
Series: parport: Introduce module_parport_driver() and use it
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=441671
  Lore link: https://lore.kernel.org/r/20210303091642.23929-1-andriy.shevchenko@linux.intel.com
    Patches: [v3,1/3] parport: Introduce module_parport_driver() helper macro
             [v3,2/3] spi: butterfly: Switch to use module_parport_driver()
             [v3,3/3] spi: lm70llp: Switch to use module_parport_driver()

Total patches: 6

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



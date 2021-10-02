Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EAC41F92E
	for <lists+linux-spi@lfdr.de>; Sat,  2 Oct 2021 03:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbhJBBbw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Oct 2021 21:31:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230255AbhJBBbw (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 1 Oct 2021 21:31:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 20D8661AFA;
        Sat,  2 Oct 2021 01:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633138207;
        bh=DF4SsL70Lab7ieeIjNwJweCH/2jQxE+V+haotr1TEJ8=;
        h=Subject:From:Date:To:From;
        b=h5doG1qe/L2hx2k9PQLqxui4QH/zmc4pCTyJh16Fmua7+Y+gZjA8rZX5Eoz8dgwQT
         GezOQv+EhYQdfTXbb2Hu+DohbMIeI+qPDTsXIFZi8C7vgWvZiHhIqx3rNsR0TFabFS
         H4yle8AHF7x6qPGL2djzezH62Thch32wJv2sfGOrmzkG78M4ky7oYTGhrnkVRHDEEg
         VBM73gDaacupqPeLkM7tuvBR5u26HVT3XnGqTy5hZ9yivzXAmgs81nkDAFfoZbFDsU
         aaUqoWmAywDKcMpTEwlxKP8BvGtbf9tOJtjU6ZE9s6bizCq+0UXEguU0MeBXDIWn/q
         cMjeRHe2brn0g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0C35E60A69;
        Sat,  2 Oct 2021 01:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163313820699.19894.16343687163085064327.git-patchwork-summary@kernel.org>
Date:   Sat, 02 Oct 2021 01:30:06 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: spi: spi-nxp-fspi: don't depend on a specific node name erratum workaround
  Submitter: Michael Walle <michael@walle.cc>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=556523
  Lore link: https://lore.kernel.org/r/20211001212726.159437-1-michael@walle.cc

Total patches: 1

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



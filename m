Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091B342CA87
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 22:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239083AbhJMUCP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Oct 2021 16:02:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239040AbhJMUCM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 13 Oct 2021 16:02:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BC9C1611CE;
        Wed, 13 Oct 2021 20:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634155208;
        bh=0MM43aPJMIZmxM/jSmU9Z6uxfzbeNPh4uiEhCjcPZBE=;
        h=Subject:From:Date:To:From;
        b=N2Yu5WTFLJz4nqdOWD/CD07a6H2nCXmFzkvS5Z4aNDqbF2yftIL8ZLUCcwZKGwV5A
         CFMYMUHqMlgGX8hW4s7n7eplt9ipNAcC1RWM0ppgpIIPcppBv5jaG2b3YCASUxbW5L
         XBVR483TVHFTXdlpw7FKCqT9ZAhurOZp0vb42evguguQrv1ZqIUA/doshXQRjDHhng
         arUGmGOto8Tz95w0QExTXLro9RFowzkaw8zHiUXWYK3xGiNJZ3s4qAgCjSWBkOHzqU
         RyYEs45qW+lP/H1AgrpIqwHHjnE/7rK9u7mCQK7ON/lC8GVBfIg/oKbSUtme5UCtU2
         9qxeEdonY12cg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id ACEB460173;
        Wed, 13 Oct 2021 20:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163415520865.18235.2062383921390854696.git-patchwork-summary@kernel.org>
Date:   Wed, 13 Oct 2021 20:00:08 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: tegra20: fix build with CONFIG_PM_SLEEP=n
  Submitter: Arnd Bergmann <arnd@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=562791
  Lore link: https://lore.kernel.org/r/20211013144538.2346533-1-arnd@kernel.org

Patch: spi: cadence-quadspi: fix dma_unmap_single() call
  Submitter: Arnd Bergmann <arnd@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=562793
  Lore link: https://lore.kernel.org/r/20211013144600.2378037-1-arnd@kernel.org


Total patches: 2

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



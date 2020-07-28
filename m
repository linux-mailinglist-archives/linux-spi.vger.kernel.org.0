Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7207A230FFC
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jul 2020 18:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbgG1QkK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Jul 2020 12:40:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731191AbgG1QkK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 28 Jul 2020 12:40:10 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595954409;
        bh=lylxq3E3l6iq3EKvuiVjxxNGtkXWlYskWJb5zMl6iCI=;
        h=Subject:From:Date:To:From;
        b=WB0cC4ABlzqGTCdlgDhhdKiiEgO19ghHi0L18faoz/0Vde7UNvGSpdH0h5sXVRolJ
         fo5CQwGoEBgaat4DNHkzqFVBLQsxNfwugTkuzh59qToKbDEo7kF+S8S9IUyIZV9Xnr
         WeQ5PpUH5lV9gBe4WV0O1mprBO7idEUiJgqCjoJk=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159595440969.8900.2442558990136017984.git-patchwork-summary@kernel.org>
Date:   Tue, 28 Jul 2020 16:40:09 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: [v3] spi: spi-topcliff-pch: drop call to wakeup-disable
  Submitter: Vaibhav Gupta <vaibhavgupta40@gmail.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=324891
  Link: <20200727172936.661567-1-vaibhavgupta40@gmail.com>

Series: [v3,1/3] spi: rockchip: Config spi rx dma burst size depend on xfer length
  Submitter: Jon Lin <jon.lin@rock-chips.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=322881
  Link: <20200723004356.6390-1-jon.lin@rock-chips.com>
    Patches: [v3,1/3] spi: rockchip: Config spi rx dma burst size depend on xfer length
             [v3,2/3] spi: rockchip: Support 64-location deep FIFOs
             [v3,3/3] spi: rockchip: Fix error in SPI slave pio read

Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot

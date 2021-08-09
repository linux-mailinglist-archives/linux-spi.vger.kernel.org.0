Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64C23E45FD
	for <lists+linux-spi@lfdr.de>; Mon,  9 Aug 2021 15:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbhHINBJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Aug 2021 09:01:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233614AbhHINBI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Aug 2021 09:01:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3684060E78;
        Mon,  9 Aug 2021 13:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628514048;
        bh=6BONcFltVodywSmpA9wdeL3FvGPsrqQoDXh9I32mXF8=;
        h=Subject:From:Date:To:From;
        b=rmL1HVQnreis6Du0Y1NeRJ/IbW4JNcaP/LmXHplAjGl30nD8jVEp4jkxh/epEyIlW
         0lMwBkL3VA6crf5I6PzhUCzIkwGJY4gAuOkAqP1JlvFLG93QaWvDm2h+oqfqUFPTAn
         ktIoCEiqDN2l9PIK9r7I76VKqFYkZ9KLrt9ArpBD2DyG2Q/g65xZOgWv08Do9qOT7x
         XA5Y/BjzTn1qDoLnT4bB+uBQq3ZgdOuOjJH5w+N99o8f3D6ybOKXPkey1H4F1baaO2
         tpv3AHaN45bTrF4w8Vg3gqKGwmkAdSmI/T4kGTXmB3xUkVZ5YGgAMb+l4V7Kr5NABz
         eXY1tScSfaBAw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 21E4F609B8;
        Mon,  9 Aug 2021 13:00:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162851404808.23781.503346044337128370.git-patchwork-summary@kernel.org>
Date:   Mon, 09 Aug 2021 13:00:48 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: [v7] spi: mxic: patch for octal DTR mode support
  Submitter: Zhengxun Li <zhengxunli@mxic.com.tw>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=528389
  Lore link: https://lore.kernel.org/r/1628501963-7814-1-git-send-email-zhengxunli@mxic.com.tw
Series: [v2,1/2] spi: tegra20-slink: Improve runtime PM usage
  Submitter: Dmitry Osipenko <digetx@gmail.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=524505
  Lore link: https://lore.kernel.org/r/20210731192731.5869-1-digetx@gmail.com
    Patches: [v2,1/2] spi: tegra20-slink: Improve runtime PM usage
             [v2,2/2] spi: tegra20-slink: Don't use resource-managed spi_register helper

Total patches: 3

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



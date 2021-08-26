Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA643F8A03
	for <lists+linux-spi@lfdr.de>; Thu, 26 Aug 2021 16:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242845AbhHZOU4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Aug 2021 10:20:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229832AbhHZOUz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 26 Aug 2021 10:20:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8B80660E78;
        Thu, 26 Aug 2021 14:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629987608;
        bh=9yHHYqVIO3J7cX4Vw3GYjfDL5aAVr6DYyjQtAt4gKOM=;
        h=Subject:From:Date:To:From;
        b=b4nNCkLqKrd9VmqLLGjd+kbcUc41Rbyssd+ehrrfu1IifuSIynwtlnGuYb+o6p+K5
         Kh0BaOyCnkmTxeyNZuMEjwlNebQog19luX4YlEzkGTgKQIX8UhQRFr9xbjROt+/0yG
         dQn87N4+7u3aQ93SLchskbds8Od1Gvrl7vogl5LSjbI2j+1dA0rTdlJmtTIYvKu/9q
         FAPZfkX3OfA2GVY7HOnGXOO1XFg8sY95Bq/ZV81IDOFsZNoAZT2BiDuEdzDh0g+Bad
         Rroj7wEeRgsp26scWlYpOSFDq+njnl+RGNKa+FlfLSlZz3kSgLWBuf6GwHaO9u4Ujz
         1VN6XV9EDWfpg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7830F60972;
        Thu, 26 Aug 2021 14:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162998760843.14289.17138022675709532391.git-patchwork-summary@kernel.org>
Date:   Thu, 26 Aug 2021 14:20:08 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: [RESEND] spi: spi-zynq-qspi: use wait_for_completion_timeout to make zynq_qspi_exec_mem_op not interruptible
  Submitter: quanyang.wang <quanyang.wang@windriver.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=537429
  Lore link: https://lore.kernel.org/r/20210826005930.20572-1-quanyang.wang@windriver.com

Total patches: 1

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



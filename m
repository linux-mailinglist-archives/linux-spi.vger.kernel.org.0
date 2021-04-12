Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE25035D0B5
	for <lists+linux-spi@lfdr.de>; Mon, 12 Apr 2021 21:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236867AbhDLTBr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Apr 2021 15:01:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236781AbhDLTBr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 12 Apr 2021 15:01:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1923D61358;
        Mon, 12 Apr 2021 19:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618254089;
        bh=8m/K6ixxAVlKD4i9SprddZhlfFuLW5Jqo13oPY8ysrM=;
        h=Subject:From:Date:To:From;
        b=Q/JZoZ77ZrULydXa2BXrK+6SnIFY6eXq47NHK/Lk9mNpL5vlBugWgGfexwoYEVAWa
         BEWE319EP9ujCwlJxrHu1Op9Y/68VKiPQuTwLKNqvzIqzfV46AnBnxTQSMhYouzJuy
         lRXwHVDaAuKtOr4y+MpFUdK1az42Z8gRyJO0gkAxgbT5Jf+z/mGAzFe5QnRYgqclZY
         sj06wNfj05+i3KU9N398Wmo0X8OhnElTEh/3Tj52guQtsp0NNsJhy48z5Mymw9YrZw
         uyufrxA3DutqaFh3UG5dMxZRzO/nAzWaSsrwFYgDo758VGdInkp01d/AqHI+E8pKEC
         04QwJD43d8fdg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0471760A6F;
        Mon, 12 Apr 2021 19:01:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161825408896.30039.14612337907017339761.git-patchwork-summary@kernel.org>
Date:   Mon, 12 Apr 2021 19:01:28 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: Minor updates for hisi-sfc-v3xx
  Submitter: Yicong Yang <yangyicong@hisilicon.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=465569
  Lore link: https://lore.kernel.org/r/1618228708-37949-1-git-send-email-yangyicong@hisilicon.com
    Patches: [v2,1/2] spi: hisi-sfc-v3xx: fix potential irq race condition
             [v2,2/2] spi: hisi-sfc-v3xx: drop unnecessary ACPI_PTR and related ifendif protection

Total patches: 2

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D6B425F4F
	for <lists+linux-spi@lfdr.de>; Thu,  7 Oct 2021 23:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241673AbhJGVmL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Oct 2021 17:42:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241732AbhJGVmK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 7 Oct 2021 17:42:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A0AC460EBD;
        Thu,  7 Oct 2021 21:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633642816;
        bh=L/Fz3fcGFTEwb/laeUNJr5SzxbWe6CkmUY8xfD99GJQ=;
        h=Subject:From:Date:To:From;
        b=snXnx6l1DxzjA6X8V4eePe6m0qKm2IfghN0L8ouRWRgjxn5berPTmzAN4P1IHOj5d
         Ra6nTy+OsXQdD6fYtcT3xhe3z0PR5nhT1cKmwP/MKFmVmzvxh7ewFf/WNEkclalgvd
         Kkn7USU/TCkDUs73fZYg4MQZH3pOX/qDapnLT8SajuUGy1dggRfoirfQzyQyKwmvUW
         TynWNjb+4efiA59txJD/bDfcThzWvdxZOlPWICuV8ukxQgdBzIsqpaeFA8vhePGQUD
         nmjlxtFigoImC1zNC7EGGNqROgve7gRdiA/xpxlT66GKLvW8y29eDlxvwRPrdwWYHX
         Bq3wVI9A6wKZQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8A2C16094F;
        Thu,  7 Oct 2021 21:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163364281651.15413.11933510108845547541.git-patchwork-summary@kernel.org>
Date:   Thu, 07 Oct 2021 21:40:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: Various Cleanups
  Submitter: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=559095
  Lore link: https://lore.kernel.org/r/20211007121415.2401638-1-u.kleine-koenig@pengutronix.de
    Patches: [1/4] spi: Move comment about chipselect check to the right place
             [2/4] spi: Remove unused function spi_busnum_to_master()
             [3/4] spi: Reorder functions to simplify the next commit
             [4/4] spi: Make several public functions private to spi.c


Total patches: 4

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



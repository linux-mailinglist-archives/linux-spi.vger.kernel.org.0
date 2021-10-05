Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60563422C85
	for <lists+linux-spi@lfdr.de>; Tue,  5 Oct 2021 17:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhJEPcA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Oct 2021 11:32:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhJEPcA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 5 Oct 2021 11:32:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E7B566115A;
        Tue,  5 Oct 2021 15:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633447809;
        bh=Km4qxscA0QAM67IoKpryWzrTUv2mwXhV9SWYCrsB6bY=;
        h=Subject:From:Date:To:From;
        b=B5XV9pVhlsHVxuugJ1yn3AGjqDKOx8ZI7uBgEGUkICXtJ59hLjzvus4swg9RPLms/
         cTul/E/g/M8Yz2sPhy5Wegq7hyEnw1Vr5sQ8m19PYeLGQSYG/H3N0Ylp1Hi6yYzRHb
         HvMZSlvOwG0NfnQIY5W4UBO2CRpJ81QXH0th22+Apy0nv+xATvdsrMkfiVU1xekZob
         1o22YbuBUXpkRa7M8lXVJAYCopyH3fLDJPCZOIeVpSnFiGWa5ESWiyDkJdUsnv5KjF
         mMgYycHBszESrGP9peuppqULyo9KkdlF5O6YuRY1p+FWh6ckXg2nv7VhEWGtWYL/MC
         ucwNxwQhy6Xcg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D5E4060971;
        Tue,  5 Oct 2021 15:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163344780982.17305.5086888871037948924.git-patchwork-summary@kernel.org>
Date:   Tue, 05 Oct 2021 15:30:09 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: spi: fsi: Print status on error
  Submitter: Eddie James <eajames@linux.ibm.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=557341
  Lore link: https://lore.kernel.org/r/20211004195149.29759-1-eajames@linux.ibm.com

Total patches: 1

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



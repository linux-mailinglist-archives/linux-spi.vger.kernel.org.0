Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABD82D453B
	for <lists+linux-spi@lfdr.de>; Wed,  9 Dec 2020 16:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgLIPVT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Dec 2020 10:21:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:38024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbgLIPVS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 9 Dec 2020 10:21:18 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607527238;
        bh=oP1/ghIggIcdAgTMo8gKtiiliLAPXkTFve4MepiTTmU=;
        h=Subject:From:Date:To:From;
        b=qdB7UTxxs1XiqlPdkLB2PfOzdgzWx7HBcdZ3Ng1ijfeQUMUahwY40OfC93D95Nd6b
         w5JMmKXRy1e3czw8HLk/3K1OM5OG1+AIc9AQZk2X5ugVA2OStBuopCYs4rJyrVKtMA
         RbJCILgIHSP3dYjWdGSZqytvVjBJkoReg7tWN2txlwFUuwK/4nSnz0cXXQbtMKmbOk
         pmiFyqIiAj/R4pSuKZhaVLE0RYNYF0wYzXmRVJ5uQYCsus2damLA2nKGmWZKboC43z
         EhkT2pfvBEgpvAYjMkRlthTfh3ARidRz9YKSEboZyjFn5cnknRA9RgfhQuEZsvO91x
         XfE9Dm2eXz2Ug==
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160752723825.28193.5514280504355665958.git-patchwork-summary@kernel.org>
Date:   Wed, 09 Dec 2020 15:20:38 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: DW apb_ssi V4 support for Kendryte K210 RISC-V SoC
  Submitter: Damien Le Moal <damien.lemoal@wdc.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=396943
  Lore link: https://lore.kernel.org/r/20201206011817.11700-1-damien.lemoal@wdc.com
    Patches: [v3,1/3] dt-bindings: spi: dw-apb-ssi: Add Canaan K210 SPI controller
             [v3,2/3] spi: dw: Add support for 32-bits max xfer size
             [v3,3/3] spi: dw: Add support for the Canaan K210 SoC SPI

Total patches: 3

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



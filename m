Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1F932C9E0
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 02:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbhCDBOa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Mar 2021 20:14:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:39924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240482AbhCDBAz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 3 Mar 2021 20:00:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 8A29864E99;
        Thu,  4 Mar 2021 01:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614819612;
        bh=NWuBFIk5G+pdSk7BXcdWWZ1/tinMC3OgUHUQ+OqW3Ik=;
        h=Subject:From:Date:To:From;
        b=VWBGm9BpvU+SJ7StUuQpOD5DlM4bVfswKJVWaRPqHNVk8MCAz1wuUj+T1RSZ+QGH0
         MB3U1J0SbZizCUcg+fVuu4DfSwSJNSWC4ANlwOuACKlMZ3oJjai6qYH8Zz0v7x1IkR
         g25Q2mBYhj7l4B22xVOKsFiI4DMw7pewSmAVFdnhS/mllc8o1UO06kNjeSHfvTLO8N
         dvqs2vU0w9Qz0bAOZ09Robudz4PQvfih8L+gTiKw20sZyGE9w9VDEXiHaiuorMEJiF
         GpzlLNhP01jGREJPmHZ4uUClFJox8vefwJ3p1kl+TcEtjzCKC4jccfgQzEOj+ezP30
         R/4JNXex5J8/Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7310E600DF;
        Thu,  4 Mar 2021 01:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161481961241.28060.9353646308919500237.git-patchwork-summary@kernel.org>
Date:   Thu, 04 Mar 2021 01:00:12 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: NXP Flexspi driver patches
  Submitter: Kuldeep Singh <kuldeep.singh@nxp.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=440599
  Lore link: https://lore.kernel.org/r/20210302124936.1972546-1-kuldeep.singh@nxp.com
    Patches: [v2,1/4] spi: spi-nxp-fspi: Add support for IP read only
             [v2,2/4] dt-bindings: spi: spi-nxp-fspi: Add imx8dxl support
             [v2,3/4] spi: spi-nxp-fspi: Add imx8dxl driver support
             [v2,4/4] spi: spi-nxp-fspi: Implement errata workaround for LS1028A

Total patches: 4

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



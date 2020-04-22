Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31CE1B4621
	for <lists+linux-spi@lfdr.de>; Wed, 22 Apr 2020 15:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgDVNUH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Apr 2020 09:20:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgDVNUH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 22 Apr 2020 09:20:07 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587561607;
        bh=j1SMF2WXZertVZpnKmohaU29PuVt4uJk1aH1dOXTaPo=;
        h=Subject:From:Date:To:From;
        b=ER7/BPIgELHRLvMGLjOot6dWB5HPpzI8E9DbK6ZRK4/CpZw2D29WEyeE/+Qv8Z6pd
         soFEoU14jEtSjlq6btDwNsqvBKRrsIy8GAG6myJcVb5/Xo7gNXM/KgvuJfyezJp3I4
         hiAFlQ9egd5XdEq+TbRS8LepfdO+ItMDqrvUzw5U=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158756160721.6621.13938003596834310830.git-patchwork-summary@kernel.org>
Date:   Wed, 22 Apr 2020 13:20:07 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: [-next] spi: spi-fsl-qspi: Fix return value check in fsl_qspi_probe()
  Submitter: Wei Yongjun <weiyongjun1@huawei.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=274645
  Link: <20200421093908.48213-1-weiyongjun1@huawei.com>

Patch: [-next,v2] spi: spi-fsl-qspi: Fix return value check of devm_ioremap() in probe
  Submitter: Wei Yongjun <weiyongjun1@huawei.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=275061
  Link: <20200422014543.111070-1-weiyongjun1@huawei.com>

Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot

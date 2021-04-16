Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8AC36232F
	for <lists+linux-spi@lfdr.de>; Fri, 16 Apr 2021 16:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbhDPO5T (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Apr 2021 10:57:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235784AbhDPO5S (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Apr 2021 10:57:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C120361166;
        Fri, 16 Apr 2021 14:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618585013;
        bh=ksRBm4SRcnjKqJ1iXzvqvak+vhJliSDk7H0ewRcTRmk=;
        h=Subject:From:Date:To:From;
        b=bIIQYbHGHkw1Rm4dwQKWyIXcF5KWVC+SHDXZv1f3ke4QpOvIB9Zk+W2+N8BJGBZ7E
         Cks8Km+fUNnP+taLAkHiauPj0yJ0piThzT8iwpDuwVIrIRg+vqpWpkGBdW4/hEfXgS
         RR3zRJpqVfcemufygKrtl8a8AWjuq3a9y5vratjK8/oWjki9R7E4avdeqj/1AYdTwP
         1A6lBSToRprpRaDU7r9zttWqdALuUlb9JFBFj98q7QHutiNm82wpQl0IYcE9VYvSgn
         vhmDxmlxxtOqAthLE3b4cQIs8R95jdHI8rE4kHdTgG6TLwA78UEWrekuaIHv1Q9Fn0
         ox+V52++SWTNA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AA3DF609AF;
        Fri, 16 Apr 2021 14:56:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161858501363.14108.3048686187044816167.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 16 Apr 2021 14:56:53 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-zynqmp-gqspi: fix spi issues (2021-04-16T14:20:42)
  Superseding: [v1] spi: spi-zynqmp-gqspi: fix spi issues (2021-04-16T00:46:47):
    [1/5] spi: spi-zynqmp-gqspi: fix clk_enable/disable imbalance issue
    [2/5] spi: spi-zynqmp-gqspi: fix hang issue when suspend/resume
    [3/5] spi: spi-zynqmp-gqspi: Resolved slab-out-of-bounds bug
    [4/5] spi: spi-zynqmp-gqspi: fix use-after-free in zynqmp_qspi_exec_op
    [5/5] spi: spi-zynqmp-gqspi: return -ENOMEM if dma_map_single fails


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


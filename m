Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C300335BB7E
	for <lists+linux-spi@lfdr.de>; Mon, 12 Apr 2021 09:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbhDLH47 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Apr 2021 03:56:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230034AbhDLH47 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 12 Apr 2021 03:56:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 745866121F;
        Mon, 12 Apr 2021 07:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618214201;
        bh=7D/rth24LhQg6CzqMje4wkV8k3Pfzxnu/FJAUfd8elU=;
        h=Subject:From:Date:To:From;
        b=PiZBkwHQ5G7wAssmvuu+0fwAxkcPOcH9hTsXMrXUMHG7EPChI1suuhZBgYig54TO+
         rAbuowGBSBqLk1XSBeDgr2sZE7xr8n/rWLoqROTCbeuFvRqSq2WE/gLbcrE0jsjFiM
         N1Yfxv+fKVULm5N6Bt6alyuNH/onm0kJGxMZytBLeoNFqqhtYmmGKwgvTIPCXbAOlk
         8F1xK2Ox24Wbl3zKp/PJkeJPJCwMRfRg8yiDPXxpx1vCzFTleFjY33w8sU4FpDGRPQ
         vPJgrvlJqp+8m7WaG6FQS2S8vUWCDC3RvRfW+b8h8PtFPHhJ5FZhIpVJz9GITRwjyS
         zJ7RwG67/L6vA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 63EF360951;
        Mon, 12 Apr 2021 07:56:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161821420134.29624.5351993087256481750.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 12 Apr 2021 07:56:41 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in zynqmp_qspi_probe (2021-04-12T07:31:54)
  Superseding: [v1] spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in zynqmp_qspi_probe (2021-04-08T09:25:59):
    spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in zynqmp_qspi_probe


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


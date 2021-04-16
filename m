Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554BB361A28
	for <lists+linux-spi@lfdr.de>; Fri, 16 Apr 2021 09:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238060AbhDPG5E (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Apr 2021 02:57:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238245AbhDPG5E (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Apr 2021 02:57:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B59876103D;
        Fri, 16 Apr 2021 06:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618556199;
        bh=kE/pKdaTh7tZSRtN504em//pWDFuLa0m96V5OIwrqxo=;
        h=Subject:From:Date:To:From;
        b=f0mKemvHh/htB4dX8jgnysmR2zkgOExzVrfjHsjWM8moUNny2iLujYfxGvBZKuS/j
         UwcH8KCxO4CtgHHhvpD2geiyZ4pGirLTasxbaSxvmwETjAJ5gnxgdwEzsaxsdoIbVe
         rvfazERyTEt7u4nqKybKxJcVupIx8+4dC0ORDYnzQBn8tjX+PedKRtCHQOFi0aItL8
         89GZdlxZL2tbRfMPJMcy/a4qOW2fPBQWMCb+DW8UFPEjOFn9ZECfp9DgNI5owvh/KL
         AV7/jW2plH2dIhAZAp5c09fEME38NNny/hXS1Y3v70eD876MZk0eCPf1lQACKGFkMA
         QDdBGg2TEINgw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A2F2660CD4;
        Fri, 16 Apr 2021 06:56:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161855619965.10294.9089388299820608562.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 16 Apr 2021 06:56:39 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] dt-bindings: spi: brcm,spi-bcm-qspi: convert to the json-schema (2021-04-16T06:23:20)
  Superseding: [v1] dt-bindings: spi: brcm,spi-bcm-qspi: convert to the json-schema (2021-04-15T22:02:01):
    dt-bindings: spi: brcm,spi-bcm-qspi: convert to the json-schema


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


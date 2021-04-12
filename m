Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A6735C6D3
	for <lists+linux-spi@lfdr.de>; Mon, 12 Apr 2021 14:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239239AbhDLM5B (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Apr 2021 08:57:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239916AbhDLM5B (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 12 Apr 2021 08:57:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 338EA61261;
        Mon, 12 Apr 2021 12:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618232203;
        bh=3MwOsHCOsv3l76lcgVW23qdoJCDNPIPY7WpRkF1/84o=;
        h=Subject:From:Date:To:From;
        b=KxAHnv4kHG/vPLhl0S9CVtUsolu2ytO40ZIEhW74oRtn+soFOSE7LRnW2a7CeuoXP
         Fbll7yKvVAtNVN5rATZL+6acfGS4xdmvxhohXZ2r3zTlZP1mQzoEwR2USxn21/mZ6f
         /NVWg/p0AeG4G/ac1mDEDtjuSIKRAmgDpMIEI2bVcHUFLt94bXX4IeOG5RZHTof5LL
         eK4vOA3icD00UI1t1sTqkpXohcf5HDunEj+Y+1UsmjE1X+Hs/6bemTy0TzyfHtO5xR
         WP9haeiyEgFzNvahGEPFr62hP8w+yZQb6oq613UR6sOXqTxFWp5AL7HEYr5HCdQf4t
         Tq1v7SqNjvvSA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 22254600E8;
        Mon, 12 Apr 2021 12:56:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161823220308.20547.17424391619263023504.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 12 Apr 2021 12:56:43 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Minor updates for hisi-sfc-v3xx (2021-04-12T11:58:26)
  Superseding: [v1] Minor updates for hisi-sfc-v3xx (2021-04-08T11:31:45):
    [1/2] spi: hisi-sfc-v3xx: fix potential irq race condition
    [2/2] spi: hisi-sfv-v3xx: drop unnecessary ACPI_PTR and related ifendif protection


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


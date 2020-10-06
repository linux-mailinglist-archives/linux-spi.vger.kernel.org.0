Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7819284F03
	for <lists+linux-spi@lfdr.de>; Tue,  6 Oct 2020 17:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgJFPaE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 6 Oct 2020 11:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgJFPaE (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 6 Oct 2020 11:30:04 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601998203;
        bh=EuQwVZiRMy1h3Unm6i1F//YuOeeHQiWo/Bn0zePk/1s=;
        h=Subject:From:Date:To:From;
        b=nx33bpk6TiPCcX6ElYUIwppl6Uvwqa4yQOnC9Fk9Q1kjgYUmoerMXTYS8xqMzza5L
         wghdMmObwaM/pZ/xcolHbcGiXuPs19cGwuBrlQyOk2Rd6UwSgSU6CouCRLU8FPn6xZ
         XPPRtCL+TFCyll/zqCj/88lJac7ZEaqOmokKGPUw=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160199820351.11686.1005273253405060886.git-patchwork-summary@kernel.org>
Date:   Tue, 06 Oct 2020 15:30:03 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: spi: spi-mtk-nor: Add mt8192 support.
  Submitter: Ikjoon Jang <ikjn@chromium.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=360161
  Lore link: https://lore.kernel.org/r/20201006075405.11658-1-ikjn@chromium.org
    Patches: [v5,1/4] dt-bindings: spi: add mt8192-nor compatible string
             [v5,2/4] spi: spi-mtk-nor: use dma_alloc_coherent() for bounce buffer
             [v5,3/4] spi: spi-mtk-nor: support 36bit dma addressing
             [v5,4/4] spi: spi-mtk-nor: Add power management support

Total patches: 4

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



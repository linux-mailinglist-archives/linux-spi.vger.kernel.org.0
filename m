Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2D03CA36C
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jul 2021 18:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhGOQ7b (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Jul 2021 12:59:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhGOQ7b (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Jul 2021 12:59:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 184AE613EB;
        Thu, 15 Jul 2021 16:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626368198;
        bh=5ij3ir22ruZbsESJNNPKbLskGS0aSb3MrxsOeIo1JWo=;
        h=Subject:From:Date:To:From;
        b=piiahMscsY1tl/PVOkD5FvmwUVSy2mCbTl8DnKHggO527in7TQi52EYrsEWeHXGz3
         FtVA2yNWQa6MiL8nT35VsEILx0Ss7iRs38EW2vmForviQrin8R9/qtHOhgZQUplLas
         gpeezBMszu7d0DHcC5+o772WPd7WbKut7sKPumohe4QQdh1+ZFOoz+SjaAq1Yxeat1
         MRXE663ruVvu3pCGOhHyeVRek3v0DR9AlAzMClT5KRUg9ZRojM7+MqLNFTI0R8NAj1
         iwIOWb9qTQ1zYz63zgTEEzA37YTGoKDcl7rekZ8RriBvlQOJ9naRTsHsUO16G9HWnu
         EeiJkSGVGmGOA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 07CC1609B8;
        Thu, 15 Jul 2021 16:56:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162636819797.9816.15792144254497261518.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 15 Jul 2021 16:56:37 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: spi-cadence-quadspi: Fix division by zero warning (2021-07-15T16:21:32)
  Superseding: [v2] spi: spi-cadence-quadspi: Fix division by zero warning (2021-07-15T00:46:30):
    [v2] spi: spi-cadence-quadspi: Fix division by zero warning


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


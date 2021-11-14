Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E794844FC60
	for <lists+linux-spi@lfdr.de>; Sun, 14 Nov 2021 23:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbhKNW74 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 14 Nov 2021 17:59:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:52836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232607AbhKNW7v (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 14 Nov 2021 17:59:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4C14E61105;
        Sun, 14 Nov 2021 22:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636930608;
        bh=YMkgDDtsH4cKxAz85KXoTeFRxVd+WietJleLIDxcPuI=;
        h=Subject:From:Date:To:From;
        b=NvApPWWxTc/12U71Qx9IgZT/8qA6xRht5z0FYbg0U3XlHyOaAjJPA/YxZE+fgBtDh
         w2TUMtmLQmklym0lIs2oWsZ9jVBYQ7D9x8OQ8AwgOli215XAQsJZzo8dikXFnIK0UM
         KgUYlQEER7VaDzvYMPf/UQiskD+0Bw14t8/CJz10G+7/UF2CdGB6dSUkDMxq/G1mnZ
         E52vAGwDxKpIC4QP6yb/7mKhsAqxcsd4E9GIwoUx/cmID8RAuKpyClmtOxqYIM8VBh
         lBVZYYx6b7aJJzApHfbsxh97hqf+YuPraxlPie0j64WgrX5uaN8wscxaAdPQbmcSIK
         0YTH9q+sbO0Hw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 36BC16097A;
        Sun, 14 Nov 2021 22:56:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163693060815.15380.11097881941668158664.git-patchwork-housekeeping@kernel.org>
Date:   Sun, 14 Nov 2021 22:56:48 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: dw: Cleanup macros/funcs naming and add IP-core version support (2021-11-14T22:30:20)
  Superseding: [v1] spi: dw: Cleanup macros/funcs naming and add IP-core version support (2021-11-12T20:49:23):
    [1/4] spi: dw: Discard redundant DW SSI Frame Formats enumeration
    [2/4] spi: dw: Put the driver entities naming in order
    [3/4] spi: dw: Convert to using the Bitfield access macros
    [4/4] spi: dw: Add Synopsys Component version reading and parsing


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


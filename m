Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365AB365DFB
	for <lists+linux-spi@lfdr.de>; Tue, 20 Apr 2021 18:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhDTQ5X (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Apr 2021 12:57:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232879AbhDTQ5X (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 20 Apr 2021 12:57:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7BD1D613AB;
        Tue, 20 Apr 2021 16:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618937811;
        bh=TnBvDWeROMQRcbYAYW9CX3zr0XRFX9ybv6qCVXwFYyE=;
        h=Subject:From:Date:To:From;
        b=LvOqdcUGxrJk8fYOCHa4SrYkVcUOZhLJCTj4elsMcBGePVY5ko/uYQEfoMl7w2hcL
         GGWV7ndd2S/PLMLU0O0xMPQpY9xHHxkY5LYO5ENEzhtpuWTlTpUCNXbjN5spCEtmTx
         k1Xs+kWBUPOW6Vh0swqEiNxn+msTyL50gHDZaDnqPiSBVN3iSgqL/m7ED6t0cVkDT7
         pwTxftrcCgvr+uK91jp2GNFQ3gHnVnKrDElJDT2MmHscIDDFNEnTDp+LOuEbxWC0X+
         TrjJst/dKH5GelCz1pcm0T03N6MOudDBNIEqh2HSkuo+nMCGxPE13wlomuWCt/i7ty
         G7K+fKvFEvklQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 73F2C60971;
        Tue, 20 Apr 2021 16:56:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161893781146.18519.973206230315173977.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 20 Apr 2021 16:56:51 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: Allow to have all native CSs in use along with GPIOs (2021-04-20T16:44:24)
  Superseding: [v1] spi: Allow to have all native CSs in use along with GPIOs (2021-04-20T14:10:04):
    [v1,1/2] spi: Allow to have all native CSs in use along with GPIOs
    [v1,2/2] spi: Avoid potential UB when counting unused native CSs


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


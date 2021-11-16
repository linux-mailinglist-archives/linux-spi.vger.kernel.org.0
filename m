Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701FE45261C
	for <lists+linux-spi@lfdr.de>; Tue, 16 Nov 2021 02:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345345AbhKPCBw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Nov 2021 21:01:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:37140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240461AbhKPB7s (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Nov 2021 20:59:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 5C88661A89;
        Tue, 16 Nov 2021 01:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637027812;
        bh=H/6ZObEE45coK1REj7ms+36bIZYePU9neZSWX64owSY=;
        h=Subject:From:Date:To:From;
        b=sFyjd5elwsf+w0RqquFvnFuY3Eon4NskSYUp86zTH/f+POlF+eLVX+ZrEUKJsJQzv
         25rFnN9XRJief1d/0y1vwavZy/V5FfzS0tDRtfv64g8GKvV3DRSQQVZyiFU81WO2PO
         x/emrbIylWKzbNQv6UqKo45pTDrFJOCwPGrJxEv/SZOxugChRypyQ93o3Z580eYzlA
         BMztLktimqzEEzVzeSH5pouslRKYHu3OXrYZ+agdl62O8DBlCURhaOAEr2gVyfcc7V
         N2TlkDcEJf469nJNlHCVA8q5pWy32ytCgRkVhpTW3tt5kLLhiDbGB71/cojtjoMx/L
         SjcbhigJk2OKA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 492B5609EB;
        Tue, 16 Nov 2021 01:56:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163702781226.12764.9439637000052517974.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 16 Nov 2021 01:56:52 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: dw: Cleanup macros/funcs naming and add IP-core version support (2021-11-15T18:19:15)
  Superseding: [v2] spi: dw: Cleanup macros/funcs naming and add IP-core version support (2021-11-14T22:30:20):
    [v2,1/6] spi: dw: Add a symbols namespace for the core module
    [v2,2/6] spi: dw: Discard redundant DW SSI Frame Formats enumeration
    [v2,3/6] spi: dw: Put the driver entities naming in order
    [v2,4/6] spi: dw: Convert to using the Bitfield access macros
    [v2,5/6] spi: dw: Introduce Synopsys IP-core versions interface
    [v2,6/6] spi: dw: Replace DWC_HSSI capability with IP-core version checker


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743751A7A51
	for <lists+linux-spi@lfdr.de>; Tue, 14 Apr 2020 14:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439854AbgDNMGU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Apr 2020 08:06:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439855AbgDNMGT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 14 Apr 2020 08:06:19 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586865979;
        bh=bJEdGrDByczPzPX2jplhop768nMCUDU8k1GrsUIDj7M=;
        h=Subject:From:Date:To:From;
        b=yRk827XwegGbxk/XTqd8evY3p7ga818NGsz9shv/GNqqlPaUoCIJ2lbj2Lt1A7rfX
         8Kcgqv1IEi0S9+D2sO6p+k+u4/6OEmW8HvdHjSn1oBqiETHQ64pp0JOt6fT2lQhgz7
         HlE0NH2IH0gfAMHNvSJGbLxdgqiWQJFGA2Bv2UKo=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158686597918.28989.12683518738302754936.git-patchwork-summary@kernel.org>
Date:   Tue, 14 Apr 2020 12:06:19 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: spi: pxa2xx: Enable support for compile-testing
  Submitter: Geert Uytterhoeven <geert@linux-m68k.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=238989
  Link: <20200210093027.6672-1-geert@linux-m68k.org>

Series: arm64: dts: sun50i: H6: Enable SPI controller
  Submitter: André Przywara <andre.przywara@arm.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=229579
  Link: <20200116231148.1490-1-andre.przywara@arm.com>
    Patches: [v3,1/3] arm64: dts: sun50i: H6: Add SPI controllers nodes and pinmuxes
             [v3,2/3] arm64: dts: allwinner: h6: Pine H64: Add SPI flash node
             [v3,3/3] dt-bindings: spi: sunxi: Document new compatible strings

Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB8022943E
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jul 2020 11:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbgGVJAS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Jul 2020 05:00:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726870AbgGVJAR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 22 Jul 2020 05:00:17 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595408417;
        bh=JtxyaZlwfAofmy/R4OduHi1e9jThRxojiHiy17bWPi0=;
        h=Subject:From:Date:To:From;
        b=xqSgYb7Fs8ixGXhg6476piaBoRc0SF+zCqiqskt9da0mRkdwsYCMmc6fHejtkegwb
         BU2WxsB1fd3wPDdcifEpGPNVTX7ZPJyF7x8xXEgDHYtoVpx3QP3G1mAIyn1VmlFHWo
         fldvAmGyumr5/sW6ZVf3hJVVRYXgFdDSmcKatHEM=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159540841758.26567.13442040470712970783.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 22 Jul 2020 09:00:17 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: rockchip: Config spi rx dma burst size depend on xfer length (2020-07-22T08:37:37)
  Superseding: [v1] spi: rockchip: Config spi rx dma burst size depend on xfer length (2020-07-22T06:52:55):
    [v1,1/3] spi: rockchip: Config spi rx dma burst size depend on xfer length
    [v1,2/3] spi: rockchip: Support 64-location deep FIFOs
    [v1,3/3] spi: rockchip: Fix error in SPI slave pio read


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307DD1CEE5B
	for <lists+linux-spi@lfdr.de>; Tue, 12 May 2020 09:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbgELHkR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 May 2020 03:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbgELHkR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 12 May 2020 03:40:17 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589269216;
        bh=bk5WDpTCIMiJ0e1n24NwkOBmK1cK2eh11dx0YNCFloc=;
        h=Subject:From:Date:To:From;
        b=oZwNjf2jFGnD7LsKJ9Fgg0o2KtJ0JQxsvJfkE9xt2DuAwBxJAhUgDKif89IDM6LrQ
         +WzvKc4Ena+hNCh+llpVHFqJ5hNB56Ai/4E1Cd0NnX+oZnBWXLtOScYCMXbkDvMRrN
         hIO9J8yah66ERgjABdjd0BYbfeCT4/jZYAZ3s3FQ=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158926921676.31275.9377053420847177550.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 12 May 2020 07:40:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Enable l3gd20 on stm32f429-disco board (2020-05-12T07:36:47)
  Superseding: [v1] Enable l3gd20 on stm32f429-disco board (2020-05-09T06:58:20):
    [1/3] ARM: dts: stm32: Add pin map for spi5 on stm32f429-disco board
    [2/3] ARM: dts: stm32: enable l3gd20 on stm32429-disco board
    [3/3] spi: stm32: Add SPI_SIMPLEX_RX, SPI_3WIRE_RX support for stm32f4


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot

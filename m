Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D8834B5D3
	for <lists+linux-spi@lfdr.de>; Sat, 27 Mar 2021 10:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhC0J44 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 27 Mar 2021 05:56:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231445AbhC0J4l (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 27 Mar 2021 05:56:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1D9FE61A02;
        Sat, 27 Mar 2021 09:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616839001;
        bh=xj9udIYPEg9+Pc+m9rHV1hT+xjLTaxuPyU5797wygGM=;
        h=Subject:From:Date:To:From;
        b=ZHzstjYabwNlOVAHBacn//bnT18/YKhQSQpQgoBnk/5ObBRWH6knpIxALTKrrdy/G
         9DzCP7mZMhNIuWPUknqC6XgSJ4LZC+0Yjdtvcxbd+lFC8iQ1aKonq2J8RS9jteKVhK
         FXYmKoeLym+tM0CiZeWe8gBd8yRGzBK7H+aYipbXovcbiGY6t6fmHqHgGgNUxz2qHl
         SFdjyP6EG4NSIJ30WdLjKbp4s6t+1kF3htSIvqHoScmuQwa4SLg5WOWUhGf4LzjVHX
         2NkWAnyzbYZsI3usFUwvKRh3UDJIbF+tgvpWgPRJ/ZeIhI0hv2pq5YBUZCsHoCq8ps
         nXOJvFMMbuPnw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 07E20609EA;
        Sat, 27 Mar 2021 09:56:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161683900096.15837.10140938432802813735.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 27 Mar 2021 09:56:40 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: Add HiSilicon SPI Controller Driver for Kunpeng SoCs (2021-03-27T09:10:00)
  Superseding: [v2] spi: Add HiSilicon SPI Controller Driver for Kunpeng SoCs (2021-03-18T09:50:24):
    [V2] spi: Add HiSilicon SPI Controller Driver for Kunpeng SoCs


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B20E3985C0
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jun 2021 11:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhFBJ6a (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Jun 2021 05:58:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229571AbhFBJ6a (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 2 Jun 2021 05:58:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id DC60B611CC;
        Wed,  2 Jun 2021 09:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622627807;
        bh=8j/xbtrJcXVMWhyUw9mcfSUFUczgvlVSScLh9oGcle4=;
        h=Subject:From:Date:To:From;
        b=a0WJE/1jJMukv/REhCbWmrw2qHUtNsDSxT/nJWtQL0a8e1216CpQNOvHvmzSiMW+E
         6cFqGODpvCIqsr9LX7FBeTIk4O8yBY4Bb9LPkr1Z/2yHdrCdSVvFQ8mEE5L6mMZfZS
         z55WTKrPkecsSSEJMyPbu7T8yVf4mRGERW9GjVj2sDik24Pk5NkcaDztHMEtJp3GEx
         P7I0paJxPUK5KbGggUXE/Gtp5CyR7vTrMiG98naYFE+isGCFXJDmqTpXQ9xqGQ/GX9
         nm/bUVn5zOJ9ueMND19WAuQ457c2GJZ/x4hsuEL1Siqdep+wa+ImTgMln+v95DXzJP
         S/ruUg2wtIyKg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C7B4A60A39;
        Wed,  2 Jun 2021 09:56:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162262780775.3404.1809794021695943154.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 02 Jun 2021 09:56:47 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] mtd: spinand: add SPI-NAND MTD resume handler (2021-06-02T09:49:13)
  Superseding: [v4] mtd: spinand: add SPI-NAND MTD resume handler (2021-05-28T14:16:36):
    [v4,1/3] mtd: spinand: Add spinand_init_flash() helper
    [v4,2/3] mtd: spinand: add spinand_read_cfg() helper
    [v4,3/3] mtd: spinand: add SPI-NAND MTD resume handler


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


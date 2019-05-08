Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9757C17585
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2019 12:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfEHKAI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 May 2019 06:00:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbfEHKAI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 8 May 2019 06:00:08 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557309608;
        bh=8raXf4XH87b8YSIiBLpB726b6faFuBPCEQZOXkQcVww=;
        h=Subject:From:Date:To:From;
        b=qbBxhJDbbGD8eJZFDJHVh7H+2z56Gh/te4vnJN5Juag2pIYuGckh4vxILw2Aygvnt
         NThAYf1gfgiBCi+NeitbIO0Snae/2X7ASVwrXJ3w2IXLBlC3sie8ZnRczFONRzVIxH
         ryM4Wm+DVUaYGkAeyfBxGykBfjWetQ16jMuf0pUY=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <155730960822.30741.9728463466766848422.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 08 May 2019 10:00:08 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-mem: Fix build error without CONFIG_SPI_MEM (2019-04-10T12:13:41)
  Superseding: [v1] spi: spi-mem: Fix build error without CONFIG_SPI_MEM (2019-04-08T14:39:49):
    spi: spi-mem: Fix build error without CONFIG_SPI_MEM

Latest series: [v2] spi: tegra20-slink: change chip select action order (2019-03-29T17:44:11)
  Superseding: [v1] spi: tegra20-slink: change chip select action order (2019-03-26T14:30:50):
    spi: tegra20-slink: change chip select action order


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot

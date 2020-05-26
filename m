Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C651E1EDB
	for <lists+linux-spi@lfdr.de>; Tue, 26 May 2020 11:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbgEZJkQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 May 2020 05:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728735AbgEZJkQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 26 May 2020 05:40:16 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590486016;
        bh=dMAVVx38L9zxfjXm9BxyEdT0gTTwLNQy0l6De2b+LSs=;
        h=Subject:From:Date:To:From;
        b=hsh8kow/yd+gfmWfNlm9B/GxK95Skp0XfNpsEMGQz6HrSDj2KVFSsqXBAr+f2f74U
         6nhHofHNPOrTa0g2CcQjO7ax+uwSRhT7WrVPgqWev+i+IO8r1WYxJO5ZI7IeVKlc8M
         y1veAlkssR7jmzoxTE53YGIXt1y+XSYI7/pBuMlU=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159048601595.3274.8224087135910196046.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 26 May 2020 09:40:15 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] mtd: spi-nor: Move cadence-qaudspi to spi-mem framework (2020-05-26T09:35:58)
  Superseding: [v1] mtd: spi-nor: Move cadence-qaudspi to spi-mem framework (2020-05-08T18:54:05):
    [1/6] mtd: spi-nor: cadence-quadspi: Drop cdns,is-decoded-cs property
    [2/6] mtd: spi-nor: cadence-quadspi: Provide a way to disable DAC mode
    [3/6] mtd: spi-nor: cadence-quadspi: Don't initialize rx_dma_complete on failure
    [4/6] mtd: spi-nor: cadence-quadspi: Fix error path on failure to acquire reset lines
    [5/6] mtd: spi-nor: Convert cadence-quadspi to use spi-mem framework
    [6/6] spi: Move cadence-quadspi driver to drivers/spi/


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot

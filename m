Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7461DF745
	for <lists+linux-spi@lfdr.de>; Sat, 23 May 2020 14:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbgEWMkP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 23 May 2020 08:40:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbgEWMkP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 23 May 2020 08:40:15 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590237614;
        bh=40t+t+c0l4Us5Zb+GvJjY7BiJJtU9a7Ayxi//uHqmWM=;
        h=Subject:From:Date:To:From;
        b=nV1FK6V44PjNxBoU3pcAAk3W9zmTBMzHVbNImq+td+BMSdHxf4C3NnIcmYrp7lt9u
         30R/w8P5VvfPzmV+lf1OO0553BaTqPgID4f+Apb6Z1O37BJWDNVsfrq/D2M1sGAM0G
         oHZAJ8ycJZ8VZYW3kRy/sWqyV5pETsmTTmBrn7ok=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159023761488.6335.10958982289880792244.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 23 May 2020 12:40:14 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: tegra20-slink: Fix runtime PM imbalance on error (2020-05-23T12:29:09)
  Superseding: [v1] spi: tegra20-slink: Fix runtime PM imbalance on error (2020-05-21T07:49:46):
    spi: tegra20-slink: Fix runtime PM imbalance on error


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot

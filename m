Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56CD6224615
	for <lists+linux-spi@lfdr.de>; Sat, 18 Jul 2020 00:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgGQWAV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Jul 2020 18:00:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbgGQWAU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 17 Jul 2020 18:00:20 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595023220;
        bh=wqxZoJ03ajhLa5Kg4TfK1HfFOUr3/rR0nWoY+jB1HF8=;
        h=Subject:From:Date:To:From;
        b=HGUb0EBRHRKhyLgAz1Nrc+rMsZfHLkoJkNP2YM/QrQeIE/rypJMTpTmqZpWpJuu3R
         CT7/tL65mCTafxmUZYuEFk99qIuyMdMrYzd9U5vSZ1PRxRUfWpY/VqmIz8mERXz/Ba
         jqafQ5j6BdK3f9D1F9B2myrgxKMK7m8WC8hPMH9k=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159502322070.27877.7149479150263128497.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 17 Jul 2020 22:00:20 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: lantiq-ssc: Fix warning by using WQ_MEM_RECLAIM (2020-07-17T21:56:48)
  Superseding: [v1] spi: lantiq-ssc: Fix warning by using WQ_MEM_RECLAIM (2020-07-14T23:02:34):
    spi: lantiq-ssc: Fix warning by using WQ_MEM_RECLAIM


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot

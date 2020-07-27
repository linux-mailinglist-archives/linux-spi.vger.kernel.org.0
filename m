Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3320222E45C
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jul 2020 05:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgG0DUW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 26 Jul 2020 23:20:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgG0DUV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 26 Jul 2020 23:20:21 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595820021;
        bh=ABEcLC8FHstL/LTWPGfwIhu0rvH3gGF2PELpZrENQQw=;
        h=Subject:From:Date:To:From;
        b=uFm17A//780QRgWbop2lHEVooM4U2P8VDIKmTtn+RWvaTWs2VlVzERMGo+HKpryxx
         /ox/qfJNBWX1oiEnfTtBSH2FvDAvgbTno3llWsSAHwzyXkZxsR4hISuHRdxQr/xy0y
         IT2HYioiE7OCU7lqYLogZtjZ+Np8FEOB+ylpJnuA=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159582002095.13864.5573638814756740375.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 27 Jul 2020 03:20:20 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Some bug fix for lpspi (2020-07-27T03:14:45)
  Superseding: [v1] Some bug fix for lpspi (2020-07-14T07:52:46):
    [1/5] spi: lpspi: fix the imbalance of runtime pm function call
    [2/5] spi: lpspi: add NULL check when probe device
    [3/5] spi: lpspi: fix kernel warning dump when probe fail after calling spi_register
    [4/5] spi: lpspi: handle EPROBE_DEFER when get cs-gpios number
    [5/5] spi: lpspi: fix using CS discontinuously on i.MX8DXLEVK


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot

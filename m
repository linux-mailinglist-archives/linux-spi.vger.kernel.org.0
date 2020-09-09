Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4755A2631AE
	for <lists+linux-spi@lfdr.de>; Wed,  9 Sep 2020 18:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgIIQX7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Sep 2020 12:23:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731058AbgIIQX4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 9 Sep 2020 12:23:56 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599661209;
        bh=7tgq976YflukM2+dTuvPcGj+NOj3wfosUbqKkLpiQeo=;
        h=Subject:From:Date:To:From;
        b=DnYqic3+hhgMuSzc4cRsaIWsUflH43D5LidTNDxEZPT0q3Bi8deEgNJjqOHOe+u7x
         YbkSR47RPxB89VtT2RIu/umUD85k6jsIoYsrGgbvDCX2v28Cv6w5E0qzfEZ75M8ZX+
         D0Bb+Bnr0xGDimsjamHUqjmTmLsmEN21nz/LKgsY=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159966120911.30175.8129406677056651419.git-patchwork-summary@kernel.org>
Date:   Wed, 09 Sep 2020 14:20:09 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: [v3] spi: Fix memory leak on splited transfers
  Submitter: Gustav Wiklander <gustav.wiklander@axis.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=345505
  Link: <20200908151129.15915-1-gustav.wiklander@axis.com>

Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot

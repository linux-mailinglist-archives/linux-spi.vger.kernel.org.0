Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96021FA47A
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 01:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgFOXkK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 19:40:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbgFOXkK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Jun 2020 19:40:10 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592264410;
        bh=cyseUQ+Wvl5cmfxwbhSZFqm965mvwrf6+KbYTNnKND0=;
        h=Subject:From:Date:To:From;
        b=mpkInmvzp+3njs2w5a5XDST+0iD0Tz4ALFydLc96/tjJsYNR3qXtC0zObPEbvU5W/
         85277emaFLydbCDpYSIb9emEb2X+fDjnPq1gBcqZlhxTgvObCJgykxJ0KE5N4Q1mQv
         FHfC5jiqNDVLtijTFg7zeodBGyeSqj4Hy8mXDLYc=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159226441026.21156.12316636614958020368.git-patchwork-summary@kernel.org>
Date:   Mon, 15 Jun 2020 23:40:10 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: [v4] spi: add Renesas RPC-IF driver
  Submitter: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=302223
  Link: <1ece0e6c-71af-f0f1-709e-571f4b0b4853@cogentembedded.com>

Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot

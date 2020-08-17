Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92444246655
	for <lists+linux-spi@lfdr.de>; Mon, 17 Aug 2020 14:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgHQM1k (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Aug 2020 08:27:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgHQM1j (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 17 Aug 2020 08:27:39 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597667259;
        bh=Rd4bxfpJanLo0o0DRbuGawDmb7I13Jg2VOb/QETUtCw=;
        h=Subject:From:Date:To:From;
        b=M7rKxWQxm/178gNpfb+bRXhaGl3zDA4xCp9YWz3CnF6Eh5327zx0hWyl3nBREzLng
         bDPc1h2in3SF0/7aMDEQr9ByU6A/U0nuXSMA0PNdlRgkhV9Cd8kql5ou6Tuc9WkHMx
         sLnKCpwLJkkzsbP7njhHKrQMocSq6vcXg1JuTZDo=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159766725904.11852.12134879706242500098.git-patchwork-summary@kernel.org>
Date:   Mon, 17 Aug 2020 12:27:39 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: [v2] spi: lantiq-ssc: Fix warning by using WQ_MEM_RECLAIM
  Submitter: Hauke Mehrtens <hauke@hauke-m.de>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=320387
  Link: <20200717215648.20522-1-hauke@hauke-m.de>

Series: QSPI: Add DVFS support
  Submitter: Rajendra Nayak <rnayak@codeaurora.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=312471
  Link: <1593769293-6354-1-git-send-email-rnayak@codeaurora.org>
    Patches: [1/3] spi: spi-qcom-qspi: Use OPP API to set clk/perf state
             [2/3] arm64: dts: sdm845: Add qspi opps and power-domains
             [3/3] arm64: dts: sc7180: Add qspi opps and power-domains

Series: spi: spi-qcom-qspi: Avoid some per-transfer overhead
  Submitter: Doug Anderson <dianders@chromium.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=315735
  Link: <20200709145145.4055619-1-dianders@chromium.org>
    Patches: [v2,1/2] spi: spi-qcom-qspi: Avoid clock setting if not needed
             [v2,2/2] spi: spi-qcom-qspi: Set an autosuspend delay of 250 ms

Total patches: 6

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot

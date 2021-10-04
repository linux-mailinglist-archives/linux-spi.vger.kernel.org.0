Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BC44207A4
	for <lists+linux-spi@lfdr.de>; Mon,  4 Oct 2021 10:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhJDI6o (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Oct 2021 04:58:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229631AbhJDI6n (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 4 Oct 2021 04:58:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 532D8611CC;
        Mon,  4 Oct 2021 08:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633337815;
        bh=muAhxX1ltWVAKECsa7+S/V2AOZ/3nKTj3Tty7oPBLdA=;
        h=Subject:From:Date:To:From;
        b=aDfqKYNVVaRZpT8j4//bChfNMZTDIfJ/rJ8XBEcCai/PKnyns6Hw8GThn/lK0lSIR
         6JsOgynXathkGN68fQkCLuLQiixXmBc8LFPQ4JHWJK+dRH3aFqjaiFSTKO47hWZ+y9
         ZotOXeCmNgO0Itc4jX0WrS9MlQLXPbiDfG7eIrx0LAl6DJWUkXl2qeX/WtrbkEplrX
         q9aG71dbky2qvX6mpP1wGvaUeyTXchlN0a62u5eGM6B8jEho+GNEaJWlpxlsJauWtx
         fb/QDCqur3u/sUSmQ92Kk14tWJbenCeq/7iU7d0Ad8EgGCSuxoRbcfLQ6n8i5P5Vec
         HO0UnuIQgIlyw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3DBF1608AF;
        Mon,  4 Oct 2021 08:56:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163333781518.18919.18301217299653396080.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 04 Oct 2021 08:56:55 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: cadence: fix static checker warning (2021-10-04T08:38:24)
  Superseding: [v1] spi: cadence: fix static checker warning (2021-10-03T07:04:18):
    spi: cadence: fix static checker warning


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


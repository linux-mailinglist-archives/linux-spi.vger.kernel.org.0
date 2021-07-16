Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740313CB935
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jul 2021 16:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240205AbhGPO7k (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jul 2021 10:59:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239909AbhGPO7k (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Jul 2021 10:59:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4015C613CF;
        Fri, 16 Jul 2021 14:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626447403;
        bh=c1xTOfx6wfV6EBw94hy87hYxSm5rk8PWthj52oqNQqw=;
        h=Subject:From:Date:To:From;
        b=hJlXwzmt7xw9Y4g4802jFRBBBYtY7NTKC8OGaAa/A71iJEiFmuREi+S4gUG3sBKL7
         8qaje7H8bLiykeGD+IzXb1ISGVb27S8bipUUc6kZ3SmOiELRoRCjVcyEd53CEMWS5D
         ZfNCiJQdDiDDfj/O1q2gCUYFNEyJuxoSb1+izV3y6jQyz9ae2yyhRvj162G/GG+tbX
         X8tXsT7ri5a9XpdaroTSzfHDYk/ritejdojv2qsSBXWQFgjChVW/Dph7+XvTRDwxBS
         s1XlFvd4IvIk3JrSsPJGwzsT6g5JP8WtptaebtYRc4lQayw+j61Db+u9QSKL7DVUvj
         VltB276jpNU8A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3992260970;
        Fri, 16 Jul 2021 14:56:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162644740323.8759.806339488125748364.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 16 Jul 2021 14:56:43 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] spi: spi-cadence-quadspi: Fix division by zero warning (2021-07-16T14:31:24)
  Superseding: [v4] spi: spi-cadence-quadspi: Fix division by zero warning (2021-07-16T03:05:28):
    [v4,1/2] spi: spi-cadence-quadspi: Revert "Fix division by zero warning"
    [v4,2/2] spi: spi-cadence-quadspi: Fix division by zero warning


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


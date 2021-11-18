Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE8245635F
	for <lists+linux-spi@lfdr.de>; Thu, 18 Nov 2021 20:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhKRTXJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Nov 2021 14:23:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:33548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229929AbhKRTXJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 18 Nov 2021 14:23:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id CC8DF610F8;
        Thu, 18 Nov 2021 19:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637263208;
        bh=qGbIQ6nkeTw6hRHI57y6MtG8XHEuF/SEOX+qpf/h8ao=;
        h=Subject:From:Date:To:From;
        b=SniA/CrbiU8a4utjrFHKTGoEM+0Uqe66uZq0aFpMR9hMih91YfH/WZZenrghW79hM
         eWAYOr+ZSS1QJwk5aR04u7CSegFJuZrEiUjjlbauTMGvaaz6EpZjQ4OOfICAlrs9Y+
         at/4/uG1s8G1zye2o3NuvsU2bo8+bIhl9KPvX6RsldwbSy/dqVc2ZnPCK/165OGRVW
         ckXlNnBKn+2o3L9Fo6tlpbuXvTHNGsuKSJhUsU81bKvnvF9oGKEYTZ7GuxoouHxaHE
         1VhY2vEnjjYwbew7wyrzYkVpWIp1vQXSoq1PWDc8AR0Ug/lK+IKjaPscjxNJXqNCq5
         s0O3OvPdl3l9g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BAFD860A4E;
        Thu, 18 Nov 2021 19:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163726320870.3614.16721314908989982227.git-patchwork-summary@kernel.org>
Date:   Thu, 18 Nov 2021 19:20:08 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: RSPI driver support for RZ/G2L
  Submitter: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=582015
  Lore link: https://lore.kernel.org/r/20211118031041.2312-1-prabhakar.mahadev-lad.rj@bp.renesas.com
    Patches: [v2,1/3] spi: dt-bindings: renesas,rspi: Document RZ/G2L SoC
             [v2,2/3] spi: spi-rspi: Add support to deassert/assert reset line
             [v2,3/3] spi: spi-rspi: Drop redeclaring ret variable in qspi_transfer_in()


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



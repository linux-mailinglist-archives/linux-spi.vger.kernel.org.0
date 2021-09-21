Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD58413925
	for <lists+linux-spi@lfdr.de>; Tue, 21 Sep 2021 19:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhIURvl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Sep 2021 13:51:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231795AbhIURvf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 21 Sep 2021 13:51:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A591461178;
        Tue, 21 Sep 2021 17:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632246606;
        bh=ctfu6yFI8U7lqZOMXrKm6Jz0xaw9KgVZUeHTJO67Mgg=;
        h=Subject:From:Date:To:From;
        b=nDsYpb9HcSc88wJAeeKaEOh8R2qhzh9K1kzMVtkAw5TSWZ4lp3/WlOUtLBH98yysM
         hyEWq5+px4S0NVf1nQo4o0yMfBfSel03bukQfcpXIiH3uNmmPfRqRWjyzsXOP98UoK
         FY1IdxI0hAQ/rw/akQOBL89vwMMF87iBQQS81XEvozWXRtpERPSmAXH6DAFRs29ING
         BZvOj1d4NfS70Zw0qIWzaOv5ApvnSJr1lgs3DzOmqYYJqlXN6sZYQ1assoo+mLRcPr
         04tUy24vsToSvt5ou+qi8SHo49QvEwtduClaka2aFcrCJjq3YxQvkmCnyoKHhUKkA/
         ErdpFkZ9VV0ew==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 946AC60A2A;
        Tue, 21 Sep 2021 17:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163224660654.27409.2793242236497198814.git-patchwork-summary@kernel.org>
Date:   Tue, 21 Sep 2021 17:50:06 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: spi: Revert modalias changes
  Submitter: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=550495
  Lore link: https://lore.kernel.org/r/20210921173222.46514-1-broonie@kernel.org

Total patches: 1

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



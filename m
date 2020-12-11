Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4152D7D6E
	for <lists+linux-spi@lfdr.de>; Fri, 11 Dec 2020 18:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389313AbgLKRyS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Dec 2020 12:54:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:32860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436721AbgLKRxu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 11 Dec 2020 12:53:50 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607709190;
        bh=h4DT62siC7TQPCYcCanwHJgl6xjTQafPeaNPntTVfm8=;
        h=Subject:From:Date:To:From;
        b=F+9hrTA1sIPAnvkO/BK2rBvkP75W6CFQ/UMvY61kFPAmXhm4lj9n84f08xF9jTLnU
         16Ar+9uoXuX5OAD0IjmHy77AIm6aQUf/JeeJflyj60LnKeLyykaBUiB14ZzYW2ghMt
         Cr9URqY5lIXOabxS7SuZLnD27WlhO/KaMLyZ0fttEkyg3b2MQ9H0ZAe5q5dGCv1HNn
         OjJ9zIykGqRXHeYi9j14oe70XmPcNb9TARbHJBMJ+Pi/z4igPtW2evnUhN2FC9QjzE
         CpKctj55hkqup1NuHExrbkHq+0Si+H7lFR9G9dOd82o/D0AzrpCWronzuHw94Ekk9j
         OlBk0jRnFMRyA==
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160770918994.8865.8175683641296632634.git-patchwork-summary@kernel.org>
Date:   Fri, 11 Dec 2020 17:53:09 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: spi: spi-geni-qcom: Use the new method of gpio CS control
  Submitter: Stephen Boyd <swboyd@chromium.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=394995
  Lore link: https://lore.kernel.org/r/20201202214935.1114381-1-swboyd@chromium.org
Series: spi: spi-geni-qcom: Use gpio descriptors for CS
  Submitter: Stephen Boyd <swboyd@chromium.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=396589
  Lore link: https://lore.kernel.org/r/20201204193540.3047030-1-swboyd@chromium.org
    Patches: [1/3] platform/chrome: cros_ec_spi: Don't overwrite spi::mode
             [2/3] platform/chrome: cros_ec_spi: Drop bits_per_word assignment
             [3/3] spi: spi-geni-qcom: Use the new method of gpio CS control

Total patches: 4

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



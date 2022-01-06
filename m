Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99AA4486B2E
	for <lists+linux-spi@lfdr.de>; Thu,  6 Jan 2022 21:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243749AbiAFUaO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 Jan 2022 15:30:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52802 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243719AbiAFUaM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 Jan 2022 15:30:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1958E61D2F
        for <linux-spi@vger.kernel.org>; Thu,  6 Jan 2022 20:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 846A5C36AE5;
        Thu,  6 Jan 2022 20:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641501011;
        bh=tqBL+Cbnpl7H/eLlHQw2ehighWJ3EyftFStKlkhTQ2M=;
        h=Subject:From:Date:To:From;
        b=OPhcjQAUII37nYajgfix1+tCibLQKWkECYyPVqrCeid+TUUvDnNjzYXUdPpAOjm25
         Y0fVXRoTjcsF/9Dw9hpRNsx+IIVdnaAvyhBxC4/mOTG2YSwygmWm109RaWlpIruXkA
         vR0MqPEfuQNjgs2HxyOv0ioWGdAFISh1wpbRGe7Qa7ZflCepItDMQo7yYaIvRw13rG
         lce7VjC1Vu5BczwGxGjiHDMoW/OFzhsjdYHgBgpflXfFCW2kXI/HWQZqU+W2EDrUJ3
         Je83Ko1o9LNZCiO5YWVt9jdzYswixn2VMxGKARzlAJfVDEhZRU/iJTBtnrHvAzpvLP
         nsPUo9O2RfF9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68A60F79403;
        Thu,  6 Jan 2022 20:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164150101135.19887.5342580960456475790.git-patchwork-summary@kernel.org>
Date:   Thu, 06 Jan 2022 20:30:11 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [v2,1/2] spi: qcom: geni: set the error code for gpi transfer
  Submitter: Vinod Koul <vkoul@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=602312
  Lore link: https://lore.kernel.org/r/20220103071118.27220-1-vkoul@kernel.org
    Patches: [v2,1/2] spi: qcom: geni: set the error code for gpi transfer
             [v2,2/2] spi: qcom: geni: handle timeout for gpi mode


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



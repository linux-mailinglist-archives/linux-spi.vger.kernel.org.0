Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FDE49B6AD
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jan 2022 15:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383050AbiAYOob (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Jan 2022 09:44:31 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45920 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389255AbiAYOkO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Jan 2022 09:40:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C577615F0
        for <linux-spi@vger.kernel.org>; Tue, 25 Jan 2022 14:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0DDDC340F8;
        Tue, 25 Jan 2022 14:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643121610;
        bh=CcptRaMG/J44aEtr5zb/HldC4B/f88/35aMzwo5p46o=;
        h=Subject:From:Date:To:From;
        b=l18q5SEr9riVu2AqKKu5VIYW2VHhCQaHgarDHVCGD6NF6grCe1ReNkSAMCRHbJ3+y
         JjPUsB4YRf/Eq+eN3U3x5RvkzZdm0zAP01R611Nt/ZcPAPgoohdHwtBh7J+Z3xwsV4
         yqQIa7K66QA4tkDf4ZbHPF/T8Gb5JXLk320j6mEYc3EDcHOrANyx49c8Rx52pZA97+
         n/wo2j5vZDeC04DBtaKADLTjyi5xqlZwc4vpFnFsEEkQ2tUOg7fghQ1WGqEu3wpJr7
         sRLf3qeAnzXDXMqw+swRFEIl0KLot65aediH8gqGAO+7SLgZxYUYPucNdMDVNl33hn
         +Nts+u77C3zDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93CFFF6079C;
        Tue, 25 Jan 2022 14:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164312161054.15682.3194632369773761183.git-patchwork-summary@kernel.org>
Date:   Tue, 25 Jan 2022 14:40:10 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add spi control driver for Sunplus SP7021 SoC
  Submitter: Li-hao Kuo <lhjeff911@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=606178
  Lore link: https://lore.kernel.org/r/cover.1642494310.git.lhjeff911@gmail.com
    Patches: [v6,1/2] spi: Add spi driver for Sunplus SP7021


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



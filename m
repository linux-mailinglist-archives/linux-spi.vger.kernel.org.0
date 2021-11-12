Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044DA44EEA3
	for <lists+linux-spi@lfdr.de>; Fri, 12 Nov 2021 22:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbhKLVdC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Nov 2021 16:33:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:33942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231877AbhKLVdB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 12 Nov 2021 16:33:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 8258D60F51;
        Fri, 12 Nov 2021 21:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636752610;
        bh=JiCjGqcpYyaTJH7/ffkkkHcz5S35Mc8rhZw74ahO/zM=;
        h=Subject:From:Date:To:From;
        b=lizCtSXeBSrh7a7CcK7OVNlysScXs34nBxiNKfnh+g0LdPrA+tLjID5sUp0NsQUHx
         fnRrLYqWpqjY5QYdDAsvNc8bgsPcvr9sOXdw2Ci6lAkbiU22OrkGuhb0sYzYaQQqWM
         o6aT6gtzvr/LVJg/+sHdhx8/iAIzKPVuVFDpPahET9IryCglG+Udi7QhdXpjQfW2cO
         xPRClG+e7vEdR8Y2FulhmIMgFs8Rpxwa65/0TIDaUgIcUShDCQ7OLOpHu1TJoTVdpe
         7aR2/F2H3D5h6SI13G3Ix5g/ddW5ilSNv6BHU9TdHpjh5wCKS87Hp80X/gweHGjl7c
         hYWliCoaP6ELw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6DE7D609F7;
        Fri, 12 Nov 2021 21:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163675261039.31967.904644210466330871.git-patchwork-summary@kernel.org>
Date:   Fri, 12 Nov 2021 21:30:10 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: fix use-after-free of the add_lock mutex
  Submitter: Michael Walle <michael@walle.cc>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=578547
  Lore link: https://lore.kernel.org/r/20211111083713.3335171-1-michael@walle.cc


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



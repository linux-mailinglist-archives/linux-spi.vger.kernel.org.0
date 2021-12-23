Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF17D47E6D7
	for <lists+linux-spi@lfdr.de>; Thu, 23 Dec 2021 18:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349485AbhLWRUP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 23 Dec 2021 12:20:15 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52618 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349465AbhLWRUO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 23 Dec 2021 12:20:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74F2FB81FC1
        for <linux-spi@vger.kernel.org>; Thu, 23 Dec 2021 17:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F9E7C36AE5;
        Thu, 23 Dec 2021 17:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640280012;
        bh=Xk+CQ66LikpIB4t8AUXGg74hHy4nU4+OztLXC6ZkwAY=;
        h=Subject:From:Date:To:From;
        b=NlmmjhG/3jCgxmIJHyFGSjmn9ViEmksACEO8tgxFQuOdzWVjVfixqAvBHZwbe+IGo
         fPA2ZcI2hYkADN0OuYS1gBgasf7gvNF7ZA7e3in9JxWlXr6V1uwlKNiH50wQQ3zyLo
         Xvlc21EW7p41gJK8dDogDcf+j3vttHW6RmLIipdlVpq7cQPUmFbJer2VsEd1/2JZuS
         GXI+x0u9iDqoJ72/BA5/ukdTkkVwQYSbxGAf9sOtXp6/m/8mooXy93w4kv7JhWo8t+
         ykbHSNRcjbZ0ia1kS1Y2RN+H4kG6z2VNPj541AQTl2H3gIEDMC/w0lnB6OQfuiRHUv
         PvflJODMtDdxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F5B8EAC060;
        Thu, 23 Dec 2021 17:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164028001199.3194.3975746030531521107.git-patchwork-summary@kernel.org>
Date:   Thu, 23 Dec 2021 17:20:11 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [v2,1/3] spi: dln2: Propagate firmware node
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=599402
  Lore link: https://lore.kernel.org/r/20211222155739.7699-1-andriy.shevchenko@linux.intel.com
    Patches: [v2,1/3] spi: dln2: Propagate firmware node
             [v2,2/3] spi: dw: Propagate firmware node
             [v2,3/3] spi: pxa2xx: Propagate firmware node


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



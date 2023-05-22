Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1A570C121
	for <lists+linux-spi@lfdr.de>; Mon, 22 May 2023 16:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjEVOaY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 May 2023 10:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbjEVOaX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 22 May 2023 10:30:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0C190
        for <linux-spi@vger.kernel.org>; Mon, 22 May 2023 07:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0274061DC1
        for <linux-spi@vger.kernel.org>; Mon, 22 May 2023 14:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FDBCC433D2;
        Mon, 22 May 2023 14:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684765821;
        bh=jdPLFSjVtVPLFx3NRvqrx5+rpiR77UNF2ELSI2woHPw=;
        h=Subject:From:Date:To:From;
        b=qW42k7Sl4dEDt8Ew6CjCDgpxmCzA4EH1r2i+F1tGqLGnVNQd86S2nUXLqMYhOR7qY
         ivXDVbD/WoGpAdN0CQlZYvKgV96x9d0LAOqKKpW/5Wz1LpjHJiet71B8yL+h4E7F7P
         2tDolvC6y9Tp7LuSD1/yYcqmqqODmeSDUGKG3JBuKCBSJ2yX0XD8/7fPMNfzXmtj8E
         DlMyp6GBiF4Fy+lnD+o/CX8PwclFj/1XJcb613vKmGsID4XH/nwR2Sfyu6yx4LL8fp
         mjIUMfr1SrxpmnIVlhRGmPeTJZjB3vlL6AKviv3EKKTJ6RAkSTehxvuW2VGOb/TUo+
         +YjQ4Bwl4JN9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D495E22AEB;
        Mon, 22 May 2023 14:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168476582115.22087.6862811146983793423.git-patchwork-summary@kernel.org>
Date:   Mon, 22 May 2023 14:30:21 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [v2,1/2] spi: spi-cadence: Interleave write of TX and read of RX FIFO
  Submitter: Charles Keepax <ckeepax@opensource.cirrus.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=748822
  Lore link: https://lore.kernel.org/r/20230518093927.711358-1-ckeepax@opensource.cirrus.com
    Patches: [v2,1/2] spi: spi-cadence: Interleave write of TX and read of RX FIFO


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



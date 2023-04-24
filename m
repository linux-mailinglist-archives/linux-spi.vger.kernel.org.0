Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2249F6ECE4C
	for <lists+linux-spi@lfdr.de>; Mon, 24 Apr 2023 15:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjDXNbO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Apr 2023 09:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbjDXNaz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Apr 2023 09:30:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7196A6D
        for <linux-spi@vger.kernel.org>; Mon, 24 Apr 2023 06:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF8F561DE3
        for <linux-spi@vger.kernel.org>; Mon, 24 Apr 2023 13:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54ACCC433EF;
        Mon, 24 Apr 2023 13:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682343021;
        bh=eYDlgiDR0/LmcX6Ch+MZGoqOBa2ZIgJo9URD/8ogtCM=;
        h=Subject:From:Date:To:From;
        b=Ypl+W3o2KnkG3iqY/Gw0tXHuY51619oxdTKlYZkfxR85sltiHI5kJEhYXdg7GBHYa
         N5uCj7/9sNFKtoxn760EZrnm/b/erHPk9paNzpnDO6ZnOP8+b9QSsqBS9wbzXsojPl
         qD3Ud9qGXB5E+R8CJBX7HmHttja+iQ3y62ZfsKFxlDWBSoJLTcRKP90nVHAs8SgBZe
         aSn2u2p5aH0PjbxUMkQzpBfCnusQLSCvLzMvlAZUB1UmmHkjUxvC3YAJVZPCTt7+Wt
         6am4JV/vPB92+SWyaZSBmIGpo069FcmgCHbr9ZHaEQ0Mo+Umh38C9/n7KE6qgBZ+cz
         lKZ6eBoy8j7Qw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2432DE5FFC4;
        Mon, 24 Apr 2023 13:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168234302110.24554.16480279733497802494.git-patchwork-summary@kernel.org>
Date:   Mon, 24 Apr 2023 13:30:21 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

Series: Tegra TPM driver with HW flow control
  Submitter: Krishna Yarlagadda <kyarlagadda@nvidia.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=742029
  Lore link: https://lore.kernel.org/r/20230421091309.2672-1-kyarlagadda@nvidia.com
    Patches: [V10,1/3] spi: Add TPM HW flow flag
             [V10,3/3] spi: tegra210-quad: Enable TPM wait polling


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



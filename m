Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FC9765C37
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jul 2023 21:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjG0TkZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Jul 2023 15:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjG0TkY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Jul 2023 15:40:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA33F2D6A
        for <linux-spi@vger.kernel.org>; Thu, 27 Jul 2023 12:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7ED4661F20
        for <linux-spi@vger.kernel.org>; Thu, 27 Jul 2023 19:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4FE5C433C7;
        Thu, 27 Jul 2023 19:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690486822;
        bh=Hf/7wGghdpNpTpPir6mUvth9BKyDv95CzvX5zPW7qVQ=;
        h=Subject:From:Date:To:From;
        b=iPG6TB47+ELOWpYeEON2EZxIcXNof+BXiAydHMdeIFcDwuejbxHhtWiU1z1LPbpYs
         hDOdrr5sNjlofm+n9IDV91REy7/O/BCTRYUwMAwCVX8nnyLwes8qL2i3Pbo/ZVbNgQ
         HuGrikWgwcU5VfVE9Rk4fwRnvI30SfNz0FcaJk5Bjw/Gha06JXmnswxE62rd/zKhqP
         b9k69EgC9gOoCFn2T0Vuv6bSeOaaG56XbFPl/9EMiXNFTHTp9RbBiRWaLZOzaKHwLa
         oYa89bRjruxa/2/XY91hpf8xh8rDWK21S7QZSGMNUmCKRYJabUDP4W3GcldmjNPc/B
         rvjpO62S0b3Uw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3764C40C5E;
        Thu, 27 Jul 2023 19:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169048682272.6510.12858871003454379852.git-patchwork-summary@kernel.org>
Date:   Thu, 27 Jul 2023 19:40:22 +0000
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

Patch: [-next] spi: s3c64xx: Clean up redundant dev_err_probe()
  Submitter: Chen Jiahao <chenjiahao16@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=770139
  Lore link: https://lore.kernel.org/r/20230727131635.2898051-1-chenjiahao16@huawei.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



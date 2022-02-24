Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4B74C396D
	for <lists+linux-spi@lfdr.de>; Fri, 25 Feb 2022 00:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiBXXAs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Feb 2022 18:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235925AbiBXXAq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Feb 2022 18:00:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7844521EB99
        for <linux-spi@vger.kernel.org>; Thu, 24 Feb 2022 15:00:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D5E861BBE
        for <linux-spi@vger.kernel.org>; Thu, 24 Feb 2022 23:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 724D2C340EF;
        Thu, 24 Feb 2022 23:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645743613;
        bh=vwfdBFOGjDLw66JzZiN2HSEVaD+wBCd9eUane6YItRw=;
        h=Subject:From:Date:To:From;
        b=J1FLXwEUIbFFj4zwBDNN/7Gn6fYd0Us8RPSfyvBdam68PF5Rl39bxsHpu/tOA1B2p
         biypeqLprlcEAh8OfeULYSSfr7MHX7dhhvjxV3ejC0wdnmVPC/UrfKWoP3ig4ZJ94g
         uwXsKn8KbQTxTanyjTAn2YmWuPcLl5O5lTsKE3O6bsLWndxpiOpG03/cIbhh1khlzd
         hVN7XX7ZWAksoOiMwkzmGLbM+oks1SH/HoUTZADzHIAeU3n6PqcUOdyexGA+zcK7AR
         ylE73tpSPNhf3AgRQSjmgtwhrVZ6D5HD+Adb4P4b5rFhCyEkrVhJ1UsUibskifpkcK
         7UTOFmrxr3XwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E6A1E6D453;
        Thu, 24 Feb 2022 23:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164574361323.23657.18021516420520694338.git-patchwork-summary@kernel.org>
Date:   Thu, 24 Feb 2022 23:00:13 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Series: Tegra QUAD SPI combined sequence mode
  Submitter: Krishna Yarlagadda <kyarlagadda@nvidia.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=616839
  Lore link: https://lore.kernel.org/r/20220222175611.58051-1-kyarlagadda@nvidia.com
    Patches: [v2,1/5] spi: tegra210-quad: use device_reset method
             [v2,2/5] dt-bindings: spi: Tegra234 QUAD SPI compatible
             [v2,3/5] spi: tegra210-quad: add new chips to compatible


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



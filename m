Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2754E4B6CDB
	for <lists+linux-spi@lfdr.de>; Tue, 15 Feb 2022 14:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237253AbiBONAZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Feb 2022 08:00:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236536AbiBONAZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Feb 2022 08:00:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA91880203
        for <linux-spi@vger.kernel.org>; Tue, 15 Feb 2022 05:00:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 484E7B81977
        for <linux-spi@vger.kernel.org>; Tue, 15 Feb 2022 13:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DAE8BC340EB;
        Tue, 15 Feb 2022 13:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644930011;
        bh=hELAyleHSXj17ymqHHuyaJOOzqHF8iIhG1nUt+xZqa0=;
        h=Subject:From:Date:To:From;
        b=Vev8icg7YYhcLYMdA2NXhH6v+Xs+GGwbLeMo/ad+vAb+Up65JypDnpf8TdnaAAARZ
         FZTpPFsj9PQMtx/h3i3s9GPrJuOgegLvksaGJZn5H6IBn/EASPxFyZb7ly6DWhad7F
         n8xvb1VidpfiFOGkthf6w2S0AHXyUIh8UixmupUUmEGbD+52KQUjUJ4WvrbKUVqN68
         SrM6Di3GI+HFneKkJdWBUiHMfVN2dOnZSrRm/2ffkSV2zZ60VYTCdhS0BbQb7Xlh/w
         JdpCR/a4ZprR/ALRI17YKXBJkbSX40W/MTOUkVZBUw/6tiOqSQw0eU0oMpHNPjSG3p
         q6vyhmR1J7Flw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9A6BE6BBD2;
        Tue, 15 Feb 2022 13:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164493001168.13729.10742282866937856095.git-patchwork-summary@kernel.org>
Date:   Tue, 15 Feb 2022 13:00:11 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Series: spi: amd: Add support for new controller version
  Submitter: André Almeida <andrealmeid@collabora.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=613509
  Lore link: https://lore.kernel.org/r/20220211143155.75513-1-andrealmeid@collabora.com
    Patches: [v2,1/3] spi: amd: Use iopoll for busy waiting
             [v2,2/3] spi: amd: Remove needless rom_addr variable

Series: mtd: spi-nor / spi / MFD: Convert intel-spi to SPI MEM
  Submitter: Mika Westerberg <mika.westerberg@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=612609
  Lore link: https://lore.kernel.org/r/20220209122706.42439-1-mika.westerberg@linux.intel.com
    Patches: [v6,1/3] mtd: spi-nor: intel-spi: Disable write protection only if asked
             [v6,3/3] Documentation / MTD: Rename the intel-spi driver


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



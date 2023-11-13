Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF70D7E9F29
	for <lists+linux-spi@lfdr.de>; Mon, 13 Nov 2023 15:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjKMOub (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Nov 2023 09:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjKMOu3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Nov 2023 09:50:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFA11715
        for <linux-spi@vger.kernel.org>; Mon, 13 Nov 2023 06:50:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98D9DC433C7;
        Mon, 13 Nov 2023 14:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699887026;
        bh=maMmfH+zDR4gmkYO/V34AMPNQJMWQ/DUVByTwp/AX3A=;
        h=Subject:From:Date:To:From;
        b=arkUs3LNPOjzPxIQDCaU7s2rm+3aSkaztfdSCXV+MnzE+aKC5adIEZndD0GHKjXeQ
         52ca4KCFB45IkSSFwnBEaZnJ7LC3UK+Dt2TkjgPY665OdIZMQoARQ9ssQYw9IrH1Di
         ECSl7NT1AOtym7+LNZpNo5QYcjbD8yGfjKQ5IX8V/cl0wwi4QMrvwx/rPLdI8jWyTV
         mZ9/i87A3Ua7aE2zuI4NNlLyUjN7YmynsixET5Gx9bRaC9QPE6bmxD6n2/dfhglqOY
         EYu4XbfL/oshUcU9lV70eRnX3CMQJBUg1qL1eTdlRg7vc/nnMNtJo55Os1yIRCSqyk
         kEPcOD4F/a5Ng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74DBDC04DD9;
        Mon, 13 Nov 2023 14:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169988702639.10049.15682816641983793452.git-patchwork-summary@kernel.org>
Date:   Mon, 13 Nov 2023 14:50:26 +0000
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

Series: Add Intel LJCA device driver
  Submitter: Wu, Wentong <wentong.wu@intel.com>
  Committer: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=791135
  Lore link: https://lore.kernel.org/r/1696833205-16716-1-git-send-email-wentong.wu@intel.com
    Patches: [v20,1/4] usb: Add support for Intel LJCA device
             [v20,2/4] i2c: Add support for Intel LJCA USB I2C driver
             [v20,3/4] spi: Add support for Intel LJCA USB SPI driver
             [v20,4/4] gpio: update Intel LJCA USB GPIO driver

Series: Support AMD Pensando Elba SoC
  Submitter: Brad Larson <blarson@amd.com>
  Committer: Arnd Bergmann <arnd@arndb.de>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=783935
  Lore link: https://lore.kernel.org/r/20230913214944.59804-1-blarson@amd.com
    Patches: [v16,1/6] dt-bindings: arm: add AMD Pensando boards
             [v16,4/6] arm64: Add config for AMD Pensando SoC platforms

Patch: riscv: dts: starfive: fix NOR flash reserved-data partition size
  Submitter: Aurelien Jarno <aurelien@aurel32.net>
  Committer: Conor Dooley <conor.dooley@microchip.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=779638
  Lore link: https://lore.kernel.org/r/20230826182702.2641743-1-aurelien@aurel32.net


Total patches: 7

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



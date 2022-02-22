Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93174BFD39
	for <lists+linux-spi@lfdr.de>; Tue, 22 Feb 2022 16:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbiBVPkn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Feb 2022 10:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiBVPkm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Feb 2022 10:40:42 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8B0163055
        for <linux-spi@vger.kernel.org>; Tue, 22 Feb 2022 07:40:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A4321CE1715
        for <linux-spi@vger.kernel.org>; Tue, 22 Feb 2022 15:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED502C340E8;
        Tue, 22 Feb 2022 15:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645544410;
        bh=OOX15LcY9+gdFVIp7lQUYmKQU9xkG9Onr7nnZ/wteFk=;
        h=Subject:From:Date:To:From;
        b=BVcM1Qv24wVNB/FxC7q1r/gJDjDG6FW/qyVhDsl1VZNBP0kcwrPMyIHtFYYAO2lm5
         3GAWpoCSFfOqtdUJiw+5oEZlwosgA/5MfAx09yMketblQhKevpVBmV6MN3l799kUk/
         RFz5F/83/beDjuCCbgrFkXUFI60Lwin0z/3RJw8wzPk7Ou/pILfsy6bj+AZ1em7Af9
         7idUV05hXdgvFVHN3wKQ/JbHda/kP5/0aEFDolLVoZPeo5+2s/tYEEf4Rlzw4Pei3d
         ChHq/t9XYGiZ1BwDKZmwQLkR3G3an6goNSguPVpqYmhMmHLn+JOhsWqs31Kbis9iMH
         0IkjKYiwZtJFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC2B6E5D07E;
        Tue, 22 Feb 2022 15:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164554440977.8337.5697363615196952811.git-patchwork-summary@kernel.org>
Date:   Tue, 22 Feb 2022 15:40:09 +0000
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

Series: auxdisplay: Add support for the Titanmec TM1628 7 segment display controller
  Submitter: Heiner Kallweit <hkallweit1@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=616449
  Lore link: https://lore.kernel.org/r/1f39432b-84e2-e6dc-a6b8-c48ad5cf2210@gmail.com
    Patches: [v2,1/6] spi: gpio: Implement LSB First bitbang support


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



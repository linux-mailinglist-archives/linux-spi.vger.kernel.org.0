Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDABA6A48AD
	for <lists+linux-spi@lfdr.de>; Mon, 27 Feb 2023 18:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjB0R4V (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Feb 2023 12:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjB0R4V (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Feb 2023 12:56:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542B91CF41
        for <linux-spi@vger.kernel.org>; Mon, 27 Feb 2023 09:56:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC91F60EDF
        for <linux-spi@vger.kernel.org>; Mon, 27 Feb 2023 17:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 275B3C433D2;
        Mon, 27 Feb 2023 17:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677520579;
        bh=X/K3DBaRSW2LXwGOeo2YtvXJNiGP10RcmkaohJw5DaQ=;
        h=Subject:From:Date:To:From;
        b=YSx3en5jJzxbjcVbmx59GmO/VopNKxmPkZ8irtP8uQvfQmgNwwzIUwpWOtxg7xq/a
         3Ni/vct2Rd7tUcEhSwsmxdixmsm2k5w6+T7nW571jxF+1MNI5XBOae9sd7c7Z2gCTS
         UB8WxSxgemvMFlFyslvKGZiPGSFiIF+6P4wT/mmumfNDjy9KNtHHyvwJXOnUGEmAU0
         0f7LMWOKmeMtC97snVNTcPh4l00VwPH+ke8MrOBRAacSrJCeKV1M3FAsRg0n49JtO+
         2nqpjhuOR/fLpDS8Fr0LmDQGcDpu73LZRezpE+xLB2vrYo3l4VxiP7Dx40dguZ+qU+
         6E32aO6DlWT4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 08614E1CF31;
        Mon, 27 Feb 2023 17:56:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167752057902.11897.13506733541106434106.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 27 Feb 2023 17:56:19 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v6] Tegra TPM driver with HW flow control (2023-02-27T17:21:05)
  Superseding: [v5] Tegra TPM driver with HW flow control (2023-02-27T12:06:59):
    [V5,1/3] spi: Add TPM HW flow flag
    [V5,2/3] tpm_tis-spi: Support hardware wait polling
    [V5,3/3] spi: tegra210-quad: Enable TPM wait polling


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


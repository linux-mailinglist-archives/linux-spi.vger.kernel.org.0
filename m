Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5440699AA3
	for <lists+linux-spi@lfdr.de>; Thu, 16 Feb 2023 17:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjBPQ4Z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Feb 2023 11:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBPQ4Y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Feb 2023 11:56:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4731B135
        for <linux-spi@vger.kernel.org>; Thu, 16 Feb 2023 08:56:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D99A262045
        for <linux-spi@vger.kernel.org>; Thu, 16 Feb 2023 16:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CF87C433EF;
        Thu, 16 Feb 2023 16:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676566583;
        bh=mdtsB7z+rYmOQtq95EzaGN/1b1qlq4WmYnZNpz06eWA=;
        h=Subject:From:Date:To:From;
        b=sEOuOzR2/930wpmu0YGidU0+fs2DqkF62RVXft4RGxSMYZFpJ9Hb9MV+Qw0+yukwK
         0khS6FPnk/uJtFMZBrPE6m43W1Fo/2MpvUIHuX8QQpLlVXqd6r7USvTEm7qBpj24Rp
         5jUYnjogVmfThrlrSvOPdDyC2e2fBZjP/cnVdax0+jysvSQaNBarAZ2WbJawooxXdG
         AOxLaJFNOAS2bkoep10AOV5T4zLWYAIU5MW2L8PpLDJXxvYN2yk997ZMmqSiAyPG8k
         qaPrJRxD7L7P67awUA9sgaIwaOH6M2o4QuqmBhymBwar8Iupz/YZSvvvnTx1UKubix
         u5BLjs1G5GWPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4498E68D2E;
        Thu, 16 Feb 2023 16:56:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167656658293.2738.12726026902120012901.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 16 Feb 2023 16:56:22 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] SPI updates for v6.2-rc8-abi (2023-02-16T16:33:04)
  Superseding: [v1] SPI updates for v6.2-rc8-abi (2023-02-16T13:11:08):
    [GIT,PULL] SPI updates for v6.2-rc8-abi


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


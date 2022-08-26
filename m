Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA005A252E
	for <lists+linux-spi@lfdr.de>; Fri, 26 Aug 2022 11:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343975AbiHZJ5G (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Aug 2022 05:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343708AbiHZJ4z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Aug 2022 05:56:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C4529CA6
        for <linux-spi@vger.kernel.org>; Fri, 26 Aug 2022 02:56:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D610EB8307E
        for <linux-spi@vger.kernel.org>; Fri, 26 Aug 2022 09:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A54C1C433D6;
        Fri, 26 Aug 2022 09:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661507806;
        bh=7G5xfuWtofn26Pf+l6b69AXXrMklrwBpjBhsUxR72aw=;
        h=Subject:From:Date:To:From;
        b=MTSuyP1UbezeXeETQRnYgMzV/mYUVN7VxuHILDsmAR+BtVbbgR+APMREk4B0eXSb9
         AdVKhscJIE0V1iqxb+Wl7l2aac6L7bmyQMCurvu/AVkcisOZhIj/6/pRdrAzRXrocq
         gi4qASlTrZ8/KnumoIUwfOciptdGhSew2qI6bICE8Ynw/nqJSIzcLWIFhu4neFsi2l
         OdnR62Of9FkeTr4j/EyJgw1EyLMbXcbiYw4t+KC1hXFGWXyvMbJrnGPgUbYzNkZJSF
         AHKimVlddR0YCcYWtCjbbOL8ixBDegzdablvxMpFSkZKqB0GPBwkDC1n5iWMgejJMR
         dORgTnBfbAmqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87370C0C3EC;
        Fri, 26 Aug 2022 09:56:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166150780655.10001.14558346486146590058.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 26 Aug 2022 09:56:46 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: stm32-qspi: Fix stm32_qspi_transfer_one_message() error path (2022-08-26T09:20:31)
  Superseding: [v1] spi: stm32-qspi: Fix stm32_qspi_transfer_one_message() error path (2022-08-26T09:18:51):
    spi: stm32-qspi: Fix stm32_qspi_transfer_one_message() error path


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E120753B670
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jun 2022 11:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiFBJ4f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jun 2022 05:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiFBJ4d (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Jun 2022 05:56:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403F72A78AA
        for <linux-spi@vger.kernel.org>; Thu,  2 Jun 2022 02:56:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03A09B80DB1
        for <linux-spi@vger.kernel.org>; Thu,  2 Jun 2022 09:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C75A0C385A5;
        Thu,  2 Jun 2022 09:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654163790;
        bh=koecvQwMs3+mO/lKdxqC1kMa2NXoYcJWXH08yj6RhL0=;
        h=Subject:From:Date:To:From;
        b=Eb+8FslZuWPTYFjQ8X8RXogitjHFKX/haPAmmR3K0d/PhffsS8cgES42OU7SpuuUP
         QVRXFjfz7B3flS1LPXDiCHFF2Dp8GP48Pk0LHOt6C11kqNYZOn4oM3Hm1wVCSN8zry
         WmBuNcwnchGBmDeg4t4zxnR8FkcrZpVfdMpEPgxrZ97W1tU4+zyvPyK+BaFqcKao83
         4ZNqOkdyD3+VmjTcEO/Z/ObKlre4AGbNXQ8yjONVvgek+L/G2YmNbezJnez7cDKQAB
         8z9HwjnGIl2yn8ad/62pmPji4bNWNwrhBTDhFZjjoIc0Y+YhsIfLmhlxRUGZJThHSd
         fLP2I2zN/ZXuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ACB6BF0394E;
        Thu,  2 Jun 2022 09:56:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165416379070.19715.16574879711256008148.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 02 Jun 2022 09:56:30 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: stm32-qspi: Remove unused parameters (2022-06-02T09:25:37)
  Superseding: [v1] spi: stm32-qspi: Remove unused parameters (2022-06-02T08:55:54):
    [1/2] spi: stm32-qspi: Remove stm32_qspi_get_mode() unused parameter
    [2/2] spi: stm32-qspi: Remove stm32_qspi_wait_cmd() unused parameter
  Superseding: [v1] spi: stm32-qspi: Remove unused parameters (2022-06-02T08:59:16):
    [1/2] spi: stm32-qspi: Remove stm32_qspi_get_mode() unused parameter
    [2/2] spi: stm32-qspi: Remove stm32_qspi_wait_cmd() unused parameter


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


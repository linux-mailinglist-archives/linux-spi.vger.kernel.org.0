Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113496813E4
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jan 2023 15:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbjA3O4X (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 30 Jan 2023 09:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjA3O4W (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 30 Jan 2023 09:56:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F3529435
        for <linux-spi@vger.kernel.org>; Mon, 30 Jan 2023 06:56:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64A9761179
        for <linux-spi@vger.kernel.org>; Mon, 30 Jan 2023 14:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C87B8C433D2;
        Mon, 30 Jan 2023 14:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675090580;
        bh=/oO7VEXEaRAXL3CRGXtTZ9sLNQPEEtnLFm2ueQMzNhg=;
        h=Subject:From:Date:To:From;
        b=jjgZVagwCEcz9UWWRL9TKl9p04u4orwy/HBJgHfuP+8I0WZGqXqlhaVCJpIqsP3al
         lo6xCLjuvURcQ11rCR0ASXbek2cehvq1re06zkjXXrw3/OS43i/3pnKIqTrGW3x4J9
         f1DkzczOq6QeSGrfA+1gh8U2Aei9txgY21+VS+/rAGxGmb+vbeE2FJOFFcUoOgfF00
         fXb5lxstNje6Me7LgjW882+8DXWveBr2xdQGBff8ATygRfEJnhWJYkGqRBYZrdQ5Z2
         x0VQUrSotjm8KIy3xtDVZyMrBNeOXb08ulyiUDraAJ1mO6muW4TdS4DUKm2taR3Mxi
         4Uy3q7sg/ZHew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AC49EC04E31;
        Mon, 30 Jan 2023 14:56:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167509058069.14782.6965316566888257061.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 30 Jan 2023 14:56:20 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: dw_bt1: fix MUX_MMIO dependencies (2023-01-30T14:01:40)
  Superseding: [v1] spi: dw_bt1: fix MUX_MMIO dependencies (2022-12-15T16:52:34):
    spi: dw_bt1: fix MUX_MMIO dependencies


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


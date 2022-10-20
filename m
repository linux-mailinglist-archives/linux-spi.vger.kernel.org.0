Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C981D60693E
	for <lists+linux-spi@lfdr.de>; Thu, 20 Oct 2022 21:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiJTT4y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Oct 2022 15:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiJTT4x (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Oct 2022 15:56:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA01A1D8F00
        for <linux-spi@vger.kernel.org>; Thu, 20 Oct 2022 12:56:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1907D61CE8
        for <linux-spi@vger.kernel.org>; Thu, 20 Oct 2022 19:56:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76A09C433D6;
        Thu, 20 Oct 2022 19:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666295811;
        bh=uxdfm5Myar006tSynRu/XeknDHuYJu0/Pw3XQlH7KHM=;
        h=Subject:From:Date:To:From;
        b=YWWjaxoDNEoQVxI72t6j0QlU3e8gOhQrVaUsDcbIGR7ShELL/MNAq8Z7VMOkJpxy6
         0UViUt+IG8Lgs/J5iIYYTugVM1BzFFNIM7aM630Tt+r/gwbnMngGSIN4VURuRZSOBL
         pVoOO9iFzJk6kMTrR2rLCKCK4GAkuTWBHChqGSkxAUkwjjf/hhockcc9Tdo1vb3ukt
         ShyWn8B21L77RT8kvgNpMwF01Z8wJkly7rp+pyQMmgpy2DXCnUZxeofcpd699ZXD/F
         rCUsv78/FAhxp60I7r16D7tDDFKDtZNxvZBx4pcjxIG0YQ8AOXke1N/yPNTbB0wRj7
         ygSmBJvd4qUyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 598A7E270E2;
        Thu, 20 Oct 2022 19:56:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166629581136.25766.11346420627990842066.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 20 Oct 2022 19:56:51 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] spi: pxa2xx: Pass the SSP type via device property (2022-10-20T19:44:56)
  Superseding: [v3] spi: pxa2xx: Pass the SSP type via device property (2022-10-20T16:26:27):
    [v3,1/5] spi: pxa2xx: Respect Intel SSP type given by a property
    [v3,2/5] spi: pxa2xx: Remove no more needed PCI ID table
    [v3,3/5] spi: pxa2xx: Remove no more needed driver data
    [v3,4/5] spi: pxa2xx: Move OF and ACPI ID tables closer to their user
    [v3,5/5] spi: pxa2xx: Switch from PM ifdeffery to pm_ptr()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


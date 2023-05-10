Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE336FDA28
	for <lists+linux-spi@lfdr.de>; Wed, 10 May 2023 10:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbjEJI4x (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 May 2023 04:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236854AbjEJI4s (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 10 May 2023 04:56:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C62B9
        for <linux-spi@vger.kernel.org>; Wed, 10 May 2023 01:56:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D52D9647D8
        for <linux-spi@vger.kernel.org>; Wed, 10 May 2023 08:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BC2EC433D2;
        Wed, 10 May 2023 08:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683709004;
        bh=i8Pr0ftmft7/u3xcHbO9JHHZPjZ7o7XQn1r8tyhCE+M=;
        h=Subject:From:Date:To:From;
        b=XCuAXPqFToe+otVY895zFCvK2totlMUQ/6fACEvAOLt76Nu8YI26j2Xwo6p6IIpPF
         TmTft/IeJyi9TtvQGN+5ppMLrqkMTtziFBlyNdNdIQI9pa2NRz7eMmAp894bivaH1W
         wEFqFT4RlVBfEG3SX6IDs0plwAmYliBR8RL6nAD7NFxPODoIp1qF85LZpgjJ5odLHk
         GgEQR7JCeBXZCP4icHQS0y84VFZvIqdgJmYjEFeygWbJCpzmujkaHtZvuEQSwCnEvb
         5BMS/3bZGitD6l6gB+PIY7NLMyIT7dbTMIoAS3z3OzPcBUvikl79IHJxqE9Gnx6nD+
         Kfp+LMZVPnveQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC465E26D21;
        Wed, 10 May 2023 08:56:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168370900396.23240.3547969544726585146.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 10 May 2023 08:56:43 +0000
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

Latest series: [v5] Allwinner R329/D1/R528/T113s SPI support (2023-05-10T08:11:07)
  Superseding: [v4] Allwinner R329/D1/R528/T113s SPI support (2023-05-07T15:03:32):
    [v4,1/5] dt-bindings: spi: sun6i: add DT bindings for Allwinner R329/D1/R528/T113s SPI
    [v4,2/5] spi: sun6i: change OF match data to a struct
    [v4,3/5] spi: sun6i: add quirk for in-controller clock divider
    [v4,4/5] spi: sun6i: add support for R329/D1/R528/T113s SPI controllers
    [v4,5/5] riscv: dts: allwinner: d1: Add SPI controllers node


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


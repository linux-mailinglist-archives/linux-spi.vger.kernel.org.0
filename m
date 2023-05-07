Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A336F998B
	for <lists+linux-spi@lfdr.de>; Sun,  7 May 2023 17:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjEGP4o (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 7 May 2023 11:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjEGP4n (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 7 May 2023 11:56:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADAA11610
        for <linux-spi@vger.kernel.org>; Sun,  7 May 2023 08:56:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D7A360A4C
        for <linux-spi@vger.kernel.org>; Sun,  7 May 2023 15:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F0EFC433EF;
        Sun,  7 May 2023 15:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683475001;
        bh=hZnWWv85Da7XHZxjaFK3Qsi7hr3nmnl/09LeQLmceuo=;
        h=Subject:From:Date:To:From;
        b=S+NPlZeDyvM/rnh0vyeqqWbb9wGii8RxiiHfY/WN4+GimQn0qJO5BGuqd5k42eiWc
         DdIXsygxFJEslPMN+Yz351+2ev6G+sTuPGS2UKNOFs4sbxZi6WMGTlilyDCebdmoWT
         36S4AzrpP41LDUR5SMHUuupsSd/Uoy4oyl6gKg/epsCX+VxmqsqJzhqlQET1USy6D5
         REKfnZXHQk2B6tt6rtMrbJyy3v2K7L9HH0KWomJ6H1i1Otx+WDyvkagItbJ/1kjgW8
         BcTblkYUDBSZkM/YZKINn/gWb7ObxA7zlCjrXoyyhUyZdndc7/WVgnji5+W1UOhC18
         4VmRCILZiLy4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 53CC9E5FFCC;
        Sun,  7 May 2023 15:56:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168347500133.19886.7645793795471663587.git-patchwork-housekeeping@kernel.org>
Date:   Sun, 07 May 2023 15:56:41 +0000
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

Latest series: [v4] Allwinner R329/D1/R528/T113s SPI support (2023-05-07T15:03:32)
  Superseding: [v3] Allwinner R329/D1/R528/T113s SPI support (2023-05-06T23:26:03):
    [v3,1/5] dt-bindings: spi: sun6i: add DT bindings for Allwinner R329/D1/R528/T113s SPI
    [v3,2/5] spi: sun6i: change OF match data to a struct
    [v3,3/5] spi: sun6i: add quirk for in-controller clock divider
    [v3,4/5] spi: sun6i: add support for R329/D1/R528/T113s SPI controllers
    [v3,5/5] riscv: dts: allwinner: d1: Add SPI controllers node


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


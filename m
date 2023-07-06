Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3234B749B36
	for <lists+linux-spi@lfdr.de>; Thu,  6 Jul 2023 13:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjGFL41 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 Jul 2023 07:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjGFL40 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 Jul 2023 07:56:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C2610F5
        for <linux-spi@vger.kernel.org>; Thu,  6 Jul 2023 04:56:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3026061912
        for <linux-spi@vger.kernel.org>; Thu,  6 Jul 2023 11:56:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A721C433CA;
        Thu,  6 Jul 2023 11:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688644584;
        bh=GZ++xj09HrHKwgzVZXSKGF3f9wv3fDCYGbKJhhO8Oic=;
        h=Subject:From:Date:To:From;
        b=T2YYEES1nxaT1iY+NjzlmoMSr8Io9bmmAJZm2tNnTOKEszhuxcU6yljB5KIxUJKxj
         UsrmRMlM7wRz77to8h90+Bg1+lKgpBaukVoPffyJcmBWZ8Mjgy9daiznGnMFRDRFNg
         uOqVA/cgEVSMMkNZU18ox68lrXB2SJHd+I6smPQbSGog0/fvUXezojlSaslOOiGJyi
         hwDkp1u8TTecoZZRH5TdV+HCobb2R6L4I3PTvwtCCXzp4fO+WJ9o33SoR0ghbGiypL
         pdS868fGyuB66L7g2Jy2WeNn6FOX5fDB24TtKx7NoAdc98HklyYN/6UaXrB8BkNCWB
         BGKJeRJ9AhOKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 851F9E5381B;
        Thu,  6 Jul 2023 11:56:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168864458454.27639.18187079012107030367.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 06 Jul 2023 11:56:24 +0000
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

Latest series: [v2] spi: amlogic-spifc-a1: fixes and improvements for amlogic-spifc-a1 (2023-07-06T11:03:29)
  Superseding: [v1] spi: amlogic-spifc-a1: fixes and improvements for amlogic-spifc-a1 (2023-07-03T09:45:16):
    [v1,1/2] spi: amlogic-spifc-a1: implement adjust_op_size()
    [v1,2/2] spi: amlogic-spifc-a1: add support for max_speed_hz


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8F66E2645
	for <lists+linux-spi@lfdr.de>; Fri, 14 Apr 2023 16:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjDNO4p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Apr 2023 10:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjDNO4p (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 Apr 2023 10:56:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C5065AE
        for <linux-spi@vger.kernel.org>; Fri, 14 Apr 2023 07:56:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 492B06470B
        for <linux-spi@vger.kernel.org>; Fri, 14 Apr 2023 14:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9DE7C433EF;
        Fri, 14 Apr 2023 14:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681484202;
        bh=IAkMHbtY8J0lIUfkE50EMAnWE1a7sozszOWk2lSEegA=;
        h=Subject:From:Date:To:From;
        b=amzzotML2BXHtYgo+QYkWGw1B4qw/fSGlFVQBtEr+ng6tFyxER/luc97gGp0nMQYY
         utUFO6oqRLSX5S3/N5cKEk1PhmqEE7LxdTzA/kyUuwsEkfmannk456HXXGbSE4Qn2h
         D58H0dvTPDfLz2ouwUMBprRSaXoweGcKG5WoXPKFGIlavwwwV+5VEtXA/nhPuasu/o
         I9xcRdfjJRC72HGEnhKhGOK/LN/2aKMCfsRLXOLTUyxfZY7QxoQk2EdJVNMOXtsy1A
         fr/Lu7Yw1dpuvNpsjHutmVg22BFY6jwf8GGkvMBdWCUlI+U2AiyjQdk3718ZHnMDVD
         /qG87vhKslf4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F214E52441;
        Fri, 14 Apr 2023 14:56:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168148420258.15455.4183029708426960038.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 14 Apr 2023 14:56:42 +0000
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

Latest series: [v3] spi: Add DMA mode support to spi-qcom-qspi (2023-04-14T14:05:52)
  Superseding: [v2] spi: Add DMA mode support to spi-qcom-qspi (2023-04-12T15:29:45):
    [V2,1/3] spi: dt-bindings: qcom,spi-qcom-qspi: Add iommus binding for qspi
    [V2,2/3] arm64: dts: qcom: sc7280: Add stream-id of qspi to iommus
    [V2,3/3] spi: spi-qcom-qspi: Add DMA mode support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


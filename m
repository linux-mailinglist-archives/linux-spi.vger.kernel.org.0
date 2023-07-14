Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEE47530C7
	for <lists+linux-spi@lfdr.de>; Fri, 14 Jul 2023 06:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjGNE4Z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Jul 2023 00:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjGNE4X (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 Jul 2023 00:56:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F382D5F
        for <linux-spi@vger.kernel.org>; Thu, 13 Jul 2023 21:56:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A9ED612D6
        for <linux-spi@vger.kernel.org>; Fri, 14 Jul 2023 04:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD3C9C433C8;
        Fri, 14 Jul 2023 04:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689310581;
        bh=o2h+mfBCHvOngPtG9pV/pTtyLF25f/nnt6QXeZuF7zY=;
        h=Subject:From:Date:To:From;
        b=C8lJmfT3miX+lRRyGeoFmJNfn3GBvXcJm+gogV39QXN5+il1gt73lzrEBWSGaRGoW
         DWupe5zrktDTfUHZ0LUhBYhpgt9ebo9tnTPdaAC3D+bkOAOi3xDqjbrmvXbn6fJR9h
         uw+GaVE0cR99IVWSndt1yDFReDVqD/mQrLLvjWoDadt/NMdyBFagexQwKXSTZX6OYt
         iQfCrVGefC1EHgMET+B69HVMEyS36nSUg6iWylY4ZzAHUAe+C74PtarMtJ+MLp9EnL
         tAS67e/pPr/RBrf72NyqZ3RLYfquJvoeA3hOkj7xquOxpNDbSZ3rAHqZIWgu/6NAlF
         lipy1Fmyz6aYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AFCBDE1B4D6;
        Fri, 14 Jul 2023 04:56:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168931058171.14407.11589029488350744602.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 14 Jul 2023 04:56:21 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v7] spi-geni-qcom: Add SPI device mode support for GENI based QuPv3 (2023-07-14T04:22:01)
  Superseding: [v6] spi-geni-qcom: Add SPI device mode support for GENI based QuPv3 (2023-07-13T11:51:43):
    [v6,1/2] soc: qcom: geni-se: Add SPI Device mode support for GENI based QuPv3
    [v6,2/2] spi: spi-geni-qcom: Add SPI Device mode support for GENI based QuPv3


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


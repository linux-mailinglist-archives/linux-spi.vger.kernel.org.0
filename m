Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CE96EC996
	for <lists+linux-spi@lfdr.de>; Mon, 24 Apr 2023 11:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjDXJ5A (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Apr 2023 05:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjDXJ46 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Apr 2023 05:56:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDA01FC0
        for <linux-spi@vger.kernel.org>; Mon, 24 Apr 2023 02:56:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8032461F83
        for <linux-spi@vger.kernel.org>; Mon, 24 Apr 2023 09:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF81AC433EF;
        Mon, 24 Apr 2023 09:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682330210;
        bh=VaeaFb5KsXO7005cWteagbGJlK8Itb4PvkSpIVD0kgo=;
        h=Subject:From:Date:To:From;
        b=Xp2PLJbpzlm9aBDArDGgyNu6xDrEbrFQeZ44yOM8hzSj5AhT3KxnBsHkbdouZExg/
         xPFoqisM4rdHa0C1lp+8WyVIwQsjvFN8uUdryVkOlrpwxkfBc0OTLgB4qcdFcpMd+P
         Ow3+lEfKq6KCky5RI01b4AaX0jIIVcomFZ6PNfjvsQRxI0ooV1iYyW9YOhQV3/h6Ow
         6f1U0/hgucqRHvVqBd9JZZkmBr7E3hNf9M2S/BAnWtWN/7q6Olodnn/5/R9aWMJGcD
         qFT3oW71qGZxUiY4cDcPSNHrwWxPeQCi/NX4tszqJynAsxVK3+L17fKGin5eVjQtYf
         /1h4nEbEqxo0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C60EFE5FFC9;
        Mon, 24 Apr 2023 09:56:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168233021080.9519.3623636846041607996.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 24 Apr 2023 09:56:50 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] spi: Add DMA mode support to spi-qcom-qspi (2023-04-24T09:32:37)
  Superseding: [v4] spi: Add DMA mode support to spi-qcom-qspi (2023-04-20T13:13:09):
    [v4,1/5] spi: dt-bindings: qcom,spi-qcom-qspi: Add iommus
    [v4,2/5] arm64: dts: qcom: sc7180: Add stream-id of qspi to iommus
    [v4,3/5] arm64: dts: qcom: sc7280: Add stream-id of qspi to iommus
    [v4,4/5] arm64: dts: qcom: sdm845: Add stream-id of qspi to iommus
    [v4,5/5] spi: spi-qcom-qspi: Add DMA mode support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


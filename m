Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B8A700615
	for <lists+linux-spi@lfdr.de>; Fri, 12 May 2023 12:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240650AbjELK4v (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 May 2023 06:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240646AbjELK4t (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 12 May 2023 06:56:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F2B26B7
        for <linux-spi@vger.kernel.org>; Fri, 12 May 2023 03:56:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C93865559
        for <linux-spi@vger.kernel.org>; Fri, 12 May 2023 10:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6850C433D2;
        Fri, 12 May 2023 10:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683889007;
        bh=Bdy4v1SSBFxMsdJTiMvbjZvUeh9Tomtxfq1XF3jIs/M=;
        h=Subject:From:Date:To:From;
        b=InlFQ3U/oGh3z0KmEZwtORQBu8MlmvuWmJ1FYaOFmd5vsKANRmGMvtTt5liGjrTp2
         grquZunYgpNvRo8HLPtX4WmYAJcyTjyoI6cEiOouiNUJDI7MKegjfExLdbu5OhZXQW
         0TS15wR72tD1uArhPt2hDUnEsCT8UZTKHuZ6nm3rmViBRUIqf+HovXrCbVkSCOIHHk
         Ev2Y4vZUwYNYYStHRMkzOZjloB1KqkfhIzb4Fa/GyoZlL6UvRDUFLlySo5/QccvnM/
         x66b9dTUPsn7U0JnrPHo4Mmz/BbQjvpDFj5c5gMQuFmt4Dcpqi91NSu+YozePVRtSS
         RDGQS21xhNmAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E6E7E26D2A;
        Fri, 12 May 2023 10:56:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168388900758.26432.9559735271935769890.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 12 May 2023 10:56:47 +0000
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

Latest series: [v11] spi: dw: DW SPI DMA Driver updates (2023-05-12T10:47:42)
  Superseding: [v10] spi: dw: DW SPI DMA Driver updates (2023-05-09T08:22:39):
    [v10,1/5] spi: dw: Add 32 bpw support to SPI DW DMA driver
    [v10,2/5] spi: dw: Move dw_spi_can_dma()
    [v10,3/5] spi: dw: Add DMA directional capability check
    [v10,4/5] spi: dw: Add DMA address widths capability check
    [v10,5/5] spi: dw: Round of n_bytes to power of 2


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


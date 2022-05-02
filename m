Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB8B517700
	for <lists+linux-spi@lfdr.de>; Mon,  2 May 2022 20:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386973AbiEBTAH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 May 2022 15:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiEBTAF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 May 2022 15:00:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4152264D8
        for <linux-spi@vger.kernel.org>; Mon,  2 May 2022 11:56:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0FAC614A7
        for <linux-spi@vger.kernel.org>; Mon,  2 May 2022 18:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 422DEC385A4;
        Mon,  2 May 2022 18:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651517793;
        bh=UfnbSZOXMrzY/0u0scd1Jj+AWKFMLxuridWsG32eGxs=;
        h=Subject:From:Date:To:From;
        b=JxUQdC0ClUD9w/XyOM032tEjQd101+ZrF/QW+6JklJlpv/YF9r9VL4BHm2byP5oAA
         6KPEUiwYWIALVAi5mRQv9IQtytmIqYeNAM0QYEoKoUmHx75y2EyYwoEfAxCwDc90XA
         siHifsLKhlam6du377OwAIRn/yHJqL27k+zZFG5tRLV9a9GQnnRX2szjFn4EBVaHNy
         eYaN2O1ULdB0iQFkUYj4BFqOP51ZZdo53LBgaFgYSH0GwcLYSQ/lexiZJzmzIFqmyN
         ukwENnUOxdHAg3NOEMI79VaQjuMb8QnNXb4Z/4R5UVCqGu4tiBM1KmyqOXqsq8vNTf
         pYHYjsH1gO55g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 26476E6D402;
        Mon,  2 May 2022 18:56:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165151779315.5759.2622490355554813502.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 02 May 2022 18:56:33 +0000
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

Latest series: [v1] spi: spi-imx: cleanups and performance improvements (2022-05-02T17:54:50)
  Superseding: [v1] spi: spi-imx: cleanups and performance improvements (2022-05-02T16:52:01):
    [RFC,1/9] spi: spi-imx: fix sparse warning: add identifier name to function definition
    [RFC,2/9] spi: spi-imx: avoid unnecessary line continuations
    [RFC,3/9] spi: spi-imx: mx51_ecspi_intctrl(): prefer 'unsigned int' to bare use of 'unsigned'
    [RFC,4/9] spi: spi-imx: spi_imx_buf_rx_swap_u32(): fix sparse warning
    [RFC,5/9] spi: spi-imx: spi_imx_buf_rx_swap_u32(): replace open coded swahw32()
    [RFC,6/9] spi: spi-imx: complete conversion from master -> controller
    [RFC,7/9] spi: spi-imx: replace struct spi_imx_data::bitbang by pointer to struct spi_controller
    [RFC,8/9] spi: spi-imx: add PIO polling support
    [RFC,9/9] spi: spi-imx: mx51_ecspi_prepare_message(): skip writing MX51_ECSPI_CONFIG register if unchanged


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A2B6E58CF
	for <lists+linux-spi@lfdr.de>; Tue, 18 Apr 2023 07:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjDRF4k (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Apr 2023 01:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjDRF4k (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Apr 2023 01:56:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C5240F0
        for <linux-spi@vger.kernel.org>; Mon, 17 Apr 2023 22:56:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 803B7629E2
        for <linux-spi@vger.kernel.org>; Tue, 18 Apr 2023 05:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7A7FC433EF;
        Tue, 18 Apr 2023 05:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681797397;
        bh=HEzb+4P4t0fL+1W13gLjKbMvUhhXQQUFEEqDs/bqJvI=;
        h=Subject:From:Date:To:From;
        b=djcL2W1J7EofZK1az0JnQHoxUulV7pJ3BcDj8XgKJ5/RXzmpujgzUsVkSGIVcKNyk
         LwFspUK2jzkrq1yaQ61Exsoanc4sEYUoBb0FXdHJ9reqPBbveUVnhiubSsgDCqXO5z
         mn1wR0kRwXec/Q34NX7vEmINef3seQeawUYvz3NQzpzslGPnB75lsZjEsJ7f6FPkY9
         iPpgya03XbzaEiXNEqq/qcj+5w9p0AoeMhrQphibFwm3CbSEsvCazFNT4ZvElKAzkm
         H0Q6YEQ/o0xK0GEILa+rwVJMzvIVVdt9fGK51L8UQOgxofOL1futn4spz9K2J/Zdrk
         HvLU2GG6lecdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B38E4C4167B;
        Tue, 18 Apr 2023 05:56:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168179739767.7639.7401417322411965188.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 18 Apr 2023 05:56:37 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v7] spi: dw: DW SPI DMA Driver updates (2023-04-18T05:28:57)
  Superseding: [v6] spi: dw: DW SPI DMA Driver updates (2023-04-14T12:05:15):
    [v6,1/5] spi: dw: Add 32 bpw support to SPI DW DMA driver
    [v6,2/5] spi: dw: Move "dw_spi_can_dma" function
    [v6,3/5] spi: dw: Add DMA directional capability check
    [v6,4/5] spi: dw: Add DMA address widths capability check
    [v6,5/5] spi: dw: Round of n_bytes to power of 2


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


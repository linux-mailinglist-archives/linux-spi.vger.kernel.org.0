Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD1657E61A
	for <lists+linux-spi@lfdr.de>; Fri, 22 Jul 2022 19:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbiGVR4v (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 Jul 2022 13:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236325AbiGVR4o (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 Jul 2022 13:56:44 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5899B7E31D
        for <linux-spi@vger.kernel.org>; Fri, 22 Jul 2022 10:56:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A5EE6CE2A54
        for <linux-spi@vger.kernel.org>; Fri, 22 Jul 2022 17:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3212C341C6;
        Fri, 22 Jul 2022 17:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658512599;
        bh=uIsLoecEsarDeOEdBWX50fVSU8/b1JiU4SpWkY6sda8=;
        h=Subject:From:Date:To:From;
        b=k8cXYOhVfz0vhN8bqPAHLiI9FNQsKeqWlzRy2YpuNvod1ytnEo/SuqryBeNOlFGgp
         ZS4Wv9Of0msJGupL79eTNJ+f4EPEo9W2TjDc6yVJC880PTE3b1hd2/EgaLBn9gD9kI
         967vWjZ9Z1269sAVeken+4lhfCHOYJyjLHzYg0t1Y3UUkTRrfbL4t4dBIbFzToGzTy
         sTftI+89/TDp0N5QFV6NVBt/GCCzlY6Og4nbE7fQE4gb806EI7iKuThNAxYoDgnD74
         gMgXtwz/TUEZKtBmvUBlFKmoRHF5NIJ7GcCY5Hhu0nUNZ9MbEPUGfIzaZceavHNZJx
         BN0VOG+qh8QiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4617E451B3;
        Fri, 22 Jul 2022 17:56:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165851259973.28463.14939297530114863299.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 22 Jul 2022 17:56:39 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Add SPI Driver to HPE GXP Architecture (2022-07-22T17:23:34)
  Superseding: [v1] Add SPI Driver to HPE GXP Architecture (2022-07-20T20:11:57):
    [v1,1/5] spi: spi-gxp: Add support for HPE GXP SoCs
    [v1,2/5] spi: dt-bindings: add documentation for hpe,gxp-spifi
    [v1,3/5] ARM: dts: hpe: Add spi driver node
    [v1,4/5] ARM: configs: multi_v7_defconfig: Enable HPE GXP SPI driver
    [v1,5/5] MAINTAINERS: add spi support to GXP


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


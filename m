Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BF369124C
	for <lists+linux-spi@lfdr.de>; Thu,  9 Feb 2023 21:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjBIU4m (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Feb 2023 15:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjBIU4i (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Feb 2023 15:56:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70E86ADDE
        for <linux-spi@vger.kernel.org>; Thu,  9 Feb 2023 12:56:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C730B82318
        for <linux-spi@vger.kernel.org>; Thu,  9 Feb 2023 20:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25B0BC433D2;
        Thu,  9 Feb 2023 20:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675976185;
        bh=YDKkAulCpvPgL5lQlcQIOGFm2LCRNtq214zr2UkmJMw=;
        h=Subject:From:Date:To:From;
        b=qapugQilHPo+wNSG1/HNF7tuWRm7/oXz5qHL9SgJwRh11g7wYCIytQOgUzWlVghxE
         IBhEycoSwxrPX/E0WraK+1tOzw2OmG7jnZD2B5kLXjD2tsBwpOe2fc1zv8IL1Rc5lK
         YIL8bcfgzdcBsU5Px+wfMnzyqJ3Hc2iZiS/hB915ZkYgkEG8CeNs1Ymsd5/B8M6RqI
         wplH3bBM2QqD5v0Y3P4cWluVT8ECR2DIiUnHiTYwlvko9Oz9BjcadmAi4uxoMAU77Z
         2kHUgEDgK1ui3m/uJl8fnzdO7e05Q43sgXNRoAleSJnrkQYa9PHIHSNQJP6nCTE71E
         inAZFNT+jXelg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06CE7E21EC9;
        Thu,  9 Feb 2023 20:56:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167597618502.32044.251509936482299615.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 09 Feb 2023 20:56:25 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] spi: bcm63xx-hsspi: driver and doc updates (2023-02-09T20:02:32)
  Superseding: [v3] spi: bcm63xx-hsspi: driver and doc updates (2023-02-07T06:58:11):
    [v3,01/15] dt-bindings: spi: Convert bcm63xx-hsspi bindings to json-schema
    [v3,02/15] dt-bindings: spi: Add bcmbca-hsspi controller support
    [v3,03/15] ARM: dts: broadcom: bcmbca: Add spi controller node
    [v3,04/15] arm64: dts: broadcom: bcmbca: Add spi controller node
    [v3,05/15] spi: bcm63xx-hsspi: Add new compatible string support
    [v3,06/15] spi: bcm63xx-hsspi: Endianness fix for ARM based SoC
    [v3,07/15] spi: bcm63xx-hsspi: Add polling mode support
    [v3,08/15] spi: export spi_transfer_cs_change_delay_exec function
    [v3,09/15] spi: bcm63xx-hsspi: Handle cs_change correctly
    [v3,10/15] spi: bcm63xx-hsspi: Fix multi-bit mode setting
    [v3,11/15] spi: bcm63xx-hsspi: Add prepend mode support
    [v3,12/15] spi: spi-mem: Allow controller supporting mem_ops without exec_op
    [v3,13/15] spi: bcm63xx-hsspi: Disable spi mem dual io read op support
    [v3,14/15] spi: bcmbca-hsspi: Add driver for newer HSSPI controller
    [v3,15/15] MAINTAINERS: Add entry for Broadcom Broadband SoC HS SPI drivers


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


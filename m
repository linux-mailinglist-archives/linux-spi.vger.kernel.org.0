Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02FF67A62F
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jan 2023 23:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbjAXW4X (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Jan 2023 17:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjAXW4X (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Jan 2023 17:56:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845A3474F4
        for <linux-spi@vger.kernel.org>; Tue, 24 Jan 2023 14:56:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B9EF6137B
        for <linux-spi@vger.kernel.org>; Tue, 24 Jan 2023 22:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D405C4339B;
        Tue, 24 Jan 2023 22:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674600981;
        bh=asSmkmjAOzO/341M/jDozQuTT5pQVTDpqhweXQuz7gY=;
        h=Subject:From:Date:To:From;
        b=Kh5d9wfyqlEXYPQDSHCs9Y8jIveCuZy3L5Imwy33fCYvXH87V2OSl5FSHXX9NQ1jG
         FskpuYflOkGrfp+U4DnVmf0XBRf8JahgQRpfwerg2Ah4xKVTLZSdHfA/Y+mZsUKDA7
         n2XZJjQlsZ6qxsb7ywTFOGOFCLNHBy2PxhsxVSEwcLfQv5FXnbpRbpAVD4z+VWA9EI
         tvYaw5uvK6Dpo8iFYGki47pM2cbdKY97+L9XMgZyWwvH61FN/3MPbR8NmD3P1Fm9YM
         HvilsjyTyDPIi7rUzR6XeZGOkNBe5V09RzTzCq1GtmWaSe7Nbac7TNoNPoafOc7L2T
         BdOzUiXwx5ihg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 641CFE5250F;
        Tue, 24 Jan 2023 22:56:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167460098140.21095.8988385313483842106.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 24 Jan 2023 22:56:21 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: bcm63xx-hsspi: driver and doc updates (2023-01-24T22:12:03)
  Superseding: [v1] spi: bcm63xx-hsspi: driver and doc updates (2023-01-06T20:08:04):
    [01/16] dt-bindings: spi: Convert bcm63xx-hsspi bindings to json-schema
    [02/16] dt-bindings: spi: Add bcmbca-hsspi controller support
    [03/16] dt-bindings: spi: Add spi peripheral specific property
    [04/16] ARM: dts: broadcom: bcmbca: Add spi controller node
    [05/16] arm64: dts: broadcom: bcmbca: Add spi controller node
    [06/16] spi: bcm63xx-hsspi: Endianness fix for ARM based SoC
    [07/16] spi: bcm63xx-hsspi: Add polling mode support
    [08/16] spi: bcm63xx-hsspi: Handle cs_change correctly
    [09/16] spi: bcm63xx-hsspi: Fix multi-bit mode setting
    [10/16] spi: bcm63xx-hsspi: Make dummy cs workaround as an option
    [11/16] spi: bcm63xx-hsspi: Add prepend feature support
    [12/16] spi: bcm63xx-hsspi: Add clock gate disable option support
    [13/16] spi: spi-mem: Allow controller supporting mem_ops without exec_op
    [14/16] spi: bcm63xx-hsspi: prepend: Disable spi mem dual io read op support
    [15/16] spi: bcmbca-hsspi: Add driver for newer HSSPI controller
    [16/16] MAINTAINERS: Add entry for Broadcom Broadband SoC HS SPI drivers


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


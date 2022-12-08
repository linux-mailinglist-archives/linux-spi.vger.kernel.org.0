Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC33964697A
	for <lists+linux-spi@lfdr.de>; Thu,  8 Dec 2022 07:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiLHG4a (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Dec 2022 01:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHG42 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 8 Dec 2022 01:56:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D597062B
        for <linux-spi@vger.kernel.org>; Wed,  7 Dec 2022 22:56:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9BE761D9F
        for <linux-spi@vger.kernel.org>; Thu,  8 Dec 2022 06:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E16AC433D6;
        Thu,  8 Dec 2022 06:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670482586;
        bh=vZPvMzWeX5L2uduOVvn045mPs9I1S3ud8Yp00OF7DJM=;
        h=Subject:From:Date:To:From;
        b=ZOu0VU82SkcPwDxKfQG5hU2+TlgkQVQgxnVmQTkJW4+wZbqwXw5XCEpINH1pyAAwD
         YS0NCenOSUyg3qT4hBkGHg6ELiOC9rqMJalkU9yTZpkMY2LEyRXjGFVV4d0hCe7yff
         TFQjgdBGVKoPM5NnnMGsHHpuqor68NVweop7e3JuNrugzH0qrF7R5FE5s7Zo6p2tuk
         5v0k58kCmB0LUwc5BQVxyeqVapexvolXvlM2FwGHTKbz5QIRJfNyXOGy+q0nhJwQn8
         UUOPr6kPN8IWRBG8ZHZEHhbvdTEUXO/tPPzyAN89/5lXyZto8M2w67RfkH/3hp5GiY
         xUsssp5b1ARDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 254EBC395EA;
        Thu,  8 Dec 2022 06:56:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167048258614.14938.7502080634493398678.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 08 Dec 2022 06:56:26 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] Add MediaTek MT7986 SPI NAND and ECC support (2022-12-08T06:29:47)
  Superseding: [v2] Add MediaTek MT7986 SPI NAND and ECC support (2022-12-05T06:57:47):
    [v2,1/9] spi: mtk-snfi: Add snfi support for MT7986 IC
    [v2,2/9] spi: mtk-snfi: Change default page format to setup default setting
    [v2,3/9] spi: mtk-snfi: Add optional nfi_hclk which needed for MT7986
    [v2,4/9] mtd: nand: ecc-mtk: Add ECC support fot MT7986 IC
    [v2,5/9] dt-bindings: spi: mtk-snfi: Add compatible for MT7986
    [v2,6/9] spi: mtk-snfi: Add snfi sample delay and read latency adjustment
    [v2,7/9] dt-bindings: spi: mtk-snfi: Add read latch latency property
    [v2,8/9] dt-bindings: mtd: Split ECC engine with rawnand controller
    [v2,9/9] dt-bindings: mtd: ecc-mtk: Add compatible for MT7986


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


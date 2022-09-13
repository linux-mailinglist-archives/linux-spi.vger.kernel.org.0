Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DD45B79B6
	for <lists+linux-spi@lfdr.de>; Tue, 13 Sep 2022 20:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiIMSgH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Sep 2022 14:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiIMSfu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Sep 2022 14:35:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA79E402F1
        for <linux-spi@vger.kernel.org>; Tue, 13 Sep 2022 10:56:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5706E6153C
        for <linux-spi@vger.kernel.org>; Tue, 13 Sep 2022 17:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF7B9C433D6;
        Tue, 13 Sep 2022 17:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663091812;
        bh=dqUVlDp2AWrvZrJwSPBsStw72LEKIKRSNw2iVBHQeWk=;
        h=Subject:From:Date:To:From;
        b=t4qbShHI/woIJS6TxH11cF/pzr4aYi+h/AJ1UrlhKkeL7fKLWcWBLRSp2rzwxSL1M
         AZH2FzqPZI+nKf2Kj1/pr1XVa71HMFW+iedYRfq8vB43fqtVyXl4eGUFiT2rAXWemd
         6BFjuiivTFmXDlmrx0RCCijgkFKXfo3Yl5+8HipPlbe8+AREqwAPsnWkxjElo3/pEJ
         z/C2l16Ft2kKqcOSomlJNh8qDL77lXEmQXwSEiNHNBZlM9051rjR3OlPPM5U8jmLvM
         fb7HQ7CYtIuWDqmSZRT/+YrirwCRTEmYjFELlxH9+KnWwnUEoM3PMoZ0w8caIimjyM
         G7G5gDucbiJXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92204C59A58;
        Tue, 13 Sep 2022 17:56:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166309181258.31681.6352811951941141985.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 13 Sep 2022 17:56:52 +0000
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

Latest series: [v3] Make atmel serial driver aware of GCLK (2022-09-13T14:22:04)
  Superseding: [v2] Make atmel serial driver aware of GCLK (2022-09-06T13:55:02):
    [v2,01/13] spi: dt-bindings: atmel,at91rm9200-spi: Add DMA related properties
    [v2,02/13] ARM: dts: at91: sama7g5: Swap rx and tx for spi11
    [v2,03/13] dt-bindings: mfd: atmel,sama5d2-flexcom: Add SPI child node ref binding
    [v2,04/13] ARM: dts: at91: sam9x60ek: Add DBGU compatibles to uart1
    [v2,05/13] dt-bindings: serial: atmel,at91-usart: convert to json-schema
    [v2,06/13] dt-bindings: serial: atmel,at91-usart: Add SAM9260 compatibles to SAM9x60
    [v2,07/13] dt-bindings: mfd: atmel,sama5d2-flexcom: Add USART child node ref binding
    [v2,08/13] tty: serial: atmel: Define GCLK as USART baudrate source clock
    [v2,09/13] tty: serial: atmel: Define BRSRCCK bitmask of UART IP's Mode Register
    [v2,10/13] tty: serial: atmel: Only divide Clock Divisor if the IP is USART
    [v2,11/13] clk: at91: sama5d2: Add Generic Clocks for UART/USART
    [v2,12/13] tty: serial: atmel: Make the driver aware of the existence of GCLK
    [v2,13/13] dt-bindings: serial: atmel,at91-usart: Add gclk as a possible USART clock

Latest series: [v3] ACPI: unify _UID handling as integer (2022-09-13T16:31:43)
  Superseding: [v2] ACPI: unify _UID handling as integer (2022-09-08T13:29:06):
    [v2,1/8] ACPI: utils: Add acpi_dev_uid_to_integer() helper to get _UID as integer
    [v2,2/8] ACPI: LPSS: Refactor _UID handling to use acpi_dev_uid_to_integer()
    [v2,3/8] ACPI: x86: Refactor _UID handling to use acpi_dev_uid_to_integer()
    [v2,4/8] i2c: amd-mp2-plat: Refactor _UID handling to use acpi_dev_uid_to_integer()
    [v2,5/8] i2c: mlxbf: Refactor _UID handling to use acpi_dev_uid_to_integer()
    [v2,6/8] perf: qcom_l2_pmu: Refactor _UID handling to use acpi_dev_uid_to_integer()
    [v2,7/8] spi: pxa2xx: Refactor _UID handling to use acpi_dev_uid_to_integer()
    [v2,8/8] efi/dev-path-parser: Refactor _UID handling to use acpi_dev_uid_to_integer()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


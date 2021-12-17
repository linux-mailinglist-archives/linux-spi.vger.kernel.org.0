Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28FC47921D
	for <lists+linux-spi@lfdr.de>; Fri, 17 Dec 2021 17:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhLQQ5Z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Dec 2021 11:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239471AbhLQQ5W (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Dec 2021 11:57:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF89C06173E
        for <linux-spi@vger.kernel.org>; Fri, 17 Dec 2021 08:57:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA0D1B828FF
        for <linux-spi@vger.kernel.org>; Fri, 17 Dec 2021 16:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B835DC36AE1;
        Fri, 17 Dec 2021 16:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639760239;
        bh=p8j5Fdp+n63WOoB+KFSZQB/MIguRTJIMzDo6RZeguGc=;
        h=Subject:From:Date:To:From;
        b=nY87JakVjs360giMR3RLUiHu31jK5Dvx75jTrZKzLgMO6I3hDRsN6tUqm2KM8+bxV
         MoAo2bexPBA1FlLCBWjIoqulMOxDdJMOyIkfBtnplGFR6wfJSjiBbvigxWzPQLHj0+
         uRsf3HRCOm5e2QKUrr3wwFww8AvQ5r9b1GPJD6dTiK6EXLKXhdO9q0tilIMmg0aXWr
         n+FXKf80B+/ebQvfyKkz+KtYAHMNpogDUjZQaKABkNjULIl/nxZuVB4iAKAUHPHQjv
         6ahGn/qCVO8l5JLUDnznBixTk7kfQI/yi8fipheEnvfH6pZs5mxqXrukSpTK9DponY
         z6iZAyMMUlX+A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 91C9260A0A;
        Fri, 17 Dec 2021 16:57:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163976023958.29269.9351157136929626614.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 17 Dec 2021 16:57:19 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v7] External ECC engines & Macronix support (2021-12-17T16:16:40)
  Superseding: [v6] External ECC engines & Macronix support (2021-12-16T11:16:26):
    [v6,01/28] dt-bindings: mtd: nand-controller: Fix the reg property description
    [v6,02/28] dt-bindings: mtd: nand-controller: Fix a comment in the examples
    [v6,03/28] dt-bindings: mtd: nand-controller: Harmonize the property types
    [v6,04/28] dt-bindings: mtd: nand-chip: Create a NAND chip description
    [v6,05/28] dt-bindings: mtd: spi-nand: Convert spi-nand description file to yaml
    [v6,06/28] dt-bindings: vendor-prefixes: Clarify Macronix prefix
    [v6,07/28] dt-bindings: spi: mxic: The interrupt property is not mandatory
    [v6,08/28] dt-bindings: spi: mxic: Convert to yaml
    [v6,09/28] dt-bindings: spi: mxic: Document the nand-ecc-engine property
    [v6,10/28] dt-bindings: mtd: Describe Macronix NAND ECC engine
    [v6,11/28] mtd: spinand: macronix: Use random program load
    [v6,12/28] mtd: nand: ecc: Add infrastructure to support hardware engines
    [v6,13/28] mtd: nand: Add a new helper to retrieve the ECC context
    [v6,14/28] mtd: nand: mxic-ecc: Add Macronix external ECC engine support
    [v6,15/28] mtd: nand: ecc: Provide a helper to retrieve a pilelined engine device
    [v6,16/28] mtd: nand: mxic-ecc: Support SPI pipelined mode
    [v6,17/28] mtd: spinand: Delay a little bit the dirmap creation
    [v6,18/28] spi: spi-mem: Fix a DTR related check in spi_mem_dtr_supports_op()
    [v6,19/28] spi: spi-mem: Introduce a capability structure
    [v6,20/28] spi: spi-mem: Fill the spi-mem controller capabilities of all the drivers
    [v6,21/28] spi: spi-mem: Kill the spi_mem_dtr_supports_op() helper
    [v6,22/28] spi: spi-mem: Add an ecc_en parameter to the spi_mem_op structure
    [v6,23/28] mtd: spinand: Create direct mapping descriptors for ECC operations
    [v6,24/28] spi: mxic: Fix the transmit path
    [v6,25/28] spi: mxic: Create a helper to configure the controller before an operation
    [v6,26/28] spi: mxic: Create a helper to ease the start of an operation
    [v6,27/28] spi: mxic: Add support for direct mapping
    [v6,28/28] spi: mxic: Add support for pipelined ECC operations


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


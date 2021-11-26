Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C926745EE61
	for <lists+linux-spi@lfdr.de>; Fri, 26 Nov 2021 13:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbhKZNC0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Nov 2021 08:02:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:43656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234445AbhKZNAY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 26 Nov 2021 08:00:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 16C356112D;
        Fri, 26 Nov 2021 12:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637931432;
        bh=4U2DWaTkhVXACVez+SvrrkqOwzMWt8XdXy6z4otxBdE=;
        h=Subject:From:Date:To:From;
        b=MfEn285ESohsFnGzZ9rR9IAiLN6zrgmwHzA7bK40pZhLxvGkJvW1k4njKXEadms3V
         yxYrDMHlMv5k2eveWI1uBzLDcfhvKc1CjFnKOe1dpqfONQNjTTIHs3kLoPO4jqOc8e
         CfIi7eoqN6ZMD6s9Nvr/J+uaE6k1rP0yTQ5YO9K7CxH0+tUG+nSwoqRG+CzVndkRPN
         cCAPFyGGck3Cy5l0XamdNNfHe3jlN07TCFvgSCY9Lm2+Ph70E4oHMIDSgkA3oYd6BJ
         VE4Dyj94hpyCv0OJuu1Bry6ImrHIrN9nmCybkGVLd+U0zHoFvz3bZnsen9EXdYk3nh
         ZoqBcV1rZjo8Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1066860A4E;
        Fri, 26 Nov 2021 12:57:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163793143206.6316.13645460634815492794.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 26 Nov 2021 12:57:12 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] External ECC engines & Macronix support (2021-11-26T11:39:04)
  Superseding: [v1] External ECC engines & Macronix support (2021-10-20T14:27:51):
    [01/18] dt-bindings: mtd: nand-controller: Fix the reg property description
    [02/18] dt-bindings: mtd: nand-controller: Fix a comment in the examples
    [03/18] dt-bindings: mtd: nand-chip: Create a NAND chip description
    [04/18] dt-bindings: mtd: spi-nand: Convert spi-nand description file to yaml
    [05/18] dt-bindings: vendor-prefixes: Clarify Macronix prefix
    [06/18] dt-bindings: spi: mxic: The interrupt property is not mandatory
    [07/18] dt-bindings: spi: mxic: Convert to yaml
    [08/18] dt-bindings: mtd: Describe Macronix NAND ECC engine
    [09/18] dt-bindings: spi: mxic: Document the nand-ecc-engine property
    [10/18] mtd: spinand: macronix: Use random program load
    [11/18] mtd: nand: ecc: Add infrastructure to support hardware engines
    [12/18] mtd: nand: mxic-ecc: Add Macronix external ECC engine support
    [13/18] mtd: nand: mxic-ecc: Support SPI pipelined mode
    [14/18] spi: mxic: Fix the transmit path
    [15/18] spi: mxic: Create a helper to configure the controller before an operation
    [16/18] spi: mxic: Create a helper to ease the start of an operation
    [17/18] spi: mxic: Add support for direct mapping
    [18/18] spi: mxic: Add support for pipelined ECC operations


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


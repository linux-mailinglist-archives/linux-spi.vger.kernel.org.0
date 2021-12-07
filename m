Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA5446B832
	for <lists+linux-spi@lfdr.de>; Tue,  7 Dec 2021 10:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbhLGKAr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Dec 2021 05:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhLGKAq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Dec 2021 05:00:46 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27DFC061574
        for <linux-spi@vger.kernel.org>; Tue,  7 Dec 2021 01:57:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F0BA7CE1A2D
        for <linux-spi@vger.kernel.org>; Tue,  7 Dec 2021 09:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26B94C341C1;
        Tue,  7 Dec 2021 09:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638871032;
        bh=KTzPfSPf/J5ieELpcD316NwoO6q9kR15ra5UwlFcitE=;
        h=Subject:From:Date:To:From;
        b=dddek9rnkkWpVOxWgSauEQFPL0KL/iHEnTED1zKw9lxjQDWo48ye2IxwHDmdFVBMs
         +6TMnd0xcvxUx++nuIjUJQ4JbxxLtyLroGcPLef/07zTLJn2ljhI0Q28glXYp8ARIi
         mF1XrL97T6MkAJz72zHsrUmxmuCABdr10M6heLjn7+cYvw4s8mgE4hAJ/iq7fCzLb6
         FLP5tp0IXpQO/pKG6UFOve2+MkzkmiO/LayYwWyYhJx0V8eI8Jr5FodHitN6RQKLXk
         16UkO8SVfqysuezS2/YFIRRkuZPUkaUXwYdLkt9EAPL3ZWTBS8kI5zdCQ9CWkA9vq7
         JCz1y3QL/DitA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id F373660973;
        Tue,  7 Dec 2021 09:57:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163887103196.28423.18177653736620191209.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 07 Dec 2021 09:57:11 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] External ECC engines & Macronix support (2021-12-07T09:34:01)
  Superseding: [v2] External ECC engines & Macronix support (2021-11-26T11:39:04):
    [v2,01/20] dt-bindings: mtd: nand-controller: Fix the reg property description
    [v2,02/20] dt-bindings: mtd: nand-controller: Fix a comment in the examples
    [v2,03/20] dt-bindings: mtd: nand-chip: Create a NAND chip description
    [v2,04/20] dt-bindings: mtd: spi-nand: Convert spi-nand description file to yaml
    [v2,05/20] dt-bindings: vendor-prefixes: Clarify Macronix prefix
    [v2,06/20] dt-bindings: spi: mxic: The interrupt property is not mandatory
    [v2,07/20] dt-bindings: spi: mxic: Convert to yaml
    [v2,08/20] dt-bindings: spi: mxic: Document the nand-ecc-engine property
    [v2,09/20] dt-bindings: mtd: Describe Macronix NAND ECC engine
    [v2,10/20] mtd: spinand: macronix: Use random program load
    [v2,11/20] mtd: nand: ecc: Add infrastructure to support hardware engines
    [v2,12/20] mtd: nand: Add a new helper to retrieve the ECC context
    [v2,13/20] mtd: nand: mxic-ecc: Add Macronix external ECC engine support
    [v2,14/20] mtd: nand: mxic-ecc: Support SPI pipelined mode
    [v2,15/20] mtd: spinand: Create direct mapping descriptors for ECC operations
    [v2,16/20] spi: mxic: Fix the transmit path
    [v2,17/20] spi: mxic: Create a helper to configure the controller before an operation
    [v2,18/20] spi: mxic: Create a helper to ease the start of an operation
    [v2,19/20] spi: mxic: Add support for direct mapping
    [v2,20/20] spi: mxic: Add support for pipelined ECC operations


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


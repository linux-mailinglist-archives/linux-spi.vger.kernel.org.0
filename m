Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEA446F29D
	for <lists+linux-spi@lfdr.de>; Thu,  9 Dec 2021 18:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237632AbhLISAx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Dec 2021 13:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237566AbhLISAw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Dec 2021 13:00:52 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2211C061746
        for <linux-spi@vger.kernel.org>; Thu,  9 Dec 2021 09:57:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 40384CE27AA
        for <linux-spi@vger.kernel.org>; Thu,  9 Dec 2021 17:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AFB6C341C7;
        Thu,  9 Dec 2021 17:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639072635;
        bh=ByBilnVsqDHz5fgRdEgcQTJxKOXi+Kdi/Yi9rm+ANp8=;
        h=Subject:From:Date:To:From;
        b=hYDhXK98Z09CzaBckVyKtLqRv1ixHjvgd02P4rIAS/WbOPD724vYChiN/uBdsQEnU
         aWK4CzYHrQhUKQct/jOYxbq0iVbVWtG/j7adOhDBcSt/6JfLD9iN/o0R/ivbhDc98L
         9Hthf4EW8QXIo0hzFtpgUuklkpoK5SzfPWHbA+MDHdqFAJ6fvB00HUhVlRFuTt4iLr
         EbmI0KgMBJ+e7Nq8SXCAjff8K9idhh9j6XRtYq/Ww2LF6x+MxkhyrgbRU2EaSpDn7g
         ClOoo4VHNCRZeyP7qBIiUPodSnWL9MmCPnDfGdcaY74USDQUWSePMvCZ3nOVqmf5+0
         c9eb0SQjz5+tQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 44A3F609B3;
        Thu,  9 Dec 2021 17:57:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163907263527.1657.16919189244366777128.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 09 Dec 2021 17:57:15 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] External ECC engines & Macronix support (2021-12-09T17:40:34)
  Superseding: [v3] External ECC engines & Macronix support (2021-12-07T09:34:01):
    [v3,01/22] dt-bindings: mtd: nand-controller: Fix the reg property description
    [v3,02/22] dt-bindings: mtd: nand-controller: Fix a comment in the examples
    [v3,03/22] dt-bindings: mtd: nand-controller: Harmonize the property types
    [v3,04/22] dt-bindings: mtd: nand-chip: Create a NAND chip description
    [v3,05/22] dt-bindings: mtd: spi-nand: Convert spi-nand description file to yaml
    [v3,06/22] dt-bindings: vendor-prefixes: Clarify Macronix prefix
    [v3,07/22] dt-bindings: spi: mxic: The interrupt property is not mandatory
    [v3,08/22] dt-bindings: spi: mxic: Convert to yaml
    [v3,09/22] dt-bindings: spi: mxic: Document the nand-ecc-engine property
    [v3,10/22] dt-bindings: mtd: Describe Macronix NAND ECC engine
    [v3,11/22] mtd: spinand: macronix: Use random program load
    [v3,12/22] mtd: nand: ecc: Add infrastructure to support hardware engines
    [v3,13/22] mtd: nand: Add a new helper to retrieve the ECC context
    [v3,14/22] mtd: nand: mxic-ecc: Add Macronix external ECC engine support
    [v3,15/22] mtd: nand: mxic-ecc: Support SPI pipelined mode
    [v3,16/22] mtd: spinand: Delay a little bit dirmap creation
    [v3,17/22] mtd: spinand: Create direct mapping descriptors for ECC operations
    [v3,18/22] spi: mxic: Fix the transmit path
    [v3,19/22] spi: mxic: Create a helper to configure the controller before an operation
    [v3,20/22] spi: mxic: Create a helper to ease the start of an operation
    [v3,21/22] spi: mxic: Add support for direct mapping
    [v3,22/22] spi: mxic: Add support for pipelined ECC operations


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


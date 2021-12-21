Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F2A47C5A0
	for <lists+linux-spi@lfdr.de>; Tue, 21 Dec 2021 18:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240800AbhLUR6g (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Dec 2021 12:58:36 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35422 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240795AbhLUR6f (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Dec 2021 12:58:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0E33616D5
        for <linux-spi@vger.kernel.org>; Tue, 21 Dec 2021 17:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5723CC36AE8;
        Tue, 21 Dec 2021 17:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640109514;
        bh=FUnwysrPkY01vUBHyPsYaJVqaNeoDXY2Tzd1MUkpgJ8=;
        h=Subject:From:Date:To:From;
        b=csLEQNWqopJ09NQvjn6vXqKPaGSGa+zegyAJxnTdJeYQBhsx2siuG/bFqdCauIu9J
         hGyOW7G0BIBXFOTwWcP4RYHE0jh3TI3gv5JT/MBjOCiIilDdwIq+zyoxH6VA33oIGn
         9Xjvu6Uh9bpF940h5iFTS0/bfmoHWBNuD13lNUwihCQVDnfUe/fGabkZqJvNlfnPIj
         nj0WJ9BVSsHI0GRV2LvzqnHZ9z454RN13zZSFO5fZer1v1MRbbMtmkJFB+tV2Yfka7
         ZDoTlN2saMNL8hVChFYXS5CzBRJJuyRbmg2OOr5g+ihFjFXYfwvou/y+PpY8QYqoTM
         knNhBE6AHl7Zw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 37828609CC;
        Tue, 21 Dec 2021 17:58:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164010951417.13461.1962552316113916046.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 21 Dec 2021 17:58:34 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v8] External ECC engines & Macronix support (2021-12-21T17:48:30)
  Superseding: [v7] External ECC engines & Macronix support (2021-12-17T16:16:40):
    [v7,01/14] spi: spi-mem: Fix a DTR related check in spi_mem_dtr_supports_op()
    [v7,02/14] spi: spi-mem: Introduce a capability structure
    [v7,03/14] spi: spi-mem: Check the controller extra capabilities
    [v7,04/14] spi: cadence: Provide a capability structure
    [v7,05/14] spi: mxic: Provide a capability structure
    [v7,06/14] spi: spi-mem: Kill the spi_mem_dtr_supports_op() helper
    [v7,07/14] spi: spi-mem: Add an ecc_en parameter to the spi_mem_op structure
    [v7,08/14] mtd: spinand: Delay a little bit the dirmap creation
    [v7,09/14] mtd: spinand: Create direct mapping descriptors for ECC operations
    [v7,10/14] spi: mxic: Fix the transmit path
    [v7,11/14] spi: mxic: Create a helper to configure the controller before an operation
    [v7,12/14] spi: mxic: Create a helper to ease the start of an operation
    [v7,13/14] spi: mxic: Add support for direct mapping
    [v7,14/14] spi: mxic: Add support for pipelined ECC operations

Latest series: [v5] Stacked/parallel memories bindings (2021-12-21T17:00:55)
  Superseding: [v4] Stacked/parallel memories bindings (2021-12-10T20:10:36):
    [v4,1/3] dt-bindings: mtd: spi-nor: Allow two CS per device
    [v4,2/3] spi: dt-bindings: Describe stacked/parallel memories modes
    [v4,3/3] spi: dt-bindings: Add an example with two stacked flashes


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


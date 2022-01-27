Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B7249DE8E
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jan 2022 10:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiA0J4T (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Jan 2022 04:56:19 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45694 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238454AbiA0J4T (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Jan 2022 04:56:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4969D61C04
        for <linux-spi@vger.kernel.org>; Thu, 27 Jan 2022 09:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5067C340EA;
        Thu, 27 Jan 2022 09:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643277377;
        bh=7+7N0Y8HnzwF5HCbLGK1tgeZa1h/5wbGQIWAX8KVUu8=;
        h=Subject:From:Date:To:From;
        b=aUhjqi1hQNY9GX19bKZAkDpzxk0stv+ZoqFSmm1MwkgBGi7p92K1j/k9zw6BXoERG
         xzL3rEG381lfyQSz3XvxS+mc8eO9DogQUUclW80Tf4O1JuFxNA7DmNlDdajSQ0ozkg
         0rJtkv/5LK7Dt6M4ZgzK7cG2JBsrrsF2jrKGDyjoIKev1sljxXqm9eZEVEFnCDZcqY
         iL4IY/amXOaEraDbttMVMEcr36YH31SgBuykHTjY/cUiYztfEgikCht1EZAGfQtCaF
         q+gzrZxCX0XhEUKQGXqPqznwdwg1t+3BT4Cmp/t1PpLs3LeQtLC9bNXEVGMdaGAUnz
         VD/kPmVI1OEdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 982B4E5D07E;
        Thu, 27 Jan 2022 09:56:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164327737761.18588.11763996135550040294.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 27 Jan 2022 09:56:17 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v10] External ECC engines & Macronix support (2022-01-27T09:17:55)
  Superseding: [v9] External ECC engines & Macronix support (2022-01-04T08:36:18):
    [v9,01/13] spi: spi-mem: Introduce a capability structure
    [v9,02/13] spi: spi-mem: Check the controller extra capabilities
    [v9,03/13] spi: cadence-quadspi: Provide a capability structure
    [v9,04/13] spi: mxic: Provide a capability structure
    [v9,05/13] spi: spi-mem: Kill the spi_mem_dtr_supports_op() helper
    [v9,06/13] spi: spi-mem: Add an ecc parameter to the spi_mem_op structure
    [v9,07/13] mtd: spinand: Delay a little bit the dirmap creation
    [v9,08/13] mtd: spinand: Create direct mapping descriptors for ECC operations
    [v9,09/13] spi: mxic: Fix the transmit path
    [v9,10/13] spi: mxic: Create a helper to configure the controller before an operation
    [v9,11/13] spi: mxic: Create a helper to ease the start of an operation
    [v9,12/13] spi: mxic: Add support for direct mapping
    [v9,13/13] spi: mxic: Add support for pipelined ECC operations


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


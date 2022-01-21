Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B1549649C
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jan 2022 18:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381169AbiAUR4W (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Jan 2022 12:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382011AbiAUR4T (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Jan 2022 12:56:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95475C06173D
        for <linux-spi@vger.kernel.org>; Fri, 21 Jan 2022 09:56:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 335A261B32
        for <linux-spi@vger.kernel.org>; Fri, 21 Jan 2022 17:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FA38C340E1;
        Fri, 21 Jan 2022 17:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642787778;
        bh=bvlWyehetIo3K8vI9o/ROUug93tF9xL8KPixYJtyAwU=;
        h=Subject:From:Date:To:From;
        b=Pv6PoCSXVlS2Hccts+xsE6LxTtmYK1P7MUp0U2FOS1jeXkQTXUSuCgQysYgWf30Lu
         GXRCUaA1cDeY3KF69dSk5Bj23uQj76V/Bi8E09qpZpA0ps/AidoGEd2CZa2ArhyVxX
         saCRMyhrnPzaJvBUubgR4q+75i1L/QE6Xb5o6WliMD5BGsJSGIjShJwtFDYlAIPmjI
         nq9gdcPT5oB4iGdSMfy+8grPX2AMNsc8bKbnbb7Wc6Hu7iuX508vs2CONK9dPVjjNb
         gSp3r44Lz0NxdP3fwTv9kW+zTP9420ocIDGxUYCeeSGXYjuy9SqDFaUY1OzdQibVFt
         SU94uDX0Z/TpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 88189F60795;
        Fri, 21 Jan 2022 17:56:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164278777855.24153.6635250349857481350.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 21 Jan 2022 17:56:18 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v6] Support Spi in i2c-multi-instantiate driver (2022-01-21T17:24:22)
  Superseding: [v5] Support Spi in i2c-multi-instantiate driver (2022-01-21T14:32:45):
    [v5,1/9] spi: Make spi_alloc_device and spi_add_device public again
    [v5,2/9] spi: Create helper API to lookup ACPI info for spi device
    [v5,3/9] spi: Support selection of the index of the ACPI Spi Resource before alloc
    [v5,4/9] spi: Add API to count spi acpi resources
    [v5,5/9] platform/x86: i2c-multi-instantiate: Rename it for a generic serial driver name
    [v5,6/9] platform/x86: serial-multi-instantiate: Reorganize I2C functions
    [v5,7/9] platform/x86: serial-multi-instantiate: Add SPI support
    [v5,8/9] ALSA: hda/realtek: Add support for HP Laptops
    [v5,9/9] ACPI / scan: Create platform device for CS35L41


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


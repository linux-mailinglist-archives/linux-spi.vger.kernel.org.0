Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF7A49619F
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jan 2022 15:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381421AbiAUO4T (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Jan 2022 09:56:19 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43590 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381395AbiAUO4R (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Jan 2022 09:56:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3196961827
        for <linux-spi@vger.kernel.org>; Fri, 21 Jan 2022 14:56:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99CD7C340E3;
        Fri, 21 Jan 2022 14:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642776976;
        bh=WsiC45+h9lbQLLeJISw1g3x//zaVZ16+wFAmsfr0WYY=;
        h=Subject:From:Date:To:From;
        b=puK5FAMb/VA+RhFW+yhKejuHASgZxWcKX7BIXAxx0jpiJ+caJ4qLyCnoFStSoOjJM
         kDkr6OnmbidvR8qRO2XRyTs2y89OTxNfLQfffP8NLmaSA5nckDtmdMpSmlF/wwCv2u
         wbXgCnKKkVtQ3Wwuyf97IqvR/Gnax1G7Os0am0N8+dfYSJnbbms7VpiQvNE2JOWFfu
         eWpuNay6svt74sElghTbKHlaFrPYo7vGculDUKh7ZXnUvSxEowjnKnEa7j4KzON+pT
         wykRK2nJyc4euU3UJ+XbJg4lihh7RXvtFtKHDdr820fVlWv+zNy0jPmgINxrhVBClT
         BP9OvHeFs4+IQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85969F60795;
        Fri, 21 Jan 2022 14:56:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164277697654.30436.2052261706525846872.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 21 Jan 2022 14:56:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] Support Spi in i2c-multi-instantiate driver (2022-01-21T14:32:45)
  Superseding: [v4] Support Spi in i2c-multi-instantiate driver (2022-01-20T13:43:18):
    [v4,1/9] spi: Make spi_alloc_device and spi_add_device public again
    [v4,2/9] spi: Create helper API to lookup ACPI info for spi device
    [v4,3/9] spi: Support selection of the index of the ACPI Spi Resource before alloc
    [v4,4/9] spi: Add API to count spi acpi resources
    [v4,5/9] platform/x86: i2c-multi-instantiate: Rename it for a generic bus driver name
    [v4,6/9] platform/x86: bus-multi-instantiate: Reorganize I2C functions
    [v4,7/9] platform/x86: bus-multi-instantiate: Add SPI support
    [v4,8/9] ALSA: hda/realtek: Add support for HP Laptops
    [v4,9/9] ACPI / scan: Create platform device for CS35L41


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


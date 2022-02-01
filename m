Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739B84A623A
	for <lists+linux-spi@lfdr.de>; Tue,  1 Feb 2022 18:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241350AbiBARUP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Feb 2022 12:20:15 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53642 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbiBARUO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Feb 2022 12:20:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 957D061225
        for <linux-spi@vger.kernel.org>; Tue,  1 Feb 2022 17:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CBF5C340EB;
        Tue,  1 Feb 2022 17:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643736010;
        bh=SwOssDCsZLbU/wqYVIXAtR6nYuGbzdttHOgNvSA9848=;
        h=Subject:From:Date:To:From;
        b=S3mGyJ8vOeaUAZ5HOnci5I5Ud2zZC7+qX0KsvxAKRqc597IJUiKRPJic+sJuwVkRK
         Q0JOcDqq+97fFGnxrwX1cRzDWLWBePUnmKo1wtnrILxgE807QfcDbeFXkqSRmwAJIk
         q35SuB4ygzfbAA+xFqF+0dnXXfd5vynG2rHyEaROsQ5uauIQsIZZqTdfuMA1kNenxU
         xUbldiqfzq0PEGITViR2horGk912Pm5uvcLQk++2MjEsFOLfwZKAu1DFuBhS8L7CZA
         jZUCIgiANZJ4hohNrZBhIuQWCo5Yw3YCmHCUw9Kiz2iGFbMIi9V9+pf147SeB7rd+R
         TZGvl7fmwcy0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5EDB9E5D08C;
        Tue,  1 Feb 2022 17:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164373601033.31519.18420364923458399767.git-patchwork-summary@kernel.org>
Date:   Tue, 01 Feb 2022 17:20:10 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Support Spi in i2c-multi-instantiate driver
  Submitter: Stefan Binding <sbinding@opensource.cirrus.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=607335
  Lore link: https://lore.kernel.org/r/20220121172431.6876-1-sbinding@opensource.cirrus.com
    Patches: [v6,1/9] spi: Make spi_alloc_device and spi_add_device public again
             [v6,2/9] spi: Create helper API to lookup ACPI info for spi device
             [v6,3/9] spi: Support selection of the index of the ACPI Spi Resource before alloc
             [v6,4/9] spi: Add API to count spi acpi resources


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



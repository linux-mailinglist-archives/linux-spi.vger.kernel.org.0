Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3829F494FA5
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jan 2022 14:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243047AbiATN4R (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Jan 2022 08:56:17 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58062 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243240AbiATN4P (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Jan 2022 08:56:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28113B81D7A
        for <linux-spi@vger.kernel.org>; Thu, 20 Jan 2022 13:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0643C340E0;
        Thu, 20 Jan 2022 13:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642686973;
        bh=F/KZdY0TID9P8XsCNWIOtcl+R0m/+NS8zgyw4OwQk9E=;
        h=Subject:From:Date:To:From;
        b=OHrouKoQQ4FomSKZtmq1cG+0j/KkebZHz40DE/8BFx8WESmohvve7f0QTdTkA355D
         sOMF3W/xV609ozgz4VbZ+jNBIRkuy2aRbxhNv2NYnQgtTpQ8f+PusXPhlDvFcWWo8X
         pn2cWsz2txn5WDqDtr2uQxOhnt0yIEyU9bgB4EGsHoZnpB89koeOacIVK5yAnJVWSP
         2NCx0VHzqiXAzD8XWVe04/qjVT7xzTWZkOwD8W6EkaQsi0ZSsisbYH+VG7158OID0X
         HB9JlgwvIj/jWk8iWDYXwWL8Vyq00IIiSmCL0WXBzIWAdFI019i+cbMh/CnQjdhJoA
         JWHgWK1QD8TPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC7FBF60796;
        Thu, 20 Jan 2022 13:56:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164268697273.27378.9153334026493832151.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 20 Jan 2022 13:56:12 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] Support Spi in i2c-multi-instantiate driver (2022-01-20T13:43:18)
  Superseding: [v3] Support Spi in i2c-multi-instantiate driver (2022-01-18T14:52:42):
    [v3,01/10] spi: Make spi_alloc_device and spi_add_device public again
    [v3,02/10] spi: Create helper API to lookup ACPI info for spi device
    [v3,03/10] spi: Support selection of the index of the ACPI Spi Resource before alloc
    [v3,04/10] spi: Add API to count spi acpi resources
    [v3,05/10] platform/x86: i2c-multi-instantiate: Move it to drivers/acpi folder
    [v3,06/10] ACPI: i2c-multi-instantiate: Rename it for a generic bus driver name
    [v3,07/10] ACPI: bus-multi-instantiate: Reorganize I2C functions
    [v3,08/10] ACPI: bus-multi-instantiate: Add SPI support
    [v3,09/10] ALSA: hda/realtek: Add support for HP Laptops
    [v3,10/10] ACPI / scan: Create platform device for CS35L41


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


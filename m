Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C2E4929EE
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jan 2022 16:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242653AbiARP4O (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jan 2022 10:56:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60754 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242413AbiARP4N (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jan 2022 10:56:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6340A6128A
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 15:56:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCB2BC340E0;
        Tue, 18 Jan 2022 15:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642521372;
        bh=p7ceySJ/F1xKOI78iBMucS6B7K+fRkPwknoWDr93er4=;
        h=Subject:From:Date:To:From;
        b=qp/xyUhugcqE0WzmY0TQPgiMJNadBn+24s0SY6UIIt8c/ohTR/fX6Ij9tQJ7IyD2g
         mrxaRScAJoDJv2FPYhV+P0KlmIfS8031bYOempKHOTgxXbbS5oRtSLuJ9Bf8MVNSP8
         Ii8mHosmtVeraenOsv5+YBWQnqK4mLCQHvhYkOeeLu3DnP0R+iCO1NuMXH2KR2UT/c
         oRWuWMN5COmIKSqUBRd9TG3JdyXtVdMUeC6RPPgpBjDeI7SbJhjD9ZkRzHpXOhPio8
         Ev+Vr2Z4jvo+wZS320051pEQTtfaj37iECsgwcSHrbOw2uvzm+mdw4t+f+WXtYptdx
         Ze+sSm11hbl8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2281F60794;
        Tue, 18 Jan 2022 15:56:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164252137265.30520.9878164027218751870.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 18 Jan 2022 15:56:12 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] Support Spi in i2c-multi-instantiate driver (2022-01-18T14:52:42)
  Superseding: [v2] Support Spi in i2c-multi-instantiate driver (2021-12-10T15:40:44):
    [v2,1/6] spi: Export acpi_spi_find_controller_by_adev to be used externally
    [v2,2/6] spi: Make spi_alloc_device and spi_add_device public again
    [v2,3/6] platform/x86: i2c-multi-instantiate: Move it to drivers/acpi folder
    [v2,4/6] ACPI: i2c-multi-instantiate: Rename it for a generic bus driver name
    [v2,5/6] ACPI: bus-multi-instantiate: Reorganize I2C functions
    [v2,6/6] ACPI: bus-multi-instantiate: Add SPI support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


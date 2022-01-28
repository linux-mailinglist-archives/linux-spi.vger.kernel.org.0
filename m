Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05B349FE7D
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jan 2022 17:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350287AbiA1Q4Q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jan 2022 11:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245711AbiA1Q4Q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jan 2022 11:56:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5A4C061714
        for <linux-spi@vger.kernel.org>; Fri, 28 Jan 2022 08:56:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D821B8264E
        for <linux-spi@vger.kernel.org>; Fri, 28 Jan 2022 16:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D17F8C340E0;
        Fri, 28 Jan 2022 16:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643388973;
        bh=mhCwGLpT+QxP5bmlN6JmWZDXVfZGCfOwjzHFN+Y0qag=;
        h=Subject:From:Date:To:From;
        b=LmherHZzg2aF6NIRqZOmUeHoj1agI0g+8R4MBum8T9+jE7ImlFhH+NUpfcfN9VLM/
         zafTl5Vt4VoTgHoAuORF+CSUtx6dLXkym4Axrwoy8daZWfNdgg+T02X6Yn6dxfkn1P
         FYcEVZ6AUfQB/AeqarD82w8aJCB7KrVdwh0GsUbWpEc2eMYt0vZLdpWu7ti4m23hEF
         +HpHDlZHCpUKhQkNbbZ2LRfnZvbKQ9s88F2CCufWhFiXTO02+WznmZhEen9TMGKQq8
         fjOtpwJEMcfSpBvnFQkEqqKFG8iMAhmZ6imSO5EU98T4wPSYE1k+EQodgXmvP5T1my
         Vkhvh8Hj/Ghlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BC5B5F60799;
        Fri, 28 Jan 2022 16:56:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164338897376.26130.15967795145235028846.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 28 Jan 2022 16:56:13 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: tegra20: Fix missing IRQ check in tegra_slink_probe (2022-01-28T16:47:41)
  Superseding: [v2] spi: tegra20: Fix missing IRQ check in tegra_slink_probe (2022-01-28T16:18:07):
    [v2] spi: tegra20: Fix missing IRQ check in tegra_slink_probe


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


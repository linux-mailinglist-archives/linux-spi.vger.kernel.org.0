Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800F74C01B9
	for <lists+linux-spi@lfdr.de>; Tue, 22 Feb 2022 19:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbiBVS4x (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Feb 2022 13:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbiBVS4w (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Feb 2022 13:56:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B71B14AC9B
        for <linux-spi@vger.kernel.org>; Tue, 22 Feb 2022 10:56:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 068DB614BF
        for <linux-spi@vger.kernel.org>; Tue, 22 Feb 2022 18:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71DACC340E8;
        Tue, 22 Feb 2022 18:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645556185;
        bh=r3ZIdcgqESdWVvgxZr/P7ji0Qm7SyNT60hnkPCNhDAk=;
        h=Subject:From:Date:To:From;
        b=bHjcT0npdZgL8yZMM+gUk0FJ43yqRmVyxrUNJz3IdiFY8hBS9J2/1HzsoLN6mbzTD
         Flrazh7JzP9d0OnzeXJsI0FDqa8an6FdDQPMUytVImtBD2eAxmNVKWEo0KoBfIdJA1
         UB00zZ9Xkq5T17HwGBV4MbykPmKQvvuXSSGz0Iewg9nrqSp/vWQfhP4LVIDcQwyXsS
         7TLT/oZ7/neNQhnOsjbDuo2To0hfSDtaZpvRBasqyMlBsLVokIfpIk75guXby0IBGx
         FNh9x+eZ+OcP7Z2j8Gpg9WhmVeJhNQDddv9retVh/XkzVnDF++Ssg4zYS+D/RZ/Sw3
         rIQPU27+FhS5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5BA73E6D537;
        Tue, 22 Feb 2022 18:56:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164555618537.18296.6715350486158690882.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 22 Feb 2022 18:56:25 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Tegra QUAD SPI combined sequence mode (2022-02-22T17:56:06)
  Superseding: [v1] Tegra QUAD SPI combined sequence mode (2022-02-04T10:29:30):
    [1/6] spi: tegra210-quad: use device_reset method
    [2/6] dt-bindings: spi: Tegra234 QUAD SPI compatible
    [3/6] spi: tegra210-quad: add new chips to compatible
    [4/6] spi: tegra210-quad: add acpi support
    [5/6] dt-bindings: spi: Tegra QUAD SPI combined sequence
    [6/6] spi: tegra210-quad: combined sequence mode


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


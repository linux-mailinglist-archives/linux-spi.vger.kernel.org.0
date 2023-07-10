Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB0074DA9C
	for <lists+linux-spi@lfdr.de>; Mon, 10 Jul 2023 17:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjGJP4y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 Jul 2023 11:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbjGJP4s (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 10 Jul 2023 11:56:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE9D11B
        for <linux-spi@vger.kernel.org>; Mon, 10 Jul 2023 08:56:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B029A61068
        for <linux-spi@vger.kernel.org>; Mon, 10 Jul 2023 15:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1ABEAC433C8;
        Mon, 10 Jul 2023 15:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689004607;
        bh=C9Anc+W54V01oX7sio/4YKetSvXSsF9Ti3DL6LWH6+k=;
        h=Subject:From:Date:To:From;
        b=ZOclvgNLPWGtU+J7a7c2ADO9vkonIXeLlDZG8HEFK96pSnL/rUTnuhT/ShtQzf1c2
         PujFKDqR+RhbfaQPjEW2j7pyr8GX9K7ygkmCOHzNmleQG48TxNjJDbDqwCCVw8nDlW
         3OntNkmgwoTNSxKLOwwEjT4AwcxBBCZBeDMDhxfbwcylqLsodFyq2wSgh9qFVzQhYE
         e+yCnmdDtwm0OiXAHMEtTRoSxV+zuD7mdzDOi9WufH+AbclnDjPfhAxrXkAgZ7d9kH
         BgnYi3EEOzL8JozkHuSl5nvuIroj7BRuyUSj6qOTRoyIsxEUY1mIen7mdFWxFvLSEa
         uZna08JMIWCJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00B1EC0C40E;
        Mon, 10 Jul 2023 15:56:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168900460699.24648.2061002846412780014.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 10 Jul 2023 15:56:46 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: Header and core clean up and refactoring (2023-07-10T15:49:18)
  Superseding: [v1] spi: Header and core clean up and refactoring (2023-07-10T10:27:45):
    [v1,1/8] spi: Remove unneeded OF node NULL checks
    [v1,2/8] spi: Drop duplicate IDR allocation code in spi_register_controller()
    [v1,3/8] spi: Use sysfs_emit() to instead of s*printf()
    [v1,4/8] spi: Get rid of old SPI_MASTER_NO_.X and SPI_MASTER_MUST_.X
    [v1,5/8] spi: Sort headers alphabetically
    [v1,6/8] spi: Clean up headers
    [v1,7/8] spi: Fix spelling typos and acronyms capitalization
    [v1,8/8] spi: Use struct_size() helper


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


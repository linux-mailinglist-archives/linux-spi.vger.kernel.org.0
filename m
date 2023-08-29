Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1ED78BE19
	for <lists+linux-spi@lfdr.de>; Tue, 29 Aug 2023 07:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjH2F5P (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Aug 2023 01:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjH2F4v (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Aug 2023 01:56:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDEFEC
        for <linux-spi@vger.kernel.org>; Mon, 28 Aug 2023 22:56:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 650E5628F2
        for <linux-spi@vger.kernel.org>; Tue, 29 Aug 2023 05:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC091C433C8;
        Tue, 29 Aug 2023 05:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693288608;
        bh=cc5Y5NpXyCi2vBCWfUS213qSg55jTNDz/O1Zsq6i7k4=;
        h=Subject:From:Date:To:From;
        b=H/CRYbLp3hpEMyDRY0JN18Td5wTTmscIXvffmwtUQl72l0MQ8xnm1NMFduGLB3Lse
         /XuOsQJIGEd3aPi8/vw4okWXjwsfqpSSs1lue+iADQrM1NOulkK3MJWSeM68xbMPqG
         4kLGHR+gOguI3SKVTZOFuwqC1nyNlJwHFuy6NRca2jduolQIPVEyFDo7roTS9C+uHC
         FqoMHbx2K5MVQ7MMMbWRI+I1j6Yx4i/pC8qhFj2qMy4Do3ImU7E0cxJwpdQKXl8fLJ
         +pfmBPGA94rIiQP3D7PpIQFjSgan1yiJqESUMwpvaEzhr5xHQBaTiDJhVlbZX/G+mo
         f5Q/1CLcxNBag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4AD6C3959E;
        Tue, 29 Aug 2023 05:56:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169328860873.13166.14724532374428146414.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 29 Aug 2023 05:56:48 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v11] Add Intel LJCA device driver (2023-08-29T04:54:04)
  Superseding: [v10] Add Intel LJCA device driver (2023-08-26T23:13:59):
    [v10,1/4] usb: Add support for Intel LJCA device
    [v10,2/4] i2c: Add support for Intel LJCA USB I2C driver
    [v10,3/4] spi: Add support for Intel LJCA USB SPI driver
    [v10,4/4] gpio: update Intel LJCA USB GPIO driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


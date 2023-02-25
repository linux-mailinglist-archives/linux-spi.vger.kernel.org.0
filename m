Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1344F6A2A5A
	for <lists+linux-spi@lfdr.de>; Sat, 25 Feb 2023 15:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjBYO40 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 25 Feb 2023 09:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBYO4Z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 25 Feb 2023 09:56:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AE516AE3
        for <linux-spi@vger.kernel.org>; Sat, 25 Feb 2023 06:56:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 847C560AFD
        for <linux-spi@vger.kernel.org>; Sat, 25 Feb 2023 14:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0C46C433EF;
        Sat, 25 Feb 2023 14:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677336982;
        bh=b3NR0Wd2Saz04mliSTjmhzOvd8jD0u2OzQFVEoYg50U=;
        h=Subject:From:Date:To:From;
        b=auj9n/azHdMk9I/j6SZ5u/bkHDO0PH8V8U3nxZacZGJ04W9Si+h8yLAiw1Rz962Ts
         UUm9hliS3rQ4Fsq9vZ/sT932uHCOW0Qx26i17JBFGsXZTfHtJ9esGOWsBMsq4NdyJ0
         tkrAk/hOLpUC0+H8SRhaJ25x5Ad8pwUbH4F2v+9n+YYr8hyR7zz1dcd838tQfaCdxP
         UUbQJ0R3dW/3T7WYkyaw3JxWuWeH/e6LadO/NE05/Ih6Z9V7no/fPvXogrKJvH5bS2
         UlpRuo29a2AZ2L6V/l7AYbkgeqztnQEnvDnyCbUcqrFpbuG2fpqEy9kKfM59S+NlCJ
         Di3r7CeB1Dfog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB847E68D26;
        Sat, 25 Feb 2023 14:56:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167733698261.3986.17052757604752934064.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 25 Feb 2023 14:56:22 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Add Intel LJCA device driver (2023-02-25T14:01:13)
  Superseding: [v1] Add Intel LJCA device driver (2023-02-19T18:30:54):
    [1/5] mfd: Add support for Intel LJCA device
    [2/5] gpio: Add support for Intel LJCA USB GPIO driver
    [3/5] i2c: Add support for Intel LJCA USB I2C driver
    [4/5] spi: Add support for Intel LJCA USB SPI driver
    [5/5] Documentation: Add ABI doc for attributes of LJCA device


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


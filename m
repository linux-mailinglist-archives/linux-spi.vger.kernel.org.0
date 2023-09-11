Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1858B79C13D
	for <lists+linux-spi@lfdr.de>; Tue, 12 Sep 2023 02:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjILAoo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Sep 2023 20:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjILAol (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Sep 2023 20:44:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22046F260
        for <linux-spi@vger.kernel.org>; Mon, 11 Sep 2023 17:28:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C8E4C116A3;
        Mon, 11 Sep 2023 21:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694469417;
        bh=zHDff2Qlu/bHFBRTD4SSO/66T71oUEQ3S6ffXPbtiMM=;
        h=Subject:From:Date:To:From;
        b=PjV15HfSlUAVtQF7DqMMlK13jasBayqoxuMkBkv92nSinOVVTDb4ro7S3d1Hi/9P5
         kPvW936gfSG5YhVqoMTI5pglOv2tdNnzu2OmVrPEm4A0szFZgNI/INGVIZtWrh5Rgu
         xOzi3UtjPCZsaybESG3MhfyIEBorN2SmuGdjq9UyBEmXCmU7nt3jQoVlYiW7crdG53
         +9Gxg7TCCzpnloIFeptH8TgUEYISI2SwT3O9feMyE7rsbla88U63l+X1mB9q1r1aUl
         X3Pq3C1UuMX9uXQ3pzv7BJqljDjBzOGSf3tZJiJRahbUc7vLXeaxDAjb1Mk2SvEdPU
         AKy7kfVS09lww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 625A1C00446;
        Mon, 11 Sep 2023 21:56:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169446941739.29142.15615126562742113404.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 11 Sep 2023 21:56:57 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: bcm2835: reduce the abuse of the GPIO API (2023-09-11T16:15:53)
  Superseding: [v2] spi: bcm2835: reduce the abuse of the GPIO API (2023-09-01T11:15:48):
    [RFT,v2] spi: bcm2835: reduce the abuse of the GPIO API


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8C65BE96D
	for <lists+linux-spi@lfdr.de>; Tue, 20 Sep 2022 16:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbiITO4x (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Sep 2022 10:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiITO4w (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Sep 2022 10:56:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAF71EAC9
        for <linux-spi@vger.kernel.org>; Tue, 20 Sep 2022 07:56:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96E82B810EA
        for <linux-spi@vger.kernel.org>; Tue, 20 Sep 2022 14:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47388C433C1;
        Tue, 20 Sep 2022 14:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663685809;
        bh=EaMXVDaaSdPSAQZ7Pk92tK00vLGKzgCzEBJSi5IZnhg=;
        h=Subject:From:Date:To:From;
        b=SNFI6aqxdYbAaplJKHVvSYcPz1Q/1Vr3TalCP/Pw8P+uu/Hxu4atywrIrDyjnWx2t
         QJVCVJ06zdhXoePVLhQmiNtppmp6YKwqGKymEBViAWy+U0FkKwITNBckjHD8bLYkV9
         Rsi0I7otTVODFqg4ja4kcXjX/bi+Vrf7egUiFDC/CwLOLFGRCpu19LI6mm7on8QgoN
         Bh/aLVbrjtvPLB6NeyqmM4fvjut+rzttQkDxe0iHKu9YLGUyo6kQVmav5ugYtni1bx
         RdODW809KBxRomxlfa95ktQ6wN0F6ujT6aTa7D7IGXw+hxkjLDQwsUClKPDOwZHLww
         5opsLhV9RkFnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2EEB2E21EDF;
        Tue, 20 Sep 2022 14:56:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166368580918.17359.11379221973073821325.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 20 Sep 2022 14:56:49 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: s3c24xx: Switch to use devm_spi_alloc_master() (2022-09-20T14:22:16)
  Superseding: [v1] spi: s3c24xx: Switch to use devm_spi_alloc_master() (2022-09-20T11:49:01):
    [-next] spi: s3c24xx: Switch to use devm_spi_alloc_master()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


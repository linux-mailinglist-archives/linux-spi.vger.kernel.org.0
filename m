Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1862458A5BB
	for <lists+linux-spi@lfdr.de>; Fri,  5 Aug 2022 07:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbiHEF4d (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Aug 2022 01:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiHEF4c (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 Aug 2022 01:56:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F2C33E0B
        for <linux-spi@vger.kernel.org>; Thu,  4 Aug 2022 22:56:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 249EE60A4E
        for <linux-spi@vger.kernel.org>; Fri,  5 Aug 2022 05:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79B8FC433C1;
        Fri,  5 Aug 2022 05:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659678990;
        bh=oau/KGTJKcga6TMrU0EBX2TuRHxQslrCNlpPdKq89+s=;
        h=Subject:From:Date:To:From;
        b=q4VDNivACXkOY+NY5Lb12Fjkl/4QXirUgJUOI+HSzyGr0uDKWggzw2v7RzDmalRtu
         omq1mBM3XTYkIZmDE7ttlk6oxeMRqLIYksPbnmpRtiWo1wtmnvHBWnP/HwrMl2XkEC
         bnaONG0mKfjTGfr7G3e2KuP/Be36csomUdSEfz5EE5EmTUwe4QCNZJkctbdrHxPwqV
         j8cor0AziYQkozdSaMJG1e8u68gWCZyukAX9mlQ9ibfcdjPyjMJ97O12ABE9sA3vt8
         zdulodINRBbm/G9Gap8DGQvG6GV7yWIRse8z08YQXS3wwoevJZyNoy/Hzrc/MeeeTo
         fVJS02kmqJVhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51716C43142;
        Fri,  5 Aug 2022 05:56:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165967899025.17729.17242570322985126479.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 05 Aug 2022 05:56:30 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] Add support for Microchip QSPI controller (2022-08-05T05:30:15)
  Superseding: [v2] Add support for Microchip QSPI controller (2022-08-02T07:05:15):
    [v2,1/3] spi: dt-binding: add Microchip CoreQSPI compatible
    [v2,2/3] spi: microchip-core-qspi: Add support for microchip fpga qspi controllers
    [v2,3/3] MAINTAINERS: add qspi to Polarfire SoC entry


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


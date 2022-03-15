Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00ACC4D932D
	for <lists+linux-spi@lfdr.de>; Tue, 15 Mar 2022 04:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbiCOD5l (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Mar 2022 23:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237491AbiCOD5k (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Mar 2022 23:57:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170CD48E46
        for <linux-spi@vger.kernel.org>; Mon, 14 Mar 2022 20:56:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C50C6B80FB5
        for <linux-spi@vger.kernel.org>; Tue, 15 Mar 2022 03:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B2D0C340E8;
        Tue, 15 Mar 2022 03:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647316585;
        bh=Pm/b03D5n+pgy4Jp+PehDMlphI51IL+OkogGXHoC+T8=;
        h=Subject:From:Date:To:From;
        b=QaWDEMXnn9fv/x6npjYI7c1oocLN7KRPZuDyrMDHJ0gvki+VR7Y3oma9dn1FMHGdu
         tg2miasNgNxJ0rTC7LQiWf9553R/R8kyS2ZQ52/POTpJr62k9aSlPjbNNoFmZl+Eua
         cyzacafVCQ7AARYmiu9bxQ0y4wkG+urDg5crxhrzaP5LTSakGJmEcdB0Xcws4IdfWY
         IjkfqTMHNZkdKh/2Y4GmS8iTHHTjugK0eoKWmEaCL+N9TwpcXDb2guyQSdfWurxk0r
         ZlitKwd6fyNVT4QM8uuO1g6oME/N4SjhwgwNjquP9h5Vob6HyV6H/KoEIxrHNCT6qm
         IcnsuP9Iwd2Dg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E0B8E6BBCA;
        Tue, 15 Mar 2022 03:56:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164731658544.7665.3213499169321237802.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 15 Mar 2022 03:56:25 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] spi: mediatek: add single/quad mode support (2022-03-15T03:24:06)
  Superseding: [v3] spi: mediatek: add single/quad mode support (2022-03-07T06:52:23):
    [V3,1/7] spi: mediatek: support tick_delay without enhance_timing
    [V3,2/7] dt-bindings: spi: Add compatible for MT7986 with single mode
    [V3,3/7] spi: mediatek: add MT7986 single mode design support
    [V3,4/7] dt-bindings: spi: Add compatible for MT7986 with quad mode
    [V3,5/7] spi: mediatek: add spi memory support for MT7986
    [V3,6/7] dt-bindings: spi: support spi-hclk
    [V3,7/7] spi: mediatek: support spi-hclk


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


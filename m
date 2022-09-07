Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9129F5B07AF
	for <lists+linux-spi@lfdr.de>; Wed,  7 Sep 2022 16:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiIGO5N (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 7 Sep 2022 10:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiIGO44 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 7 Sep 2022 10:56:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D4E9FD0
        for <linux-spi@vger.kernel.org>; Wed,  7 Sep 2022 07:56:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0B86B81D7A
        for <linux-spi@vger.kernel.org>; Wed,  7 Sep 2022 14:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C298C433C1;
        Wed,  7 Sep 2022 14:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662562612;
        bh=vYm5QlBK64M0NOsS8QH3W9N7BlMwABVhz0+/KsHWXAA=;
        h=Subject:From:Date:To:From;
        b=Fi/eb2Ad5zFl/lWz00CwYKTa+bFeAWLUVDCCuqzpC3TnuRdq2POUFIY9/gAfsvHjt
         n5QKGnWO3KnuYh1+KYHNtXHDqkf017v0ukM0DYj4gm6w615XvriLs80ZkPpm56O0ND
         RAuVNfZHOMlfwsqSU33IuwsFu3XC+R3JV4AODAQGHpg84xJl4tZBnINgBt0c3ENDvL
         7+jgSWRDvE6CSUDPafGmdqp2NuWWgZ/XqPrebAYsu8MXBgTEIzXWJgsxclan1Du1Eq
         wKYeyk1fi2amk0bkn/CVP/Lz0FCqom9HgIKvdL7El6J3U85NfVZtLoVuf/HqAjceVu
         GvR9UbfTO45lw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 514EBE1CABD;
        Wed,  7 Sep 2022 14:56:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166256261232.23603.5266367698476050466.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 07 Sep 2022 14:56:52 +0000
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

Latest series: [v3] spi: Add capability to perform some transfer with chipselect off (2022-09-07T14:11:25)
  Superseding: [v3] spi: Add capability to perform some transfer with chipselect off (2022-08-18T13:57:49):
    [v3] spi: Add capability to perform some transfer with chipselect off


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


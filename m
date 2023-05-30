Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3FF716550
	for <lists+linux-spi@lfdr.de>; Tue, 30 May 2023 16:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjE3O44 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 May 2023 10:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjE3O44 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 May 2023 10:56:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9E4FC
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 07:56:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8926E63079
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 14:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0916C4A0E7;
        Tue, 30 May 2023 14:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685458609;
        bh=0PdVrQfo6KOkLoKcizPMOaOmNupJDDtIlaus/gYiRf4=;
        h=Subject:From:Date:To:From;
        b=HxsIV583Cq/4VmiYJPXA8UEJesw6cpzztdp4H0drDf/8j6QIfgaSsuqLgsYvFKfTk
         QhSVKgbHbIE1aTvFJoapJn/ijLqjMZXHk9TMyQsijD51xD50AWqcyWnvXXMKXx13og
         dzFdvDRjLJdDAwt3ecsDh+8KXs8hD9pSuVZDdEsoHQPjLbvYy3sZSiNlWnPzS847SV
         daaaMuV28u0iwXvd65x8ygOdRVJJU9xX9JWBcgRugC2tSEK/svDppHuQRhIMZrpu+A
         vnXZ1zrQjX3CTlX2Epg8gaMCzq5IZtRgUxzIXril/M2IWsMXY2T1wlhMwSfTkcHpRN
         W57rmOpk5gFxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2245E52BF6;
        Tue, 30 May 2023 14:56:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168545860979.20113.9311792377550518548.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 30 May 2023 14:56:49 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v7] spi: add SPI_MOSI_IDLE_LOW mode bit (2023-05-30T14:16:36)
  Superseding: [v6] spi: add SPI_MOSI_IDLE_LOW mode bit (2023-05-24T09:19:43):
    [v6,1/5] spi: add SPI_MOSI_IDLE_LOW mode bit
    [v6,2/5] spi: spi-imx: add support for SPI_MOSI_IDLE_LOW mode bit
    [v6,3/5] spi: spidev: add two new spi mode bits
    [v6,4/5] spi: spidev_test: Sorted the options into logical groups
    [v6,5/5] spi: spidev_test Add three missing spi mode bits


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


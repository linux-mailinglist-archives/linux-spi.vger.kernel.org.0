Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEF163DB35
	for <lists+linux-spi@lfdr.de>; Wed, 30 Nov 2022 17:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiK3Q5l (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Nov 2022 11:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiK3Q5E (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Nov 2022 11:57:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9A29208D
        for <linux-spi@vger.kernel.org>; Wed, 30 Nov 2022 08:56:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6D14B81C34
        for <linux-spi@vger.kernel.org>; Wed, 30 Nov 2022 16:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AD3FC433C1;
        Wed, 30 Nov 2022 16:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669827387;
        bh=EB2rZYhqoKJsCzQVu11jU3lTk+IGu9qz30FN5NlOeCw=;
        h=Subject:From:Date:To:From;
        b=gvu19uppvIOOzF0tBNfkqEfb/P7jebJrUkB9MWKuiwPTvD69wtu/6xfD1dUi7JKan
         P5GIjlZ7DANAosdmco9WoMl6gKlJKwNRF9kTTdZnpV6i0ennKiWx1wS8qlsyEVNEmW
         Gi6lyQjzaET276e15+CZj7FGBlvSwuJI16dEGgY+zb0gQ3+7vKM6hq4cc4ODIyatGJ
         LrePhQYW/CNQusEq39zYG3HDtvZDZgBxq/vGTDzQPVSR7X9cLEwTVXGakjuSxw+Ulh
         RgB8VeYN4G1PFJW7EDpuTet5DzSS8d3WejntL6ToutZHGjipIsVnexFWfgR5XfccaM
         7UqoNrFMkuT/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3CC70E21EF2;
        Wed, 30 Nov 2022 16:56:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166982738714.1004.823026340479864016.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 30 Nov 2022 16:56:27 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spidev: mask SPI_CS_HIGH in SPI_IOC_RD_MODE (2022-11-30T16:29:27)
  Superseding: [v1] spi: spidev: mask SPI_CS_HIGH in SPI_IOC_RD_MODE (2022-11-30T14:39:48):
    spi: spidev: mask SPI_CS_HIGH in SPI_IOC_RD_MODE


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


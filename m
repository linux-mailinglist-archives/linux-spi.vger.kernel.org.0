Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC15D54C940
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jun 2022 14:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349355AbiFOM4j (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jun 2022 08:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346690AbiFOM4j (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jun 2022 08:56:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CD33F892
        for <linux-spi@vger.kernel.org>; Wed, 15 Jun 2022 05:56:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58024B81D6D
        for <linux-spi@vger.kernel.org>; Wed, 15 Jun 2022 12:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C262CC34115;
        Wed, 15 Jun 2022 12:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655297795;
        bh=hsyZL1UKRQK5lEQpGqXxcvU7W7oXBdqt23bWAUKJXFg=;
        h=Subject:From:Date:To:From;
        b=L6Kq4rw8H7VMBWbHsi/ET9rEjXvKWv1lh0ILny+QQyc2IQGmTjeN18pM+fV5kI7a7
         9ldviMIfAv4xBffI8/XMeC3U0+mGcXaqG47YzkKOL9oabhLYwK1sk42vJgp4LUwpcs
         /2lWdtP76cXsKYMg0QFWMoX4KskAvD6+0gF1+JWqzHV7rKQaT5RdL/D2PxiwHd/x8A
         +OswxvNNEcCFZcQgLd4Tq6ZWyEIq9I42ueyoLIXzeq/+/vN/zlHauenS1eIFCidiWY
         BZaud685jCk/hSTwDqdslKgIrBWLOs/OuARgzPIkaFQ/6hwH3HphGCRjqP2DW6DWiv
         HNtZa/SdwHfZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9CFF3E6D466;
        Wed, 15 Jun 2022 12:56:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165529779557.6419.607971445204470496.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 15 Jun 2022 12:56:35 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Optimize spi_sync path (2022-06-15T12:46:29)
  Superseding: [v1] Optimize spi_sync path (2022-05-25T14:29:25):
    [RFC,1/3] drivers: spi: API: spi_finalize_current_message -> spi_finalize_message
    [RFC,2/3] drivers: spi: spi.c: Move ctlr->cur_msg_prepared to struct spi_message
    [RFC,3/3] drivers: spi: spi.c: Don't use the message queue if possible in spi_sync


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


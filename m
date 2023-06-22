Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EDC73ABCB
	for <lists+linux-spi@lfdr.de>; Thu, 22 Jun 2023 23:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjFVVuW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Jun 2023 17:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjFVVuW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Jun 2023 17:50:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB82510DB
        for <linux-spi@vger.kernel.org>; Thu, 22 Jun 2023 14:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6861761917
        for <linux-spi@vger.kernel.org>; Thu, 22 Jun 2023 21:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C534FC433C8;
        Thu, 22 Jun 2023 21:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687470620;
        bh=TaILC6SaSaph8HPdKSeiieqder1ur6V9/Ql9GeaPz3I=;
        h=Subject:From:Date:To:From;
        b=ahWrwJrUruOQ4qiy7v6wJZgCTW8+rUpiKn/ThvF9Q6RdEYep+SZWOqRv675rzLrrA
         +Eh/EsyfZWIpATh5kRqSQwWTme3oLluRUNdUNLQCEbXEqIDZRNAOoKbQUhpJAu1cqc
         oz1wN2olbEson4HtqNYy2OGB6QIxGUrdK1ExiZwF9q/MP0n4ylrlVEn73M4y0EPzFe
         BROeY7S/lVuOnwtClL1um5ASdlhxSsnt9y9UdeiX+zGxvOV6i5CIagoLa8JvGF9+JD
         KOVm4646RpAh+0YmpzjXVp5e0vWtS7qJ83ZWZFPM719gf5yXp5XWdqT8C0R0g1puQS
         IxaAZWLjzfMIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 989A9C395F1;
        Thu, 22 Jun 2023 21:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168747062052.9617.6920370103517961405.git-patchwork-summary@kernel.org>
Date:   Thu, 22 Jun 2023 21:50:20 +0000
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

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: zynqmp-gqspi: fix clock imbalance on probe failure
  Submitter: Johan Hovold <johan+linaro@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=759390
  Lore link: https://lore.kernel.org/r/20230622082435.7873-1-johan+linaro@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



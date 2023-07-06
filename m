Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2906A7497C6
	for <lists+linux-spi@lfdr.de>; Thu,  6 Jul 2023 10:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjGFI4X (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 Jul 2023 04:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjGFI4W (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 Jul 2023 04:56:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232C61BC3
        for <linux-spi@vger.kernel.org>; Thu,  6 Jul 2023 01:56:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B684618C7
        for <linux-spi@vger.kernel.org>; Thu,  6 Jul 2023 08:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3868C433C8;
        Thu,  6 Jul 2023 08:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688633781;
        bh=wnvpgM/INv2cWwkgobQ68/OFb0NDddldP73tlZ4jZFg=;
        h=Subject:From:Date:To:From;
        b=h301yIT27EANXhlCt2Zc3O+aVtoijroQK7q4rQV0KbR1vy6ffzXDkoFC4VD2EyWyW
         yN8nP2AzJR+MSAlQI0hOjx+iZMirnCRuL0J+vKRIDUfKMIMgFvjTcecxnfJ6ypSa7H
         f4rG390p8oZw68L6ZPmxC7U1pDzB3PIMEhSgsuMGHNtJyxVJfC0uhA2H7LFIUrgNmq
         LfUaN+NIcxWXG1WtzOymmi0Lmev4cRqwXC3WJIyS78r8YLUUDi7xAd2mZgH7C2Uiy5
         WFZ20EcBzllTX47ABKhxsSb8xixbsh8kPIrJb3mKwD2VU5g5GJ5e7Fs3o4k7+bYnVF
         GCLotc4ikJBXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D3AFAE5381B;
        Thu,  6 Jul 2023 08:56:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168863378086.4700.15374736928358058308.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 06 Jul 2023 08:56:20 +0000
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

Latest series: [v3] spi: stm32: disable device mode with st,stm32f4-spi compatible (2023-07-06T08:13:42)
  Superseding: [v2] spi: stm32: disable device mode with st,stm32f4-spi compatible (2023-06-27T12:39:06):
    [v2] spi: stm32: disable device mode with st,stm32f4-spi compatible


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


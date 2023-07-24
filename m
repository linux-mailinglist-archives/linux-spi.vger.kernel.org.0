Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3450275F402
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jul 2023 12:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbjGXK4t (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Jul 2023 06:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbjGXK4p (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Jul 2023 06:56:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E978199
        for <linux-spi@vger.kernel.org>; Mon, 24 Jul 2023 03:56:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AE106109E
        for <linux-spi@vger.kernel.org>; Mon, 24 Jul 2023 10:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BE55C433C9;
        Mon, 24 Jul 2023 10:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690196189;
        bh=InYdxvpge/EwsUuxQ0TgB1xjDrU93ABZCGLCumwCrnw=;
        h=Subject:From:Date:To:From;
        b=V6T4jxZEZBiKf9qY7Uc7OkgLmS7n0YAqIN5KDMvYClUlmHjXPVHRb3rsGUtqwf9gO
         Gp6kDZrq0qAjDKTK6qLl57rUBA3AZfhPHuGIg5+KDZgVol/K2PsgNCJN1iJvtrtgXr
         UyYj17KbhLOR1YfwVuuWVYJtEMsO3jgZOjE+sr6GwctWhkp2zAwrGEgFdbbmLp0QTa
         ZEE2ZOOnwd7vEkPjAgROQOOgoCrBcrYsEfN97w7tvBhwUmX69ge9r+/Q5Vl8nAf6ul
         mZ6BXRh9ETgv2+p99dUhxlfCB4Kz0K/TmMVhnMqFeNX0UfyayAJyCMetxmKxOlqxxv
         GLCeBIytSQ6jw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E98DE1F658;
        Mon, 24 Jul 2023 10:56:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169019618944.8717.9548974087397085387.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 24 Jul 2023 10:56:29 +0000
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

Latest series: [v3] Add SPI module for StarFive JH7110 SoC (2023-07-24T10:10:54)
  Superseding: [v2] Add SPI module for StarFive JH7110 SoC (2023-07-13T09:00:14):
    [v2,1/3] dt-bindings: spi: add reference file to YAML
    [v2,2/3] dt-bindings: spi: constrain minItems of clocks and clock-names
    [v2,3/3] riscv: dts: starfive: Add spi node for JH7110 SoC


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


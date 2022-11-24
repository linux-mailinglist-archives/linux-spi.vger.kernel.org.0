Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CDC636F84
	for <lists+linux-spi@lfdr.de>; Thu, 24 Nov 2022 01:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiKXA40 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Nov 2022 19:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKXA4Y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Nov 2022 19:56:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A044C9FC9
        for <linux-spi@vger.kernel.org>; Wed, 23 Nov 2022 16:56:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 311E761FA5
        for <linux-spi@vger.kernel.org>; Thu, 24 Nov 2022 00:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97791C433C1;
        Thu, 24 Nov 2022 00:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669251382;
        bh=tO8ywanNYoX0WZ1TN92GeuXCMi4dtAYNycrb9nLHG54=;
        h=Subject:From:Date:To:From;
        b=CEIFzfOlGcWxpVpbLAQMbl3C0uShhNeLPOGx/dbiDL76h2dQR5VovIHAbIwo8f+KZ
         sEbyf/D5JubnTmhTY7VjbOeK8hQ1Nula9UcQ4LKdFGB6LxwCuAWZa9DECbxH+R8Rrq
         /PljDPkK4FClvxgjkrWZSEx9FdvAEvVE+oVhRMlhsOBGYmT1w+ZUPU93wx4pfmQu0g
         dzphAlNWsS9XDNor3BkexZjZ0tn3ip3F4vrtGrkRBbberICCvcPgbzIV4Uewe9x0gp
         ZmE11lvxTbCjQFqp4zjHjTNk6xwvGfQ1G0XdLZsW7F6WeinOlzaZI74YKWV91Cd/Ar
         07Puh/IEcNNSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 769CDC395C5;
        Thu, 24 Nov 2022 00:56:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166925138247.18748.17153880005932546256.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 24 Nov 2022 00:56:22 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] Introduce Socionext F_OSPI SPI flash controller (2022-11-24T00:33:50)
  Superseding: [v2] Introduce Socionext F_OSPI SPI flash controller (2022-11-21T01:47:58):
    [v2,1/2] dt-bindings: spi: Add Socionext F_OSPI controller bindings
    [v2,2/2] spi: Add Socionext F_OSPI SPI flash controller driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D5477A732
	for <lists+linux-spi@lfdr.de>; Sun, 13 Aug 2023 16:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjHMO4x (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 13 Aug 2023 10:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjHMO4w (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 13 Aug 2023 10:56:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2C718F
        for <linux-spi@vger.kernel.org>; Sun, 13 Aug 2023 07:56:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4A3862923
        for <linux-spi@vger.kernel.org>; Sun, 13 Aug 2023 14:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A2BFC433C8;
        Sun, 13 Aug 2023 14:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691938614;
        bh=6jEC9yx5IS91dmnjIgXw4tpdD/8VqzybO5tP5PpC6iQ=;
        h=Subject:From:Date:To:From;
        b=cjnY4eT1DzF8VF+Yvyo1z398rh7cQd+PjJs/m70ZcuzQOmAaWpwY1IGxjDUeG4/0M
         Q6N5G5Vq5kUmPcFLV5ucRwOK/GDc0ZJpSsCVc7/ZLlhbeJNNUvFppbIe50UI+uMvSp
         Hge5a8AAAbpCN1AoTdfxj2L7oXXvwS/hLY7oCKkqdJzQAtPHyoeisYodersOF46YzG
         U9MK6BWAT7r7OzwzW0vvvMGn3TPGb+byT2iqg8Bi4r9McYqGG77kRWzcHu9MQxk2mp
         GthWqJcv7qmNFfb4E5Q+7eONYGcBDJjM99F5cDUdnHmZRjMqRs3y+fM5iu99Q9K9rM
         TJgLOFw96diUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 203BDC3274B;
        Sun, 13 Aug 2023 14:56:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169193861412.24330.3252306608554062498.git-patchwork-housekeeping@kernel.org>
Date:   Sun, 13 Aug 2023 14:56:54 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-mpc512x-psc: Fix an unsigned comparison that can never be negative (2023-08-13T14:12:07)
  Superseding: [v2] spi: spi-mpc512x-psc: Fix an unsigned comparison that can never be negative (2023-08-07T14:49:41):
    [v2] spi: spi-mpc512x-psc: Fix an unsigned comparison that can never be negative

Latest series: [v2] Documentation: spi: Added a valid hyperlink (2023-08-13T14:25:46)
  Superseding: [v2] Documentation: spi: Added a valid hyperlink (2023-08-13T14:25:32):
    [v2] Documentation: spi: Added a valid hyperlink


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


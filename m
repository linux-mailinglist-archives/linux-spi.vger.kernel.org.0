Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8C9769983
	for <lists+linux-spi@lfdr.de>; Mon, 31 Jul 2023 16:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjGaOa1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 Jul 2023 10:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjGaOa0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 Jul 2023 10:30:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E16E57
        for <linux-spi@vger.kernel.org>; Mon, 31 Jul 2023 07:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4301561172
        for <linux-spi@vger.kernel.org>; Mon, 31 Jul 2023 14:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A31CBC433C8;
        Mon, 31 Jul 2023 14:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690813821;
        bh=Wx8jksvPPHxoQ4xfCHLVrwJY5vx11BcB20sIWsz/L54=;
        h=Subject:From:Date:To:From;
        b=MkoPZXRXJHR/6750QoEmJSs30o2Ccl3WeUtVZ+2oG9oCqaBWepwaRX11buDY9uIN5
         QyncdiVi81rw/1ALvwytCWLaztGHQs/EVQGeYWU4AM6sS4psKqrAjFjyXOXoVvBHS1
         jdgvWkcTVtnSREzjwqyZdMj871f0W95tVb5AsINWQxp5DNHqYM0sXg5dx4pcw6i3o4
         hsFQgQ7eN5ImE2whzAlKTuvbYmfQyyW34OGb3FRoe+aihYP+g+NgXvVSGS+h8SRu2K
         iXtJD73uNZMF1e0HHXxH+pydwmU3LsT3GdPsnFmW0N9lRpKE/SobOUGk4QzdMJk8mo
         xQitk2IelefEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79B12E96ABF;
        Mon, 31 Jul 2023 14:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169081382139.20032.12241573007482889032.git-patchwork-summary@kernel.org>
Date:   Mon, 31 Jul 2023 14:30:21 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: Use dev_err_probe instead of dev_err
  Submitter: Wang Ming <machel@vivo.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=769654
  Lore link: https://lore.kernel.org/r/20230726105457.3743-1-machel@vivo.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D987A5BBD
	for <lists+linux-spi@lfdr.de>; Tue, 19 Sep 2023 09:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjISH4t (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Sep 2023 03:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjISH4s (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 Sep 2023 03:56:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BF711C
        for <linux-spi@vger.kernel.org>; Tue, 19 Sep 2023 00:56:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31022C433B9;
        Tue, 19 Sep 2023 07:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695110201;
        bh=BceDKMnnr1dx4s7ly9HnlX4vzArvlF9qu8Lak+D+76g=;
        h=Subject:From:Date:To:From;
        b=tuNpEAQaGWF2NityRJFIxiHvWRJ126CtxZYLG9fBYCHIhYn7nT0IBe4swG9i87+qk
         tRi2FMaxh4p5EZTiwKwln/Jo51Z+AWUJZh/UvGIVf4L8NafE+Tk3MRlr1qkExAGRBk
         hl03OEHHYZVYNIlxqFvUMKVR0ZBkSyjm692nuPPE3wACO6nDBYixWSuWELcly6k38P
         U917UbHk6fZ/VcQtUQODeQZDrgxHgpwH7W+BOYTup+cM1snzNWDqdPUzk1ey9svwwG
         zl73Ly6lRgX6x56OKBGZTywF2TnSeHQrNWYVgKIqeaHE0EgdmVMOhh1lUwibvTgfUt
         lqO+qUOEWH8uw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0BCC1E11F41;
        Tue, 19 Sep 2023 07:56:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169511020098.31520.1116747782953760365.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 19 Sep 2023 07:56:40 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-cadence-quadspi: Fix missing unwind goto warnings (2023-09-19T07:46:59)
  Superseding: [v1] spi: spi-cadence-quadspi: Fix missing unwind goto warnings (2023-09-15T12:31:04):
    spi: spi-cadence-quadspi: Fix missing unwind goto warnings


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


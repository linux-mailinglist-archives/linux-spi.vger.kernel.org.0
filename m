Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18826BE488
	for <lists+linux-spi@lfdr.de>; Fri, 17 Mar 2023 09:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjCQI53 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Mar 2023 04:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjCQI5G (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Mar 2023 04:57:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D34D7338C
        for <linux-spi@vger.kernel.org>; Fri, 17 Mar 2023 01:56:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25D8A6221A
        for <linux-spi@vger.kernel.org>; Fri, 17 Mar 2023 08:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B955C4339B;
        Fri, 17 Mar 2023 08:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679043394;
        bh=CgSH6bTcm85CJhIYL+CB3zp9TRcuG2OzkuzixsvsjjE=;
        h=Subject:From:Date:To:From;
        b=ZSpmar0kU80vQ7BdQno6cFkdopwycz17KkOx99TBo5N3dBVH3kcYzpPaC8D6VFfht
         J85l2mjJQz9MlU8yG6tpjx8EgSbT9cljyvQQNb6DVFFTQkLUxo+6lqyhEg7Q4Cfbzi
         BB7sqgQfNSi+i0tm5DCQN00hNbODwE738Sr+FTUB3o0r3qZ5yKwNyMSTi5PHMkeHXv
         yK4M1JgCpOLnRCNRnZEcBpY2KDpTxS71rMRoU6WkafM3+YYgr0ifRfwf5QpKhSMRlZ
         wHYp0EjSibOwTa4WCUZ6oGmo3ApXDKPdjfJbXfD7xbDd6hJT+hMsEtTnKF8cYXfnC2
         de6vg7SfMqUXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70D05E66CBF;
        Fri, 17 Mar 2023 08:56:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167904339445.27640.15447859783240749007.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 17 Mar 2023 08:56:34 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: loongson: add bus driver for the loongson spi (2023-03-17T08:29:49)
  Superseding: [v1] spi: loongson: add bus driver for the loongson spi (2023-03-08T02:59:06):
    [v1,1/2] dt-bindings: spi: add loongson spi
    [v1,2/2] spi: loongson: add bus driver for the loongson spi controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


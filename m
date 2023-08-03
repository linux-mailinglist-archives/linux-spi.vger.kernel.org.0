Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB91C76EF22
	for <lists+linux-spi@lfdr.de>; Thu,  3 Aug 2023 18:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbjHCQKa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Aug 2023 12:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236506AbjHCQK2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 3 Aug 2023 12:10:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4999430C0
        for <linux-spi@vger.kernel.org>; Thu,  3 Aug 2023 09:10:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC0A561E17
        for <linux-spi@vger.kernel.org>; Thu,  3 Aug 2023 16:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3FF6EC433C8;
        Thu,  3 Aug 2023 16:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691079025;
        bh=nOMxpcJqTbBfX5v3Bu4fF2l6oOJIgGVVjyHrCXcdhh8=;
        h=Subject:From:Date:To:From;
        b=Jj40gR0uVT9Vb9EKW7Jvsk3+7SPwg+4wirjnLolYspZYxyU8pMzeIPmbVXG/6lYgD
         LY7N9YfHgX4QyJ6jBpxSUiJv3eR6edG0+sDxX5KUoyMgf5XUFL/prrE3wtDT3g3lhj
         b7O8ChSM9NH4qiWpleDF2jDtRn7UgxI+IxyubqJOEyWuTLoKrunTggbX+vzPGdTyoL
         QAyhGaCHv6Wr+3edYSRKYw0abey4uByqG5KDA8p0eOh+aYXi4P11MkHrmcf3cZHBr/
         0iWr/1SlM645u/PGdLdWLZFcyAz4nFvkfGCahXl7okGthn4eZHI4iZJhvahhqaXXyb
         OYbC5f+nxaNnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18B17C43168;
        Thu,  3 Aug 2023 16:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169107902503.21134.17838907465436107252.git-patchwork-summary@kernel.org>
Date:   Thu, 03 Aug 2023 16:10:25 +0000
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

Patch: [-next] spi: fsl-spi: Do not check 0 for platform_get_irq()
  Submitter: Zhu Wang <wangzhu9@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=772512
  Lore link: https://lore.kernel.org/r/20230803083944.21501-1-wangzhu9@huawei.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



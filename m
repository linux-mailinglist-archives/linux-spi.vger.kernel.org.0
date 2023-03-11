Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DA06B5EAA
	for <lists+linux-spi@lfdr.de>; Sat, 11 Mar 2023 18:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjCKRUg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 11 Mar 2023 12:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjCKRUe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 11 Mar 2023 12:20:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00D8D58B1
        for <linux-spi@vger.kernel.org>; Sat, 11 Mar 2023 09:20:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FCA360DC6
        for <linux-spi@vger.kernel.org>; Sat, 11 Mar 2023 17:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1E8CC433D2;
        Sat, 11 Mar 2023 17:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678555217;
        bh=gDD86hkBJ7ByxiGELSqYVlYYwoOcn/oDNyOI4BaTvmQ=;
        h=Subject:From:Date:To:From;
        b=cWcETlWfz5p/CwjlFDptEPxvU6hspqZhLcvH0mg1CvGSxspSLMU+Np39CJHLv/qcf
         kEg4Tw4ugIlu2u39hV/cLXBNFP/1s8T3QRm1lI0ZKhr1VAr/qZChcQKOygs3xvnf+i
         2J2U3VFtQ/PXXW4DwlOla0foyQE9xIIYlSzB1SYIYbJGvytcmlOt3iO7ROmGpbxgdA
         RtlfiGC2yIiPRFZKMxrrEIru3QK9l6bw0ak/oTc/NiL+AAA7ZPe0ccnrqY6fDklGr8
         i7zK3E8F4vR1JytMBmOhAzFlGIxqPviL/2XRP1KBH2KIyA1Jz73yV/Dv6K8G1dMtB8
         m6J2O4Goaeh2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A678E61B65;
        Sat, 11 Mar 2023 17:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167855521752.32258.2710180348401887504.git-patchwork-summary@kernel.org>
Date:   Sat, 11 Mar 2023 17:20:17 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: fsi: restore CONFIG_FSI dependency
  Submitter: Arnd Bergmann <arnd@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=728626
  Lore link: https://lore.kernel.org/r/20230310140605.569363-1-arnd@kernel.org

Patch: Revert "spi: fsi: Make available for build test"
  Submitter: Tom Rix <trix@redhat.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=728888
  Lore link: https://lore.kernel.org/r/20230310202848.437655-1-trix@redhat.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



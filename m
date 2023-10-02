Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532D57B57A3
	for <lists+linux-spi@lfdr.de>; Mon,  2 Oct 2023 18:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238217AbjJBPu3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Oct 2023 11:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237474AbjJBPu0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 Oct 2023 11:50:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25605E5
        for <linux-spi@vger.kernel.org>; Mon,  2 Oct 2023 08:50:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2BF2C433C7;
        Mon,  2 Oct 2023 15:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696261823;
        bh=PVOykK5W7JDZzF90jt3vEIgzmwEJ2r92b8sNdqINwyM=;
        h=Subject:From:Date:To:From;
        b=oWQDjb0VGtPhb5vFCgWTY2WEdKcqU15DNTemIXzWJMbJ8epUSdqZwpJnHR9HGQm58
         APpqs2tOl8e7XlKuXUplY476enUIicO3aSgTSi5Fjv4XT7BM+qSbQTi63qpRYxeFJN
         nEqvtVQJhoWTg2XKRiYQRZV+oDGV6driHHyhCp/uemdBh+lee2j47cDreWS+fndCsi
         b8f4HD7Q79kcklExYjh5VP6aqtefWD2Ide8RZ2uxV/9ZKFrynZk6WDcM0XRpKCylbU
         FeNm4RkI1MI4aXnreTGMiTvbozh7m+HnfkhSO5at/ugwEOY9/tq/XB85EN5au4kYUm
         dI1OHZbbTUnjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C1E4E632D1;
        Mon,  2 Oct 2023 15:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169626182348.11738.15621205025242139542.git-patchwork-summary@kernel.org>
Date:   Mon, 02 Oct 2023 15:50:23 +0000
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

Patch: spi: npcm-fiu: Fix UMA reads when dummy.nbytes == 0
  Submitter: William A. Kennington III <william@wkennington.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=786878
  Lore link: https://lore.kernel.org/r/20230922182812.2728066-1-william@wkennington.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



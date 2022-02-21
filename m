Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0494BE0DD
	for <lists+linux-spi@lfdr.de>; Mon, 21 Feb 2022 18:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiBUPbB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Feb 2022 10:31:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379283AbiBUPao (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Feb 2022 10:30:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A887A22B2D
        for <linux-spi@vger.kernel.org>; Mon, 21 Feb 2022 07:30:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 457396118B
        for <linux-spi@vger.kernel.org>; Mon, 21 Feb 2022 15:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0C81C340E9;
        Mon, 21 Feb 2022 15:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645457411;
        bh=N5DxF4Se/4nx9bOXVU94woZxMv0Ptp76zpvgD9FCol0=;
        h=Subject:From:Date:To:From;
        b=IKgG2bXeWNL2x0o/bnvAhHS+oKhw/q5JSonVmz1eZlXgRkR8hW8BpLuqNvi2wZYe0
         6Xv/Yi8U6xbvUwn8vIYBX5ga/LBT9c/yCHMnaPREST3QAPnMek+9lpUKjScUPjpucJ
         iNgcsmwVx7iebu6lTTGY7ZwJ20X08dyFDRVIwaMgrmGg70kRdcocLKQTy5LNRnvhoW
         KBlHk2f2Nm5u3BtW4kTw61yDkSmF6jkLYoLTeF9lHhynF+WfIOmLgMssfAGMlMMtIc
         2ERE3vTnLjL9fo32ItRIoKU/PshgCKHRI7jlgb/D31E5qQxyBDGftfihXbxhUpq+Dz
         9S7k2FcIlpuGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 957EAE6D3E8;
        Mon, 21 Feb 2022 15:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164545741152.428.15274895012933745103.git-patchwork-summary@kernel.org>
Date:   Mon, 21 Feb 2022 15:30:11 +0000
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

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Stacked/parallel memories bindings
  Submitter: Miquel Raynal <miquel.raynal@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=608625
  Lore link: https://lore.kernel.org/r/20220126112608.955728-1-miquel.raynal@bootlin.com
    Patches: [v6,1/3] dt-bindings: mtd: spi-nor: Allow two CS per device
             [v6,2/3] spi: dt-bindings: Describe stacked/parallel memories modes
             [v6,3/3] spi: dt-bindings: Add an example with two stacked flashes


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



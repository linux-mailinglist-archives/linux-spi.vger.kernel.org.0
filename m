Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10634B2875
	for <lists+linux-spi@lfdr.de>; Fri, 11 Feb 2022 15:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbiBKO4W (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Feb 2022 09:56:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351117AbiBKO4V (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Feb 2022 09:56:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E261DE
        for <linux-spi@vger.kernel.org>; Fri, 11 Feb 2022 06:56:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 679F661F9E
        for <linux-spi@vger.kernel.org>; Fri, 11 Feb 2022 14:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3535C340E9;
        Fri, 11 Feb 2022 14:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644591377;
        bh=flwboD2V8DcJiXNtOFerNpu0TB5f1nOv7COrZXXU/Ps=;
        h=Subject:From:Date:To:From;
        b=L5NVPkQbeIn7DVBPZsw+CAClDcd6wX1pjEAiaj7/xBumR1iGBiPBH9d+NneLz2jVn
         xKcqCGMq/CYWbE2HsCSWmt4w1v4Jrdc7MFFX7muFhPkUQdBz/KDv15TYnG+Dzwan9j
         05aFDgIbicKEyw9GiltWsfjtyR38cLTTqFbOt4lzjv7XQzR7gDRjhTLcxX0WWU9c3e
         733ytnTYaa91wXl6HgBmdlGwrg5qQ3a/G1BjVxETbhxr3rvvblJX3x54xiFzlrWfkE
         Gb8dk/Ufh9wLuNmAbSIa3BrTA+xU+wSEDpAYsTun4a5h9j9l6n4rkYwjfNQKv6SDtr
         VsuQ+C8G1jxWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B28EBE5D09D;
        Fri, 11 Feb 2022 14:56:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164459137765.7030.6321080244770705518.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 11 Feb 2022 14:56:17 +0000
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

Latest series: [v2] spi: amd: Add support for new controller version (2022-02-11T14:31:52)
  Superseding: [v1] spi: amd: Add support for new controller version (2022-02-09T16:57:31):
    [1/3] spi: amd: Use iopoll for busy waiting
    [2/3] spi: amd: Remove needless rom_addr variable
    [3/3] spi: amd: Add support for version AMDI0062


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


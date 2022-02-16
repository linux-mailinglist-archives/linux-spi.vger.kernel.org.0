Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32C84B8ADE
	for <lists+linux-spi@lfdr.de>; Wed, 16 Feb 2022 14:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbiBPN4o (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Feb 2022 08:56:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbiBPN4k (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Feb 2022 08:56:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C83DE88
        for <linux-spi@vger.kernel.org>; Wed, 16 Feb 2022 05:56:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0128861842
        for <linux-spi@vger.kernel.org>; Wed, 16 Feb 2022 13:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 678D2C340EF;
        Wed, 16 Feb 2022 13:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645019785;
        bh=wuwQ5CfMWx4rPNL+mxnqU+BpnzUKVUJu11i6qOqziNY=;
        h=Subject:From:Date:To:From;
        b=F/F6XxXRreJRaZtk0xJWiJ/Gu1ohTL5fp3xXqSB+c8KdDYx/ZXGTEigcGcRaZkbHK
         /sQXCuK+zH1Uf9H7IKermY+H/hzzHv6UZE5wCh5zWP7AFi2GVdhhvEgs0CzJqVNVFr
         AaKB5j03tgLPUgDmhuadTDIaMRtqFIob19A+s/TaV8LgJHzVJQg4vJqud2jVx3t8UH
         /F8IwhbEK9OXXaklUvxqQVVBPITyZYV8J+7E7b7YVH8W1w/s6QSFI4ZW6fTu9FH27L
         hfL2C/62/fcn0PJ+GIiM1dHg5nGt7B7TeGrx60EOCMbpmGVgfkd0GjmuyZeXIbKA6p
         fKBKV0jY378Ag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 552F9E5D07D;
        Wed, 16 Feb 2022 13:56:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164501978534.27647.10671943512752001646.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 16 Feb 2022 13:56:25 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: amd: Add support for new controller version (2022-02-16T13:16:35)
  Superseding: [v2] spi: amd: Add support for new controller version (2022-02-11T14:31:52):
    [v2,1/3] spi: amd: Use iopoll for busy waiting
    [v2,2/3] spi: amd: Remove needless rom_addr variable
    [v2,3/3] spi: amd: Add support for version AMDI0062


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


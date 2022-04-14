Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07ED500AA8
	for <lists+linux-spi@lfdr.de>; Thu, 14 Apr 2022 11:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241106AbiDNJ7X (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Apr 2022 05:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241941AbiDNJ7U (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 14 Apr 2022 05:59:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED98270924
        for <linux-spi@vger.kernel.org>; Thu, 14 Apr 2022 02:56:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FCE461BB3
        for <linux-spi@vger.kernel.org>; Thu, 14 Apr 2022 09:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5703C385A5;
        Thu, 14 Apr 2022 09:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649930189;
        bh=RxitJMnxdQjHoOX3WAi8fjcjnrFdC20DM26iiIFlNL4=;
        h=Subject:From:Date:To:From;
        b=ruze0hr+c/CpJPbUCkzW60BX5zM5Q1nWraO+86JmbFpjE3XetCv5/ncO9WS5Gr+dH
         m/WUnzRoQnCDtsnS3pq7KSgsIqxsxBRNDn1QV5uZKuAmzuc3/4I8Yk386mCIM4zAYT
         tysrFCNanCStd9A+xNYnE3WadRWzfWUScSRjbblnvOGaip7DEh0ydHbzY41DTkIl5l
         zIs6/mhi1sXj2dF/FG3BbpyLgJx92cKZPRWgJUYKAPLEvrWp1XANi5zS6ESaJDIfRX
         0Jjlg9eCT8esXBiioTAc9zeD2JduJ3J8RvJAOPcvKctq4fYXaWyh7bxqQNb9Z3XZW9
         EU1eCuettwWHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0CF3E85D15;
        Thu, 14 Apr 2022 09:56:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164993018973.11462.882548643132849596.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 14 Apr 2022 09:56:29 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: spi-cadence-quadspi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync (2022-04-14T08:56:37)
  Superseding: [v1] spi: spi-cadence-quadspi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync (2022-04-13T09:36:56):
    spi: spi-cadence-quadspi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


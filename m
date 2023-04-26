Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9046EEFB1
	for <lists+linux-spi@lfdr.de>; Wed, 26 Apr 2023 09:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239809AbjDZH46 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Apr 2023 03:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239924AbjDZH45 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Apr 2023 03:56:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4503598
        for <linux-spi@vger.kernel.org>; Wed, 26 Apr 2023 00:56:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC75A62B0F
        for <linux-spi@vger.kernel.org>; Wed, 26 Apr 2023 07:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DAFBC433D2;
        Wed, 26 Apr 2023 07:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682495810;
        bh=9h7g8+n2n/SyJxBmDkNKCDrSn+ouy+3eDINhG9yS+eU=;
        h=Subject:From:Date:To:From;
        b=NuRJr22pIM1pYYOqEDhf5MQiErTPWNGMVUlgcAeUFfi5l6mqNLk9OAHbOSCTqjSB3
         /gs1vwN5VDL9P1KvBugpwS9P7lcJ7pOEvMgkkrmDhsaQMxElvhzkKzx9ihNvStn7UX
         9BDf3DCQTrIuTXajJzLRCL3AukL7PyGwCkuOM+KiL3shv4+7EfpGQq/MNfvtGiD1Li
         +QoBion3T2iFa1HM9MVmzPHygGYXhf67OJf+StlodfV2s/RefSWCpKihyNDxfYryJk
         qz9OnBHnthI3XbjotGd6veMyKpZM+s7aIJMGVdwAarkphnsEz6V74ySHRwgE3eldYS
         9iBDIiQQkNpOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 465B5E5FFC6;
        Wed, 26 Apr 2023 07:56:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168249581028.26081.6607962971851553952.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 26 Apr 2023 07:56:50 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v9] spi: loongson: add bus driver for the loongson spi (2023-04-26T07:10:45)
  Superseding: [v8] spi: loongson: add bus driver for the loongson spi (2023-04-19T06:22:01):
    [v8,1/2] dt-bindings: spi: add loongson spi
    [v8,2/2] spi: loongson: add bus driver for the loongson spi controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


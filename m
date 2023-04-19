Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558426E7387
	for <lists+linux-spi@lfdr.de>; Wed, 19 Apr 2023 08:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjDSG4k (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Apr 2023 02:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjDSG4k (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Apr 2023 02:56:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD7E2698
        for <linux-spi@vger.kernel.org>; Tue, 18 Apr 2023 23:56:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA1996154E
        for <linux-spi@vger.kernel.org>; Wed, 19 Apr 2023 06:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51698C433EF;
        Wed, 19 Apr 2023 06:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681887398;
        bh=GIBaW1+C6nKK3VRQj11fDjnRpNFMQhvTwNdf0wslm00=;
        h=Subject:From:Date:To:From;
        b=Pxhj+xwHxI3jHBmKIGamjMxNAjazDrg0huJruKCrdQamGqAjrN9a9wpYUzkv5g3gE
         6IHKayqpYopYdtE6VloaOEI4OG8nGUtaShWf//bzt7t4gdbqk5oX/EAdFtGD0ScG+J
         fDJLTnOpU7PPB4qHlyqMbqBdTGAWtAtoh7hJzp12s+EpltboxbbLDYQzAKXhLijBLP
         1pUDtNI7VeX8nz6kIgpmFuuB52TjJ3pCLCBvK+ewK58b/T8HvMhYwzH7gkuoDODccW
         U/kjF6f3bGf1BQgTfl+4OJp/60VDftvJ+IPIH0ks+c4jbPoJxYvRgNjeNkf2nP7S27
         6gCMVp+Ilm7vA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 339E5E3309C;
        Wed, 19 Apr 2023 06:56:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168188739820.22207.10066567033684859498.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 19 Apr 2023 06:56:38 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v8] spi: loongson: add bus driver for the loongson spi (2023-04-19T06:22:01)
  Superseding: [v7] spi: loongson: add bus driver for the loongson spi (2023-04-12T04:51:51):
    [v7,1/2] dt-bindings: spi: add loongson spi
    [v7,2/2] spi: loongson: add bus driver for the loongson spi controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


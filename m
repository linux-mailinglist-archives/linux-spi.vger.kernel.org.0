Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5397658F4
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jul 2023 18:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjG0Qkm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Jul 2023 12:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjG0Qkl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Jul 2023 12:40:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE533A84
        for <linux-spi@vger.kernel.org>; Thu, 27 Jul 2023 09:40:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1127B61ED2
        for <linux-spi@vger.kernel.org>; Thu, 27 Jul 2023 16:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7601DC433C8;
        Thu, 27 Jul 2023 16:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690476024;
        bh=D+L0HfUtcw8EPHO2W1Ucf0vAUImnFWQAIs8ROMkekpU=;
        h=Subject:From:Date:To:From;
        b=Ihrr7Lus2Tq5MpDG6Bpar75AtmlGPK4WoudyPY6m3etQoARr0nqrhMM1pUjAgIE4m
         AowvNytBdhkM8CGP9/DWjGJY8uFmEsCp/WWeVUTJ0cNUCBVcpj/TomDVwFmiNm90jU
         THR5E0G3O/2Be9oEUjV1gJh7VBREggbM45KnFHczhob4utnPm7HvMvaTuLoGZ7Rbhn
         62qkCHlQEw1MV8GLQlsf52miGsUKy5XJt2m6RxIW7bkDGXokhJM17kgdxcu8bnneGs
         MuqKO5z00DfmBEvwJNLXY/+aQmApmkyFVHiJboi4TTNlhm+rONEpxoHxTUguhP4bE9
         esH8zD0yklyzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54DFAC40C5E;
        Thu, 27 Jul 2023 16:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169047602428.2499.9685515587658881713.git-patchwork-summary@kernel.org>
Date:   Thu, 27 Jul 2023 16:40:24 +0000
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

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [-next] spi: stm32: Remove redundant dev_err_probe()
  Submitter: Ruan Jinjie <ruanjinjie@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=769921
  Lore link: https://lore.kernel.org/r/20230727110558.2904084-1-ruanjinjie@huawei.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



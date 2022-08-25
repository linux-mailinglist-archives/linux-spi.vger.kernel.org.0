Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370485A14E8
	for <lists+linux-spi@lfdr.de>; Thu, 25 Aug 2022 16:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239344AbiHYO4x (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 Aug 2022 10:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242114AbiHYO4w (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 25 Aug 2022 10:56:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE0D3342E
        for <linux-spi@vger.kernel.org>; Thu, 25 Aug 2022 07:56:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 070A8615A7
        for <linux-spi@vger.kernel.org>; Thu, 25 Aug 2022 14:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 620DFC433D6;
        Thu, 25 Aug 2022 14:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661439407;
        bh=6B1pC1FXIr4cRQn+E3baL3aFCbtjFyxhWdnSlvV9bGo=;
        h=Subject:From:Date:To:From;
        b=C7lZ90kWqkQetJQ3EECA48Env9ipyn+mgzxvwGy9cE69HeOYYR9SHw7q7upUlxWNP
         5rLpWZUNa9MB74mKMtLoklpP/eLbQqvJKDLMYLz5tzbLXgLiWwF4O42FK3TOWymq4O
         8zYFQqPn/w/XoDgQWEh207hlv3l9TDIs/ndFRuZd9HUY+zzvwl3thXh/WAbKqg617S
         P7gyr5kqxSBKP85JVz7u9tK9+1st1nZVh4Avsmn61iTWW2M9+msfiaOq9FG03IPExr
         v+Dnx1iuAAKg+AzpfTU1DVFOXvIvscIr6CHvCuC0r0S2aj098VoQKjG+9ntgaCITcQ
         rOLrGuu7QOZ3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 39C75C004EF;
        Thu, 25 Aug 2022 14:56:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166143940716.8424.15133698835605308407.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 25 Aug 2022 14:56:47 +0000
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

Latest series: [v3] spi: amd: Configure device speed (2022-08-25T14:31:32)
  Superseding: [v2] spi: amd: Configure device speed (2022-08-19T12:36:30):
    [v2] spi: amd: Configure device speed


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


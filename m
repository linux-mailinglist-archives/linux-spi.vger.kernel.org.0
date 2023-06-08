Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5AB727950
	for <lists+linux-spi@lfdr.de>; Thu,  8 Jun 2023 09:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbjFHH47 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Jun 2023 03:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbjFHH46 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 8 Jun 2023 03:56:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB712126
        for <linux-spi@vger.kernel.org>; Thu,  8 Jun 2023 00:56:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEF236403E
        for <linux-spi@vger.kernel.org>; Thu,  8 Jun 2023 07:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B28DC433D2;
        Thu,  8 Jun 2023 07:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686211016;
        bh=hunlLjncmvMzv8A5/+cdrlDT3O6D4HzJVJykl1QsLXA=;
        h=Subject:From:Date:To:From;
        b=qhy86iMM38eqmHj6MMeete+EsUn1v9UrdM4BdhpavTLzBRDEqRE1uDjWqyHc9AnDF
         voum0Q0sPc5SV1DrAHXjt9DiR11OHjj3gsezKWgSr/379DwxHe/rcaNs0tLEFCyRsm
         CAktArZUmmzhPbdhrF+nkyyRRZcI46VeLUNibpFgu4jvGEr1OH50+5xxMkXao5CGTt
         uFPevjw5rlcR2hvOT+otY+rQubuwzlV39Dbyn5A3FkCksM2X//94x72jUxCmygjbs9
         5m9+MfPxwk1cmUdYS1GQcB4C4a3IVyUaXVH8tBfcsFl9JnFpt6eg1/9bDEbQ2JFZg3
         XfahVm4Sj9Hjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35DFEE87232;
        Thu,  8 Jun 2023 07:56:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168621101621.9506.9921171488243721912.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 08 Jun 2023 07:56:56 +0000
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

Latest series: [v12] spi: loongson: add bus driver for the loongson spi (2023-06-08T07:28:18)
  Superseding: [v11] spi: loongson: add bus driver for the loongson spi (2023-05-22T07:10:29):
    [v11,1/2] dt-bindings: spi: add loongson spi
    [v11,2/2] spi: loongson: add bus driver for the loongson spi controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


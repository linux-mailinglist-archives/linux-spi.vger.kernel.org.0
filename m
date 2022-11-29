Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934D563BE4C
	for <lists+linux-spi@lfdr.de>; Tue, 29 Nov 2022 11:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiK2K41 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Nov 2022 05:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiK2K4X (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Nov 2022 05:56:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50B45F86D
        for <linux-spi@vger.kernel.org>; Tue, 29 Nov 2022 02:56:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F08561671
        for <linux-spi@vger.kernel.org>; Tue, 29 Nov 2022 10:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98D74C433C1;
        Tue, 29 Nov 2022 10:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669719381;
        bh=gU89fCoy4AVaxBkn/9TshVO2YFg1PilMK7VW70FMlG0=;
        h=Subject:From:Date:To:From;
        b=i2rKN5JP1gdVIgQekp+DkZLlK3QU+ujVNPn3zS+xY30pN8NaSxUAE6G9Foz6O1XJA
         GSclwk36dXOegjb/yo10GF+v3Ivz+Zm1Yzr/9C/xTCuI7Wf+fkZtZ/rAqNvt3sfdL/
         bPlyF/afNZL8L/h8q2JJ+xS5oJkq2v6UKOnxnGYWOwprfT1+2lCPzOl8ixhv4L1Epj
         pEbgnLw8vyRTxrRsfiNjy4UiHkoseNb48i8Dg31tK/hJ/ryynQKEupiFOhZydanDb8
         9MwoZXOt+pei1NmIgT+KI8ZjhH7ERJnyuAgor9e+uuzwb2adAxFyNYoNTmPsaM7Sts
         sijhGgOJLE7ug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E2B0C395EC;
        Tue, 29 Nov 2022 10:56:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166971938151.22569.3092261387272664438.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 29 Nov 2022 10:56:21 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] nuvoton,wpcm450-fiu binding example fixes (2022-11-29T10:22:24)
  Superseding: [v1] nuvoton,wpcm450-fiu binding example fixes (2022-11-28T21:49:28):
    [1/2] spi: dt-bindings: nuvoton,wpcm450-fiu: Fix error in example (bogus include)
    [2/2] spi: dt-bindings: nuvoton,wpcm450-fiu: Fix warning in example (missing reg property)


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


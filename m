Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21CD50C0EA
	for <lists+linux-spi@lfdr.de>; Fri, 22 Apr 2022 23:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiDVVLO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 Apr 2022 17:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiDVVLN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 Apr 2022 17:11:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8132A36C902
        for <linux-spi@vger.kernel.org>; Fri, 22 Apr 2022 13:06:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FD9061CE0
        for <linux-spi@vger.kernel.org>; Fri, 22 Apr 2022 19:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91ECBC385A0;
        Fri, 22 Apr 2022 19:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650657387;
        bh=dYIV8VTrFxakzgFtlwIxrOQH7w5DmwGrb1eh6Ubcu0s=;
        h=Subject:From:Date:To:From;
        b=u9tvVYnOWdAk86Q0p/TZNvO8QjnjFleOxOJhgbza5Y2jcOPro/bB92gW6jyzbnJct
         /JQDo3I+mvSGTUZGJ3KXwjTr3rDfJ5C8n5mUovJYF/eyPzVaZRNVNtCx+E3KoYaA2D
         6luGzGsrCHmT0DIgNXInnXqT9knW/axHmQdjH2DiXXGUuNFmusr9gbYSq3o/kJoewa
         Jr7QkUpVVPMTeFFs16obLLDsYq6R8LHQHXAwGUJpmX67M0A/RsCub8Wu3w55NIy6dL
         YZ29B301tZ9QtcrlBMFh+T7q+z5IaCUAEOQL5tdqL4h0IeUJvkmmbwHQC8NB5JqpR2
         qDmwnnaGsq5Kg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62354E85D90;
        Fri, 22 Apr 2022 19:56:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165065738727.13514.13635245301628090695.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 22 Apr 2022 19:56:27 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Improve SPI support for Ingenic SoCs. (2022-04-22T19:09:42)
  Superseding: [v1] Improve SPI support for Ingenic SoCs. (2022-04-15T14:22:08):
    [1/3] SPI: Ingenic: Add support for use GPIO as chip select line.
    [2/3] dt-bindings: SPI: Add bindings for new Ingenic SoCs.
    [3/3] SPI: Ingenic: Add support for new Ingenic SoCs.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


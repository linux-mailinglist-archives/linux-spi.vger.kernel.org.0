Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA47F5E61D1
	for <lists+linux-spi@lfdr.de>; Thu, 22 Sep 2022 13:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiIVL45 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Sep 2022 07:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiIVL4y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Sep 2022 07:56:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028C2A61DE
        for <linux-spi@vger.kernel.org>; Thu, 22 Sep 2022 04:56:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E9FEB81F1E
        for <linux-spi@vger.kernel.org>; Thu, 22 Sep 2022 11:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C659C433C1;
        Thu, 22 Sep 2022 11:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663847810;
        bh=WYcbu7zJQ23nByhECAMuijwfIuMrwPoL9L1cHe8HYPE=;
        h=Subject:From:Date:To:From;
        b=RDXxB468vgMkeRk3QuUHj2zSFThJl778mBndUOMwE6Ik3zDJy6N5W0vsIaZFHKYtt
         bml8M7VrYYtFCSS2smOKQNl3MregTx6EtNbjQzwsvUWhLlyOPaWWIrg25PZfhFybEa
         vqNw2R8ouyhuOxdoTDA8qZWaMXbMifhwKX4ZnK/VxqwGUdIois860UNBLvY6i2iSbG
         +shZpXOiRH54m6+rV7NHZRgANbXW24/0aUrvBXORW2bTejEStgWD11BoGZHFg+kjf2
         qWUtdcOw7fOWZ+j95BuF/if/TvoaGxCKAZid/6VMaB2Y3irgxJN7ODnbWLwU15LvUA
         3zRydixyAabkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35ABEE21ED1;
        Thu, 22 Sep 2022 11:56:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166384781012.19062.2697004871804946683.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 22 Sep 2022 11:56:50 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] Make atmel serial driver aware of GCLK (2022-09-22T11:33:38)
  Superseding: [v4] Make atmel serial driver aware of GCLK (2022-09-19T15:08:38):
    [v4,1/9] dt-bindings: mfd: atmel,sama5d2-flexcom: Add SPI child node ref binding
    [v4,2/9] dt-bindings: serial: atmel,at91-usart: convert to json-schema
    [v4,3/9] dt-bindings: serial: atmel,at91-usart: Add SAM9260 compatibles to SAM9X60
    [v4,4/9] dt-bindings: mfd: atmel,sama5d2-flexcom: Add USART child node ref binding
    [v4,5/9] dt-bindings: serial: atmel,at91-usart: Add gclk as a possible USART clock
    [v4,6/9] tty: serial: atmel: Define GCLK as USART baudrate source clock
    [v4,7/9] tty: serial: atmel: Define BRSRCCK bitmask of UART IP's Mode Register
    [v4,8/9] tty: serial: atmel: Only divide Clock Divisor if the IP is USART
    [v4,9/9] tty: serial: atmel: Make the driver aware of the existence of GCLK


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


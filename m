Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6BA7BD3E5
	for <lists+linux-spi@lfdr.de>; Mon,  9 Oct 2023 08:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbjJIG4Z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Oct 2023 02:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbjJIG4Z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Oct 2023 02:56:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A30A4
        for <linux-spi@vger.kernel.org>; Sun,  8 Oct 2023 23:56:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01414C433C8;
        Mon,  9 Oct 2023 06:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696834584;
        bh=HkqH25JoMROarWzmh0qBGkay3SgqeF/UT/Xs9g2/bG0=;
        h=Subject:From:Date:To:From;
        b=os4B5Ebi4DYiaoFVI9hUg8ebf2OoV2jg/2yPv/NCB0FVnLb1cDmkWp1iThALQhNYw
         M51gTRqNm+apjimmlGWbbYe+kMgWfWq0+IiKfi1BnKNqT3LZKR3dgTs+OUTHKx7ppE
         GcjZ1ttIRChzIoMnZxAeb0Loym9hAPAaLbVg0q8As2n/TJ1bBHSmbXr1ijbP9Fgu+y
         FTymqQ0ORCRNzmqxZbGr7HTRcJZV7Zh/IE3g9IRmPXE03GrCIzTeby/jMUBygXAmv+
         53h1f+XcSMUaLuk5AN2SoVrp8bHLfV/dLLgm4EBhx5Pku+Qh6rLFlayJJHuBKNTzRu
         HMAgR2QY6gq8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6633E0009B;
        Mon,  9 Oct 2023 06:56:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169683458387.29163.17633289673819969793.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 09 Oct 2023 06:56:23 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v20] Add Intel LJCA device driver (2023-10-09T06:33:21)
  Superseding: [v19] Add Intel LJCA device driver (2023-09-16T18:53:34):
    [v19,1/4] usb: Add support for Intel LJCA device
    [v19,2/4] i2c: Add support for Intel LJCA USB I2C driver
    [v19,3/4] spi: Add support for Intel LJCA USB SPI driver
    [v19,4/4] gpio: update Intel LJCA USB GPIO driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


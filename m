Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DD45E99EF
	for <lists+linux-spi@lfdr.de>; Mon, 26 Sep 2022 08:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiIZG4w (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Sep 2022 02:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbiIZG4v (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 26 Sep 2022 02:56:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9212423BEA
        for <linux-spi@vger.kernel.org>; Sun, 25 Sep 2022 23:56:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E708B818EC
        for <linux-spi@vger.kernel.org>; Mon, 26 Sep 2022 06:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 069CBC433D6;
        Mon, 26 Sep 2022 06:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664175408;
        bh=RybmKPwo6zg1KO0T4lQ5DlD7YGJqQ8VO16Y1xI87vMk=;
        h=Subject:From:Date:To:From;
        b=MA5Jw9U3i/gfkpyZLOHQACtADGZIlZp1ngyN01MqB5/16qGqIQIcZPZehF8K29Mq2
         xBG4B2oTcTGDqCrZ0s2rd150B9lFMp2AX/vkywFh8Lo2MVK/8Bk3C+Qo5moCJ3JYxy
         aVgcqsLVsW8OjKwNVLhUNMc+JeIGWolEpI02aJ4Bsc+Itg93NHoY2CZVUvp12TT9LM
         Jo0Sfs0oCyBWOuI0Nb1QzKiImeg4DLf1/ky3lF7LCKL0T7egPn8Ozc4b6u/GkYS+uy
         aFY7MA3Farroi7J8UfXAofv8NE1pUIZNzngSpy8yXOcHUjypntUhmHBK1ixH/JyTm6
         BnkYUlL7il20Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D691DC04E59;
        Mon, 26 Sep 2022 06:56:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166417540779.9190.5524175038136397604.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 26 Sep 2022 06:56:47 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: spi-zyqnmp-gqspi: Add tap delay and Versal platform support (2022-09-26T06:33:20)
  Superseding: [v2] spi: spi-zyqnmp-gqspi: Add tap delay and Versal platform support (2022-09-15T12:07:43):
    [v2,1/7] spi: spi-zynqmp-gqspi: Fix kernel-doc warnings
    [v2,2/7] spi: spi-zynqmp-gqspi: Set CPOL and CPHA during hardware init
    [v2,3/7] spi: spi-zynqmp-gqspi: Avoid setting baud rate multiple times for same SPI frequency
    [v2,4/7] firmware: xilinx: Add qspi firmware interface
    [v2,5/7] spi: spi-zynqmp-gqspi: Add tap delay support for ZynqMP GQSPI Controller
    [v2,6/7] dt-bindings: spi: spi-zynqmp-qspi: Add support for Xilinx Versal QSPI
    [v2,7/7] spi: spi-zynqmp-gqspi: Add tap delay support for GQSPI controller on Versal platform
  Superseding: [v3] spi: spi-zyqnmp-gqspi: Add tap delay and Versal platform support (2022-09-25T18:07:33):
    [v3,1/7] spi: spi-zynqmp-gqspi: Fix kernel-doc warnings
    [v3,2/7] spi: spi-zynqmp-gqspi: Set CPOL and CPHA during hardware init
    [v3,3/7] spi: spi-zynqmp-gqspi: Avoid setting baud rate multiple times for same SPI frequency


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


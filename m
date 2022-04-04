Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7724D4F0FB0
	for <lists+linux-spi@lfdr.de>; Mon,  4 Apr 2022 08:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359645AbiDDG6Y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Apr 2022 02:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiDDG6Y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Apr 2022 02:58:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B445137BF5
        for <linux-spi@vger.kernel.org>; Sun,  3 Apr 2022 23:56:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 606A5B80EA0
        for <linux-spi@vger.kernel.org>; Mon,  4 Apr 2022 06:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2334C340EE;
        Mon,  4 Apr 2022 06:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649055386;
        bh=wTUzp2pFe5N1jaGJCjq4cb/gcleweAto+OKaeQFl72Q=;
        h=Subject:From:Date:To:From;
        b=j/BLam2aCaV8enkA+cFDUZvI6THTryNl3LIbG+FV1RwRUsM69JKhKagU0Xnnu5GG5
         XnAZz47MqjMbw+op/Zqco1BYig3Nwlgi37G6Reyg2uoAmn0NlZQZr2t4E4i8JH+k7K
         4HgSr+BvBJmgRpIZlFEwJmDa+j1fc9lHaqeGHftYb2rKt7yvB20WYltDw+8HnMTVne
         /x3a7MG+qmwQVJT+4WJwaPSSKY4PSIJyvX1fxZ5lS019arDv3UyXWYKyFIsFJRNvY3
         ITliyifK5UwjJFxhG2du4S12S74/garGbsKedh/zKE3RDSbpDNsI0Hzr0hem2dtuhz
         /vdkEj9Z8Fo8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4041E85AE7;
        Mon,  4 Apr 2022 06:56:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164905538586.25319.11676462951857580746.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 04 Apr 2022 06:56:25 +0000
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

Latest series: [v3] spi: dt-bindings: qcom,spi-geni-qcom: convert to dtschema (2022-04-04T06:40:16)
  Superseding: [v2] spi: dt-bindings: qcom,spi-geni-qcom: convert to dtschema (2022-03-31T16:02:48):
    [v2,1/2] spi: dt-bindings: qcom,spi-geni-qcom: convert to dtschema
    [v2,2/2] dt-bindings: qcom: qcom,geni-se: refer to dtschema for SPI


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


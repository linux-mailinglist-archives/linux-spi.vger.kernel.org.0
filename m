Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BBD5B50C0
	for <lists+linux-spi@lfdr.de>; Sun, 11 Sep 2022 20:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiIKS4v (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 11 Sep 2022 14:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIKS4v (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 11 Sep 2022 14:56:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA8D1A046
        for <linux-spi@vger.kernel.org>; Sun, 11 Sep 2022 11:56:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B1796101C
        for <linux-spi@vger.kernel.org>; Sun, 11 Sep 2022 18:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C068C433B5;
        Sun, 11 Sep 2022 18:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662922609;
        bh=/AApr7lvedQUsHzpk7yW7TNXKHf4gZiNNmPkzOxqmQk=;
        h=Subject:From:Date:To:From;
        b=jSdHkLjY89fHFZqG6Dv2ELsjzWWBbKqOxTrkJ37UylNocXAVZ5HVAqiCQ+T0oF0a+
         zMYA0sYBJjNhUtQ7ka10CtJyK382C4gH5IFrazhyhd9ikUemHWNlS/KqV+Xdh9FJnA
         SpvCAL02yQJwaHo9RglHyt4uVXPk5i8lvW8MD6c9Zq/T1Rsj3/eel78bOVaZJobfVR
         iLCx8NAkcoo7aU14Y7OCgq9bfntGOhFJeOLEMG7lOnJxg/la00uelXRCqsNris+PZ4
         fN//2oBTqxMHCX+eZXkpp4MWmwOPopMASTiILDM5i1+Ib7pdXiDwk1BXi8sFpjdMXs
         65/Dk84hEETQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F861C04E59;
        Sun, 11 Sep 2022 18:56:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166292260913.7572.13148325817711950047.git-patchwork-housekeeping@kernel.org>
Date:   Sun, 11 Sep 2022 18:56:49 +0000
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

Latest series: [v2] dt-bindings: spi: rockchip: add power-domains property (2022-09-11T17:58:39)
  Superseding: [v1] dt-bindings: spi: rockchip: add power-domains property (2022-09-10T18:56:28):
    [v1] dt-bindings: spi: rockchip: add power-domains property


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


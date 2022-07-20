Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E59557BC1F
	for <lists+linux-spi@lfdr.de>; Wed, 20 Jul 2022 18:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiGTQ4t (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Jul 2022 12:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236846AbiGTQ4n (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Jul 2022 12:56:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA04E6A9C7
        for <linux-spi@vger.kernel.org>; Wed, 20 Jul 2022 09:56:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DC8C9CE2205
        for <linux-spi@vger.kernel.org>; Wed, 20 Jul 2022 16:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1563FC341C7;
        Wed, 20 Jul 2022 16:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658336199;
        bh=GDnt2a1ykufSZASv8SsbVxxvQuIwJcxO0yAtUum02RY=;
        h=Subject:From:Date:To:From;
        b=hiXxW8BTzU3wPDGvat4UQFuTRTO3FpSFnDQPHLunMUstuXCCziBL14v/cucKI+Q+X
         7PIZa3PXkZj7DwnubRpQpIH7DTHSgjswYCBdtNsB71Yq2KqIP381ComDXhVobUSJkt
         P+XyHOSNLH1IgY2eXIUU9mO9nbDqr/8xrT25xoqEq3K5qbr4E5/a0YJ+Fsxyit2ubT
         KPiYqy94EgSHXNJqm/Pie3YebpdrGIxzLUhOd/N4lHhbrgcSvLrJTGQzY44DV8jkFI
         oG2VbZ8j4V/g6iNkgiaGz7uvDEKZCFX1Myjc0uFUl+vIgBxY1v45tur4x7amqHsTwv
         cnEwNF1NtWqwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EDD89D9DDDD;
        Wed, 20 Jul 2022 16:56:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165833619897.27329.6965341734350887803.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 20 Jul 2022 16:56:38 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: dt-bindings: qcom,spi-geni-qcom: allow three interconnects (2022-07-20T16:38:41)
  Superseding: [v2] spi: dt-bindings: qcom,spi-geni-qcom: allow three interconnects (2022-05-05T06:52:33):
    [qcom,v2] spi: dt-bindings: qcom,spi-geni-qcom: allow three interconnects


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


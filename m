Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB7574648B
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jul 2023 22:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjGCU40 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 Jul 2023 16:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGCU40 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 3 Jul 2023 16:56:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4DEE54
        for <linux-spi@vger.kernel.org>; Mon,  3 Jul 2023 13:56:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E60FB61019
        for <linux-spi@vger.kernel.org>; Mon,  3 Jul 2023 20:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56D8CC433C8;
        Mon,  3 Jul 2023 20:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688417784;
        bh=4FPBMrvmHdLdRVyj5+iKVYFo0F04LIndRgk/U9REJa4=;
        h=Subject:From:Date:To:From;
        b=ThTDDvGgV9rOj+D9xOvWhmN5USlJqauwZapR0JYGHKXHm5duQTVffE7x1OjVSgfTr
         GnWeD6dFZqsJf2ZODoBIgnG8BfqHmoB8mPevTE4/ktifrEH020GKBExwdMomOftWL0
         2qJ+DBiTMXb+2ND1VkCXMKm/XtRZKlt9qy/jBgdOd+bIzap2A2CHh0p+MvDmZhMn4Q
         24wJUjKGUL6PPu4xm0Jen8ZBdatlVUBwyPnhuLzZjIUOQ1QJlsS7O1KP9IEhkWIZjC
         ipYtX81yn2huehzBi0U3iNlkfyEcc15qFAkDA2idaQTeOiunf8d+BpVeEn1ODD6ik4
         28P6oV5AhiQWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 397A7C04E32;
        Mon,  3 Jul 2023 20:56:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168841778423.22905.6928908777190272605.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 03 Jul 2023 20:56:24 +0000
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

Latest series: [v2] Add interconnects to QUPs on SM8250 (2023-07-03T20:15:24)
  Superseding: [v1] Add interconnects to QUPs on SM8250 (2023-07-03T13:31:09):
    [1/5] dt-bindings: spi: spi-geni-qcom: Allow no qup-core icc path
    [2/5] dt-bindings: serial: geni-qcom: Allow no qup-core icc path
    [3/5] dt-bindings: i2c: qcom,i2c-geni: Allow no qup-core icc path
    [4/5] soc: qcom: geni-se: Allow any combination of icc paths
    [5/5] arm64: dts: qcom: sm8250: Add interconnects and power-domains to QUPs


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F43716C88
	for <lists+linux-spi@lfdr.de>; Tue, 30 May 2023 20:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbjE3SaX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 May 2023 14:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbjE3SaW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 May 2023 14:30:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF196A7
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 11:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 665A3613B3
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 18:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD132C433EF;
        Tue, 30 May 2023 18:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685471420;
        bh=uuMSUMW8r26goxCRXAfMf3YjS81TNpz2ctrf+lnC8iQ=;
        h=Subject:From:Date:To:From;
        b=JYZbn/cs0vo/Xh5SHM5XYpb8B9plSrF7oyIActfRPglEGxbQ5P+AM795SGoruW/L3
         zdLkf5L8/xHAymnKDILL/akL6oMSdIn7bR/EPIgBzlnFNlSg3ZAkxs3sJtCrzFx414
         ef7MLJx0nBLGzqoMlx1ffseRydxrOdjo35fRRd3+57UCdDTOLcJxbr/58v5E88gAwf
         R/iwlPvpWvproVPG+fY5hafnylDBJYQA3W+BYMJ+JfzpX1VbJxCodIEhg2oIsM1IIv
         EYkH9PDbwZH4Mi/2lfQ1NAVZAvKRkwrHSGlpNHy7b7oucixe7l/fDdnbvvKGCEyMPM
         GUqAqD1L6zrbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8989E52BF5;
        Tue, 30 May 2023 18:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168547142059.12613.16493290474502548107.git-patchwork-summary@kernel.org>
Date:   Tue, 30 May 2023 18:30:20 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: dt-bindings: restrict node name suffixes
  Submitter: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=752283
  Lore link: https://lore.kernel.org/r/20230530144851.92059-1-krzysztof.kozlowski@linaro.org
    Patches: [1/7] dt-bindings: phy: intel,combo-phy: restrict node name suffixes
             [5/7] spi: dt-bindings: restrict node name suffixes


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



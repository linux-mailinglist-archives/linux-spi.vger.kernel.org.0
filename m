Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929DF779765
	for <lists+linux-spi@lfdr.de>; Fri, 11 Aug 2023 20:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjHKS5B (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Aug 2023 14:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236617AbjHKS5A (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Aug 2023 14:57:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DED6A8
        for <linux-spi@vger.kernel.org>; Fri, 11 Aug 2023 11:57:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2286A6614B
        for <linux-spi@vger.kernel.org>; Fri, 11 Aug 2023 18:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 865A9C433C8;
        Fri, 11 Aug 2023 18:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691780219;
        bh=ITFARf/q4OekMeUxWVPoG0gxs4/jXTIIG6bo6xO25hI=;
        h=Subject:From:Date:To:From;
        b=B8zoo0JZk8/MhHtFccR9ZACVhHYcW34IoLmxR29IkDN536IZ4PjXkKFDo6NOQTQEl
         TuEFmz8kZE7fRvwvAINnzKQjZpmHIZxo5E3F0u6tDB5l9unn3HetpbwnF3p4c6IGO1
         K2d2VXm3lfWfrf0Td5NE02yXPxK+ePf/GTho3eP3Q/kDhyvt2lbZfuNK4JfXy9vWDo
         TkqMQOrVEC2m11nEH3AG5S2NaUOJ6ENqnhDsWHddfUcq+hAzgnLPqM1P+1EngsqtbZ
         I0CKEIYLey4ZY7k5Qvh1wpZy9/zUTXmAhYIRIitNmBlM2NUKl+eXcqOBC94gP250+B
         MscYvb/DUW7fA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B95AC3274B;
        Fri, 11 Aug 2023 18:56:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169178021943.12546.1733011767527661054.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 11 Aug 2023 18:56:59 +0000
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

Latest series: [v15] Support AMD Pensando Elba SoC (2023-08-11T18:05:14)
  Superseding: [v14] Support AMD Pensando Elba SoC (2023-05-15T18:15:58):
    [v14,1/8] dt-bindings: arm: add AMD Pensando boards
    [v14,2/8] dt-bindings: spi: cdns: Add compatible for AMD Pensando Elba SoC
    [v14,3/8] dt-bindings: soc: amd: amd,pensando-elba-ctrl: Add Pensando SoC Controller
    [v14,4/8] MAINTAINERS: Add entry for AMD PENSANDO
    [v14,5/8] arm64: Add config for AMD Pensando SoC platforms
    [v14,6/8] arm64: dts: Add AMD Pensando Elba SoC support
    [v14,7/8] spi: cadence-quadspi: Add compatible for AMD Pensando Elba SoC
    [v14,8/8] soc: amd: Add support for AMD Pensando SoC Controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


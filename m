Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC76B705004
	for <lists+linux-spi@lfdr.de>; Tue, 16 May 2023 15:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjEPN4p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 May 2023 09:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjEPN4o (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 May 2023 09:56:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9A7D2
        for <linux-spi@vger.kernel.org>; Tue, 16 May 2023 06:56:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3832D6168D
        for <linux-spi@vger.kernel.org>; Tue, 16 May 2023 13:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1224C433EF;
        Tue, 16 May 2023 13:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684245402;
        bh=IEqA+scX8aXb8J76qiSA/57BIRDXk9s1/8OXx0bVbeY=;
        h=Subject:From:Date:To:From;
        b=H8SYoEVWjcKZtY8anhT9AEiUO+zgz1ZSFC0wslkFTO9U6ZRYiFa/r1OfzIGoAXdhz
         9K/A3TbmI04wrxUM5J4l9zKhCoAIzXthCe2NT27Xysdkspjmek/wgax7OPEPTYPuZ4
         6SqJRAYxT80K+dCCwgBB8W8oR9EIux1DrR7+jp3XOC1z7ekjkbyDK2+7Q8BFLDeHXD
         wDO+iNgqBMDCkIn6O6CPARJ56Kr7O94+aOQGunJ0rmmxKEgLo6HJNa9l8rV0gDm0sO
         S4yJmJSKjQ2Ge+lApWy3cqD39TKRicICXTX2Fuhe2jVHZXBZT7Z5KPaRkBUPU4uTQH
         Sgu/hJ56x4noQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D2FEE5421E;
        Tue, 16 May 2023 13:56:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168424540242.28634.247267478825903434.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 16 May 2023 13:56:42 +0000
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

Latest series: [v10] spi: loongson: add bus driver for the loongson spi (2023-05-16T13:12:24)
  Superseding: [v9] spi: loongson: add bus driver for the loongson spi (2023-04-26T07:10:45):
    [v9,1/2] dt-bindings: spi: add loongson spi
    [v9,2/2] spi: loongson: add bus driver for the loongson spi controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


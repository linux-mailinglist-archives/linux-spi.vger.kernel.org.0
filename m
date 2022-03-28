Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B75E4EA0DC
	for <lists+linux-spi@lfdr.de>; Mon, 28 Mar 2022 21:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343945AbiC1T7A (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Mar 2022 15:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344193AbiC1T6G (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 28 Mar 2022 15:58:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65905B3F5
        for <linux-spi@vger.kernel.org>; Mon, 28 Mar 2022 12:56:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62C506140B
        for <linux-spi@vger.kernel.org>; Mon, 28 Mar 2022 19:56:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1B44C340F0;
        Mon, 28 Mar 2022 19:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648497384;
        bh=ugiFHGItx5T7NdQRJ0gvYJBIoyogceohXHdGFzTOZho=;
        h=Subject:From:Date:To:From;
        b=dfOS0LF7SmEd55tnretLz2ttBGiA5Ts5E9NQUXY5uIqp3PdhZFtM42v7QTNXzE2F1
         EyPQci1fHX/1ptcqH+nmv7qbxGR+dJaTa89TsnYAJJkwJR54xXY2d/6+XgyRzkPs2e
         /AbCMD6ONUpkL/z7Z+R2rW+n2kmAv2r8lAZ+BwgqiC6W7FvIbiVEBjC2g+HFnK3ti5
         l2JnoE/8jjjyrwCrqvgtcuSDAG6F4qzSw2zuUGEE+Ec4cflPmZoUHxe15pL6MWoS/v
         QlP/VNQ5mYv/EL3Ldkicew9gdbUVKLDcdKRqf24UP/HkPZTceXEFiEnG1rpH1l7tZU
         da0j4Nppp691A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A30FFE7BB0B;
        Mon, 28 Mar 2022 19:56:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164849738466.12223.3388557805139558886.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 28 Mar 2022 19:56:24 +0000
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

Latest series: [v2] dt-bindings: spi: qcom-qspi: Add minItems to interconnect-names (2022-03-28T19:20:06)
  Superseding: [v1] dt-bindings: spi: qcom-qspi: Add minItems to interconnect-names (2022-03-26T21:21:34):
    dt-bindings: spi: qcom-qspi: Add minItems to interconnect-names


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


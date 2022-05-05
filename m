Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25BF51B849
	for <lists+linux-spi@lfdr.de>; Thu,  5 May 2022 08:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbiEEHAL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 May 2022 03:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236957AbiEEHAJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 May 2022 03:00:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11930443DB
        for <linux-spi@vger.kernel.org>; Wed,  4 May 2022 23:56:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E2DB61B07
        for <linux-spi@vger.kernel.org>; Thu,  5 May 2022 06:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03A0EC385A8;
        Thu,  5 May 2022 06:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651733790;
        bh=+U154OZyrTVjk7sUY6NI8oUBGBpQmxmudqBkvXFGIoo=;
        h=Subject:From:Date:To:From;
        b=arAXrz4kLYZfRJFntY2Ga/umtUvnzngSfgWDI0rCph8NksU1sm1sfRvuXSWQxxl7M
         vcTCcnAAt/rRToo+lTMzeg/FN2AzmWEcNrJNmFj7SePvoTbHqW+ejifzEhZPBj6AS9
         hmgSh2NX+e4wSsJauXGXMLlxWluNf3O1xfK5mUc1kPhXIijP9kkni7J3Ld7I6RgNQ+
         CvFGrJWey9ecgg2DaIyb8YJVgY996oa/lLBjSk8Sen6Zjeaap2b01NcP/8StBG4Wf2
         9TGrUpZxKDFpbjGnB5+lTVBXoKfOkJAEa9iAfOJ3YDav3g24hPt/7BrWHUydgftPic
         x4JpsI2tEGjUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB001F03848;
        Thu,  5 May 2022 06:56:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165173378989.17998.3325466345134456345.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 05 May 2022 06:56:29 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: dt-bindings: qcom,spi-geni-qcom: allow three interconnects (2022-05-05T06:52:33)
  Superseding: [v1] spi: dt-bindings: qcom,spi-geni-qcom: allow three interconnects (2022-05-04T12:51:19):
    spi: dt-bindings: qcom,spi-geni-qcom: allow three interconnects


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


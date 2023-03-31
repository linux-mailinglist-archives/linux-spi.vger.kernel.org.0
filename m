Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910FB6D162A
	for <lists+linux-spi@lfdr.de>; Fri, 31 Mar 2023 05:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCaD4o (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Mar 2023 23:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjCaD4o (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 30 Mar 2023 23:56:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D58CBB9D
        for <linux-spi@vger.kernel.org>; Thu, 30 Mar 2023 20:56:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F80DB82BA7
        for <linux-spi@vger.kernel.org>; Fri, 31 Mar 2023 03:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36D56C4339B;
        Fri, 31 Mar 2023 03:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680235000;
        bh=8zLSqOz8xnDl80V2yfZDwXEAyM2XhTkKps28KaYmyhc=;
        h=Subject:From:Date:To:From;
        b=gbTg/WJJqX54YDWA+YahhT3v05Yp7PBapduzD2Qk9BFaUDrXTsnPN1tgnBINvYAIt
         7XG5+IsAcxeeawn7m7S28LUkKhvVXlXjSUY/mVztKvLungTe5QxcHAffkCZhp742Z0
         bmgVBuibzZSMswugHrdpRZ1NdDF1vzALTJravFZigcPC/WRAXtBG1EoCySBXRXICBB
         b6QYohYN8BJf3FAcsfXw6J6b1Jiap9w9bl3GeHc3Ko0P2LKGKEvfV/C/0pFaE8vB3a
         McxGuUn9RSLfNq7M2iFr2CI6Xx5wnMbV8UqNnpymOOKavgJzKLTxQjy72TVmzn/Xha
         xIPH0aThXQU0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0DFA9C43161;
        Fri, 31 Mar 2023 03:56:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168023499998.32562.12845799095137351326.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 31 Mar 2023 03:56:39 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] spi: loongson: add bus driver for the loongson spi (2023-03-31T03:29:07)
  Superseding: [v4] spi: loongson: add bus driver for the loongson spi (2023-03-28T11:22:09):
    [v4,1/2] dt-bindings: spi: add loongson spi
    [v4,2/2] spi: loongson: add bus driver for the loongson spi controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146D16CBE39
	for <lists+linux-spi@lfdr.de>; Tue, 28 Mar 2023 13:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjC1L4s (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Mar 2023 07:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbjC1L4p (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Mar 2023 07:56:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D6E8A45
        for <linux-spi@vger.kernel.org>; Tue, 28 Mar 2023 04:56:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26611616DF
        for <linux-spi@vger.kernel.org>; Tue, 28 Mar 2023 11:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86B75C433D2;
        Tue, 28 Mar 2023 11:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680004599;
        bh=zZwAyKLNi+xOgpxSDlWONxffTtC2dwSChTDb8El1s5Y=;
        h=Subject:From:Date:To:From;
        b=T8b609OnPC1Y7OtCENaP5bPa6yA0uW1z5v02TIfmwF19iPaNLprJgNmCJ41FtzMJa
         B3xLra/zk+VOSpmW5P2mET5wajbSLa/36or6n7YgfvIqxAV76tnpX4/nsub+o1NBfd
         gW9XPDgoutSGvMovCwzi+JeL5rd6vxuJCBD9pQCIgxNVCnnTM4PtfiMrwWoa2ZOYxp
         emQ+feo8f+GfBkCXfOm3wW4d6MuSH+O/n7vTWRxavf6wfdMvamu1/NHIhhphfqj04o
         ni9hcnwpnhdxlDsfaq8bkBY6nV6Cvhi8Q7P5kox9FGxTeL9RCATKrv6H+iyoX5GMbM
         qBYipqr0lAMzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70D50E21EE2;
        Tue, 28 Mar 2023 11:56:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168000459945.25691.13197236424063518164.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 28 Mar 2023 11:56:39 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] spi: loongson: add bus driver for the loongson spi (2023-03-28T11:22:09)
  Superseding: [v3] spi: loongson: add bus driver for the loongson spi (2023-03-24T06:33:15):
    [v3,1/2] dt-bindings: spi: add loongson spi
    [v3,2/2] spi: loongson: add bus driver for the loongson spi controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


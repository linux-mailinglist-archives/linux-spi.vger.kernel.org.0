Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC9B6F53CB
	for <lists+linux-spi@lfdr.de>; Wed,  3 May 2023 10:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjECI4q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 May 2023 04:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjECI4p (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 3 May 2023 04:56:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B291AE6A
        for <linux-spi@vger.kernel.org>; Wed,  3 May 2023 01:56:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D244628C4
        for <linux-spi@vger.kernel.org>; Wed,  3 May 2023 08:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2883C433EF;
        Wed,  3 May 2023 08:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683104203;
        bh=68Pxymm/XO9Fv+IUmIEfh4ualG0Y809N+H4RXE5YdqY=;
        h=Subject:From:Date:To:From;
        b=oJEkPbSm/9gtxfSrJxssF/CYEDXXaAnYfCr9P8O3Iwz6dUVp2z9kFKX5wbEfw32NL
         3Z0rJeftWTJ1ubuE7P7gcZzSvHx/jxvEAMWoYJ8Li6ie/POEp/E2SkrdMORNxekvXZ
         LS0WiD0i0JZ1hj/vL7kmqvH2stG9xi94HR2GL8QbsMFXPcOtIOOHJ6QBLCYPU0VXK8
         b+I6V22nZqMCWLMEWzbDj5X0/hdQ1fY/o9KypnrOaedDufP3Rotd7w0sraMxuAP9Dc
         citWXbGEvLllZxFHPQFneGqhGbLhYXddCxie11i/XYm3T/ckJsMAJ8BRJyamX3dP9C
         8cPQQbErgvRuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7BA39E5FFC9;
        Wed,  3 May 2023 08:56:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168310420345.9909.14363827276545352826.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 03 May 2023 08:56:43 +0000
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

Latest series: [v2] dt-bindings: spi: zynqmp-qspi: Add power-domains and iommus properties (2023-05-03T08:20:36)
  Superseding: [v1] dt-bindings: spi: zynqmp-qspi: Add power-domains and iommus properties (2023-05-02T13:47:42):
    dt-bindings: spi: zynqmp-qspi: Add power-domains and iommus properties


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


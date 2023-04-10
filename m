Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8B46DCB3C
	for <lists+linux-spi@lfdr.de>; Mon, 10 Apr 2023 20:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjDJS4l (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 Apr 2023 14:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDJS4k (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 10 Apr 2023 14:56:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9D2B8
        for <linux-spi@vger.kernel.org>; Mon, 10 Apr 2023 11:56:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D76D60E15
        for <linux-spi@vger.kernel.org>; Mon, 10 Apr 2023 18:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB048C433EF;
        Mon, 10 Apr 2023 18:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681152998;
        bh=z/59S2uCv4mYKzmE5bFp4qqMOf2Iv49su7gZAYkG4+o=;
        h=Subject:From:Date:To:From;
        b=tRBdZxNUcQNmpSZlwK9QwuGq0XWUOr6SSa7GW7/fE2jWJKEsCjmI9UU/1q7s0E+PS
         zP3r5hpsXxtbtXpe7cKcpreqFNqXsqDXMAJpyhwzHZJZvPFiudZZmBybtqQpX63zr5
         G1BY35769agacNaQw1qn/SQccw/XZl0fM9+EHrrNkZYftYYgWWyUVxf/hJLkBwEfmN
         cduSuNMM7qp4JXNxV15Zdj0t+tz/28QMowxyss7LRas1Xqbrt0wF/ps4hy+KrOCDAz
         ckWQmiTnyUnb0MfpxYVMr9IKloIlcfkG6OdEKz+p7HxL5bTzpGLaSGS+4u+Jr5Iioq
         rBSg/DZKnmSfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 832B2E21EEE;
        Mon, 10 Apr 2023 18:56:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168115299847.28459.53582434041162837.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 10 Apr 2023 18:56:38 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v13] Support AMD Pensando Elba SoC (2023-04-10T18:45:11)
  Superseding: [v12] Support AMD Pensando Elba SoC (2023-03-23T00:06:42):
    [v12,01/15] dt-bindings: arm: add AMD Pensando boards
    [v12,02/15] dt-bindings: mmc: cdns: Add AMD Pensando Elba SoC
    [v12,03/15] dt-bindings: spi: cdns: Add compatible for AMD Pensando Elba SoC
    [v12,04/15] dt-bindings: spi: dw: Add AMD Pensando Elba SoC SPI Controller
    [v12,05/15] dt-bindings: soc: amd: amd,pensando-elba-ctrl: Add Pensando SoC Controller
    [v12,06/15] MAINTAINERS: Add entry for AMD PENSANDO
    [v12,07/15] arm64: Add config for AMD Pensando SoC platforms
    [v12,08/15] arm64: dts: Add AMD Pensando Elba SoC support
    [v12,09/15] spi: cadence-quadspi: Add compatible for AMD Pensando Elba SoC
    [v12,10/15] spi: dw: Add support for AMD Pensando Elba SoC
    [v12,11/15] mmc: sdhci-cadence: Enable device specific override of writel()
    [v12,12/15] mmc: sdhci-cadence: Support device specific init during probe
    [v12,13/15] mmc: sdhci-cadence: Add AMD Pensando Elba SoC support
    [v12,14/15] mmc: sdhci-cadence: Support mmc hardware reset
    [v12,15/15] soc: amd: Add support for AMD Pensando SoC Controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


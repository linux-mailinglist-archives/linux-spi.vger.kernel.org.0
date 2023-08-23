Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C09784F7E
	for <lists+linux-spi@lfdr.de>; Wed, 23 Aug 2023 05:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjHWD46 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 23:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbjHWD44 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 23:56:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24576E50
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 20:56:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7D1161590
        for <linux-spi@vger.kernel.org>; Wed, 23 Aug 2023 03:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA94CC433C7;
        Wed, 23 Aug 2023 03:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692763012;
        bh=uvs9Oa9VuNxa0POCi1Ek+o3eWrRb0u/k0GobjSR3Ano=;
        h=Subject:From:Date:To:From;
        b=Kis4eLIKI9bAMqVtvgz/fMgouBSZxWEhiYNQtNMt9fMz5mL8ge7G4kz/+cFUt9qmW
         boAUZ1RyPqXWMXU5v7FpK20nfFP4WjpI7WtyJiKwmuXSX7rhE679ncxnDixkGk14jo
         h1eytsoqcGyiMxguSHrzyT0dND/mqyDM/uGTOGnxvC5LMr6PKU6tYN7mfSuaw0Soed
         LxtKqcmMG8j2YG4GR/2ek1LV3BT7VGI/eYheqlUwHPdl5WaztpARG9lbKCuFuWxe81
         xoszxix4yeh79FqxoBNea2WhXj8uRJO5/Qy0kNdjVMOtsLBU39Q4Yh1NGCxjv+KNc7
         e5ftrZJ3Dv/dQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BF464E4EAF7;
        Wed, 23 Aug 2023 03:56:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169276301277.31307.1807431102004392204.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 23 Aug 2023 03:56:52 +0000
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

Latest series: [v2] spi: switch to use modern name (part3) (2023-08-23T03:29:42)
  Superseding: [v1] spi: switch to use modern name (part3) (2023-08-10T08:29:43):
    [-next,01/21] spi: lm70llp: switch to use modern name
    [-next,02/21] spi: lp-8841: switch to use modern name
    [-next,03/21] spi: meson-spicc: switch to use modern name
    [-next,04/21] spi: meson-spifc: switch to use modern name
    [-next,05/21] spi: microchip-core-qspi: switch to use modern name
    [-next,06/21] spi: microchip-core: switch to use modern name
    [-next,07/21] spi: mpc512x-psc: switch to use modern name
    [-next,08/21] spi: mpc52xx-psc: switch to use modern name
    [-next,09/21] spi: mpc52xx: switch to use modern name
    [-next,10/21] spi: mt65xx: switch to use modern name
    [-next,11/21] spi: mt7621: switch to use modern name
    [-next,12/21] spi: mtk-nor: switch to use modern name
    [-next,13/21] spi: mtk-snfi: switch to use modern name
    [-next,14/21] spi: mux: switch to use spi_alloc_host()
    [-next,15/21] spi: mxic: switch to use modern name
    [-next,16/21] spi: mxs: switch to use modern name
    [-next,17/21] spi: npcm-pspi: switch to use modern name
    [-next,18/21] spi: nxp-fspi: switch to use modern name
    [-next,19/21] spi: oc-tiny: switch to use modern name
    [-next,20/21] spi: omap-uwire: switch to use modern name
    [-next,21/21] spi: omap2-mcspi: switch to use modern name


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


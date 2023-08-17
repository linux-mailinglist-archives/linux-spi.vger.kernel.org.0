Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA87177F054
	for <lists+linux-spi@lfdr.de>; Thu, 17 Aug 2023 07:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244699AbjHQF5B (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Aug 2023 01:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348214AbjHQF4y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Aug 2023 01:56:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D452722
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 22:56:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2AB760B96
        for <linux-spi@vger.kernel.org>; Thu, 17 Aug 2023 05:56:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0888CC433C7;
        Thu, 17 Aug 2023 05:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692251812;
        bh=8JtgPxYApAGiO9eYakRmL52iJFzkJ/8JNlUB71uoJOo=;
        h=Subject:From:Date:To:From;
        b=WAsAjTbK3If92I9IrPcg69iBHXIDgzfL8iVsxgg9m3KIryomcAHPqCj/zkOrQ9QkK
         FfjggRHSe075MO//OKUDFTjVCik3G76pqBZ2wHfnnrIdgdxKq1fKFC0iS9LaiQi/m5
         Nl21tarJtZ2cseBLKMRlc/ehTykB8SNdVlxv/Wkax1fG7ozVOigHDgEZu7aQrOxDoQ
         y/XE96VP3ukaXHmjM20Svha0/v+CXJ4IQm/DZ/Cqz69uTt1oiQ5A63XvY2LN/AncY+
         X3OTYByR/TRXSB6R5NFVTapScPMCyC82PKGy2U3+fUDyp8ExgL+F5+tI8mhit8uJJI
         7BOms3JktAw4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DDCC2E1F65A;
        Thu, 17 Aug 2023 05:56:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169225181190.20211.2277268864896750366.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 17 Aug 2023 05:56:51 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: switch to use modern name (part4) (2023-08-17T05:03:09)
  Superseding: [v1] spi: switch to use modern name (part4) (2023-08-16T09:39:51):
    [-next,01/24] spi: orion: switch to use modern name
    [-next,02/24] spi: mchp-pci1xxxx: switch to use modern name
    [-next,03/24] spi: pic32-sqi: switch to use modern name
    [-next,04/24] spi: pic32: switch to use modern name
    [-next,05/24] spi: spl022: switch to use modern name
    [-next,06/24] spi: ppc4xx: switch to use modern name
    [-next,07/24] spi: pxa2xx: switch to use modern name
    [-next,08/24] spi: spi-qcom-qspi: switch to use modern name
    [-next,09/24] spi: qup: switch to use modern name
    [-next,10/24] spi: rb4xx: switch to use modern name
    [-next,11/24] spi: realtek-rtl: switch to use devm_spi_alloc_host()
    [-next,12/24] spi: rockchip-sfc: switch to use modern name
    [-next,13/24] spi: rockchip: switch to use modern name
    [-next,14/24] spi: rpc-if: switch to use devm_spi_alloc_host()
    [-next,15/24] spi: rspi: switch to use modern name
    [-next,16/24] spi: rzv2m-csi: switch to use modern name
    [-next,17/24] spi: s3c64xx: switch to use modern name
    [-next,18/24] spi: sc18is602: switch to use modern name
    [-next,19/24] spi: sh-hspi: switch to use modern name
    [-next,20/24] spi: sh-msiof: switch to use modern name
    [-next,21/24] spi: sh-sci: switch to use modern name
    [-next,22/24] spi: sh: switch to use modern name
    [-next,23/24] spi: sifive: switch to use modern name
    [-next,24/24] spi: spi-sn-f-ospi: switch to use modern name


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


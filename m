Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE83780928
	for <lists+linux-spi@lfdr.de>; Fri, 18 Aug 2023 11:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359469AbjHRJ50 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Aug 2023 05:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359573AbjHRJ5T (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Aug 2023 05:57:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F4C4205
        for <linux-spi@vger.kernel.org>; Fri, 18 Aug 2023 02:57:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D19A679CA
        for <linux-spi@vger.kernel.org>; Fri, 18 Aug 2023 09:57:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE103C433CB;
        Fri, 18 Aug 2023 09:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692352622;
        bh=xjxb9nJ7prGnpC5noRkiuC+lwG6adlYFMBCXtzDva+w=;
        h=Subject:From:Date:To:From;
        b=C6332cMMlaXfrT2bHg7QFQ5t5dqH7V40n2tfvfYwhW0sBHDrf6j4f7vReocYOAKvK
         8gnTfwKgvpkeEfRlRCHDk1cznib+nM/LYVWoIgqCe4PyU5izEwJv6aOeKOHy7Arw1p
         b3NRkENKnPo/B8vvAEkACIEBquG6kfoYYs271bxUU2jlacGnD23ml3PZQn94u/iUji
         YYiIAMTQvtf/VI6h2ekruwQOorTCHVzVNhylzs+0GN0BjY7jDhTu1duRNktYEMXPC5
         hOZT3l9LKOOB4OcGIYPToF3nNS9BJK+O8GWANgTnflE1PnONOE+edsCRvl6ADm8Hgi
         XMg5zuxyBIsLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F0E9E93B34;
        Fri, 18 Aug 2023 09:57:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169235262264.3366.13993306940229843838.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 18 Aug 2023 09:57:02 +0000
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

Latest series: [v3] spi: switch to use modern name (part4) (2023-08-18T09:31:31)
  Superseding: [v2] spi: switch to use modern name (part4) (2023-08-17T05:03:09):
    [-next,v2,01/23] spi: orion: switch to use modern name
    [-next,v2,02/23] spi: mchp-pci1xxxx: switch to use modern name
    [-next,v2,03/23] spi: pic32-sqi: switch to use modern name
    [-next,v2,04/23] spi: pic32: switch to use modern name
    [-next,v2,05/23] spi: spl022: switch to use modern name
    [-next,v2,06/23] spi: ppc4xx: switch to use modern name
    [-next,v2,07/23] spi: pxa2xx: switch to use modern name
    [-next,v2,08/23] spi: spi-qcom-qspi: switch to use modern name
    [-next,v2,09/23] spi: qup: switch to use modern name
    [-next,v2,10/23] spi: rb4xx: switch to use modern name
    [-next,v2,11/23] spi: realtek-rtl: switch to use devm_spi_alloc_host()
    [-next,v2,12/23] spi: rockchip-sfc: switch to use modern name
    [-next,v2,13/23] spi: rockchip: switch to use modern name
    [-next,v2,14/23] spi: rspi: switch to use spi_alloc_host()
    [-next,v2,15/23] spi: rzv2m-csi: switch to use devm_spi_alloc_host()
    [-next,v2,16/23] spi: s3c64xx: switch to use modern name
    [-next,v2,17/23] spi: sc18is602: switch to use modern name
    [-next,v2,18/23] spi: sh-hspi: switch to use modern name
    [-next,v2,19/23] spi: sh-msiof: switch to use modern name
    [-next,v2,20/23] spi: sh-sci: switch to use modern name
    [-next,v2,21/23] spi: sh: switch to use modern name
    [-next,v2,22/23] spi: sifive: switch to use modern name
    [-next,v2,23/23] spi: spi-sn-f-ospi: switch to use modern name


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


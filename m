Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB9D50CF0B
	for <lists+linux-spi@lfdr.de>; Sun, 24 Apr 2022 05:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237999AbiDXD7d (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 23 Apr 2022 23:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbiDXD73 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 23 Apr 2022 23:59:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC6DDEFE
        for <linux-spi@vger.kernel.org>; Sat, 23 Apr 2022 20:56:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADEFDB80956
        for <linux-spi@vger.kernel.org>; Sun, 24 Apr 2022 03:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4AD54C385A7;
        Sun, 24 Apr 2022 03:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650772587;
        bh=jqzndcpp+uDVyG9HidSA7XdOl0KteNZuyk4k/XjM98w=;
        h=Subject:From:Date:To:From;
        b=Qw6Vjn8JN/LbfbzU3ZuOVHxznrWS05rjzaVSQ0FL71BX2qjWMiUA8BwFQkNejTHxD
         yg0CcRg3i6ftTtmkj8xXdl3p0FM6u1dlll9pB8mfOhmUB5Ae83ngf0kEPwO0F5rczr
         LHr7F43gGcri2FYlgosUS8T/X9mgIcJ8qJEtkmGawYB53SgtDBAHhDNi3xSs6Re9fi
         t6zYpJwKiHVd7xt/b4NbSey/xwuoUiqJWAqSjFOYVzoCs8wtw4x9JvOZjvl0VFiqEu
         9odbeV4QWb1OjFLWeF7YnVxShrM0N9KeeWpWcPx2aLqeCBYLJf+YyX8/k0URI47hBB
         A3MFcHITHiK+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E654E8DBDA;
        Sun, 24 Apr 2022 03:56:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165077258718.14633.3477654668463396462.git-patchwork-housekeeping@kernel.org>
Date:   Sun, 24 Apr 2022 03:56:27 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v6] spi: add support for Mediatek SPI-NAND controller (2022-04-24T03:25:22)
  Superseding: [v5] spi: add support for Mediatek SPI-NAND controller (2022-04-09T12:08:14):
    [v5,1/5] mtd: nand: make mtk_ecc.c a separated module
    [v5,2/5] spi: add driver for MTK SPI NAND Flash Interface
    [v5,3/5] mtd: nand: mtk-ecc: also parse nand-ecc-engine if available
    [v5,4/5] spi: dt-bindings: add binding doc for spi-mtk-snfi
    [v5,5/5] arm64: dts: mediatek: add mtk-snfi for mt7622


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


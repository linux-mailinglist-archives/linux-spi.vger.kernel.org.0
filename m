Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90CA506B96
	for <lists+linux-spi@lfdr.de>; Tue, 19 Apr 2022 13:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349754AbiDSMB0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Apr 2022 08:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347512AbiDSL7Z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 Apr 2022 07:59:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2FE1CB09
        for <linux-spi@vger.kernel.org>; Tue, 19 Apr 2022 04:56:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2BD56137C
        for <linux-spi@vger.kernel.org>; Tue, 19 Apr 2022 11:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 153B7C385A5;
        Tue, 19 Apr 2022 11:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650369402;
        bh=23vDFa6u5V8O7Vuj2zEPUfh9L3+I9VtAJO3dbKbH/74=;
        h=Subject:From:Date:To:From;
        b=MehTk+aflyNBwXmso4XJ+vzaEjQhvTRkiUVHNT5QFvwTP8FEQcnbnacn02lsu6znY
         Yg+/VqurOTtypckebaIHY0fzQfW7xEXTfO426/5+37SgVisXW+fAY0Uhl5dsr3lZHG
         xF54l85Y8gNx1aStFRyzt1mg6AbWvpRSMXUFTEr3jYBwhyx3LqvAXywvFK1SzBeB3h
         cDUjxu1zZvgJfM3ex73BKKNE6u8C8FeQ7qcBFjdPwSSIhJlnxk/88Rt0GNP2pWdRP/
         E1H52/y2KfJT4PI9lxjiLJj9oeBkQRrLsFCWak+QDiKg7naZxfpNS/IXc2rf3GdwfX
         mAraceBvLzocg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 007F9E8DBDA;
        Tue, 19 Apr 2022 11:56:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165036940199.3441.10291737532445848880.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 19 Apr 2022 11:56:41 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v7] Fix broken usage of driver_override (and kfree of static memory) (2022-04-19T11:34:23)
  Superseding: [v6] Fix broken usage of driver_override (and kfree of static memory) (2022-04-03T18:37:46):
    [v6,01/12] driver: platform: Add helper for safer setting of driver_override
    [v6,02/12] amba: Use driver_set_override() instead of open-coding
    [v6,03/12] fsl-mc: Use driver_set_override() instead of open-coding
    [v6,04/12] hv: Use driver_set_override() instead of open-coding
    [v6,05/12] PCI: Use driver_set_override() instead of open-coding
    [v6,06/12] s390/cio: Use driver_set_override() instead of open-coding
    [v6,07/12] spi: Use helper for safer setting of driver_override
    [v6,08/12] vdpa: Use helper for safer setting of driver_override
    [v6,09/12] clk: imx: scu: Fix kfree() of static memory on setting driver_override
    [v6,10/12] slimbus: qcom-ngd: Fix kfree() of static memory on setting driver_override
    [v6,11/12] rpmsg: Constify local variable in field store macro
    [v6,12/12] rpmsg: Fix kfree() of static memory on setting driver_override


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E2B627838
	for <lists+linux-spi@lfdr.de>; Mon, 14 Nov 2022 09:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbiKNI4V (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Nov 2022 03:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235805AbiKNI4U (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Nov 2022 03:56:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4664C1ADBE
        for <linux-spi@vger.kernel.org>; Mon, 14 Nov 2022 00:56:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D178860EC7
        for <linux-spi@vger.kernel.org>; Mon, 14 Nov 2022 08:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 411F7C433D6;
        Mon, 14 Nov 2022 08:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668416179;
        bh=z1NUAFR6P8TmThxkOWx+doQufYy60dQQKe+ip+QgDLk=;
        h=Subject:From:Date:To:From;
        b=qDzcxgROjfvUPXJvLPnN4aRfsY2tVhG/sIM94t1I8wXlOpzX4IRn5DL9SedbnsyS3
         LeDF/CYTw6Mxyd6/nw30GGklwsiTHe6gWAkUwsUz+g20yk0U5HUSlTciWmnxR66zd/
         20PSpjpPFXLxAdZCthL2n3iTHc/fjHql3v83wBsCS1ysvBePTq2QLjKElXfEonh5Lb
         5Rxxf1JFpt3ZhtxQRaZfNIN7I+5T5i37Qr89wUHC6bmtddDEHjgS5qWHEbT/ZDA861
         MgyOK5N/FekKecLTuFFBlimEa2s81E4coCBAYm5wnn2WGRijqWFSi+rMXrSeBXhyYa
         FOyb/V5gCGAqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 24EC2E270C2;
        Mon, 14 Nov 2022 08:56:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166841617914.23678.12682872033263949824.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 14 Nov 2022 08:56:19 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-mtk-nor: Optimize timeout for dma read (2022-11-14T08:13:27)
  Superseding: [v1] spi: spi-mtk-nor: Optimize timeout for dma read (2022-11-03T05:28:43):
    [v1] spi: spi-mtk-nor: Optimize timeout for dma read


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


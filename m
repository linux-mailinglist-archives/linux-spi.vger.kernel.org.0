Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760806C9AAA
	for <lists+linux-spi@lfdr.de>; Mon, 27 Mar 2023 06:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjC0E4l (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Mar 2023 00:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjC0E4l (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Mar 2023 00:56:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64223C2A
        for <linux-spi@vger.kernel.org>; Sun, 26 Mar 2023 21:56:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C56260F90
        for <linux-spi@vger.kernel.org>; Mon, 27 Mar 2023 04:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 758E6C433EF;
        Mon, 27 Mar 2023 04:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679892999;
        bh=fnLKQIgSYPfHyi34i/dNyL0HHdrgNROGzGUMpnOxxdg=;
        h=Subject:From:Date:To:From;
        b=q2PPlp9zxKKOPn1BarqKjulX+ku+d/s8xjEk4lVxxLCEXUqpvUqG08rzZAINnTLzg
         x0sFXEkp/W+uHH8QXFTLaor4cTMP/v0Z4J0N9yZo6VDnQ4NQDGzHhY142JKM4cAPZt
         wEXSg3ErNGTdGjr/Cj6k9xFIIJ7lVK5GX031aQQ+KIhHAqrKC9WQYTYY7DAqoUfL/1
         w2HcomqtPhJYl/LTRRsZ29w+zTctDCbGfL0LpbGwas7h2ODvBd7asj7M8ofKxsbF5m
         Jceml8Tt0C+sPjEUq66t/5+Qdv3isohOYHTbtAofQhbFBh63aqO22ar93WIVDiOkiR
         0/JQKMYixkcKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B4FAC41612;
        Mon, 27 Mar 2023 04:56:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167989299920.9356.3378126844220207784.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 27 Mar 2023 04:56:39 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] spi: dw: DW SPI DMA Driver updates (2023-03-27T04:34:03)
  Superseding: [v3] spi: dw: DW SPI DMA Driver updates (2023-03-26T17:35:09):
    [v3,1/2] spi: dw: Add 32 bpw support to DW DMA Controller
    [v3,2/2] spi: dw: Add dma controller capability checks


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


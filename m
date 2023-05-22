Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026CF70B72E
	for <lists+linux-spi@lfdr.de>; Mon, 22 May 2023 09:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjEVH5w (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 May 2023 03:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjEVH5V (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 22 May 2023 03:57:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DC51700
        for <linux-spi@vger.kernel.org>; Mon, 22 May 2023 00:56:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B711961E9B
        for <linux-spi@vger.kernel.org>; Mon, 22 May 2023 07:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 248CAC433D2;
        Mon, 22 May 2023 07:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684742206;
        bh=9JAvn4+kzyKd4YJEMGILigqI5U4Bel1BVv/zDMwmIaI=;
        h=Subject:From:Date:To:From;
        b=lgT24RcvbT1tMuuD/6czsnHn6wJmRitqSvNUZN8oLNkP0Rsmd+OB/QHWhypdrrPtT
         SHd3SK8tCadB113qvnlClNh9dq8SbsYe/Iq/zd2soSYrRLxNXa9bRQQ46Psr6QDCQL
         iwPv16xRbsj+CRiVrVNqN7vFncKycsD7Ftg6aL9BtpCLtjzETCjLljDeNue75z0bMG
         oBiagB9H3C1o9wzF8S06wNNw4SuIJjuR4pR2scR56vJ6AKEnt2q2CPosIPH668nK4h
         jUME11G+hcR6NVhD5bhOrX+rHEa24wUq9+e5cVdpm1N2DPiHSNeM04j6DK7oqTXk8+
         PYjuEmzRUXFzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0DBE7E22B06;
        Mon, 22 May 2023 07:56:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168474220604.19725.3621063449499953892.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 22 May 2023 07:56:46 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v11] spi: loongson: add bus driver for the loongson spi (2023-05-22T07:10:29)
  Superseding: [v10] spi: loongson: add bus driver for the loongson spi (2023-05-16T13:12:24):
    [v10,1/2] dt-bindings: spi: add loongson spi
    [v10,2/2] spi: loongson: add bus driver for the loongson spi controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


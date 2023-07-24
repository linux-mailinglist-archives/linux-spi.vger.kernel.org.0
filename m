Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA7D75F7A0
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jul 2023 14:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjGXM7q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Jul 2023 08:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjGXM7a (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Jul 2023 08:59:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D0B1FC9
        for <linux-spi@vger.kernel.org>; Mon, 24 Jul 2023 05:56:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C315B6113E
        for <linux-spi@vger.kernel.org>; Mon, 24 Jul 2023 12:56:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33749C433C7;
        Mon, 24 Jul 2023 12:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690203385;
        bh=zPC4/h4TolN/09DX+bpu0gPRZmeNa3YWdLi+1EAGa8Y=;
        h=Subject:From:Date:To:From;
        b=JERSoHOPI7PQcWcuLK7J5Wz+Qy8vAz1cNjFbsFEJ+gMckL3nPNBi0QdDCgHfcqVEM
         Fl6yVK8QQJYuzMjM+uXwOjzelO/RnjkxPNVdKSlVibvhYo5YhtipeA1f2Vj6tBhpqf
         LKV3JrgxGzqB5qBqbOK+U7a2oEzXCCCMZUcEWhNMjUnIJNYUI0KRrQfhNbId9tBdMU
         B8n1kSevnVaTHhrJtbgJq3lMyWbILpjBoynHpm9mRWRXVr5PrzYp7Eg/i34wIhh739
         WlRYiwuMjtqdxL5Ic2foHWisvRDUy7Hd73K7j/l4lXwCwUJUfRWJN2id3ht6P7cb6I
         hrDrY88KZEpUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B474E1F65A;
        Mon, 24 Jul 2023 12:56:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169020338510.15682.14294100059887560298.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 24 Jul 2023 12:56:25 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] dt-bindings: media: amphion: Fix subnode pattern (2023-07-24T12:20:58)
  Superseding: [v1] dt-bindings: media: amphion: Fix subnode pattern (2023-07-21T11:10:18):
    [1/3] dt-bindings: media: amphion: Fix subnode pattern
    [2/3] dt-bindings: lpspi: Add power-domains
    [3/3] dt-bindings: media: imx-jpeg: Add clocks property


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


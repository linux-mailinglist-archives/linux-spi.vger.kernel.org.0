Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100DD4A54D3
	for <lists+linux-spi@lfdr.de>; Tue,  1 Feb 2022 02:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiBAB4R (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 Jan 2022 20:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbiBAB4Q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 Jan 2022 20:56:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9B5C061714
        for <linux-spi@vger.kernel.org>; Mon, 31 Jan 2022 17:56:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3241AB810D8
        for <linux-spi@vger.kernel.org>; Tue,  1 Feb 2022 01:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB155C340E8;
        Tue,  1 Feb 2022 01:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643680574;
        bh=KZlT7o/iw3mdly/bOzF6iL9oru6JwmMe3WOzmOFz6bg=;
        h=Subject:From:Date:To:From;
        b=VMBBuEWAtgubhHOxu23qIlls7a16aI+7GvR0cKXmwZ+3vCcFXR72xH9pUJewHdf6b
         hrZPk4Il/BswsrYgFjLhwbQ5TU4qW3XusAxcfXMNsbcRoWn4MYooZ5lI7r68V7lGbO
         jlPUXMxO27LBSmXLH//nmYyQeZ1c3ADabGhDOBzofM2j/CSKxufn9FZOu/elqNya89
         bl2fQAvaPpx+xFVQYLV4hUc0vPaBTKu0Hs48EApb+bL6mZUVvuyW3oRfharSfJR267
         UjerD9+eLlK73tEmrvmHOeciRtA/OBp4RKpgmeHDPApMVpKkFppGGQ0XudcrvoOf0e
         K1kFODox+J0ow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5674E5D08C;
        Tue,  1 Feb 2022 01:56:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164368057386.15285.7961398230931504418.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 01 Feb 2022 01:56:13 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: bcm2835aux: Convert to use GPIO descriptors (2022-02-01T01:29:56)
  Superseding: [v1] spi: bcm2835aux: Convert to use GPIO descriptors (2022-01-21T22:41:26):
    spi: bcm2835aux: Convert to use GPIO descriptors

Latest series: [v2] spi: st-ssc4: Covert to use GPIO descriptors (2022-02-01T01:26:54)
  Superseding: [v1] spi: st-ssc4: Covert to use GPIO descriptors (2022-01-25T01:10:47):
    spi: st-ssc4: Covert to use GPIO descriptors


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0527A49090D
	for <lists+linux-spi@lfdr.de>; Mon, 17 Jan 2022 13:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbiAQM4S (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Jan 2022 07:56:18 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50046 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiAQM4R (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Jan 2022 07:56:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 399C4B81076
        for <linux-spi@vger.kernel.org>; Mon, 17 Jan 2022 12:56:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BA9CC36AE3;
        Mon, 17 Jan 2022 12:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642424175;
        bh=DswjFwjSuNr1VPV6gfcPHgHkNAG5DXtUmL/ccEkEDbU=;
        h=Subject:From:Date:To:From;
        b=hAuwE7nwNmINyxpAVOgj4qtPquBHkV6+Tczw8QiHgjY34PmqZ7FrRwQCD9qwdnI17
         26AlgVvYGbToR9Ee2cAG2MS9A5/8nwFnNC64OcWLQ/lwymN655RCbU2vtkBhy26OdB
         TZ5rSGX2mUYXJqSXztazyKtrXRkT3hsIaiDyceopNKp9ZagFHzmREL7L7Bc76k/05Q
         GZCgLMWVBfEVyXhcGyGh2sRGYwUJJo+2Htz2RZA9bL1R6+xOH50rQqbKycKndLaEEp
         D+ePYGIeUUtFnmoYWP6yqssbYOzcOE6vzo3HqPlxWRVhp2qwux7YOZfYIQwaJofjLa
         Z4HONjgDUKzgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE5FCF60795;
        Mon, 17 Jan 2022 12:56:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164242417490.9183.13704998462319249576.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 17 Jan 2022 12:56:14 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: stm32-qspi: Update spi registering (2022-01-17T12:17:44)
  Superseding: [v2] spi: stm32-qspi: Update spi registering (2022-01-12T14:44:24):
    [v2] spi: stm32-qspi: Update spi registering


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


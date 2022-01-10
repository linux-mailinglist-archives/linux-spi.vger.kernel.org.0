Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D8948906E
	for <lists+linux-spi@lfdr.de>; Mon, 10 Jan 2022 07:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbiAJG42 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 Jan 2022 01:56:28 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51110 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiAJG41 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 10 Jan 2022 01:56:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E810061185
        for <linux-spi@vger.kernel.org>; Mon, 10 Jan 2022 06:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AF99C36AE9;
        Mon, 10 Jan 2022 06:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641797786;
        bh=Tmwe6MLKwVDBXqAmlMk/Huyq//BDJRWTf/rkkusSfxQ=;
        h=Subject:From:Date:To:From;
        b=pXn2idOOz64kneeXwqWnjcH/QqYUzlnqNNjaqFqTa65AJ6RllfBEzjtdEzdklTDUK
         GVu4Si0CzlDM7pvpP9w9UxF2Aecbaw7Bg1THfzLngeRZHlnz55+SRpldszjCNb4nqs
         6tY+zASl4zOmIbLfQa74iaAQaecuXSm2l1g17HG1qy/aQuAlFZ5Os9BGEPdAWJxK1g
         CbHRjNTQoThg1KzKFt/yZh9Yufys2d9CQCfJk8IKFiacc0gbb7xGoHpCvrvASRYNlr
         3aoRG3UtDczOA+OQPmdGgCRzobejeoqkNsh/Q0MmH15zhpsO/R2UA8P4WaY5R29m2W
         LnrSkC+7gz8Tg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42943F6078B;
        Mon, 10 Jan 2022 06:56:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164179778626.8023.16009066707266162155.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 10 Jan 2022 06:56:26 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] Add SPI control driver for Sunplus SP7021 SoC (2022-01-10T06:47:20)
  Superseding: [v4] Add SPI control driver for Sunplus SP7021 SoC (2021-12-10T09:02:46):
    [v4,1/2] SPI: Add SPI driver for Sunplus SP7021
    [v4,2/2] devicetree: bindings SPI Add bindings doc for Sunplus SP7021


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


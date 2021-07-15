Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38F73C9562
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jul 2021 02:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbhGOA7f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Jul 2021 20:59:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230004AbhGOA7f (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 14 Jul 2021 20:59:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D4694613D7;
        Thu, 15 Jul 2021 00:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626310602;
        bh=WjiSfk9YyjGvZ77BvYeQmNv3dsw0k2WXSJupeaZLoEk=;
        h=Subject:From:Date:To:From;
        b=Y8zqRJC7llPjt/LDdFTGY0hxLMWX7lpAuVgbCXtGikfqsuRTtRg0P3kf4x3rYLnNB
         lhmYcGb+VC53QdvKZ9QAKmpPMq1jbUOpvPEeydzSnMGbj2I8YeD5FEnXAr7TtQwUwE
         ajPSLLS1tDd7nbrCDC8DnCtLhj+fKg1X8IkIV+m4j1UA8lNPBh6iaTMTEjLm19Ig9K
         2c91nhsah7SYNILn4J3+dsLPkSbaWw4p8b8JJO4nX7YAVUrbKexG31G5GmZZVJSI29
         kXwmzgJfFRHwMIt0DnjR6DcxPEo1zK1C7j28mgjBOAdfxAfEFl+F1noOeLe1LwRBu1
         toa2SA7pxUdpw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C8B3060970;
        Thu, 15 Jul 2021 00:56:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162631060281.23358.4539914202699272830.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 15 Jul 2021 00:56:42 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-cadence-quadspi: Fix division by zero warning (2021-07-15T00:46:30)
  Superseding: [v1] spi: spi-cadence-quadspi: Fix division by zero warning (2021-07-13T07:23:12):
    spi: spi-cadence-quadspi: Fix division by zero warning


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


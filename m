Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D38E171113
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2020 07:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgB0GkN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Feb 2020 01:40:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:59318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgB0GkN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 27 Feb 2020 01:40:13 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582785612;
        bh=3BIyW0pbwKmSGAirnTLb3asLCfL4C8QBVvcwJXcBZv8=;
        h=Subject:From:Date:To:From;
        b=rGWpv7HM4JVP25ORdFIp4R+sDdNSZLaKHTDpsA6mCxozxC2/WQ7qOVH3Z9AwYCJYu
         FMY9V8wkjmBdSbH9e548UsXJFAEoGih1ykAzBPOlNjr1S/wUlr2q6/PbjK3bMCnwod
         yN8sl6jXPBkp+fkV3B2MqJvY+2HT1nxLo5vkJqTg=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158278561276.32513.14616499967034929830.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 27 Feb 2020 06:40:12 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v11] spi: cadence-quadspi: Add support for the Cadence QSPI controller (2020-02-27T06:27:06)
  Superseding: [v10] spi: cadence-quadspi: Add support for the Cadence QSPI controller (2020-02-20T01:23:33):
    [RESEND-PATCH,v10,1/2] dt-bindings: spi: Add schema for Cadence QSPI Controller driver
    [RESEND-PATCH,v10,2/2] spi: cadence-quadspi: Add support for the Cadence QSPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot

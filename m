Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9B1EF4DF7
	for <lists+linux-spi@lfdr.de>; Fri,  8 Nov 2019 15:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfKHOUW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Nov 2019 09:20:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:49466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfKHOUW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 8 Nov 2019 09:20:22 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573222822;
        bh=jUBluRMtHWrCAN72UgbnstuCgpgFzNDZkPS7SqZr8d4=;
        h=Subject:From:Date:To:From;
        b=yDH/PJqa03MltHpYo8xW6yRo4lISyyQj9kzRRz98MK3QpdWbdr2El3iVIhVyMj917
         Nh8HHPtztdqGQ/9RaZyOpmjsUm3DJ0DBq/9MsyW1Cf+oWDJmQ7us4Ky8YiK+SYhwrg
         V31fPaCPHD4KZcNYBDROOrSF4xkyz92QlcM4uwik=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <157322282213.14274.8919365080914087588.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 08 Nov 2019 14:20:22 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: zynq-qspi: Clarify and fix the chip selection (2019-11-08T14:07:37)
  Superseding: [v1] spi: zynq-qspi: Clarify and fix the chip selection (2019-11-08T10:59:13):
    [1/7] spi: zynq-qspi: Anything else than CS0 is not supported yet
    [2/7] spi: zynq-qspi: Keep the naming consistent across the driver
    [3/7] spi: zynq-qspi: Keep the bitfields naming consistent
    [4/7] spi: zynq-qspi: Enhance the Linear CFG bit definitions
    [5/7] spi: zynq-qspi: Clarify the select chip function
    [6/7] spi: zynq-qspi: Do the actual hardware initialization later in the probe
    [7/7] spi: zynq-qspi: Support two chip selects


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot

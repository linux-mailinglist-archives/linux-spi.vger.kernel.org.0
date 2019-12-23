Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFE991291FE
	for <lists+linux-spi@lfdr.de>; Mon, 23 Dec 2019 07:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfLWGkL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Dec 2019 01:40:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:47852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfLWGkK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 23 Dec 2019 01:40:10 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577083210;
        bh=01+bFc24ZqWkeB5Ku91/xqPjL0RZxPQrTceJZ0sCuwQ=;
        h=Subject:From:Date:To:From;
        b=aOMDeqnZzI5oN9CwITsiW662SdcYhUjlegD7GEShP87z+GW1t/iFSuAWJLBFRMT9f
         HCCOIR8LEqJdjRNmcM8PqsavyHnmSkXAjzxVPlMBqJIXL+cwcYp44FRShdDts5CIbu
         yfbz+eU5Yp2sQ7gMlO+P5UQRIBYcVMuHgLsFKZU0=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <157708321052.9538.18302557878550644646.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 23 Dec 2019 06:40:10 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] spi: cadence-quadpsi: Add support for the Cadence QSPI controller (2019-12-23T06:30:01)
  Superseding: [v3] spi: cadence-quadpsi: Add support for the Cadence QSPI controller (2019-12-09T08:40:33):
    [v3,1/2] dt-bindings: spi: Add schema for Cadence QSPI Controller driver
    [v3,2/2] spi: cadence-quadpsi: Add support for the Cadence QSPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot

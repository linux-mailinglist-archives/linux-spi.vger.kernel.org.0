Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35EE112AACB
	for <lists+linux-spi@lfdr.de>; Thu, 26 Dec 2019 08:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbfLZHUL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Dec 2019 02:20:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:33482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbfLZHUL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 26 Dec 2019 02:20:11 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577344811;
        bh=WIdCJ9UBVtPbWRtV3B4WxYmE4wq33XtVW1bt7ylBCag=;
        h=Subject:From:Date:To:From;
        b=MUp5IgkFQSi3ktb6NZyMVhC+l259TANsd+WiRWziAbt3o9k65dI0LK7ORaOzH/KcU
         zof9Njxm116pbnykJ0ffpTEwaTkCXlp2AxR2IcnwzMBIwbrfc2qqmTVsqJfmb1xWlE
         p46VjJ6PqkNr77o/xhfVrIZmEoaV97OUIvUFA6G4=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <157734481112.14349.13341515241055735894.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 26 Dec 2019 07:20:11 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] spi: cadence-quadpsi: Add support for the Cadence QSPI controller (2019-12-26T07:10:56)
  Superseding: [v4] spi: cadence-quadpsi: Add support for the Cadence QSPI controller (2019-12-23T06:30:01):
    [v4,1/2] dt-bindings: spi: Add schema for Cadence QSPI Controller driver
    [v4,2/2] spi: cadence-quadpsi: Add support for the Cadence QSPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C00A917EE4C
	for <lists+linux-spi@lfdr.de>; Tue, 10 Mar 2020 03:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgCJCAN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 22:00:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgCJCAM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Mar 2020 22:00:12 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583805612;
        bh=wfko/Ogu5UpTb+l68AlbKiEUlRuA9CIAYaqLTiSaSZ4=;
        h=Subject:From:Date:To:From;
        b=2mGFJRQoqT5hve4EitgpKCZwOUjjSAVNxs/FMwgdXpgqkZYMj0PY/UEzv5SusR65E
         H+9uafBSgMroUrYjwG5a0vCDJzH6csmQRMUgZ2/m8L8ADCU7UQqybDd+DFkoWvqCS6
         fcJ0eOGndypxnvz/ubAapAPD3vyg783l/Nah9P6w=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158380561247.3409.14993592935934559617.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 10 Mar 2020 02:00:12 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v12] spi: cadence-quadspi: Add support for the Cadence QSPI controller (2020-03-10T01:52:09)
  Superseding: [v11] spi: cadence-quadspi: Add support for the Cadence QSPI controller (2020-02-27T06:27:06):
    [v11,1/2] dt-bindings: spi: Add schema for Cadence QSPI Controller driver
    [v11,2/2] spi: cadence-quadspi: Add support for the Cadence QSPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot

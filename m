Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41C6B118C5B
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2019 16:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfLJPUK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Dec 2019 10:20:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:48514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727330AbfLJPUK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 10 Dec 2019 10:20:10 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575991210;
        bh=/Ece3h4gNVUiiRMwXawEt4h9QG9dNRE0xZBKRpyV3iQ=;
        h=Subject:From:Date:To:From;
        b=Y/R543yzy5cmAyqecE+zMlHhUIscbC2mqPXW13mO4fni8T4Q6JzEaNSZgETSn63kL
         iKpw7V3WPQlyTgA2r59JrwbNX/5t2NNJY10DIMTs75YMPZN+gwnfN/5QsMAT2HrQPf
         Xw2Na0yLDwKcmm8V0nLYBpDcg50cWSoOB3ZChnfs=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <157599121030.29195.7611523159211450662.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 10 Dec 2019 15:20:10 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: fsl: don't map irq during probe (2019-12-10T15:17:15)
  Superseding: [v1] spi: fsl: don't map irq during probe (2019-12-09T15:27:27):
    [1/2] spi: fsl: don't map irq during probe
    [2/2] spi: fsl: simplify error path in of_fsl_spi_probe()


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot

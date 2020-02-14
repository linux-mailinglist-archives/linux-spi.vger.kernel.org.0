Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C49815D708
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2020 13:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbgBNMAO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Feb 2020 07:00:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:59136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728036AbgBNMAN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 14 Feb 2020 07:00:13 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581681613;
        bh=0dXA84XncEl+MfZ9J1lkAXZ9CHTOq1v0chGsTjhEbis=;
        h=Subject:From:Date:To:From;
        b=qZ/C8LaLB5en2pyU4lj5VmGdf/wTEsxwt8xDhUELbNaRtzLoJLN1bdzaawE/0ebpn
         xiVHADlE24xTvHJspo6txGcsMfsVKa9EX6EH7CG8I1yodiW5OIozqQOl0VXif2cBKv
         GEK/hgIADQ4Y0Y1XbwmwvJQ6DgAYH1An8T0NWC68=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158168161347.17819.8994123561777823623.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 14 Feb 2020 12:00:13 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v9] spi: cadence-quadpsi: Add support for the Cadence QSPI controller (2020-02-14T11:46:16)
  Superseding: [v8] spi: cadence-quadpsi: Add support for the Cadence QSPI controller (2020-01-29T07:24:55):
    [v8,1/2] dt-bindings: spi: Add schema for Cadence QSPI Controller driver
    [v8,2/2] spi: cadence-quadpsi: Add support for the Cadence QSPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 421007005E
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jul 2019 15:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbfGVNAI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Jul 2019 09:00:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728619AbfGVNAI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 22 Jul 2019 09:00:08 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563800408;
        bh=qQQHaDEtjD7sbsPResj+xeEY1XBs/L3rAVKDjY9WzPk=;
        h=Subject:From:Date:To:From;
        b=UJsZMTc5f1aqYWBGnt6ruCgW+6AMqWvHuSSCwvzY/oRZHu7kXo5wV+wB4CqrQPasZ
         DGD5AxVCIb20EBbBNrAVprZCS+z+y9ocgc01Of/B/fTDbhXuko7gTZXDjHs3M+iIBO
         liEq6VNbyU741DJgEqjEcPFL3sIJEZYuHLEbg+OY=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <156380040796.27731.3559001495948956393.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 22 Jul 2019 13:00:07 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] iio: imu: Add support for the ADIS16460 IMU (2019-07-22T12:47:44)
  Superseding: [v2] iio: imu: Add support for the ADIS16460 IMU (2019-07-17T11:51:07):
    [1/4,V2] drivers: spi: core: Add optional delay between cs_change transfers
    [2/4,V2] iio: imu: adis: Add support for SPI transfer cs_change_delay_usecs
    [3/4,V2] iio: imu: Add support for the ADIS16460 IMU
    [4/4,V2] dt-bindings: iio: imu: add bindings for ADIS16460


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot

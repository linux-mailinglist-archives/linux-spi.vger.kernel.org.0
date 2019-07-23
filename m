Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 568407131D
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jul 2019 09:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731691AbfGWHkI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Jul 2019 03:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732967AbfGWHkI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 23 Jul 2019 03:40:08 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563867608;
        bh=pAIRAXR8dq47/Q5YxxRYEMD92N7nwAnIMpvW3gd3ing=;
        h=Subject:From:Date:To:From;
        b=Neex40c3iIT0BcXFZqxbAdnJLf+d0Miw16Hw/RGiqM+G6XbtRkeE6dVDiudNSoRN8
         xZvtfPlTa31Tr3K/HIEkBduHWHSAmytXjZ4W4+1VZ0vHHfnU2Ymu7L30JXC4W7qiKd
         h04X6VtJE9quM1X2+/9S/5i7bYJXgd4/WRI6BuIo=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <156386760803.18365.10442552436700157541.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 23 Jul 2019 07:40:08 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] iio: imu: Add support for the ADIS16460 IMU (2019-07-23T07:36:38)
  Superseding: [v3] iio: imu: Add support for the ADIS16460 IMU (2019-07-22T12:47:44):
    [1/4,V3] spi: Add optional stall delay between cs_change transfers
    [2/4,V3] iio: imu: adis: Add support for SPI transfer cs_change_delay
    [3/4,V3] iio: imu: Add support for the ADIS16460 IMU
    [4/4,V3] dt-bindings: iio: imu: add bindings for ADIS16460


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot

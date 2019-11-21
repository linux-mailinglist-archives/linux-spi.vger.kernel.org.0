Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2391D104F18
	for <lists+linux-spi@lfdr.de>; Thu, 21 Nov 2019 10:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfKUJUL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 Nov 2019 04:20:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:35150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfKUJUL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 21 Nov 2019 04:20:11 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574328010;
        bh=xavyDBfFEt5u8u7vU1w22De9DVyvkZMhCXIE5IGFpoY=;
        h=Subject:From:Date:To:From;
        b=T0sxPRJ0M6mhD1y6tN/AzFkawanl8o7mfZG5+Wa1epEVROfyUk4/g9N7if23/+bkw
         RGZQ4cUahJq4EMmp+pdQi87e8vUoKFB2N9Xxk7Y4dxDz0LBhlXRH0imOuKD05lISih
         k1bM0rTwawaO5/qHpO/biBll+nWVvJK7Ndy2nL0E=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <157432801064.21497.4990774757690064403.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 21 Nov 2019 09:20:10 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: pic32: Retire dma_request_slave_channel_compat() (2019-11-21T09:14:05)
  Superseding: [v1] spi: pic32: Retire dma_request_slave_channel_compat() (2019-11-21T08:09:54):
    spi: pic32: Retire dma_request_slave_channel_compat()


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot

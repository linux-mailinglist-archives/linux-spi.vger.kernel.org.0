Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD98143284
	for <lists+linux-spi@lfdr.de>; Mon, 20 Jan 2020 20:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgATTkL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Jan 2020 14:40:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:54722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgATTkL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 20 Jan 2020 14:40:11 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579549211;
        bh=JFfQeUemZKRJAY29dnP+9IoFFUIVq4HTQjxex3i5BDk=;
        h=Subject:From:Date:To:From;
        b=sFBXvYMJe0A+D8k5Rkxtx197rLf4PlvLHvybv1ArWHjdITyPWB01cQJplwVUVFl3i
         conGZ/fr7u8U7f6o+i9Qoo7gdM6/EUd/nvh6KESMYiYxDK6SqBdlRqCFnDhVqP13Ar
         QtbmTZ9P++4/dmJ++xrLYwoF1tva+ua44kH4vWFU=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <157954921109.12143.8223074753347052785.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 20 Jan 2020 19:40:11 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: spi-ti-qspi: Support large NOR SPI flash (2020-01-14T12:41:23)
  Superseding: [v1] spi: spi-ti-qspi: Support large NOR SPI flash (2019-12-11T19:39:51):
    [1/3] spi: spi-ti-qspi: Remove unused macro for fclk frequency


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot

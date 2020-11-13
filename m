Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626E42B1831
	for <lists+linux-spi@lfdr.de>; Fri, 13 Nov 2020 10:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgKMJY6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Nov 2020 04:24:58 -0500
Received: from forward103o.mail.yandex.net ([37.140.190.177]:33307 "EHLO
        forward103o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726149AbgKMJYy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 13 Nov 2020 04:24:54 -0500
X-Greylist: delayed 377 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Nov 2020 04:24:52 EST
Received: from forward103q.mail.yandex.net (forward103q.mail.yandex.net [IPv6:2a02:6b8:c0e:50:0:640:b21c:d009])
        by forward103o.mail.yandex.net (Yandex) with ESMTP id 4FED75F8235D;
        Fri, 13 Nov 2020 12:18:34 +0300 (MSK)
Received: from mxback9q.mail.yandex.net (mxback9q.mail.yandex.net [IPv6:2a02:6b8:c0e:6b:0:640:b813:52e4])
        by forward103q.mail.yandex.net (Yandex) with ESMTP id 4AF5E61E0002;
        Fri, 13 Nov 2020 12:18:34 +0300 (MSK)
Received: from vla5-3832771863b8.qloud-c.yandex.net (vla5-3832771863b8.qloud-c.yandex.net [2a02:6b8:c18:3417:0:640:3832:7718])
        by mxback9q.mail.yandex.net (mxback/Yandex) with ESMTP id pSAr2pjuXT-IYeaiO9W;
        Fri, 13 Nov 2020 12:18:34 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1605259114;
        bh=2QGuKJSD53PCajVm5lDrDZgahhhHYLtK3iVJXhvVi80=;
        h=In-Reply-To:Subject:To:From:Cc:References:Date:Message-Id;
        b=MS2bv1kz1fwomOY7q/Tcc5+rAd//f4WfmVhzhBV+LXz1+Hd7V3xmBhBIgQUQFGgUG
         mLXawb0eiPMR7YoFmBrHcCztLrySzZeG79KJVNJ0X3ijyn06+7xoOi+1axI0jqVyuC
         wz9GhB3L+T9vEqVc+3x5AulU3ZcLn8whrfaIvkyY=
Authentication-Results: mxback9q.mail.yandex.net; dkim=pass header.i=@maquefel.me
Received: by vla5-3832771863b8.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id HQN6fQ2zIo-IJnGZG5B;
        Fri, 13 Nov 2020 12:18:33 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     xiaoning.wang@nxp.com
Cc:     broonie@kernel.org, festevam@gmail.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org,
        Nikita Shubin <nikita.shubin@maquefel.me>
Subject: [PATCH] spi: imx: enable runtime pm support
Date:   Fri, 13 Nov 2020 12:18:00 +0300
Message-Id: <20201113091800.27469-1-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727063354.17031-1-xiaoning.wang@nxp.com>
References: <20200727063354.17031-1-xiaoning.wang@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Clark, 

This patch breaks spi-imx on imx7d.
Toradex Colibri imx7d spi reports with:

    [    4.258468] inv-mpu6000-spi spi2.0: I/O Error in PIO
    [    4.264269] inv-mpu6000-spi spi2.0: SPI transfer failed: -110
    [    4.264305] spi_master spi2: failed to transfer one message from queue

We are using spi-imx with dma.

Reverting your patch fixes this issue.

The baseline commit 951cbbc386ff01b50da4f46387e994e81d9ab431 (tag: v5.9.8, stable/linux-5.9.y)

Could you please give some comments on this issue ?

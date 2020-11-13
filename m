Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743852B1AD5
	for <lists+linux-spi@lfdr.de>; Fri, 13 Nov 2020 13:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgKMMLx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Nov 2020 07:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgKMMLx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 13 Nov 2020 07:11:53 -0500
X-Greylist: delayed 429 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 Nov 2020 04:11:53 PST
Received: from forward500j.mail.yandex.net (forward500j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA96C0613D1;
        Fri, 13 Nov 2020 04:11:53 -0800 (PST)
Received: from mxback18j.mail.yandex.net (mxback18j.mail.yandex.net [IPv6:2a02:6b8:0:1619::94])
        by forward500j.mail.yandex.net (Yandex) with ESMTP id 0AB2411C1C33;
        Fri, 13 Nov 2020 15:04:37 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback18j.mail.yandex.net (mxback/Yandex) with ESMTP id 4fGUZinil1-4aKaNgI3;
        Fri, 13 Nov 2020 15:04:36 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1605269076;
        bh=8JTSwotuRGgc/44wdb4s+/iJsvCU7rusxQ3UllDMBSU=;
        h=References:Date:Message-Id:Cc:Subject:To:From;
        b=tTEnTkT72hcEIYLWsXMMSADjwPt9KZLUcKGwXTma1LLMqzxze/DckwxDHLIytcAN6
         YtriDipyDVALu1fu1GqOM0Ej89xQxi9lb9/M4kHRxmYobzEx1SPAiqHSzWDzDiWpaa
         62+JarJ5J4idn12vn0XChnzmvpTDckTqhY2F8V9w=
Authentication-Results: mxback18j.mail.yandex.net; dkim=pass header.i=@maquefel.me
Received: by sas1-c37eebe3eab8.qloud-c.yandex.net with HTTP;
        Fri, 13 Nov 2020 15:04:35 +0300
From:   "nikita.shubin@maquefel.me" <nikita.shubin@maquefel.me>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Clark Wang <xiaoning.wang@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
References: <20200727063354.17031-1-xiaoning.wang@nxp.com> <20201113091800.27469-1-nikita.shubin@maquefel.me> <CAOMZO5AVJjhqEvkiB3mXc24RNy+Ac3VW_CTg6BGNsqfSVLq0Sg@mail.gmail.com>
Subject: Re: [PATCH] spi: imx: enable runtime pm support
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Fri, 13 Nov 2020 15:04:35 +0300
Message-Id: <717261605268864@mail.yandex.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Fabio,

Apllied on the top of

   Revert "spi: imx: Fix freeing of DMA channels if spi_bitbang_start() fails"

   This reverts commit 9e68d974b2fd4977e896e166656c36e2f80293d6.

Still experiencing the same issue:

[    4.322131] inv-mpu6000-spi spi2.0: I/O Error in PIO
[    4.329353] inv-mpu6000-spi spi2.0: SPI transfer failed: -110
[    4.391504] spi_master spi2: failed to transfer one message from queue

I have config CONFIG_PM=y.

13.11.2020, 14:26, "Fabio Estevam" <festevam@gmail.com>:
> Hi Nikita,
>
> On Fri, Nov 13, 2020 at 6:18 AM Nikita Shubin <nikita.shubin@maquefel.me> wrote:
>>  Hello Clark,
>>
>>  This patch breaks spi-imx on imx7d.
>>  Toradex Colibri imx7d spi reports with:
>>
>>      [ 4.258468] inv-mpu6000-spi spi2.0: I/O Error in PIO
>>      [ 4.264269] inv-mpu6000-spi spi2.0: SPI transfer failed: -110
>>      [ 4.264305] spi_master spi2: failed to transfer one message from queue
>>
>>  We are using spi-imx with dma.
>>
>>  Reverting your patch fixes this issue.
>>
>>  The baseline commit 951cbbc386ff01b50da4f46387e994e81d9ab431 (tag: v5.9.8, stable/linux-5.9.y)
>>
>>  Could you please give some comments on this issue ?
>
> Could you please try this patch from Sascha?
> https://lkml.org/lkml/2020/10/12/981

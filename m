Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73CC0172421
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2020 17:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgB0Q6p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Feb 2020 11:58:45 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40026 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729174AbgB0Q6p (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Feb 2020 11:58:45 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 01505296437;
        Thu, 27 Feb 2020 16:58:43 +0000 (GMT)
Date:   Thu, 27 Feb 2020 17:58:41 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 06/11] mtd: spi-nor: add support for DTR protocol
Message-ID: <20200227175841.51435e3f@collabora.com>
In-Reply-To: <20200226093703.19765-7-p.yadav@ti.com>
References: <20200226093703.19765-1-p.yadav@ti.com>
        <20200226093703.19765-7-p.yadav@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 26 Feb 2020 15:06:58 +0530
Pratyush Yadav <p.yadav@ti.com> wrote:

> Double Transfer Rate (DTR) is SPI protocol in which data is transferred
> on each clock edge as opposed to on each clock cycle. Make
> framework-level changes to allow supporting flashes in DTR mode.
> 
> Right now, mixed DTR modes are not supported. So, for example a mode
> like 4S-4D-4D will not work. All phases need to be either DTR or STR.

Didn't go deep into the patch but at first glance you don't seem to
extend the framework to support stateful modes as I tried to do here
[1]. That's really something we should address before considering
supporting xD-xD-xD modes, unless the SPI-NOR only supports one
stateful mode. If we don't do that first, we might face all sort of
unpleasant issues:

* kexec not working correctly because the previous kernel left the NOR
  in an unknown state
* suspend/resume not working properly
* linux not booting properly because the bootloader left the device in
  its non-default mode
* ...

[1]https://patchwork.kernel.org/cover/10638055/


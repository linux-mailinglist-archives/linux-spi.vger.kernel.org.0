Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A760B8138
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2019 21:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392295AbfISTNL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Sep 2019 15:13:11 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:51347 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392291AbfISTNL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 Sep 2019 15:13:11 -0400
X-Originating-IP: 90.76.216.45
Received: from windsurf (lfbn-1-2159-45.w90-76.abo.wanadoo.fr [90.76.216.45])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id EE207240008;
        Thu, 19 Sep 2019 19:13:08 +0000 (UTC)
Date:   Thu, 19 Sep 2019 21:13:08 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] spi: atmel: Remove AVR32 leftover
Message-ID: <20190919211308.56c9503e@windsurf>
In-Reply-To: <20190919172453.GA21254@piout.net>
References: <20190919154034.7489-1-gregory.clement@bootlin.com>
        <20190919172453.GA21254@piout.net>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 19 Sep 2019 19:24:53 +0200
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> On 19/09/2019 17:40:34+0200, Gregory CLEMENT wrote:
> > AV32 support has been from the kernel a few release ago, but there was  
> AVR32 and  missing word^
> 
> > still some specific macro for this architecture in this driver. Lets
> > remove it.

If you want to actually be pedantic, there are a few other typos in the
commit. Hopefully the below text has all of them fixed (and does not
introduce any new one):

==

AVR32 support has been removed from the kernel a few releases ago, but
there were still some specific macros for this architecture in this
driver. Let's remove them.

==

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

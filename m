Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4BA30E0AF
	for <lists+linux-spi@lfdr.de>; Wed,  3 Feb 2021 18:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhBCRPv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 3 Feb 2021 12:15:51 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:41057 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbhBCRPa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 3 Feb 2021 12:15:30 -0500
Received: from xps13 (lfbn-tou-1-972-150.w86-210.abo.wanadoo.fr [86.210.203.150])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id E9858100008;
        Wed,  3 Feb 2021 17:14:41 +0000 (UTC)
Date:   Wed, 3 Feb 2021 18:14:40 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        zhengxunli@mxic.com.tw, juliensu@mxic.com.tw, ycllin@mxic.com.tw
Subject: Re: [PATCH] spi: Fix the logic around the maximum speed
Message-ID: <20210203181440.23cc8b55@xps13>
In-Reply-To: <CAOMZO5AG5HjYa6d9oNrFjmpepu51md3obcqcLo9PgOZMo4T9PQ@mail.gmail.com>
References: <20210203170245.31236-1-miquel.raynal@bootlin.com>
        <CAOMZO5AG5HjYa6d9oNrFjmpepu51md3obcqcLo9PgOZMo4T9PQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Fabio,

Fabio Estevam <festevam@gmail.com> wrote on Wed, 3 Feb 2021 14:10:15
-0300:

> Hi Miquel,
> 
> On Wed, Feb 3, 2021 at 2:06 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > Commit 9326e4f1e5dd ("spi: Limit the spi device max speed to controller's max speed")
> > rationaly introduced a new condition on which the device's maximum
> > speed would be set to the controller's one: if the device advertizes a
> > higher speed than the one supported by the controller.  
> 
> Already fixed:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6820e812dafb4258bc14692f686eec5bde6fba86

Oh crap :') Indeed I wasn't based on the right -rc to get the fix.

Thanks for the heads up!
Miquèl

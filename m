Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3486DF4D30
	for <lists+linux-spi@lfdr.de>; Fri,  8 Nov 2019 14:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfKHNbi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 8 Nov 2019 08:31:38 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:40149 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfKHNbi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Nov 2019 08:31:38 -0500
X-Originating-IP: 86.206.246.123
Received: from xps13 (lfbn-tou-1-421-123.w86-206.abo.wanadoo.fr [86.206.246.123])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 6C124C000E;
        Fri,  8 Nov 2019 13:31:35 +0000 (UTC)
Date:   Fri, 8 Nov 2019 14:31:34 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH 1/7] spi: zynq-qspi: Anything else than CS0 is not
 supported yet
Message-ID: <20191108143134.1490f092@xps13>
In-Reply-To: <20191108120732.GB5532@sirena.co.uk>
References: <20191108105920.19014-1-miquel.raynal@bootlin.com>
        <20191108105920.19014-2-miquel.raynal@bootlin.com>
        <20191108120732.GB5532@sirena.co.uk>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

Mark Brown <broonie@kernel.org> wrote on Fri, 8 Nov 2019 12:07:32 +0000:

> On Fri, Nov 08, 2019 at 11:59:14AM +0100, Miquel Raynal wrote:
> > Unlike what the driver is currently advertizing, CS0 only can be used,
> > CS1 is not supported at all. Prevent people to use CS1.  
> 
> This (and the rest of the series) doesn't apply against current code,
> please check and resend.

My bad, I thought I was working on a v5.3 while I was on a v5.1. Let me
rebase and resend the whole patchset. Sorry for the mistake.

Thanks,
Miquèl
